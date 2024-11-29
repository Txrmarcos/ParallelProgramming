Comparação de Resultados - Testes de Vetores

## Introdução

Este documento apresenta a comparação dos tempos de execução e os resultados do somatório de elementos de vetores de diferentes tamanhos (10.000, 100.000 e 1.000.000). Foram utilizados quatro abordagens diferentes:

1. CUDA
2. OpenMP
3. Python Threads
4. CuPy Python

## Resultados

| **Tamanho do Vetor** | **CUDA (Tempo Execução - ms)** | **OpenMP (Tempo Execução - s)** | **Threads Python (Tempo Execução - s)** | **CuPy Python (Tempo Execução - s)** | **CUDA (Soma Total)** | **OpenMP (Soma Total)** | **Threads Python (Soma Total)** | **CuPy Python (Soma Total)** |
| -------------------------- | -------------------------------------- | --------------------------------------- | ----------------------------------------------- | -------------------------------------------- | --------------------------- | ----------------------------- | ------------------------------------- | ---------------------------------- |
| 10.000                     | 0.002750                               | 0.015870                                | 0.000680                                        | 0.237164                                     | 4,998,851,588               | 10,763,146,675,099            | 50,307,628                            | 50,135,797                         |
| 100.000                    | 0.011303                               | 0.069055                                | 0.012233                                        | 0.002750                                     | 500,480,218,876             | 107,639,204,362,491           | 5,007,618,602                         | 5,013,857                          |
| 1.000.000                  | 0.030720                               | 0.030951                                | 0.015002                                        | 0.001130                                     | 4,999,389,464,576           | 1,073,932,068,576,145         | 499,877,229,954                       | 500,480,218,876                    |
