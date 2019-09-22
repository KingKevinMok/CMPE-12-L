##########################################################################
# Created by:  Mok, Kevin
#              kemok
#              3 March 2019
#
# Assignment:  Lab 4: Ascii Conversion
#              CMPE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, Winter 2019
#
# Description: This program puts program inputs takes them and reads them as either hexidecimal, binary, or decimal.
# Then you convert them into 2's compliment and add the values together. Then you convert the number into a base 4
#
# Notes:       This program is intended to be run from the MARS IDE.
##########################################################################
# reg20=Input1 ("Enter your 1st two's complement number") 
# reg21=Input2 ("Enter your 2nd two's complement number")
# print reg20
# print reg21
# if Input 1 is a binary (convert reg20 to hexdecimal and move to reg23)
# turn reg23 into ASCII string and put back into reg23
# move reg23 to v1
# if Input 2 is binary (convert reg21 to hexidecimal and move to reg24)	
# turn reg 24 into ASCII string and put back into reg24
# move reg24 to v2
# add v1 and v2 and put into v0
# convert v0 to base 4 and put it back into v0
# print new v0
.text
	#li $v0 4
	#lw $t0 ($a1)
	#la $a0 ($t0) 
	#syscall
	
	#lw $t0 ($a1) # load address of first program arguement
	#lb $t1 ($t0) # load the first byte (character) into $t1 from the address stored in $t0
	#subi $t1, $t1, 48
	
	#addi $a1, $a1, 4
	#lw $t5, ($a1)
	#lb $t2, ($t5)
	
	
	#addi $t0, $t0, 1 #increment address
	#lb $t2, ($t0)
	#subi $t2, $t2, 48
	
	#add $t7, $t2, $t1
.data


.data
	Sentence1: .asciiz "You entered the numbers: "
	Sentence2: .asciiz "The sum in base 4 is: "
	MakeLine: .asciiz "\n"
	MakeSpace: .asciiz " "
	Negativesign: .asciiz "-"
	number3: .asciiz "3"
	number2: .asciiz "2"
	number1: .asciiz "1"
	number0: .asciiz "0"  

.text

	li $v0 4
	la $a0 Sentence1                                                  # create 1st sentence 
	syscall
	
	li $v0 4
	la $a0 MakeLine                                                   # make new line
	syscall
	 
	li $v0 4
	lw $t0 ($a1)                                                      # show 1st argument
	la $a0 ($t0) 
	syscall
	
	li $v0 4
	la $a0 MakeSpace                                                  # make space
	syscall
	
	addi $a1, $a1, 4                                                  # create 2nd argument
	li $v0 4
	lw $t1 ($a1)
	la $a0 ($t1)
	syscall
	
	  
	    
	subi $a1, $a1, 4                                                  # go back to first argument
	lw $t0 ($a1)
	
	addi $t0 $t0 1                                                    # load 2nd byte in argument and move to register $t2
	lb $t2 ($t0)
	
	   
	# if 2nd byte is hex convert from hex to decimal 
  	
  	beq $t2, 0x78, convertHex1
  	bne $t2 0x78, convertBin1
  	
  	convertHex1:
  	
  	lw $t8 ($a1)
  	addi $t8 $t8 2
  	lb $t3 ($t8)
  	subi $t3 $t3 48
  	addi $t8 $t8 1						#pad with 0 or f for hex
  	li $t6 28 
  	bge $t3 0x08 padwith_f1
  	blt $t3 0x08 padwith_01
  	
  	padwith_f1:
  	beq $t6 4 exitpading1
  	li $t5 15
  	sllv $t5 $t5 $t6					#pad with f then exitpad
  	add $t4 $t4 $t5 
  	subi $t6 $t6 4
  	j padwith_f1
  	
  	padwith_01:
  	beq $t6 4 exitpading1
  	li $t5 0
  	sllv $t5 $t5 $t6
  	add $t4 $t4 $t5
  	subi $t6 $t6 4
  	j padwith_01
  	
  	
	  	
  	convertBin1:
  	
  	lw $t8 ($a1)
  	addi $t8 $t8 2
  	lb $t3 ($t8)
  	subi $t3 $t3 48
  	addi $t8 $t8 1
  	li $t6 28 
  	beq $t3 0x01 padwith_f2
  	beqz $t3 padwith_02 
  	
  	padwith_02:
  	beq $t6 4 exitpading2
  	li $t5 0
  	sllv $t5 $t5 $t6
  	add $t4 $t4 $t5
  	subi $t6 $t6 4
  	j padwith_02  
  	
  	padwith_f2:
  	beq $t6 4 exitpading2
  	li $t5 15
  	sllv $t5 $t5 $t6					# pad with f then exitpad
  	add $t4 $t4 $t5 
  	subi $t6 $t6 4
  	j padwith_f2
  	
  	exitpading1:
  		lw $t8 ($a1)
  		addi $t8 $t8 2
  		lb $t3 ($t8)
  		bge $t3 0x40 getLetter1
  		ble $t3 0x39 getNumber1
  		getValue1:							#this is for letter
  		sll $t3 $t3 4
  		addi $t8 $t8 1
  		lb $t7 ($t8)
  		bge $t7 0x40 getLetter2
  		ble $t7 0x39 getNumber2
  		getValue2:
  		or $t3 $t3 $t7							# this for number
  		or $t4 $t4 $t3
  		move $s1 $t4
  		j exit1st_argument
  	
  
  	exitpading2:
  		lw $t8 ($a1)
  		addi $t8 $t8 2
  		lb $t3 ($t8)
  		li $t9 7
  		subi $t3 $t3 48
  		sllv $t3 $t3 $t9
  		addi $t8 $t8 1
  		beq $t8 3 binarytoHex1
  		binarytoHex1:
  			beq $t8 0x7ffffffc register4
			lb $t7 ($t8)
			subi $t7 $t7 48
			subi $t9 $t9 1
			sllv $t7 $t7 $t9
			add $t3 $t3 $t7
			addi $t8 $t8 1
			j binarytoHex1
		register4:
		add $t4 $t4 $t3 
		j exit1st_argument		
  		
  	exit1st_argument:
  	
  	move $s1 $t4
  	
  	addi $a1 $a1 4							# break point
  	
  	li $t4 0
  	
  	lw $t0 ($a1)                                                    # load 2nd byte in argument and move to register $t2
  	addi $t0 $t0 1
	lb $t2 ($t0)
	
	   
	# if 2nd byte is hex convert from hex to decimal 
  	
  	beq $t2, 0x78, convertHex2
  	bne $t2 0x78, convertBin2
  	
  	convertHex2:
  
  	lw $t8 ($a1)
  	addi $t8 $t8 2
  	lb $t3 ($t8)
  	subi $t3 $t3 48
  	addi $t8 $t8 1						#pad with 0 or f for hex
  	li $t6 28 
  	bge $t3 0x08 padwith_f3
  	blt $t3 0x08 padwith_03
  	
  	padwith_f3:
  	beq $t6 4 exitpading3
  	li $t5 15
  	sllv $t5 $t5 $t6					#pad with f then exitpad
  	add $t4 $t4 $t5 
  	subi $t6 $t6 4
  	j padwith_f3
  	
  	padwith_03:
  	beq $t6 4 exitpading3
  	li $t5 0
  	sllv $t5 $t5 $t6
  	add $t4 $t4 $t5
  	subi $t6 $t6 4
  	j padwith_03
  	
  	
	  	
  	convertBin2:
  	
  	lw $t8 ($a1)
  	addi $t8 $t8 2
  	lb $t3 ($t8)
  	subi $t3 $t3 48
  	addi $t8 $t8 1
  	li $t6 28 
  	beq $t3 0x01 padwith_f4
  	beqz $t3 padwith_04 
  	
  	padwith_04:
  	beq $t6 4 exitpading4
  	li $t5 0
  	sllv $t5 $t5 $t6
  	add $t4 $t4 $t5
  	subi $t6 $t6 4
  	j padwith_04  
  	
  	padwith_f4:
  	beq $t6 4 exitpading4
  	li $t5 15
  	sllv $t5 $t5 $t6					# pad with f then exitpad
  	add $t4 $t4 $t5 
  	subi $t6 $t6 4
  	j padwith_f4
  	
  	exitpading3:
  		lw $t8 ($a1)
  		addi $t8 $t8 2
  		lb $t3 ($t8)
  		bge $t3 0x40 getLetter3
  		ble $t3 0x39 getNumber3
  		getValue3:							#this is for letter
  		sll $t3 $t3 4
  		addi $t8 $t8 1
  		lb $t7 ($t8)
  		bge $t7 0x40 getLetter4
  		ble $t7 0x39 getNumber4
  		getValue4:
  		or $t3 $t3 $t7							# this for number
  		or $t4 $t4 $t3
  		move $s2 $t4
  		j exit2nd_argument
  	
  
  	exitpading4:
  		lw $t8 ($a1)
  		addi $t8 $t8 2
  		lb $t3 ($t8)
  		li $t9 7
  		subi $t3 $t3 48
  		sllv $t3 $t3 $t9
  		addi $t8 $t8 1
  		beq $t8 0x7fffffea binarytoHex2_1					# 1st argument is binary
  		beq $t8 0x7ffffff0 binarytoHex2_2					# 1st argument is hex
  		binarytoHex2_1:
  			beq $t8 0x7ffffff1  register4_2					# fix this so increment correctly
			lb $t7 ($t8)
			subi $t7 $t7 48
			subi $t9 $t9 1
			sllv $t7 $t7 $t9
			add $t3 $t3 $t7
			addi $t8 $t8 1
			j binarytoHex2_1
		binarytoHex2_2:
			beq $t8 0x7ffffff7 register4_2
			lb $t7 ($t8)
			subi $t7 $t7 48
			subi $t9 $t9 1
			sllv $t7 $t7 $t9
			add $t3 $t3 $t7
			addi $t8 $t8 1
			j binarytoHex2_2
			
		register4_2:
		add $t4 $t4 $t3 
		j exit2nd_argument		
  		
  	exit2nd_argument:
  	
  	
  	
  	move $s2 $t4
  	
  	
  	
  	add $s0 $s1 $s2
  	
  	li $v0 4
  	la $a0 MakeSpace
  	syscall
  	
  	li $v0 1
  	move $a0 $s0						##remember to get rid of
  	syscall
  	
  			
  			 
	li $v0 4
	la $a0 MakeLine
	syscall
	
	li $v0 4
	la $a0 MakeLine
	syscall
	
	li $v0 4
	la $a0 Sentence2                                                  # create 2nd sentence
	syscall
	
	li $v0 4
	la $a0 MakeLine
	syscall
	
	beq $s0 $s0 convertBase4
	convertBase4:
	ble $s0 0xffffffff negativeBase1
	bge $s0 0x00000000 positiveBase1
	
	
	exitconvertBase4:
	
	li $v0 4 
	la $a0 MakeLine
	syscall
	
	
	li $v0 10
	syscall
	
	getLetter1:
	subi $t3 $t3 55
	j getValue1
	
	getNumber1:
	subi $t3 $t3 48
	j getValue1
	
	getLetter2:
	subi $t7 $t7 55						# why does it of by 1 letter 
	j getValue2
	
	getNumber2: 
	subi $t7 $t7 48
	j getValue2
	
	getLetter3:
	subi $t3 $t3 55
	j getValue3
	
	getNumber3:
	subi $t3 $t3 48
	j getValue3
	
	getLetter4:
	subi $t7 $t7 55						# why does it of by 1 letter 
	j getValue4
	
	getNumber4: 
	subi $t7 $t7 48
	j getValue4

	negativeBase1:
		li $v0 4
		la $a0 Negativesign
		syscall
		
		move $t0 $s0
		li $t1 4
		div $t0 $t1
		mflo $t2
		mfhi $t3
		move $t0 $t2
		beqz $t0 getbasenegativeValue0
		div $t0 $t1
		mflo $t2
		mfhi $t4
		move $t0 $t2
		beqz $t0 getbasenegativeValue1
		div $t0 $t1
		mflo $t2
		mfhi $t5
		move $t0 $t2
		beqz $t0 getbasenegativeValue2
		div $t0 $t1
		mflo $t2
		mfhi $t6
		move $t0 $t2
		beqz $t0 getbasenegativeValue3
		div $t0 $t1
		mflo $t2
		mfhi $t7
		move $t0 $t2
		beqz $t0 getbasenegativeValue4
		 
		
		
	
	
	getbasenegativeValue4:
	beq $t7 0xfffffffd write3_minus4
	beq $t7 0xfffffffe write2_minus4
	beq $t7 0xffffffff write1_minus4
	beq $t7 0	   write0_minus4
	
	getbasenegativeValue3:
	beq $t6 0xfffffffd write3_minus3
	beq $t6 0xfffffffe write2_minus3
	beq $t6 0xffffffff write1_minus3
	beq $t6 0	   write0_minus3 
	
	getbasenegativeValue2:
	
	beq $t5 0xfffffffd write3_minus2
	beq $t5 0xfffffffe write2_minus2
	beq $t5 0xffffffff write1_minus2
	beq $t5 0	   write0_minus2
	
	getbasenegativeValue1:
	
	beq $t4 0xfffffffd write3_minus1
	beq $t4 0xfffffffe write2_minus1
	beq $t4 0xffffffff write1_minus1
	beq $t4 0	   write0_minus1
	
	getbasenegativeValue0:
	
	beq $t3 0xfffffffd write3_minus0
	beq $t3 0xfffffffe write2_minus0
	beq $t3 0xffffffff write1_minus0
	beq $t3 0	   write0_minus0
	
	positiveBase1:
		move $t0 $s0
		li $t1 4
		div $t0 $t1
		mflo $t2
		mfhi $t3
		move $t0 $t2
		beqz $t0 getbaseValue0
		div $t0 $t1
		mflo $t2
		mfhi $t4
		move $t0 $t2
		beqz $t0 getbaseValue1
		div $t0 $t1
		mflo $t2
		mfhi $t5
		move $t0 $t2
		beqz $t0 getbaseValue2
		div $t0 $t1
		mflo $t2
		mfhi $t6
		move $t0 $t2
		beqz $t0 getbaseValue3
	
	
	getbaseValue0:
	
	beq $t3 3 write3_0
	beq $t3 2 write2_0
	beq $t3 1 write1_0
	beq $t3 0 write0_0 
		
	getbaseValue1:
	
	beq $t4 3 write3_1
	beq $t4 2 write2_1
	beq $t4 1 write1_1
	beq $t4 0 write0_1
	
	getbaseValue2:
	
	beq $t5 3 write3_2
	beq $t5 2 write2_2
	beq $t5 1 write1_2
	beq $t5 0 write0_2
	
	getbaseValue3:	
	
	beq $t6 3 write3_3
	beq $t6 2 write2_3
	beq $t6 1 write1_3
	beq $t6 0 write0_3
	
	write3_0:
	
	li $v0 4
	la $a0 number3
	syscall
	
	j exitconvertBase4
	write2_0:
	
	li $v0 4
	la $a0 number2
	syscall
	
	j exitconvertBase4
	write1_0:
	
	li $v0 4
	la $a0 number1
	syscall
	
	j exitconvertBase4
	write0_0:
	
	li $v0 4
	la $a0 number0
	syscall
	
	j exitconvertBase4
	write3_1:
	
	li $v0 4
	la $a0 number3
	syscall
	
	j getbaseValue0
	
	write2_1:
	
	li $v0 4
	la $a0 number2
	syscall
	
	j getbaseValue0
	
	write1_1:
	
	li $v0 4
	la $a0 number1
	syscall
	
	j getbaseValue0
	write0_1:
	
	li $v0 4
	la $a0 number0
	syscall
	
	j getbaseValue0
	write3_2:
	
	li $v0 4
	la $a0 number3
	syscall
	
	j getbaseValue1
	write2_2:
	
	li $v0 4
	la $a0 number2
	syscall
	
	j getbaseValue1
	write1_2:
	
	li $v0 4
	la $a0 number1
	syscall
	
	j getbaseValue1
	write0_2:
	
	li $v0 4
	la $a0 number0
	syscall
	
	j getbaseValue1
	write3_3:
	
	li $v0 4
	la $a0 number3
	syscall
	
	j getbaseValue2
	write2_3:
	
	li $v0 4
	la $a0 number2
	syscall
	
	j getbaseValue2
	write1_3:
	
	li $v0 4
	la $a0 number1
	syscall
	
	j getbaseValue2
	write0_3:
	
	li $v0 4
	la $a0 number0
	syscall
	
	j getbaseValue2
	
	write3_minus4:
	li $v0 4
	la $a0 number3
	syscall
	
	j getbasenegativeValue3
	
	write2_minus4:
	
	li $v0 4
	la $a0 number2
	syscall
	
	j getbasenegativeValue3
	
	write1_minus4:
	
	li $v0 4
	la $a0 number1
	syscall
	
	j getbasenegativeValue3
	
	write0_minus4:
	
	li $v0 4
	la $a0 number0
	syscall
	
	j getbasenegativeValue3
	
	write3_minus3:
	li $v0 4
	la $a0 number3
	syscall
	j getbasenegativeValue2
	
	write2_minus3:
	
	li $v0 4
	la $a0 number2
	syscall
	j getbasenegativeValue2
	
	write1_minus3:
	
	li $v0 4
	la $a0 number1
	syscall
	j getbasenegativeValue2
	
	write0_minus3:
	
	li $v0 4
	la $a0 number0
	syscall
	j getbasenegativeValue2
	
	write3_minus2:
	li $v0 4
	la $a0 number3
	syscall
	j getbasenegativeValue1
	
	write2_minus2:
	
	li $v0 4
	la $a0 number2
	syscall
	j getbasenegativeValue1
	
	write1_minus2:
	
	li $v0 4
	la $a0 number1
	syscall
	j getbasenegativeValue1
	
	write0_minus2:
	
	li $v0 4
	la $a0 number0
	syscall
	j getbasenegativeValue1
	
	write3_minus1:
	
	li $v0 4
	la $a0 number3
	syscall
	j getbasenegativeValue0
	
	write2_minus1:
	
	li $v0 4
	la $a0 number2
	syscall
	j getbasenegativeValue0
	
	write1_minus1:
	
	li $v0 4
	la $a0 number1
	syscall
	j getbasenegativeValue0
	
	write0_minus1:
	
	li $v0 4
	la $a0 number0
	syscall
	j getbasenegativeValue0
	
	write3_minus0:
	
	li $v0 4
	la $a0 number3
	syscall
	j exitconvertBase4
	
	write2_minus0:
	
	li $v0 4
	la $a0 number2
	syscall
	j exitconvertBase4
	
	write1_minus0:
	
	li $v0 4
	la $a0 number1
	syscall
	j exitconvertBase4
	
	write0_minus0:
	
	li $v0 4
	la $a0 number0
	syscall
	j exitconvertBase4
	
	