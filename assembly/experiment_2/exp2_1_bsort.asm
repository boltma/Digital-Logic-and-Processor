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
	li $a2, 1001		# read 1001 bytes
	li $v0, 14			# system call for read from file
	syscall

	# close a.in, $a0 reamins file descriptor
	li $v0, 16			# system call for close file
	syscall
	
	# call bubsort
	la $t0, buffer		# load buffer address into $t0
	lw $s0, 0($t0)		# store N in $s0
	addi $a0, $t0, 4	# $a0 = &(buffer[1]) (buffer + 4)
	move $a1, $s0		# $a1 = N
	jal bubsort

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

bubsort:
	# save registers
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s0, 0($sp)
	move $s0, $a0					# store v in $s0
	move $s1, $a1					# store n in $s1

	li $t0, 0						# $t0 stores i
	outerloop:
		bge $t0, $s1, outerexit		# exit if i >= n
		addi $t1, $t0, -1			# j = i - 1, $t1 stores j
		innerloop:
			blt $t1, $0, innerexit	# exit if j < 0
			sll $t2, $t1, 2
			add $t2, $s0, $t2		# $t2 = v + 4j
			lw $t3, 0($t2)			# $t3 = v[j]
			lw $t4, 4($t2)			# $t4 = v[j + 1]
			ble $t3, $t4, innerexit	# exit if v[j] <= v[j + 1]
			# save temp registers
			addi $sp, $sp, -8
			sw $t0, 4($sp)
			sw $t1, 0($sp)
			move $a0, $s0			# $a0 = v
			move $a1, $t1			# $a1 = j
			jal swap				# call swap
			# restore temp registers
			lw $t0, 4($sp)
			lw $t1, 0($sp)
			addi $sp, $sp, 8
			addi $t1, $t1, -1		# j--
			j innerloop
		innerexit:
		addi $t0, $t0, 1			# i++
		j outerloop
	
	outerexit:
	# restore registers and return
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	
swap:
	# no need to store registers because swap is a leaf process and never uses $s*
	sll $t0, $a1, 2		# $t0 = 4j
	add $t0, $a0, $t0	# $t0 = v + 4 * j
	lw $t1, 0($t0)		# $t1 = v[j]
	lw $t2, 4($t0)		# $t2 = v[j + 1]
	sw $t2, 0($t0)		# $v[j] = $t2
	sw $t1, 4($t0)		# $v[j + 1] = $t1
	jr $ra
