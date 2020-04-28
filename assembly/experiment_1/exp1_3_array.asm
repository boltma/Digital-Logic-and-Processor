.text
main:
	# read n
	li $v0, 5			# system call for read integer
	syscall
	move $s0, $v0		# $s0 = n
	
	# allocate space for arr and head
	sll $t0, $s0, 2		# $t0 = 4n
	sub $sp, $sp, $t0	# allocate 4n bytes in stack for arr
	move $s1, $sp		# $s1 saves arr address
	sw $zero, 0($sp)	# arr[0] = 0
	subi $sp, $sp, 8	# allocate 2 bytes in stack for head
	move $s2, $sp		# $s2 saves head address
	sw $zero, 0($sp)	# head[0] = 0
	sw $zero, 4($sp)	# head[1] = 0 (NULL)
	
	move $t0, $s2		# $t0 stores ptr
	
	# first for loop, creates a list from 0 to n - 1
	li $t1, 1				# $t1 stores i
	loop1:
		bge $t1, $s0, exit1	# exit if i >= n
		sll $t2, $t1, 2		# $t2 = 4i
		add $t2, $s1, $t2	# $t2 = arr + 4 * i
		sw $t1, 0($t2)		# $t1 = arr[i]
		subi $sp, $sp, 8	# allocate 2 bytes
		sw $sp, 4($t0)		# stores new allocated address in ptr[1]
		move $t0, $sp		# ptr = (int*)ptr[1]
		sw $t1, 0($t0)		# ptr[0] = i
		sw $zero, 4($t0)	# ptr[1] = 0 (NULL)
		addi $t1, $t1, 1	# i++
		j loop1
	
	exit1:
	li $t1, 0				# $t1 stores i
	
	loop2:
		bge $t1, $s0, exit2	# exit if i >= n
		sll $t2, $t1, 2		# $t2 = 4i
		add $t2, $s1, $t2	# $t2 = arr + 4 * i
		lw $a0, 0($t2)		# $a0 = arr[i]
		li $v0, 1			# system call for print integer
		syscall
		addi $t1, $t1, 1	# i++
		j loop2
		
	exit2:
	move $t0, $s2			# $t0 stores ptr, $t0 = head
	
	loop3:
		beq $t0, $0, exit3	# exit if ptr == NULL
		lw $a0, 0($t0)		# $a0 = ptr[0]
		li $v0, 1			# system call for print integer
		syscall
		lw $t0, 4($t0)		# ptr = (int*)ptr[1]
		j loop3
		
	exit3:
		