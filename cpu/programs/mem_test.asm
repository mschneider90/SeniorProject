.data  
.globl main 
.text  
main:  
  addi $a0, $zero, 0x0FE9
  addi $a2, $zero, 0x00AB
  addi $t1, $zero, 0x0030
  addi $t2, $zero, 0x0032
  sw $a0, 0($t1)   # Store 0x0FE9 into 0x0030
  loopstart:       # While 0x0030 equals 0x0FE9, loop
  lw $a1, 0($t1) 
  beq $a0, $a1, loopstart
  sw $a2, 0($t2)   # Store a flag into 0x0032 to show that the loop is done
