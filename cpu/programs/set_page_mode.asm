  addi $a0, $zero, 0x801 #init a0 to 60000
  addi $a1, $zero, 0x1000   #init a1 to 100
  multu $a0, $a1			 #multiply a0 and a1
  mflo $a2				 #load the counter value 6M to a2 
  addi $a2, $a2, 0x4F 
  addi $a3, $zero, 0x0000 #store the address of the configuration register. 
						  # 0: RCR. 1: BCR. 2: DIDR (read only) 
  
  addi $t1, $zero, 0x0090 #value to load into config register. This is "page mode enable, deep power down disable"
  
  lw $t0, 0($a2)  #"load configuration register" subroutine 
  lw $t0, 0($a2)  #two loads followed by two stores. 
  sw $a3, 0($a2)
  sw $t1, 0($a2)  #load the contents of register $t0 into the config register specific
  
  #sw $t0, 0x55($a1) #store t0 into a memory location. 
  lw $t0, 0($a2) #software READ CONFIGURATION REGISTER
  lw $t0, 0($a2) #two load words followed by STORE followed by LOAD. 
  sw $a3, 0($a2)
  lw $t1, 0($a2)
  
  sw $t1, 0x55($a1) #stores the value of the config register in t0 for verification. 
