module Main (main) where

-- Module Tests
import qualified Text.Compression.Simple as Simple

-- Main
main :: IO ()
main = mapM_ (\(x,y) -> print x >> y) Simple.test
