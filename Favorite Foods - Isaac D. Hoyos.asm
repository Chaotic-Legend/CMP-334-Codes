# Name: Isaac D. Hoyos

.data
food1: .asciiz "Pepperoni Pizza\n"
food2: .asciiz "Bacon Hamburger\n"
food3: .asciiz "Meat Lasagna\n"
food4: .asciiz "Chocolate Chip Cookie\n"
food5: .asciiz "Spicy Curry\n"

.text
.globl main
main:
    li $v0, 4       # Set print string syscall once.

    la $a0, food1   # Load address of first favorite food.
    syscall
    
    la $a0, food2   # Load address of second favorite food.
    syscall
    
    la $a0, food3   # Load address of third favorite food.
    syscall
    
    la $a0, food4   # Load address of fourth favorite food.
    syscall
    
    la $a0, food5   # Load address of fifth favorite food.
    syscall
    
    # Exit Program.
    li $v0, 10
    syscall