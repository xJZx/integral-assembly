#include <stdio.h>
//#include <fenv.h>
//#include <errno.h>

extern double integral2(int n, int a, int b);
extern float integralFaster(float n, float a, float b);
extern void precision();
extern unsigned long long int rdtsc_p(char b, int i); 

int main(void){
	//feclearexcept(FE_ALL_EXCEPT);

	//precision();	
	unsigned long long int t1s, t1k, t1, t2s, t2k, t2;

	double integralVar = 0;
	t1s = rdtsc_p(0, 100);
	integralVar = integral2(1000, 0, 1);
	t1k = rdtsc_p(0, 100);
	t1 = t1k - t1s;

	float integralFasterVar = 0;
	t2s = rdtsc_p(0, 100);
	integralFasterVar = integralFaster(1000, 0, 1);
	t2k = rdtsc_p(0, 100);
	t2 = t2k - t2s;

	//precision();
	
	//double integral2Var = 0;
	//integral2Var = integral2(10, 0, 1);
	
	/*if (fetestexcept(FE_INVALID)){
		printf("Floating Point Exception");
	}
	else{
		printf("integral 1: %f", integralVar);
		printf("integral 2: %lf", integral2Var);
	}*/
	
	printf("integral 1: %lf\n", integralVar);
	printf("time 1: %llu\n", t1);
        printf("integral 2: %f\n", integralFasterVar);
	printf("time 2: %llu\n", t2);

	return 0;
}
