# nvcc daxy example

An example to illustate all the intermediate output during nvcc compilation.

This could help you have better understand of the cuda compilate trajectory in the [nvcc manual](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html#cuda-compilation-trajectory).

![CUDA Compilation from .cu to an executable](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/graphics/cuda-compilation-from-cu-to-executable.png)

The command to get all the intermediate commands is:

```bash
nvcc -o daxpy daxpy.cu -arch=sm_75 --verbose 2> nvcc_verbose.log
```

The `*.dump` file is created with:

```bash
cuobjdump --dump-elf x.cubin > x.cubin.dump
```
