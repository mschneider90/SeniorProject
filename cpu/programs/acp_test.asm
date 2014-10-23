.data  
.globl main 
.text  
main:  
  addi $a0, $zero, 0x06E5
  addi $a1, $zero, 0x0F
  addi $sp, $zero, 0
  sw $a0, 0($sp)   # store $a0 into mem loc 0
  sw $a1, 1($sp)   # store $a1 into mem loc 1
  lw $t0, 0($sp)   # restore $a0  into $t0
