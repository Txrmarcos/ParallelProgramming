import threading
import time
import random


# Função principal
def sumWithThreads(numeros):
    resultados = [0, 0]  # Lista para armazenar os resultados das threads
    t1 = time.time()
    # Cria duas threads para calcular as somas parciais
    thread1 = threading.Thread(target=sumLists, args=(numeros[:len(numeros) // 2], resultados, 0))
    thread2 = threading.Thread(target=sumLists, args=(numeros[len(numeros) // 2:], resultados, 1))

    # Inicia as threads
    thread1.start()
    thread2.start()

    # Aguarda as threads terminarem
    thread1.join()
    thread2.join()

    # Soma total é a soma dos resultados das duas threads
    soma = sum(resultados)
    t2 = time.time()
    print("Tempo de execução =", t2 - t1)
    print("Soma total:", soma)
    print("------------------------------")

# Função que calcula a soma de uma sublista e armazena o resultado em uma lista de resultados
def sumLists(sublista, resultados, indice):
    resultados[indice] = sum(sublista)


if __name__ == '__main__':
    
    data0 = [random.randint(1, 10000) for _ in range(10000)]
    data1 = [random.randint(1, 100000) for _ in range(100000)]
    data2 = [random.randint(1, 1000000) for _ in range(1000000)]

    sumWithThreads(data0)
    sumWithThreads(data1)
    sumWithThreads(data2)
