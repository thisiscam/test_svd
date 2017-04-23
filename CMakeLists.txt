cmake_minimum_required(VERSION 3.0)

project(test_svd)

find_package(CUDA REQUIRED)

include_directories(eigen/)
include_directories(glm)

cuda_add_executable(
	test_svd
	test_svd.cu
	test_svd.cpp
)