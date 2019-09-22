########################################################################## 
#Created by:  Mok, Kevin
#              1649545
#              17 Feburary 2019
#
# Assignment:  Lab 4: MIPS Looping ASCII Art
#              CMPE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, Winter 2019
#
# Description: This program prints the correct number of triangle and each triangle has the correct amount of legs printed
#
# Notes:       This program is intended to be run from the MARS IDE.
##########################################################################
.data
	question1: .asciiz "Enter the length of one of the triangle legs: "
	question2: .asciiz "Enter the number of triangles to print: "
	makeLine: .asciiz  "\n"
	number: .asciiz "a"
.text
	
	li $v0, 4
	la $a0, question1                                              # ask user to enter length
	syscall
	
	
 	li $v0, 5                                                      # get length of triangle
 	syscall
	
	
    	move $t0, $v0                                                  # store length in $t0
.text
    	
    	li $v0, 4
    	la $a0, question2                                              # ask user to enter number 
    	syscall
    	

	
    	
    	li $v0, 5                                                     # get number of triangle
    	syscall
	
    	                                                            
    	move $t1, $v0                                                 # store number in $t1 = number of triangles
    	
	li $v0, 4
	la $a0, makeLine
	syscall
	
	main:

		addi $t2 ,$zero, 1                             
		addi $t4, $zero, 0
		addi $t5, $zero, 0
		addi $t6, $zero, 0                                    # all my registers
		addi $t7, $zero, 0
		addi $t8, $zero, 0
		
		li $t6, 0
	        move $t8, $t0                                         # store value to register 8 
		
		addi $t8, $t8, 1
	        move $t9, $t8                                         # counter move to register 9   
	        
		li $t4, 0
		while_out:                                            # main function with 2 while loops
			beq $t4, $t1, exitOut                         
			jal addSpace                                  # jump and link
			jal decSpace                                   
			addi $t4, $t4, 1                              # counter	
			beq $t1, $t4,  while_out                      # branch to while_out if r1 = r4
			li $v0, 4
			la $a0, makeLine
			syscall
			
			j while_out
			
			
			
		exitOut:
		
		
		li $v0, 10
		syscall
		
		addSpace:
		        li $t6, 0
	                li $t8, 0 
			li $t5, 0                                    
			while_in1:
			        
			        beq  $t5, $t0, exit_in1                # keep doing while loop if r5 not = r0
			 
			whileSpace:
				
				li $t8, 0
				bne $t6, $t0, addSpace1                # branch to addSpace1 if r6 not = r0
				
				j whileSpace 
		       addSpace1:
		                beqz, $t6, exitSpace                   # if r6 not zero, continue addSpace1 
		                li $v0, 11                             # if r6 zero, jump to exitSpace
				li $a0, 0x20
				syscall
				addi $t8, $t8, 1                       # counter
				bne $t8, $t6, addSpace1                # r8 not = r6 addSpace1
		
			exitSpace:
			li $v0, 11
			li $a0, 0x5c                                   # make slash
			syscall
			
			li $v0, 4
			la $a0, makeLine                               # print new line
			syscall
			
			
			
			addi $t5, $t5, 1                               # counter
			addi $t6, $t6 1
			
			j while_in1
			exit_in1:
			
			jr, $ra 
			
			
			
              decSpace:
                       
		        move $t6, $t0
		        move $t7, $t0
	                move $t8, $t0 
	               
			
	                
			li $t5, 0
			while_in2:
			        beq $t5, $t0, exit_in2                  # r5 not equal to r0, continue while_in2
			
			whileDecSpace:
				
				li $t8, 1
				bnez $t6, decreaseSpace1                # branch to decreaseSpace 1 when r6  not = 0
				
				j whileSpace
				 
		       decreaseSpace1:
		                beq $t8, $t6, exitSpace2                # r8 not = r6, continue decreaseSpace1
		                li $v0, 11
				li $a0, 0x20
				syscall
				addi $t8, $t8, 1
				bne $t8, $t6, decreaseSpace1 
		
			exitSpace2:
			li $v0, 11
			li $a0, 0x2f                                    # print backslash
			syscall
			beq $t7, 1 cont
			 
			exitMakeLine:
			li $v0, 4
			la $a0, makeLine
			syscall
			
			
			cont:
			addi $t5, $t5, 1
			subi $t6, $t6 1                                 # all counters
			subi $t7, $t7 1
			
			j while_in2
			
			exit_in2:
			jr, $ra  
			  
			                                               # Register Usuage:
			                                               # $t0, $1 were legs and number of triangles
			                                               # used to make xode run if had not reached that number
			                                               
			                                               #t4, $t5, $t6, $t7, $t8, were used
			                                               # as conditions and as counters and devrements to 
			                                               # the code
				
				
				
				
				
				
				
				
				
		
				
					
				
			
			
				
				
				
				
					
			
		
	
