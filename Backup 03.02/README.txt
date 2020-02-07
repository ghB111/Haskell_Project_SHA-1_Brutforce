Эффективная C-библиотека
----------------------------------------------------\
https://hackage.haskell.org/package/cryptohash-sha1 |
----------------------------------------------------/

Менее эффективная Pure-Haskell библиотека:
-------------------------------------------------------------------------------\
http://hackage.haskell.org/package/cryptohash-0.11.9/docs/Crypto-Hash-SHA1.html |
-------------------------------------------------------------------------------/
----------------------------------------------------------------------------------------\
http://hackage.haskell.org/package/cryptohash-sha1-0.11.100.1/docs/Crypto-Hash-SHA1.html |
----------------------------------------------------------------------------------------/


https://www.google.com/search?q=dieVerbatim%3A+user+error+(cabal%3A+%27C%3A%5CWindows%5CSYSTEM32%5Ccurl.exe%27+exited+with+an+error%3A+curl%3A+(6)+Could+not+resolve+host%3A+objects-us-east-1.dream.io+)&oq=dieVerbatim%3A+user+error+(cabal%3A+%27C%3A%5CWindows%5CSYSTEM32%5Ccurl.exe%27+exited+with+an+error%3A+curl%3A+(6)+Could+not+resolve+host%3A+objects-us-east-1.dream.io+)&aqs=chrome..69i57j69i58.936j0j7&sourceid=chrome&ie=UTF-8

Нужно узнать, каковы размеры пула спарков, чтобы не было overflow

Компиляция и запуск:
ghc -O2 haskOneFromFile.hs -rtsopts -threaded

haskOneFromFile.exe words.txt +RTS -N2 -s

haskOneFromFile.exe words.txt +RTS -?
(для справки)