.data  
.globl main 
.text  
main:  
  addi $a0, $zero, 0x08E9 # The note to play
  addi $sp, $zero, 0x0010 # The "e" register
  addi $t1, $zero, 0x0001 # Key pressed
  lw $t0, 0($sp)   # Read whether or not the "e" key is pressed
  beq $t0, $t1, playnote
  j end
playnote:
  sw $a0, 0($zero)
end:
