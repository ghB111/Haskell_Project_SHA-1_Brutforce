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

{-checkPass
let bString = LSU.fromString pass
let hash = B16.encode $ SHA1.hashlazy bString --lookup for base 16 stuff-}

passOfLen n 
  | n == 0    = "":[]
  | n == 1    = [ [c] | c <- alphabet]
  | otherwise = [ c:str | c <- alphabet, str <- passOfLen $ pred n] 

passOfLenNM n
  | n == 0 || n == 1 = passOfLen n
  | otherwise        = passOfLen n ++ (passOfLenNM $ pred n)

main = do
  putStrLn "Please insert your SHA-1 and I will return your password"
  hash <- getLine
  let (hashBS, _) = (B16.decode.SSU.fromString) hash
  print hashBS
  return ()

