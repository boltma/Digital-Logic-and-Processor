#include "stdio.h"
int main()
{
	FILE * infile, *outfile;
	int i;
	int* buffer;
	buffer = new int[1];
	infile = fopen("a.in", "rb");
	fread(buffer, 4, 1, infile);
	fclose(infile);
	scanf("%d", &i);
	buffer[0] = buffer[0] + i;
	printf("%d", buffer[0]);
	outfile = fopen("a.out", "wb");
	fwrite(buffer, 4, 1, outfile);
	fclose(outfile);
	return 0;
}
