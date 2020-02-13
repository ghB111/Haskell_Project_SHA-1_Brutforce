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
--import Data.ByteString.Conversion
import qualified Data.ByteString.Base16 as B16
import qualified Data.ByteString.Base16.Lazy as B16L

alphabet :: String
alphabet = " !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" ++ ['a'..'z'] ++ ['A'..'Z']

--main = print $ SHA1.hashlazy (LStr.pack [0..255])

--allPosPass = [ c : s | s <- "" : allPosPass, c <- alphabet] -- returns ALL possible passwords

checkPass :: String -> SSU.ByteString -> Bool
checkPass pass hash = let bString = SSU.fromString pass
                          assumpt = SHA1.hash bString
                      in if assumpt == hash then True else False

solveSeq1 :: SSU.ByteString -> [String] -> Maybe String
solveSeq1 _ [] = Nothing
solveSeq1 hash (str:strs) = if (checkPass str hash) then Just str else solveSeq1 hash strs

--solveSeq :: SSU.ByteString -> [String] -> [String]


passOfLen n 
  | n == 0    = "":[]
  | n == 1    = [ [c] | c <- alphabet]
  | otherwise = [ c:str | c <- alphabet, str <- passOfLen $ pred n] 

passOfLenNM n
  | n == 0 || n == 1 = passOfLen n
  | otherwise        = passOfLen n ++ (passOfLenNM $ pred n)

main = do
  --putStrLn "Please insert your SHA-1 and I will return your password"
  hash:numberOfChars':_ <- getArgs
  let [(numberOfChars,_)] = reads numberOfChars' :: [(Int, String)]
  let (hashBS, _) = (B16.decode.SSU.fromString) hash
  --let passwordSolve = solveSeq hashBS $ passOfLenNM 2
  let passwordSolve = filter (\x -> checkPass x hashBS) $ passOfLenNM numberOfChars
  --if isNothing passwordSolve then putStrLn "Couldn't find a match, sorry!" else putStrLn $ fromJust passwordSolve
  if null passwordSolve then putStrLn "----------------------FAILURE------------------------" 
  else do 
    putStrLn "\n----------------------SUCCESS------------------------"
    putStrLn $ "\t\tYour password is " ++ (show $ head passwordSolve)
    putStrLn "----------------------+++++++------------------------\n"
  --end <- getLine
  return ()

