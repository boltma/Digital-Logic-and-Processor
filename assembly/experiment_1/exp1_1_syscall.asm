.data
infile: .asciiz "a.in"
outfile: .asciiz "a.out"

.text
# open a.in
la $a0, infile		# load infile name
li $a1, 0			# flag = 0, read
li $a2, 0			# mode ignored
li $v0, 13			# system call for open file
syscall

# allocate buffer and read a integer to buffer
move $a0, $v0		# move file descriptor to $a0
addi $sp, $sp, -4	# allocate 4 bytes in stack for buffer
move $a1, $sp		# load buffer address
li $a2, 4			# read 4 bytes
li $v0, 14			# system call for read from file
syscall

# close a.in, $a0 reamins file descriptor
li $v0, 16			# system call for close file
syscall

# read integer and add to buffer
lw $t0, 0($sp)		# $t0 = buffer[0]
li $v0, 5			# system call for read integer
syscall				# $v0 = i
add $t0, $t0, $v0	# buffer[0] = buffer[0] + i
sw $t0, 0($sp)		# save $t0 to buffer

# print buffer[0]
move $a0, $t0		# move buffer[0] to $a0
li $v0, 1			# system call for print integer
syscall

# open a.out
la $a0, outfile		# load outfile name
li $a1, 1			# flag = 1, write
li $a2, 0			# mode ignored
li $v0, 13			# system call for open file
syscall

# write buffer to file
move $a0, $v0		# move file descriptor to $a0
move $a1, $sp		# load buffer address
li $a2, 4			# write 4 bytes
li $v0, 15			# system call for write to file
syscall

# close a.out, $a0 reamins file descriptor
li $v0, 16			# system call for close file
syscall
