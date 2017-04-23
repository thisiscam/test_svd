#include <iostream>

#include <cuda_runtime.h>
#include <glm/mat3x3.hpp>
#include <glm/vec3.hpp>

#include "svd.h"
#include "cuda_error.h"

using namespace glm;

__global__
void test_kernel(mat3 *matrix, vec3 *s, mat3 *v)
{
	printf("%p %f\n", s, (*s)[2]);

	if(threadIdx.x == 0) {
		dsvd<3, 3>(*matrix, *s, *v);
	}
}

void test(mat3 &m, vec3 &s, mat3 &v)
{
    // printf("%f %f %f\n", m[0][0], m[1][1], m[2][2]);
	mat3* dm;
	vec3* ds;
	mat3* dv;
	CudaSafeCall(cudaMalloc(&dm, sizeof(mat3)));
	CudaSafeCall(cudaMalloc(&ds, sizeof(vec3)));
	CudaSafeCall(cudaMalloc(&dv, sizeof(mat3)));
	std::cout << ds << std::endl;
	CudaSafeCall(cudaMemcpy(dm, &m, sizeof(mat3), cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemset(ds, 0, sizeof(vec3)));
	CudaSafeCall(cudaMemset(dv, 0, sizeof(mat3)));
	Launch(test_kernel<<<1, 1>>>(dm, ds, dv));
	CudaSafeCall(cudaMemcpy(&m, dm, sizeof(mat3), cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpy(&s, ds, sizeof(vec3), cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpy(&v, dv, sizeof(mat3), cudaMemcpyDeviceToHost));
}