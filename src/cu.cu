#include <iostream>
#include <iomanip>
#include <cuda_runtime.h>
#include <cstdlib> // Para rand() e srand()
#include <ctime>   // Para time()

// Kernel para somar elementos do vetor
__global__ void sumReduce(float *input, float *result, int n) {
    extern __shared__ float shared_data[];
    int tid = threadIdx.x;
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    // Carrega os dados do vetor global para memória compartilhada
    shared_data[tid] = (idx < n) ? input[idx] : 0.0f;
    __syncthreads();

    // Redução em memória compartilhada
    for (int stride = blockDim.x / 2; stride > 0; stride >>= 1) {
        if (tid < stride) {
            shared_data[tid] += shared_data[tid + stride];
        }
        __syncthreads();
    }

    // O resultado da soma é armazenado na primeira posição
    if (tid == 0) {
        atomicAdd(result, shared_data[0]);
    }
}

void part(int n) {
    const int N = n; // Tamanho do vetor (1 milhão de elementos)
    const int BLOCK_SIZE = 256;

    // Inicializar o gerador de números aleatórios
    srand(static_cast<unsigned int>(time(0)));

    // Alocar e inicializar vetor no host (CPU)
    float *h_input = new float[N];
    for (int i = 0; i < N; i++) {
        h_input[i] = static_cast<float>(rand() % 1000001); // Gera valores aleatórios entre 0 e 1000000
    }
    float h_result = 0.0f;

    // Alocar memória no dispositivo (GPU)
    float *d_input, *d_result;
    cudaMalloc((void **)&d_input, N * sizeof(float));
    cudaMalloc((void **)&d_result, sizeof(float));

    // Copiar dados do host para o dispositivo
    cudaMemcpy(d_input, h_input, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_result, &h_result, sizeof(float), cudaMemcpyHostToDevice);

    // Configurar grid e blocos
    int grid_size = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;

    // Medir tempo de execução
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    // Executar o kernel
    sumReduce<<<grid_size, BLOCK_SIZE, BLOCK_SIZE * sizeof(float)>>>(d_input, d_result, N);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    // Calcular tempo de execução
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    // Copiar o resultado de volta para o host
    cudaMemcpy(&h_result, d_result, sizeof(float), cudaMemcpyDeviceToHost);

    // Imprimir o resultado no formato decimal
    std::cout << std::fixed << std::setprecision(6);
    std::cout << "Sum: " << h_result << std::endl;
    std::cout << "Tempo de execução: " << milliseconds << " ms" << std::endl;

    // Liberar memória
    delete[] h_input;
    cudaFree(d_input);
    cudaFree(d_result);
}

int main(){
	part(10000);
	part(100000);
	part(1000000);
	return 0;

}

