.data  
.globl main 
.text  
main:  
  addi $a0, $zero, 0x0FE9
  addi $sp, $zero, 30
  sw $a0, 0($sp)   # store $a0 
  sw $t0, 4($sp)   # store $a0 into mem 4
