module Main (main) where

-- Module Tests
import qualified Text.Compression.Simple as Simple
import qualified Test.QuickCheck as QC
import System.Exit

-- Main
main :: IO ()
main = do
  res <- mapM test Simple.tests
  if (and res) then return ()
               else exitFailure

test :: (String, IO QC.Result) -> IO Bool
test (label,action) = do
  res <- action
  case res of QC.Success _ _ _ -> return True
              QC.GaveUp  _ _ _ -> return True
              _                -> putStrLn ("FAILED => " ++ label) >> return False
