#include <stdio.h>

__global__ void init(int n, double *x, double val) {
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  for (int i = index; i < n; i += gridDim.x * blockDim.x) {
    x[i] = val;
  }
}

__global__ void daxpy(int n, double alpha, double *x, double *y) {
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  for (int i = index; i < n; i += gridDim.x * blockDim.x) {
    y[i] = alpha * x[i] + y[i];
  }
}

int main() {
  int n = 1024;
  double *h_x, *h_y;
  cudaHostAlloc(&h_x, n * sizeof(double), cudaHostAllocDefault);
  cudaHostAlloc(&h_y, n * sizeof(double), cudaHostAllocDefault);

  double *d_x, *d_y;
  cudaMalloc(&d_x, n * sizeof(double));
  cudaMalloc(&d_y, n * sizeof(double));

  init<<<4, 128>>>(n, d_x, 4);
  init<<<4, 128>>>(n, d_y, 4);
  daxpy<<<4, 128>>>(n, 2, d_x, d_y);

  cudaMemcpyAsync(h_x, d_x, n * sizeof(double), cudaMemcpyDeviceToHost);
  cudaMemcpyAsync(h_y, d_y, n * sizeof(double), cudaMemcpyDeviceToHost);
  cudaFree(d_x);
  cudaFree(d_y);

  double mean = 0;
  for (int i = 0; i < n; i++) {
    mean += h_y[i] + h_x[i];
  }
  mean /= n;
  printf("mean: %f", mean);
}
