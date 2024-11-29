import cupy as cp
import numpy as np
import time

def somatorio(n):
    initial_time=time.time()
    size = n
    numero = cp.random.randint(0,size,size=size)
    end_time = time.time()
    print("Soma:",sum(numero))
    print("Tempo de execução:",end_time-initial_time)
    print("----------------------")

somatorio(10000)
somatorio(100000)
somatorio(1000000)
