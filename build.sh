#
cd native
../configure
make -j 4
cd ..
cd js
~/Dev/emscripten/emconfigure ../configure --disable-assertions --enable-optimized
make
# copy native tblgen, and remove makefile command to build it from js so we don't replace the native one
cp ../native/Debug+Asserts/bin/llvm-tblgen Release/bin
chmod +x Release/bin/llvm-tblgen
cat utils/TableGen/Makefile | grep -v llvm-tblgen > utils/TableGen/Makefile

