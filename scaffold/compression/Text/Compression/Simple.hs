{-# LANGUAGE    TupleSections #-}
{-# LANGUAGE    FlexibleInstances #-}
{-# LANGUAGE    ViewPatterns #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Text.Compression.Simple
( toByteString                --  :: BitString -> BS.ByteString
, toWord                      --  :: BitString -> Word8
, toBits                      --  :: BS.ByteString -> BitString
, treeSize                    --  :: FingerTree x y -> Int
, isLeaf                      --  :: FingerTree x y -> Bool
, getKey                      --  :: FingerTree t t1 -> t
, fromList                    --  :: Semigroup k => [(k,v)] -> Maybe (FingerTree k v)
, step                        --  :: (Semigroup k, Ord k) => [FingerTree k v] -> [FingerTree k v]
, buildA                      --  :: (Semigroup k, Ord k) => [FingerTree k v] -> [[FingerTree k v]]
, buildB                      --  :: (Semigroup k, Ord k) => [(k,v)] -> Maybe [FingerTree k v]
, build                       --  :: (Semigroup k, Ord k) => [(k,v)] -> Maybe (FingerTree k v)
, fromFrequencies             --  :: [(Int, v)] -> Maybe (OccuranceTree v)
, treeToBits                  --  :: OccuranceTree v -> Lookup v BitString
, coding                      --  :: BitString -> FingerTree t t1 -> Lookup t1 BitString
, frequenciesToCoding         --  :: [(Int, v)] -> Maybe (Lookup v BitString)
, packTable                   --  :: FrequencyTable Char -> String -> Maybe BS.ByteString
, packString                  --  :: String -> (FrequencyTable Char, Maybe BS.ByteString)
, unpackString                --  :: CharBits -> BS.ByteString -> String
, decompress                  --  :: BitsChar -> BitsChar -> BitString -> String
, noPrefixStarts              --  :: Eq e => [[e]] -> Bool
, invert                      --  :: [(a, b)] -> [(b, a)]
, none                        --  :: [Bool] -> Bool
, getTable                    --  :: String -> FrequencyTable Char
, tests
)

where

-- Imports
--
import Data.Bits          (setBit, testBit)
import Data.Word8         (Word8)
import Data.Maybe         (listToMaybe, mapMaybe)
import Data.List.Split    (chunksOf)
import Data.Semigroup     (Semigroup, (<>), Sum(Sum), sconcat)
import Control.Monad      (join)
import Control.Arrow      (first, second, (&&&))
import Data.List          (nub, isPrefixOf, delete, stripPrefix, group, sortBy, find, sort)
import Data.Ord           (comparing)
import Data.List.NonEmpty (nonEmpty)

import qualified Data.ByteString as BS

import Test.QuickCheck as Q

-- Types
--
type Lookup k v       = [(k,v)]
type BitString        = [ Bool ]
type CharBits         = Lookup Char BitString
type BitsChar         = Lookup BitString Char
type OccuranceTree v  = FingerTree (Sum Int) v
type FrequencyTable v = Lookup Int v

-- Data
--
data FingerTree k v = L k v | B k (FingerTree k v) (FingerTree k v)
  deriving Show

-- Instances
--
instance Semigroup k => Semigroup (FingerTree k v)
  where x <> y = B (getKey x <> getKey y) x y

instance Arbitrary v => Arbitrary (OccuranceTree v)
  where arbitrary = fmap (L (Sum 1)) arbitrary

instance Testable (Maybe Bool) where
  property Nothing  = property True
  property (Just x) = property x

-- Bits and Bytes
--
toByteString :: BitString -> BS.ByteString
toByteString = BS.pack . map toWord . chunksOf 8

toWord :: BitString -> Word8
toWord bs = foldl update 0 (zip [0..] bs)
  where
    update b (i,True ) = setBit b i
    update b (_,False) = b

toBits :: BS.ByteString -> BitString
toBits = concatMap wordBits . BS.unpack
  where
    wordBits b = map (testBit b) [0..7]


treeSize :: FingerTree x y -> Int
treeSize (L   _ _  ) = 1
treeSize (B _ l r) = treeSize l + treeSize r

isLeaf :: FingerTree x y -> Bool
isLeaf (L _ _) = True
isLeaf _       = False

getKey :: FingerTree t t1 -> t
getKey (L   k _  ) = k
getKey (B k _ _) = k

fromList :: Semigroup k => [(k,v)] -> Maybe (FingerTree k v)
fromList = fmap sconcat . nonEmpty . map (uncurry L)

step :: (Semigroup k, Ord k) => [FingerTree k v] -> [FingerTree k v]
step []    = []
step [x]   = [x]
step [x,y] = [ x <> y ]
step xs    = step (take 2 sorted) ++ drop 2 sorted
  where
    sorted = sortBy (comparing getKey) xs

buildA :: (Semigroup k, Ord k) => [FingerTree k v] -> [[FingerTree k v]]
buildA = iterate step

buildB :: (Semigroup k, Ord k) => [(k,v)] -> Maybe [FingerTree k v]
buildB = find ((<= 1) . length) . buildA . map (uncurry L)

build :: (Semigroup k, Ord k) => [(k,v)] -> Maybe (FingerTree k v)
build = join . fmap listToMaybe . buildB

fromFrequencies :: [(Int, v)] -> Maybe (OccuranceTree v)
fromFrequencies = build . map (first Sum)

treeToBits :: OccuranceTree v -> Lookup v BitString
treeToBits t = map (second reverse) result
  where
  result = if isLeaf t then coding [True] t -- Be productive for singleton trees
                       else coding []     t

coding :: BitString -> FingerTree t t1 -> Lookup t1 BitString
coding p (L _ v  ) = [ (v, p) ]
coding p (B _ l r) = coding (False : p) l ++ coding (True : p) r

frequenciesToCoding :: [(Int, v)] -> Maybe (Lookup v BitString)
frequenciesToCoding = fmap treeToBits . fromFrequencies

-- Combination
--
packTable :: FrequencyTable Char -> String -> Maybe BS.ByteString
packTable t s = do
  bitsLookup <- frequenciesToCoding t
  return $ toByteString $ concat $ mapMaybe (flip lookup bitsLookup) s

packString :: String -> (FrequencyTable Char, Maybe BS.ByteString)
packString s = (t, packTable t s) where t = getTable s

unpackString :: CharBits -> BS.ByteString -> String
unpackString t = decompress flipped flipped . toBits
  where
  flipped = sortBy (comparing (length . fst)) (invert t)

decompress :: BitsChar -> BitsChar -> BitString -> String
decompress _   [] []     = []
decompress obc [] (_:xs) = decompress obc obc xs
decompress _ _ []        = []
decompress obc ((bs,c):t) s = case stripPrefix bs s
                                of Just r  -> c : decompress obc obc r
                                   Nothing ->     decompress obc t   s

-- Tools
--
noPrefixStarts :: Eq e => [[e]] -> Bool
noPrefixStarts xs = and [none (isPrefixOf x `map` delete x xs) | x <- xs]

invert :: [(a, b)] -> [(b, a)]
invert = map (snd &&& fst)

none :: [Bool] -> Bool
none = not . or

getTable :: String -> FrequencyTable Char
getTable = map (length &&& head) . group . sort

-- Properties
--
prop_toBits_bijection :: (Q.Positive Int) -> Property
prop_toBits_bijection (Q.getPositive -> n)
  = Q.forAll (Q.vector 128) $ \x ->
  let y = take (8*n) x in
  toBits (toByteString y) == y

prop_step_size :: [OccuranceTree Char] -> Bool
prop_step_size ls = sum (map treeSize ls) == sum (map treeSize (step ls))

prop_step_size2 :: [OccuranceTree Char] -> Bool
prop_step_size2 ls = sum (map treeSize ls) == sum (map treeSize (step (step ls)))

prop_buildB_size :: String -> Property
prop_buildB_size ls = not (null ls)
                 ==> Just [length ls] == fmap (fmap treeSize) (buildB ts)
  where
  ts = map (Sum (1 :: Int),) ls

prop_build_size :: String -> Property
prop_build_size ls = not (null ls)
                 ==> Just (length ls) == fmap treeSize (build ts)
  where
  ts = map (Sum (1 :: Int),) ls

prop_frequency_tree_size :: [(Int, Char)] -> Property
prop_frequency_tree_size ls = not (null ls)
                          ==> Just (length ls) == fmap treeSize (fromFrequencies ls)

prop_same_length :: [(Int,Char)] -> Property
prop_same_length ls = not (null ls) && all (< 1000) (map fst ls)
                    ==> Just (length ls)
                     == fmap length (frequenciesToCoding ls)

prop_contains_items :: [(Int,Char)] -> Property
prop_contains_items ls =   not (null ls)
                        && all (>=0) (map fst ls)
                        ==> Just (sort (map snd ls))
                         == fmap (sort . map fst) (frequenciesToCoding ls)

prop_roundtrip :: String -> Property
prop_roundtrip s = length s > 1 ==> do
  let (t,bs) = packString s
  bytes <- bs
  bt    <- frequenciesToCoding t
  let res = unpackString bt bytes
  return (s == take (length s) res)

prop_no_prefix_starts :: Q.NonEmptyList (Q.Positive Int) -> Q.NonEmptyList Char -> Bool
prop_no_prefix_starts (map Q.getPositive . Q.getNonEmpty -> ints)
                                          (Q.getNonEmpty -> chars)
                      = Just True
                     == fmap (noPrefixStarts . map snd)
                             (frequenciesToCoding (zip ints (nub chars)))

prop_abc :: Bool
prop_abc = Just True == fmap (noPrefixStarts . map snd) (frequenciesToCoding $ getTable "abc")

tests :: [(String, IO Result)]
tests = [ qc "prop_toBits_bijection   " prop_toBits_bijection
        , qc "prop_step_size          " prop_step_size
        , qc "prop_step_size2         " prop_step_size2
        , qc "prop_buildB_size        " prop_buildB_size
        , qc "prop_build_size         " prop_build_size
        , qc "prop_frequency_tree_size" prop_frequency_tree_size
        , qc "prop_same_length        " prop_same_length
        , qc "prop_contains_items     " prop_contains_items
        , qc "prop_roundtrip          " prop_roundtrip
        , qc "prop_no_prefix_starts   " prop_no_prefix_starts
        , qc "prop_abc                " prop_abc
        ]
        where
        qc :: Testable prop => t -> prop -> (t, IO Result)
        qc x y = (x, quickCheckResult y)
