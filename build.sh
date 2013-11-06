#
cd native
../configure --enable-optimized --disable-assertions --disable-jit --disable-threads --disable-pthreads --enable-targets=sparc
make -j 4
cd ..
cd js
~/Dev/emscripten/emconfigure ../configure --enable-optimized --disable-assertions --disable-jit --disable-threads --disable-pthreads --enable-targets=sparc
make
# copy native tblgen, and remove makefile command to build it from js so we don't replace the native one
cp ../native/Release/bin/llvm-tblgen Release/bin
chmod +x Release/bin/llvm-tblgen
cat utils/TableGen/Makefile | grep -v llvm-tblgen > utils/TableGen/Makefile # XXX untested

cp ../native/Release/bin/llvm-config Release/bin
chmod +x Release/bin/llvm-config
cat tools/llvm-config/Makefile | grep -v TOOLNAME > tools/llvm-config/Makefile # XXX untested

cp ../native/Release/bin/clang-tblgen Release/bin
chmod +x Release/bin/clang-tblgen
cat tools/clang/utils/TableGen/Makefile | grep -v clang-tblgen > tools/clang/utils/TableGen/Makefile # XXX untested

cp Release/bin/clang clang.bc
EMCC_DEBUG=1 ~/Dev/emscripten/emcc -O2 clang.bc -o clang.js -s ASM_JS=2 -s OUTLINING_LIMIT=110000

# see js/test.html

#
#var __str127124057$0 = 0;
#var __str127124057$1 = 1;
#var __str1143224$0 = 0;
#var __str1143224$1 = 1;
#var __str1022046$0 = 0;
#var __str1022046$1 = 1;
#
