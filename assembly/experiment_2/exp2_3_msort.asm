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
	
	la $t0, buffer
	lw $s0, 0($t0)
	
	addi $sp, $sp, -8	# allocate 2 bytes in stack for head
	move $s1, $sp		# $s1 saves head address
	sw $0, 4($s1)		# head[1] = 0 (NULL)
	
	move $t1, $s1		# $t1 stores pointer
	
	# for loop to create list
	li $t2, 1				# $t2 stores idx
	loop1:
		bgt $t2, $s0, exit1	# exit if idx >= N
		addi $t0, $t0, 4
		lw $t3, 0($t0)
		addi $sp, $sp, -8	# allocate 2 bytes
		sw $sp, 4($t1)		# stores new allocated address in pointer[1]
		move $t1, $sp		# pointer = (int*)pointer[1]
		sw $t3, 0($t1)		# pointer[0] = buffer[idx]
		sw $0, 4($t1)		# pointer[1] = 0 (NULL)
		addi $t2, $t2, 1	# idx++
		j loop1
	
	exit1:
	lw $a0, 4($s1)		# $a0 = head[1]
	jal msort			# call msort
	sw $v0, 4($s1)		# head[1] = msort(head[1])
	
	move $t0, $s1		# $t0 stores pointer

	# open a.out
	la $a0, outfile		# load outfile name
	li $a1, 1			# flag = 1, write
	li $a2, 0			# mode ignored
	li $v0, 13			# system call for open file
	syscall
	
	move $a0, $v0			# move file descriptor to $a0
	# loop to output list
	loop6:
		lw $t0, 4($t0)		# pointer = pointer[1]
		beqz $t0, exit6		# break if pointer == NULL
		move $a1, $t0
		li $a2, 4			# write 4 bytes
		li $v0, 15			# system call for write to file
		syscall
		j loop6
	
	exit6:
	# close a.out, $a0 reamins file descriptor
	li $v0, 16			# system call for close file
	syscall
	
	# ignore deleting head
	li $v0 17			# system call for exit
	syscall


msort:
	# save registers
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	lw $t0, 4($a0)
	move $v0, $a0
	beqz $t0, return	# if head[1] == NULL, return head
	
	move $t0, $a0		# $t0 stores stride_2_pointer
	move $t1, $a0		# $t1 stores stride_1_pointer
	loop2:
		lw $t2, 4($t0)
		beqz $t2, exit2	# if stride_2_pointer[1] == NULL, break
		move $t0, $t2	# stride_2_pointer = stride_2_pointer[1]
		lw $t2, 4($t0)
		beqz $t2, exit2	# if stride_2_pointer[1] == NULL, break
		move $t0, $t2	# stride_2_pointer = stride_2_pointer[1]
		lw $t1, 4($t1)	# stride_1_pointer = stride_1_pointer[1]
		j loop2
	
	exit2:
	lw $s0, 4($t1)		# stride_2_pointer = stride_1_pointer[1] and store into $s0
	sw $0, 4($t1)		# stride_i_pointer[1] = 0 (NULL)
	
	jal msort			# $a0 didn't change, remains head
	move $s1, $v0		# stores l_head in $s1
	move $a0, $s0		# $a0 = stride_2_pointer
	jal msort
	move $a0, $s1		# $a0 = l_head
	move $a1, $v0		# $a1 = r_head
	jal merge
	
	return:
	# restore registers and return
	lw $ra, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	jr $ra

merge:
	# save registers
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -8
	move $s0, $sp					# allocate 2 bytes in head and stores head address in $s0
	sw $a0, 4($s0)					# head[1] = l_head
	move $t0, $s0					# $t0 stores p_left
	move $t1, $a1					# $t1 stores p_right
	
	loop3:
		loop4:
			lw $t2, 4($t0)			# $t2 = p_left[1]
			beqz $t2, exit4			# break if p_left[1] == NULL
			lw $t2, 0($t2)			# $t2 = (p_left[1])[0]
			lw $t3, 0($t1)			# $t2 = p_right[0]
			bgt $t2, $t3, exit4		# break if (p_left[1])[0] > p_right[0]
			lw $t0, 4($t0)			# p_left = p_left[1]
			j loop4
		
		exit4:
		lw $t2, 4($t0)				# $t2 = p_left[1]
		bnez $t2, cond1				# nothing happens if p_left[1] != NULL
		sw $t1, 4($t0)				# p_left[1] = p_right
		j exit3						# break if p_left[1] == NULL
		
		cond1:
		move $t2, $t1				# $t2 stores p_right_temp
		loop5:
			lw $t3, 4($t2)			# $t3 = p_right_temp[1]
			beqz $t3, exit5			# break if p_right_temp[1] == NULL
			lw $t3, 0($t3)			# $t3 = (p_right_temp[1])[0]
			lw $t4, 4($t0)			# $t4 = p_left[1]
			lw $t4, 0($t4)			# $t4 = (p_left[1])[0]
			bgt $t3, $t4, exit5		# break if (p_right_temp[1])[0] = (p_left[1])[0]
			lw $t2, 4($t2)			# p_right_temp = p_right_temp[1]
			j loop5
		exit5:
		lw $t3, 4($t2)				# temp_right_pointer_next = p_right_temp[1], stored in $t3
		lw $t4, 4($t0)				# $t4 = p_left[1]
		sw $t4, 4($t2)				# p_right_temp[1] = p_left[1]
		sw $t1, 4($t0)				# p_left[1] = p_right
		move $t0, $t2				# p_left = p_right_temp
		move $t1, $t3				# p_right = temp_right_pointer_next
		beqz $t1, exit3				# break if p_right == NULL
		j loop3
		
	exit3:
	lw $v0, 4($s0)					# move head[1] into $v0
	addi $sp, $sp, 8				# delete head

	# restore registers and return
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	jr $ra
