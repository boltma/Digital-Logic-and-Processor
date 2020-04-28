#include "stdio.h"
/*
链表的归并排序的核心是将链表分成前后两段 ，
分别排序后对两个有序链表归并 ， 递归边界是当前链表长度为 1。
*/

// 两个有序链表合并 ， 将右链元素插入到左链中 。
int * merge(int * l_head, int * r_head)
{
// 这里构建一个虚拟头结点 ， 方便在第一个元素前插入 。
	int * head = new int[2];
	head [1] = (int) l_head;
	int * p_left = head;
	int * p_right = r_head;
	do
	{
		do // 寻找左链中的插入位置
		{
			if (p_left[1] == (int)NULL) break;
			if (((int *)p_left[1])[0] > p_right[0]) break;
			p_left = (int *)p_left[1];
		}
		while (1);
		// 如果到达左链尾端 ， 右链直接接上
		if (p_left[1] == (int)NULL)
		{
			p_left[1] = (int)p_right;
			break;
		}
		int * p_right_temp = p_right;
		do // 寻找右链待插入片段
		{
			if (p_right_temp[1] == (int)NULL) break;
			if (((int *)p_right_temp[1])[0] > ((int *)p_left[1])[0])
				break;
			p_right_temp = (int *)p_right_temp[1];
		}
		while (1);
		// 完成插入操作
		int * temp_right_pointer_next = (int *)p_right_temp[1];
		p_right_temp[1] = p_left[1];
		p_left[1] = (int) p_right;
		p_left = p_right_temp;
		p_right = temp_right_pointer_next;
		if (p_right == NULL) break;
	}
	while (1);
	int rv = head[1];

	delete head;
	return (int *) rv;
}

// 归并排序主函数 ， 先找链表中点 ， 再分别排序 ， 最后归并
int * msort(int * head)
{
	if (head[1] == (int)NULL) return head;
	int * stride_2_pointer = head;
	int * stride_1_pointer = head;
	do // 通过同时进行步长为 1 和步长为 2 的跳转找中点
	{
		if (stride_2_pointer[1] == (int)NULL) break;
		stride_2_pointer = (int *) stride_2_pointer [1];
		if (stride_2_pointer[1] == (int)NULL) break;
		stride_2_pointer = (int *) stride_2_pointer [1];
		stride_1_pointer = (int *) stride_1_pointer [1];
	}
	while (1);
	// 拆成两个链表分别排序 ， 再归并 。
	stride_2_pointer = (int *)stride_1_pointer [1];
	stride_1_pointer[1] = (int)NULL;
	int * l_head = msort(head);
	int * r_head = msort(stride_2_pointer);
	return merge(l_head, r_head);
}

int main()
{
	FILE * infile, *outfile;
	int buffer [1001];
	infile = fopen("a.in", "rb");
	fread(buffer, 4, 1001, infile);
	fclose(infile);
	int N = buffer[0];
	int * head = new int[2];
	head[1] = (int)NULL;
	int * pointer = head;
	for (int idx = 1; idx <= N; idx++)
	{
		pointer[1] = (int) new int [2];
		pointer = (int *) pointer[1];
		pointer[0] = buffer[idx];
		pointer[1] = (int)NULL;
	}
	head[1] = (int) msort((int *)head[1]);
	pointer = head;
	outfile = fopen("a.out", "wb");
	do
	{
		pointer = (int *)pointer[1];
		if (pointer == NULL) break;
		fwrite(pointer, 4, 1, outfile);
	}
	while (1);
	fclose(outfile);
	while (head != NULL)
	{
		int * temp = head;
		head = (int *)head[1];
		delete temp;
	}
	return 0;
}
