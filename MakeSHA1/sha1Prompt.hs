import Crypto.Hash.SHA1 as SHA1
import qualified Data.ByteString.Lazy.UTF8 as LSU
import qualified Data.ByteString.Base16 as B16

main = do
  putStrLn "Please insert your password and I will generate your SHA-1 hash"
  pass <- getLine
  let bString = LSU.fromString pass
  let hash = B16.encode $ SHA1.hashlazy bString
  print hash

