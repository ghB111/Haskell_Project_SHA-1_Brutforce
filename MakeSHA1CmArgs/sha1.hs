import Crypto.Hash.SHA1 as SHA1
import System.Environment
import qualified Data.ByteString.UTF8 as SSU
import qualified Data.ByteString.Base16 as B16

main = do
  pass:_ <- getArgs
  let bString = SSU.fromString pass
  let hash = B16.encode $ SHA1.hash bString
  putStrLn $  SSU.toString hash

