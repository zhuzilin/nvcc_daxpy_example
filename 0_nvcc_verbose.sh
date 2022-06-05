#$ _NVVM_BRANCH_=nvvm
#$ _SPACE_= 
#$ _CUDART_=cudart
#$ _HERE_=/usr/local/cuda/bin
#$ _THERE_=/usr/local/cuda/bin
#$ _TARGET_SIZE_=
#$ _TARGET_DIR_=
#$ _TARGET_DIR_=targets/x86_64-linux
#$ TOP=/usr/local/cuda/bin/..
#$ NVVMIR_LIBRARY_DIR=/usr/local/cuda/bin/../nvvm/libdevice
#$ LD_LIBRARY_PATH=/usr/local/cuda/bin/../lib:
#$ PATH=/usr/local/cuda/bin/../nvvm/bin:/usr/local/cuda/bin:/usr/local/cuda/bin/:/home/mpi/zilin_disk/envs/base/bin:/home/mpi/zilin_disk/envs/base/condabin:/home/mpi/.vscode-server/bin/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/bin/remote-cli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
#$ INCLUDES="-I/usr/local/cuda/bin/../targets/x86_64-linux/include"  
#$ LIBRARIES=  "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib/stubs" "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib"
#$ CUDAFE_FLAGS=
#$ PTXAS_FLAGS=

# 1
gcc -D__CUDA_ARCH__=750 -D__CUDA_ARCH_LIST__=750 -E -x c++  \
  -DCUDA_DOUBLE_MATH_FUNCTIONS -D__CUDACC__ -D__NVCC__  \
  "-I/usr/local/cuda/bin/../targets/x86_64-linux/include"    \
  -D__CUDACC_VER_MAJOR__=11 -D__CUDACC_VER_MINOR__=6 -D__CUDACC_VER_BUILD__=112 \
  -D__CUDA_API_VER_MAJOR__=11 -D__CUDA_API_VER_MINOR__=6 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
  -include "cuda_runtime.h" -m64 "daxpy.cu" -o "daxpy.cpp1.ii"

# 2
cicc --c++14 --gnu_version=90300 --display_error_number \
  --orig_src_file_name "daxpy.cu" \
  --orig_src_path_name "/home/mpi/nvcc_example/daxpy.cu" \
  --allow_managed   -arch compute_75 -m64 --no-version-ident \
  -ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 \
  --include_file_name "daxpy.fatbin.c" \
  -tused --gen_module_id_file \
  --module_id_file_name "daxpy.module_id" \
  --gen_c_file_name "daxpy.cudafe1.c" \
  --stub_file_name "daxpy.cudafe1.stub.c" \
  --gen_device_file_name "daxpy.cudafe1.gpu"  \
  "daxpy.cpp1.ii" \
  -o "daxpy.ptx"

# 3
ptxas -arch=sm_75 -m64  "daxpy.ptx" -o "daxpy.sm_75.cubin"

# 4
fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " \
  "--image3=kind=elf,sm=75,file=daxpy.sm_75.cubin" \
  "--image3=kind=ptx,sm=75,file=daxpy.ptx" \
  --embedded-fatbin="daxpy.fatbin.c"

rm daxpy.fatbin

# 5
gcc -D__CUDA_ARCH_LIST__=750 -E -x c++ \
  -D__CUDACC__ -D__NVCC__  \
  "-I/usr/local/cuda/bin/../targets/x86_64-linux/include"   \
  -D__CUDACC_VER_MAJOR__=11 -D__CUDACC_VER_MINOR__=6 -D__CUDACC_VER_BUILD__=112 \
  -D__CUDA_API_VER_MAJOR__=11 -D__CUDA_API_VER_MINOR__=6 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
  -include "cuda_runtime.h" -m64 "daxpy.cu" -o "daxpy.cpp4.ii"

# 6
cudafe++ --c++14 --gnu_version=90300 --display_error_number \
  --orig_src_file_name "daxpy.cu" \
  --orig_src_path_name "/home/mpi/nvcc_example/daxpy.cu" \
  --allow_managed  --m64 --parse_templates \
  --gen_c_file_name "daxpy.cudafe1.cpp" \
  --stub_file_name "daxpy.cudafe1.stub.c" \
  --module_id_file_name "daxpy.module_id" \
  "daxpy.cpp4.ii"

# 7
gcc -D__CUDA_ARCH__=750 -D__CUDA_ARCH_LIST__=750 -c -x c++  \
  -DCUDA_DOUBLE_MATH_FUNCTIONS "-I/usr/local/cuda/bin/../targets/x86_64-linux/include"   \
  -m64 "daxpy.cudafe1.cpp" \
  -o "daxpy.o"

# 8
nvlink -m64 --arch=sm_75 \
  --register-link-binaries="daxpy_dlink.reg.c"    \
  "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib/stubs" \
  "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib" \
  -cpu-arch=X86_64 "daxpy.o"  \
  -lcudadevrt  -o "daxpy_dlink.sm_75.cubin"

# 9
fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " \
  -link "--image3=kind=elf,sm=75,file=daxpy_dlink.sm_75.cubin" \
  --embedded-fatbin="daxpy_dlink.fatbin.c"

rm /tmp/tmpxft_0004e690_00000000-8_daxpy_dlink.fatbin

# 10
gcc -D__CUDA_ARCH_LIST__=750 -c -x c++ \
  -DFATBINFILE="\"daxpy_dlink.fatbin.c\"" \
  -DREGISTERLINKBINARYFILE="\"daxpy_dlink.reg.c\"" \
  -I. -D__NV_EXTRA_INITIALIZATION= -D__NV_EXTRA_FINALIZATION= \
  -D__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__  \
  "-I/usr/local/cuda/bin/../targets/x86_64-linux/include"    \
  -D__CUDACC_VER_MAJOR__=11 -D__CUDACC_VER_MINOR__=6 -D__CUDACC_VER_BUILD__=112 \
  -D__CUDA_API_VER_MAJOR__=11 -D__CUDA_API_VER_MINOR__=6 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
  -m64 "/usr/local/cuda/bin/crt/link.stub" \
  -o "daxpy_dlink.o"

# 11
g++ -D__CUDA_ARCH_LIST__=750 -m64 -Wl,--start-group \
  "daxpy_dlink.o" "daxpy.o"   \
  "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib/stubs" \
  "-L/usr/local/cuda/bin/../targets/x86_64-linux/lib"  \
  -lcudadevrt  -lcudart_static  -lrt -lpthread  -ldl  -Wl,--end-group \
  -o "daxpy" 
