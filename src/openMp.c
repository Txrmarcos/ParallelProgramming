#include <stdio.h>
#include <omp.h>
#include <stdlib.h>
#include <time.h>

void somatorio(int numb) {
	printf("comecando");
	double init_time = omp_get_wtime();
	int n=numb;
	
	int vector[n];
	
	srand(time(NULL));

	for (int i =0; i<n; i++) {
		vector[i] = rand();
	}
	
	
	int num_procs = omp_get_num_procs();
	long long int sum_vector = 0;
	int part_size = n/num_procs;
	#pragma omp parallel for reduction(+:sum_vector)
	for (int i=0; i<num_procs; i++){
		
		int init = part_size * i;
		int end = (i==num_procs - 1)? n : init + part_size;
		long long int sum_part=0;
			
		for (int j=init;j<end;j++){
			sum_vector = sum_vector + vector[j];
		

		}
		sum_vector += sum_part;
		
	}
	double end_time = omp_get_wtime();
	printf("Levou %f segundos para somar todos o indicies do vetor\n", end_time - init_time);
	printf("Soma total do vetor: %lld\n",sum_vector);
	printf("-----------------------------------------------\n");

}

void main() {
	somatorio(10000);
	somatorio(100000);
	somatorio(1000000);

}
