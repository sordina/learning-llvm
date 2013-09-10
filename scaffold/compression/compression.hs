
module Main ( main ) where

-- Internal Imports
--
import Text.Compression.Simple
import GHC.Word

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
    (a, Just b) -> compress (length input) a b
    _           -> hPutStrLn stderr "Error encoding file..." >> exitFailure

compress :: (B.Binary t, B.Binary t1) => t -> [(Int, Char)] -> t1 -> IO ()
compress l a b = do
  let fs = map (small . fst) a
  let cs = BSL.pack $ map snd a

  BSL.putStrLn $ B.encode (l, fs, cs, b)

small :: Int -> Word32
small = fromIntegral
