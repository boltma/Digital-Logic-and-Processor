#include "stdio.h"
int main()
{
	int i, j, temp;
	scanf("%d", &i);
	scanf("%d", &j);
	while (i != 0 && j != 0)
	{
		if (j > i)
		{
			temp = i;
			i = j;
			j = temp;
		}
		i = i - j;
	}
	printf("%d", j);
	return 0;
}
