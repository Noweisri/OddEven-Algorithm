// please be noted that This programm will not work without nvidia cuda toolKit, or with google colab
// Odd-Even algorithm but in parallel using cuda instructions
// the function is in the device (GPU), but the main is in the host (CPU) 
%%cu
#include<stdio.h>
#include<cuda.h>
#define swap(A,B) {int temp=A;A=B;B=temp;}

__global__ void OddEvenSort(int *d_arr , int size, int step)
{
  
  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  
  if(idx % 2 == step && idx < size - 1)
    if(d_arr[idx] > d_arr[idx + 1]){
      swap(d_arr[idx],d_arr[idx + 1]);
    }
  __syncthreads();
}


int main(void)
{
  int blocks  = 1024;
  int threads = 1024;
  int arr[30];
  int *d_arr;
  int n       = sizeof(arr) / sizeof(arr[0]);
  int size    = sizeof(int) * n;
  int a;


  printf("The original array  : {");
 
  // Random variable assigned for the array  
  for (int i = 0; i < n - 2; i++) 
  {
    arr[i] = rand()%29; 
    printf(" %d ,", arr[i]);
  }
  arr[29] = rand()%29; 
  printf(" %d ", arr[29]);
  printf("}\n");


  // allocate array in device
  cudaMalloc(&d_arr , size);

  // copy host copy to device copy array
  cudaMemcpy(d_arr , arr , size , cudaMemcpyHostToDevice);


  if( n % 2 == 0)
    a = n / 2;
    else
      a = n / 2 + 1;

  // calling the kernel
  for (int i = 0; i < a; i++)
  {
    
    // odd step
    OddEvenSort <<< blocks , threads >>> (d_arr, n, 1);
   

    // even step
    OddEvenSort <<< blocks , threads >>> (d_arr, n, 0);
    
  }

  cudaDeviceSynchronize();

  // copy results back to host array
  cudaMemcpy(arr , d_arr , size , cudaMemcpyDeviceToHost);

  // free
  cudaFree(d_arr);

  // print results
  printf("array after sorting : { ");
  for (int i = 0 ; i < n - 2 ; i++)
    printf("%d , ", arr[i]);

  printf("%d }", arr[28]);

return 0;
}