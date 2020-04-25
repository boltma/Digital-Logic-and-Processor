#include "stdio.h"
int main()
{
	int i, n;
	int* arr;
	int* head;
	int* ptr;
	scanf("%d", &n);
	arr = new int[n];
	arr[0] = 0;
	head = new int[2];
	head[0] = 0;
	head[1] = (int)NULL;
	ptr = head;
	for (i = 1; i < n; i++)
	{
		arr[i] = i;
		ptr[1] = (int)new int [2];
		ptr = (int*)ptr[1];
		ptr[0] = i;
		ptr[1] = (int)NULL;
	}
	for (i = 0; i < n; i++)
	{
		printf("%d", arr[i]);
	}
	ptr  = head;
	while (ptr != NULL)
	{
		printf("%d", ptr[0]);
		ptr = (int*)ptr[1];
	}
	//释放内存的部分不需要MIPS实现
	while (head != NULL)
	{
		ptr = (int*)head[1];
		delete head;
		head = ptr;
	}
	delete arr;
	return 0;
}