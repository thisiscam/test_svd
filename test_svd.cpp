#include <iostream>

#include <glm/mat3x3.hpp>
#include <glm/vec3.hpp>
#include <glm/ext.hpp>

using namespace glm;

extern void test(mat3 &m, vec3 &s, mat3 &v);


int main(int argc, char const *argv[])
{
	mat3 m = mat3(3); /* eye */
	vec3 s;
	mat3 v;

	test(m, s, v);

	std::cout<<glm::to_string(m)<<std::endl;
	std::cout<<glm::to_string(s)<<std::endl;
	std::cout<<glm::to_string(v)<<std::endl;
}