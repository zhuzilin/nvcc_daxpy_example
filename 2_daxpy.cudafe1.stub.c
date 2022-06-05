#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wcast-qual"
#define __NV_CUBIN_HANDLE_STORAGE__ static
#if !defined(__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__)
#define __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__
#endif
#include "crt/host_runtime.h"
#include "daxpy.fatbin.c"
extern void __device_stub__Z4initiPdd(int, double *, double);
extern void __device_stub__Z5daxpyidPdS_(int, double, double *, double *);
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll(void) __attribute__((__constructor__));
void __device_stub__Z4initiPdd(int __par0, double *__par1, double __par2){__cudaLaunchPrologue(3);__cudaSetupArgSimple(__par0, 0UL);__cudaSetupArgSimple(__par1, 8UL);__cudaSetupArgSimple(__par2, 16UL);__cudaLaunch(((char *)((void ( *)(int, double *, double))init)));}
# 3 "daxpy.cu"
void init( int __cuda_0,double *__cuda_1,double __cuda_2)
# 3 "daxpy.cu"
{__device_stub__Z4initiPdd( __cuda_0,__cuda_1,__cuda_2);




}
# 1 "daxpy.cudafe1.stub.c"
void __device_stub__Z5daxpyidPdS_( int __par0,  double __par1,  double *__par2,  double *__par3) {  __cudaLaunchPrologue(4); __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(int, double, double *, double *))daxpy))); }
# 10 "daxpy.cu"
void daxpy( int __cuda_0,double __cuda_1,double *__cuda_2,double *__cuda_3)
# 10 "daxpy.cu"
{__device_stub__Z5daxpyidPdS_( __cuda_0,__cuda_1,__cuda_2,__cuda_3);




}
# 1 "daxpy.cudafe1.stub.c"
static void __nv_cudaEntityRegisterCallback( void **__T0) {  __nv_dummy_param_ref(__T0); __nv_save_fatbinhandle_for_managed_rt(__T0); __cudaRegisterEntry(__T0, ((void ( *)(int, double, double *, double *))daxpy), _Z5daxpyidPdS_, (-1)); __cudaRegisterEntry(__T0, ((void ( *)(int, double *, double))init), _Z4initiPdd, (-1)); }
static void __sti____cudaRegisterAll(void) {  __cudaRegisterBinary(__nv_cudaEntityRegisterCallback);  }

#pragma GCC diagnostic pop
