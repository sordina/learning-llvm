
module Main ( main ) where

-- Internal Imports
--
import Text.Compression.Simple

-- External Imports
--
import System.IO
import System.Exit
import qualified Data.Binary                as B
import qualified Data.ByteString.Lazy.Char8 as BSL

-- Main
--
main :: IO ()
main = do
  input <- getContents

  case packString input of
    (a, Just b) -> BSL.putStrLn $ B.encode (length input, a, b)
    _           -> hPutStrLn stderr "Error encoding file..." >> exitFailure
