import Control.Parallel.Strategies
import Crypto.Hash.SHA1 as SHA1
import Control.DeepSeq
import Control.Monad
import System.Environment
import Data.Maybe


solve :: String -> Maybe String
solve str
  | length str `mod` 2 == 0 = Just ""
  | otherwise               = Nothing

main :: IO ()
main = do
  [f] <- getArgs
  file <- readFile f
  let puzzles = lines file
      (as,bs) = splitAt (length puzzles `div` 2) puzzles -- 1
      solutions = runEval $ do
                    as' <- rpar (force (map solve as))   -- 2
                    bs' <- rpar (force (map solve bs))   -- 3
                    rseq as'                             -- 4
                    rseq bs'                             -- 5
                    return (as' ++ bs')                  -- 6
  print (length (filter isJust solutions))

--ghc -O2 name.hs -rtsopts -threaded
--name.exe fileName +RTS -N2 -s