import Control.Parallel.Strategies hiding (parMap)
import Crypto.Hash.SHA1 as SHA1
import Control.DeepSeq
import Control.Monad
import System.Environment
import Data.Maybe
import Data.Char
import Data.List.Split
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

solveSeq' :: SSU.ByteString -> [String] -> Maybe String
solveSeq' _ [] = Nothing
solveSeq' hash (str:strs) = if (checkPass str hash) then Just str else solveSeq' hash strs

fastSolveChunks :: SSU.ByteString -> [[[String]]] -> Maybe String
fastSolveChunks _ [] = Nothing
fastSolveChunks hashBS (chunk:cs) = 
  let res' = map (solveSeq' hashBS) chunk `using` parList rseq
      res = filter isJust res' in
  if null res then fastSolveChunks hashBS cs else head res

passOfLen n 
  | n == 0    = "":[]
  | n == 1    = [ [c] | c <- alphabet]
  | otherwise = [ c:str | c <- alphabet, str <- passOfLen $ pred n] 

passOfLenNM n
  | n == 0           = passOfLen n
  | otherwise        = passOfLenNM' n [] 0
                        where passOfLenNM' n passes i | n < i = passes
                              passOfLenNM' _ passes i         = passOfLen i ++ passOfLenNM' n passes (succ i)

alphLen :: Int -> Int
alphLen x 
  | x > 3     = (length alphabet)^x
  | otherwise = (length alphabet)^4

main = do
  hash:numberOfChars':chunkSizeMult':_ <- getArgs
  let [(chunkSizeMult, _)] = reads chunkSizeMult' :: [(Float, String)]
  let chunkSize = round $ 52000000 * chunkSizeMult --14776336
  let [(numberOfChars,_)] = reads numberOfChars' :: [(Int, String)]
  let (hashBS, _) = (B16.decode.SSU.fromString) hash
  let aLen = alphLen numberOfChars
  --let res = fastSolveChunks hashBS $ map (\x -> chunksOf (length x `div` 64) x) $ chunksOf (chunkSize `div` 64 ) $ passOfLenNM numberOfChars
  let res = fastSolveChunks hashBS $ map (\x -> chunksOf ((916132832 `div` 1500) `div` 1500) x) $ chunksOf (916132832 `div` 1500) $ passOfLenNM numberOfChars
  if isNothing res
  then do 
    putStrLn "\n----------------------FAILURE------------------------" 
    putStrLn "\tWe could not find your password:("
    putStrLn "----------------------+++++++------------------------\n"
  else do 
    putStrLn "\n----------------------SUCCESS------------------------"
    putStrLn $ "\t\tYour password is " ++ (show $ fromJust $ res)
    putStrLn "----------------------+++++++------------------------\n"

