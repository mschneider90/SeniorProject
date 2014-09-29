.data  
.globl main 
.text  
main:  
  addi $a0, $zero, 5
  addi $sp, $zero, 0
  sw $a0, 0($sp)   # store $a0 
  lw $t0, 0($sp)   # restore $a0  into $t0
