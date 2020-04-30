.data
buffer: .space 4004
infile: .asciiz "a.in"
outfile: .asciiz "a.out"

.text
main:
	# open a.in
	la $a0, infile		# load infile name
	li $a1, 0			# flag = 0, read
	li $a2, 0			# mode ignored
	li $v0, 13			# system call for open file
	syscall

	# allocate buffer and read a integer to buffer
	move $a0, $v0		# move file descriptor to $a0
	la $a1, buffer		# load buffer address
	li $a2, 4004		# read 4004 bytes
	li $v0, 14			# system call for read from file
	syscall

	# close a.in, $a0 reamins file descriptor
	li $v0, 16			# system call for close file
	syscall
	
	# call quickSort
	la $a0, buffer		# $a0 = buffer
	lw $s0, 0($a0)		# store N in $s0
	li $a1, 1			# $a1 = 1
	move $a2, $s0		# $a2 = N
	jal quickSort

	# open a.out
	la $a0, outfile		# load outfile name
	li $a1, 1			# flag = 1, write
	li $a2, 0			# mode ignored
	li $v0, 13			# system call for open file
	syscall

	# write buffer to file
	move $a0, $v0		# move file descriptor to $a0
	la $t0, buffer		# load buffer address
	addi $a1, $t0, 4
	sll $a2, $s0, 2		# write 4N bytes
	li $v0, 15			# system call for write to file
	syscall

	# close a.out, $a0 reamins file descriptor
	li $v0, 16			# system call for close file
	syscall

	li $v0 17			# system call for exit
	syscall


quickSort:
	# save registers, no need to save $s3, see comments below
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0		# store arr in $s0
	move $s1, $a1		# store left in $s1
	move $s2, $a2		# store right in $s2
	move $t0, $s1		# $t0 stores i
	move $t1, $s2		# $t1 stores j
	sll $t2, $s1, 2
	add $t2, $s0, $t2	# $t2 = array + 4 * left
	lw $s3, 0($t2)		# store key in $s3, key only used before calling quickSort, so no need to save register
	
	outerloop:
		innerloop1:
			sll $t2, $t1, 2
			add $t2, $s0, $t2
			lw $t3, 0($t2)				# $t3 = arr[j]
			blt $t3, $s3, innerloop2	# exit if arr[j] < key
			bge $t0, $t1, innerloop2	# exit if i >= j
			addi $t1, $t1, -1			# j--
			j innerloop1
		innerloop2:
			sll $t2, $t0, 2
			add $t2, $s0, $t2
			lw $t3, 0($t2)				# $t3 = arr[i]
			bgt $t3, $s3, innerexit		# exit if arr[i] > key
			bge $t0, $t1, innerexit		# exit if i >= j
			addi $t0, $t0, 1			# i++
			j innerloop2
		innerexit:
		bge $t0, $t1, exit				# break if i >= j
		sll $t2, $t0, 2
		add $t2, $s0, $t2				# $t2 = arr + 4 * i
		sll $t3, $t1, 2
		add $t3, $s0, $t3				# $t3 = arr + 4 * j
		lw $t4, 0($t2)					# $t4 = arr[i]
		lw $t5, 0($t3)					# $t5 = arr[j]
		sw $t4, 0($t3)					# arr[j] = $t4
		sw $t5, 0($t2)					# arr[i] = $t5
		j outerloop
	
	exit:
	sll $t2, $s1, 2
	add $t2, $s0, $t2					# $t2 = arr + 4 * left
	sll $t3, $t0, 2
	add $t3, $s0, $t3					# $t3 = arr + 4 * i
	lw $t4, 0($t3)						# $t4 = arr[i]
	sw $t4, 0($t2)						# arr[left] = $t4
	sw $s3, 0($t3)						# arr[i] = key
	
	addi $t2, $t0, -1					# $t2 = i - 1
	bge $s1, $t2, exit1					# exit if left >= i - 1
	move $a0, $s0						# $a0 = arr
	move $a1, $s1						# $a1 = left
	move $a2, $t2						# $a2 = i - 1
	jal quickSort
	
	exit1:
	addi $t2, $t0, 1					# $t2 = i + 1
	bge $t2, $s2, exit2					# exit if i + 1 >= right
	move $a0, $s0						# $a0 = arr
	move $a1, $t2						# $a1 = i + 1
	move $a2, $s2						# $a2 = right
	jal quickSort
	
	exit2:
	# restore registers and return
	lw $ra, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 16
	jr $ra
