#include "stdio.h"
/*
  快速排序的核心是寻找一个参考值 ， 将其放置到正确的位置上 ，
  再递归处理其左序列和右序列 ， 递归边界为当前序列长度为 1。
*/
int quickSort(int * arr, int left, int right)
{
	int i = left, j = right;
	int key = arr[left]; // 设置基准值
	while (1)            // 此循环将基准值放在正确的位置上
	{
		while (arr[j] >= key && i < j) j --;
		while (arr[i] <= key && i < j) i ++;
		if (i >= j)
		{
			break;
		}
		int tmp;
		tmp = arr[i];
		arr[i] = arr[j];
		arr[j] = tmp;
	}
	arr[left] = arr[i];
	arr[i] = key;
	if (left < i - 1) quickSort(arr, left, i - 1); // 处理左序列
	if (i + 1 < right) quickSort(arr, i + 1, right); // 处理右序列
	return 0;
}

int main()
{
	FILE * infile, *outfile;
	int buffer [1001];
	infile = fopen("a.in", "rb");
	fread(buffer, 4, 1001, infile);
	fclose(infile);
	int N = buffer[0];
	quickSort(buffer, 1, N);
	outfile = fopen("a.out", "wb");
	fwrite(&(buffer[1]), 4, N, outfile);
	fclose(outfile);
	return 0;
}
