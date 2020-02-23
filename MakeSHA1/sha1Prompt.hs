--import Control.Parallel.Strategies
import Crypto.Hash.SHA1 as SHA1
--import Control.DeepSeq
--import Control.Monad
--import System.Environment
--import Data.Maybe
--import Data.Char
import qualified Data.ByteString.Lazy.UTF8 as LSU
--import qualified Data.ByteString.UTF8 as SSU
--import qualified Data.ByteString.Lazy as LStr
--import Data.ByteString.Conversion
import qualified Data.ByteString.Base16 as B16
--import qualified Data.ByteString.Base16.Lazy as B16L

alphabet :: String
alphabet = " !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" ++ ['a'..'z'] ++ ['A'..'Z']

--main = print $ SHA1.hashlazy (LStr.pack [0..255])

main = do
  putStrLn "Please insert your password and I will generate your SHA-1 hash"
  pass <- getLine
  let bString = LSU.fromString pass
  let hash = B16.encode $ SHA1.hashlazy bString --lookup for base 16 stuff
  print hash

