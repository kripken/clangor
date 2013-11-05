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
cat utils/TableGen/Makefile | grep -v llvm-tblgen > utils/TableGen/Makefile # XXX untested

cp ../native/Debug+Asserts/bin/llvm-config Release/bin
chmod +x Release/bin/llvm-config
cat tools/llvm-config/Makefile | grep -v TOOLNAME > tools/llvm-config/Makefile # XXX untested

cp ../native/Debug+Asserts/bin/clang-tblgen Release/bin
chmod +x Release/bin/clang-tblgen
cat tools/clang/utils/TableGen/Makefile | grep -v clang-tblgen > tools/clang/utils/TableGen/Makefile # XXX untested

cp Release/bin/clang clang.bc
EMCC_DEBUG=1 ~/Dev/emscripten/emcc -O2 -g2 clang.bc

