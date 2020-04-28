#include "stdio.h"
#include "stdlib.h"
const int NumMax = 10000;
const int ValMax = 1000;

using namespace std;
int main(int argc, char** argv)
{
	FILE * file;
	unsigned int number[NumMax];
	number[0] = atoi(argv[1]);
	printf("%d\n", (unsigned int)number[0]);
	for (int i = 1 ; i <= number[0]; i++)
	{
		number[i] = rand() % ValMax + 1;
	}
	file = fopen("a.in", "wb");
	fwrite(number, sizeof(int), number[0] + 1, file);
	fclose(file);
	return 0;
}
