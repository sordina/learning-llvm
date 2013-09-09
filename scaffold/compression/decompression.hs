
module Main ( main ) where

-- Internal Imports
--
import Text.Compression.Simple

-- External Imports
--
import System.IO
import System.Exit
import qualified Data.ByteString      as BS
import qualified Data.ByteString.Lazy as BSL
import qualified Data.Binary          as B

-- Main
--
main :: IO ()
main = do
  input <- BSL.getContents

  let (len, table, bytes) = metadata input

  case frequenciesToCoding table of
    Just t  -> putStrLn $ take len $ unpackString t bytes
    Nothing -> hPutStrLn stderr "Error Decoding File" >> exitFailure

metadata :: BSL.ByteString -> (Int, [(Int, Char)], BS.ByteString)
metadata = B.decode
