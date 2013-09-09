
module Main ( main ) where

-- Internal Imports
--
import Text.Compression.Simple

-- External Imports
--
import Data.List.Split
import qualified Data.ByteString as BS

-- Main
--
main :: IO ()
main = do
  input <- getContents

  let
    packedLength = fmap BS.length (snd outcome)
    outcome      = packString input

  print $ "Initial length of input:    " ++ show (Just $ length input)
  print $ "Compressed length of input: " ++ show packedLength
  print "Frequency Table:"

  mapM_ print $ chunksOf 4 $ fst outcome
