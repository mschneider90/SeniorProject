.data  
.globl main 
.text  
main:  

  addi $a0, $zero, 60000 #init a0 to 60000
  addi $a1, $zero, 100   #init a1 to 100
  mult $a0, $a1			 #multiply a0 and a1
  mflo $a2				 #load the counter value 6M to a2 
  
  
startloop:
  
	
  addi $a0, $zero, 0  # load zero (starting mem address for acp) into a0
  addi $a1, $zero, 0x0fe9   # store the note reg value into $a1
  sw   $a1, 0($a0)    # store the  note reg value into the ch0 note reg (acp 0x00)
  
  sw	$a1, 1($a1)  # store the fx reg value into the ch0 fx reg (acp 0x01)
  
  addi $sp, $zero, 0
  sw $a0, 0($sp)   # store $a0 
  lw $t0, 0($sp)   # restore $a0  into $t0

  

  