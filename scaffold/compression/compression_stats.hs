
{-# LANGUAGE MagicHash #-}

module Main ( main ) where

-- Internal Imports
--
import Text.Compression.Simple
import GHC.Word

-- External Imports
--
import qualified Data.Binary                as B
import qualified Data.ByteString            as BS
import qualified Data.ByteString.Lazy.Char8 as BSL

-- Main
--
main :: IO ()
main = do
  input <- getContents

  case packString input of (a, Just b ) -> info (length input) a b
                           (_, Nothing) -> print "Couldn't compress string..."

info :: (Show t, B.Binary t) => t -> [(Int, Char)] -> BS.ByteString -> IO ()
info i a b = do
  let fs = map (small . fst) a
  let cs = BSL.pack $ map snd a

  print "Length of input"
  print i

  print "Length of bytes"
  print $ BS.length b

  print "Length of encoded dict packed"
  print $ BSL.length $ B.encode cs

  print "Length of encoded freqs Word32"
  print $ BSL.length $ B.encode fs

  print "Length of encoded tripple:"
  print $ BSL.length $ B.encode (i, a, b)

  print "Frequency table"
  mapM_ print a

small :: Int -> Word32
small = fromIntegral
