.text
main:
	# read i and j
	li $v0, 5			# system call for read integer
	syscall
	move $s0, $v0		# $s0 = i
	li $v0, 5			# system call for read integer
	syscall
	move $s1, $v0		# $s1 = j
	
	# compute gcd(i, j)
	loop:
		beq $s0, $0, exit	# exit if i == 0
		beq $s1, $0, exit	# exit if j == 0
		ble $s1, $s0, nswap	# jump from swapping if j >= i
		move $t0, $s0		# temp = i
		move $s0, $s1		# i = j
		move $s1, $t0		# j = temp
		nswap:
		sub $s0, $s0, $s1	# i = i - j
		j loop

	exit:
		move $a0, $s1		# $a0 = j
		li $v0, 1			# system call for print integer
		syscall
		
