#include "stdio.h"
/*
  课件上的冒泡排序的例子，通过两重循环不断比较相邻两个元素的大小并交换。
*/
int swap(int v[], int k)
{
	int temp;
	temp = v[k];
	v[k] = v[k + 1];
	v[k + 1] = temp;
	return 0;
}

int bubsort(int v[], int n)
{
	int i, j;
	for (i = 0; i < n; i++)
	{
		for (j = i - 1; j >= 0 && v[j] > v[j + 1]; j--)
		{
			swap(v, j);
		}
	}
	return 0;
}

int main()
{
	FILE *infile, *outfile;
	int buffer [1001];
	infile = fopen("a.in", "rb");
	fread(buffer, 4, 1001, infile);
	fclose(infile);
	int N = buffer[0];
	bubsort(&(buffer[1]), N);
	outfile = fopen("a.out", "wb");
	fwrite(&(buffer[1]), 4, N, outfile);
	fclose(outfile);
	return 0;
}
