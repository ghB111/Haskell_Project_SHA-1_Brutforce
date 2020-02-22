@echo off
pushd %~dp0
for /R %%x in (*.hs) do (
	ghc -O2 %%x -threaded -rtsopts -eventlog
)
del /Q /S "*.o"
del /Q /S "*.hi"

for /r %%x in (*.exe) do move "%%x" ".\Compiled"

popd