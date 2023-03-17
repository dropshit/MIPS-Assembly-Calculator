#Author: Cabbar Huseynzada, mail:jabbar.huseynzada@gmail.com contact with: Ig:@24cabbar Tw:@Cabbruh Tg:@dropshit
.data
promptMessage1: .asciiz "\n\nEnter the first number: "
promptMessage2: .asciiz "Enter the second number: "
operations: .asciiz "\nPress 1 for \"+\",\nPress 2 for \"-\",\nPress 3 for \"*\",\npress 4 for \"/\"\nEnter the operation: "
resultPrompt: .asciiz "\nThe result is: "
continueMessage: .asciiz "\nDo you want continue? If you want to continue press any key, otherwise press \"q\" for quit program: "
errorMessage: .asciiz "this number is not divisible by zero you if you understood this, then you can try another number or quit the program"
invalidOperation: .asciiz "Invalid operation."
loopAnswer: .word 0

.text
main:
   loop:
   	li $v0, 4
   	la $a0, continueMessage
   	syscall
   	
   	li $v0,12
	syscall
	sw $v0, loopAnswer
	
	lw $s0, loopAnswer
	beq $s0, 113, Exit		#this part is used for learn user want to continue or not 
	
  calculator: 	
   	li $v0, 4
   	la $a0, promptMessage1
   	syscall
   	
   	li $v0,5
	syscall
	move $t0, $v0 			#in $t0 the program saved the first number
	
	li $v0,4
	la $a0, promptMessage2
	syscall
	
	li $v0,5
	syscall
	move $t1, $v0 			#in $t1 the program saved the second number
	
	li $v0,4
	la $a0,operations
	syscall 

	li $v0,5
	syscall
	move $t2,$v0 			#in $t2 the program saved the operation which is chosen by user
	
	beq $t2,1,Addition
	beq $t2,2,Subtraction
	beq $t2,3,Multiplication	
	beq $t2,4,Division
	
	li $v0, 4
        la $a0, invalidOperation
        syscall
        j loop
Addition:
	li $v0,4
	la $a0,resultPrompt 		#and in this part program show to us the result
	syscall	
	
	add $t3,$t0,$t1
	move $a0,$t3  			#Addition operation
	
	li $v0,1
	syscall
	j loop				#at this part is used for again start the program if user don't want he/she can cancel it
	
Subtraction:
	li $v0,4
	la $a0,resultPrompt
	syscall
	
	sub $t3,$t0,$t1
	move $a0,$t3			#Substraction operation
	
	li $v0,1
	syscall
	j loop
	
Multiplication:
	li $v0,4
	la $a0,resultPrompt
	syscall
	
	mul $t3,$t0,$t1
	move $a0,$t3			#Multiplication operation
	
	li $v0,1
	syscall
	j loop
	
Division:
	li $v0,4
	la $a0,resultPrompt
	syscall
	
	beq $t1,$zero,ifSecondNumberIsZero	#if our divisor is zero the program will be restart because we can't divide zero by any numbers
	
	div $t3,$t0,$t1
	move $a0,$t3			#Division operation
	
	li $v0,1
	syscall
	j loop
ifSecondNumberIsZero:
	li $v0,4
	la $a0,errorMessage  		#for print error message when divisor is zero
	syscall
	
	j loop

Exit:
	li $v0,10
	syscall 			#for stop program
