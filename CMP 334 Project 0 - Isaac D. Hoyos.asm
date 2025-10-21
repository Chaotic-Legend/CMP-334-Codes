## Start of file CMP_334_Project0.asm
##
## Question:
##
## This program ask the user to enter a number 1 to 5. 
## If the user enters a number less than 1 or bigger than 5, the program prints
## out "Number is invalid.". If the number entered is valid, the program prints
## out "The item selected is " plus the selected programming language from the
## space-separated list progLanguages.
##
## For example, if user enters the number 2, the program output should be:
##
## Enter a number 1 to 5: 2
## The item selected is Dart
##
## Complete the MIPS assembly instructions, to select and print out the correct 
## programming language based on the user input.
##
## Hint: Use "selected" space to store the selected language as you loop 
## the progLanguages string char by char (one byte at a time) 
##
###############################################################################
#                                                                             #
#                               text segment                                  #
#                                                                             #
###############################################################################

	.text
	.globl __start
__start:

	# print "Enter a number 1 to 5: "
	la $a0, prompt
	li $v0, 4
	syscall
	
	# capture user input
	li $v0, 5
	syscall
	
	# save input into register $s0 
	add $s0, $v0, $zero
	
	# validate input. number must be between 1 and 5
	bgt $s0, 5, __invalid_input
	blt $s0, 1, __invalid_input
	
	# print "The item selected is "
	la $a0, result
	li $v0, 4
	syscall

#
# DO NOT MAKE ANY CHANGES ABOVE THIS LINE
#
#--------------------------your code below this line--------------------------#

# Name: Isaac D. Hoyos

    # Load user input into $t2 for comparison.
    move $t2, $s0             # $t2 = user input, 1-based index.

    # Early check for valid input (must be between 1 and 5).
    li $t7, 1
    blt $t2, $t7, end_of_string    # If input < 1, jump to error.
    li $t7, 5
    bgt $t2, $t7, end_of_string    # If input > 5, jump to error.

    # Load address of progLanguages string.
    la $t0, progLanguages     # $t0 = pointer to current character in string.
    li $t1, 1                 # $t1 = current word index (starts at 1).

find_word_start:
    lb $t3, 0($t0)            # Load current byte.
    beqz $t3, end_of_string   # Reached end of string? Invalid input.
    beq $t1, $t2, copy_word   # If current word index matches user input, copy.
    beq $t3, 32, inc_word     # If current char is a space, word boundary.
    j next_char

inc_word:
    addi $t1, $t1, 1          # Increment current word index.

next_char:
    addi $t0, $t0, 1          # Move to next character in string.
    j find_word_start

copy_word:
    # $t0 now points to the first letter of the selected word.
    la $t4, selected          # $t4 = destination buffer.
    li $t5, 0                 # $t5 = character counter.
    li $t6, 30                # $t6 = max allowed characters to copy.

copy_loop:
    lb $t3, 0($t0)            # Load byte from source.
    beqz $t3, end_copy        # End of string? Stop copying.
    beq $t3, 32, end_copy     # Space character? End of word.
    bge $t5, $t6, end_copy    # Max length reached? Stop.
    sb $t3, 0($t4)            # Store byte in destination.
    addi $t0, $t0, 1          # Move to next byte in source.
    addi $t4, $t4, 1          # Move to next byte in destination.
    addi $t5, $t5, 1          # Increment copied character count.
    j copy_loop

end_copy:
    sb $zero, 0($t4)          # Null-terminate the copied word.

    # Print the selected programming language.
    la $a0, selected
    li $v0, 4
    syscall

    j __exit                  # Normal program exit (defined elsewhere).

end_of_string:
    j __invalid_input         # Jump to error handling (defined elsewhere).
	
#--------------------------your code above this line--------------------------#
#
# DO NOT MAKE ANY CHANGES BELOW THIS LINE
#
__exit:
	li $v0, 10
	syscall
		
__invalid_input:
	# print "Number is invalid."
	la $a0, invalid
	li $v0, 4
	syscall

	j __exit

###############################################################################
#                                                                             #
#                               data segment                                  #
#                                                                             #
###############################################################################
	.data
# List of important programming languagues from 2010-2019
# The list is separated by space. 
# E.g. "Rust" is the first item in the list. "Swift" is the fifth item
#
progLanguages: 	.asciiz "Rust Dart Kotlin TypeScript Swift"

prompt:			.asciiz "Enter a number 1 to 5: "

invalid:		.asciiz "Number is invalid."

result:			.asciiz "The item selected is "
				.align 2
selected:		.space 10
##
## End of file CMP_334_Project0.asm
