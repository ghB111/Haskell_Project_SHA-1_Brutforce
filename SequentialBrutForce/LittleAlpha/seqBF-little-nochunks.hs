import Control.Parallel.Strategies
import Crypto.Hash.SHA1 as SHA1
import Control.DeepSeq
import Control.Monad
import System.Environment
import Data.Maybe
import Data.Char
import qualified Data.ByteString.Lazy.UTF8 as LSU
import qualified Data.ByteString.UTF8 as SSU
import qualified Data.ByteString.Lazy as LStr
import qualified Data.ByteString.Base16 as B16
import qualified Data.ByteString.Base16.Lazy as B16L

alphabet :: String
alphabet = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']

checkPass :: String -> SSU.ByteString -> Bool
checkPass pass hash = let bString = SSU.fromString pass
                          assumpt = SHA1.hash bString
                      in if assumpt == hash then True else False

solveSeq1 :: SSU.ByteString -> [String] -> Maybe String
solveSeq1 _ [] = Nothing
solveSeq1 hash (str:strs) = if (checkPass str hash) then Just str else solveSeq1 hash strs

passOfLen n 
  | n == 0    = "":[]
  | n == 1    = [ [c] | c <- alphabet]
  | otherwise = [ c:str | c <- alphabet, str <- passOfLen $ pred n] 

passOfLenNM n
  | n == 0           = passOfLen n
  | otherwise        = passOfLen n ++ (passOfLenNM $ pred n)

main = do
  hash:numberOfChars':_ <- getArgs
  let [(numberOfChars,_)] = reads numberOfChars' :: [(Int, String)]
  let (hashBS, _) = (B16.decode.SSU.fromString) hash
  let passwordSolve = filter (\x -> checkPass x hashBS) $ passOfLenNM numberOfChars
  if null passwordSolve 
  then do 
    putStrLn "\n----------------------FAILURE------------------------" 
    putStrLn "\tWe could not find your password:("
    putStrLn "----------------------+++++++------------------------\n"
  else do 
    putStrLn "\n----------------------SUCCESS------------------------"
    putStrLn $ "\t\tYour password is " ++ (show $ head passwordSolve)
    putStrLn "----------------------+++++++------------------------\n"

