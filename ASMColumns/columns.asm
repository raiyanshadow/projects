################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Columns.
#
# Student 1: Raiyan Ta-seen, 10109294939
# Student 2: Name, Student Number (if applicable)
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       16
# - Unit height in pixels:      16
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################

# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000
DISPLAY_LENGTH:
    .word 256
UNIT_BYTE:
    .word 4
BYTE_PER_ROW:
    .word 64
INITIAL_X:
    .word 8
INITIAL_Y:
    .word 2
COLOUR:
    .word 0xff0000
    .word 0x0000ff
    .word 0x00ff00
    .word 0xffc0cb
    .word 0xffff00
    .word 0xffa500
    .word 0x00ffff
    .word 0xffffff
DIAMOND_COLOUR:
  .word 0x00ffff
STAR_COLOUR:
  .word 0xffffff
COLUMN_BLINK_DELAY:
    .word 350
GAME_OVER_BITMAP:
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,1,1,1,0,1,0,1,0,1,1,0
  .word 0,1,0,0,0,1,0,1,0,1,1,1,0,1,0,0
  .word 0,1,0,1,0,1,1,1,0,1,0,1,0,1,1,0
  .word 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0
  .word 0,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,1,0,1,0,1,1,0,1,1,1,0
  .word 0,1,0,1,0,1,0,1,0,1,0,0,1,0,1,0
  .word 0,1,0,1,0,1,0,1,0,1,1,0,1,1,0,0
  .word 0,1,0,1,0,1,0,1,0,1,0,0,1,0,1,0
  .word 0,1,1,1,0,0,1,0,0,1,1,0,1,0,1,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SELECT_H_BITMAP:
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,1,0,0,0,1,0,1,0,0,1,0
  .word 0,1,0,0,0,1,1,0,1,1,0,1,0,0,1,0
  .word 0,1,1,1,0,1,0,1,0,1,0,1,1,1,1,0
  .word 0,1,0,0,0,1,0,0,0,1,0,1,0,0,1,0
  .word 0,1,1,1,0,1,0,0,0,1,0,1,0,0,1,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SELECT_M_BITMAP:
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,1,0,0,0,1,0,0,0,0,0,0
  .word 0,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0
  .word 0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,0
  .word 0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0
  .word 0,1,1,1,0,1,0,0,0,1,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SELECT_E_BITMAP:
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

PAUSED_BITMAP:
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,1,1,1,0,1,1,1,0,1,0,1,0,0,0
  .word 0,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0
  .word 0,0,1,1,1,0,1,1,1,0,1,0,1,0,0,0
  .word 0,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0
  .word 0,0,1,0,0,0,1,0,1,0,1,1,1,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,1,1,1,0,1,1,1,0,1,1,0,0,0,0
  .word 0,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0
  .word 0,0,1,1,1,0,1,1,1,0,1,0,1,0,0,0
  .word 0,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0
  .word 0,0,1,1,1,0,1,1,1,0,1,1,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SPECIAL_CHANCE:
  .word 20
MIN_FALL:
  .word 200
FALL_DECREASE:
  .word -2

BLOCKS_CLEARED:
  .word 0
  
##############################################################################
# Mutable Data
##############################################################################

CURRENT_X: .word 8
CURRENT_Y: .word 2
COLUMN_COLOUR_1: .word 0
COLUMN_COLOUR_2: .word 0
COLUMN_COLOUR_3: .word 0

GRID:
  .space 4096
MATCH:
  .space 4096

LAST_FALL_TIME:
  .word 0
FALL_INTERVAL:
  .word 1000

SPECIAL_POWERUP_COUNT:
  .word 2

##############################################################################
# File Names/Ascii
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:
  jal clear_screen
  # Initialize the game
  lw $s0, CURRENT_X
  lw $s1, CURRENT_Y
  li $t0, 0
  sw $t0, BLOCKS_CLEARED

  li $t4, 0 # select bit

  jal select_screen

draw_initial_column:

  addi $sp, $sp, -4
  sw $ra, 0($sp) 
  
  jal pick_colours
  ########################################################
  # POWERUPS
  ########################################################
  lw $t0, BLOCKS_CLEARED
  beq $t0, 20, special_powerup
  jal draw_column

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra

game_loop:

    ########################################################
    # KEYBOARD INPUT
    ########################################################
    lw   $t7, ADDR_KBRD
    lw   $t8, 0($t7)
    beq  $t8, 1, keyboard_input

    ########################################################
    # DELTA-TIME GRAVITY
    ########################################################
    li   $v0, 30         # syscall 30 → time in ms
    syscall
    move $t0, $a0        # CURRENT_TIME = v0  (**correct**)

    lw   $t1, LAST_FALL_TIME
    subu $t2, $t0, $t1   # dt = current - last

    lw   $t3, FALL_INTERVAL
    blt  $t2, $t3, skip_auto_fall

    # ----- TIME TO FALL -----
    sw   $t0, LAST_FALL_TIME
    jal  s_pressed        # your gravity function (drop by 1)


    ########################################################
    # ACCELERATE FALL SPEED (optional)
    ########################################################
    lw   $t4, FALL_INTERVAL
    lw $t5, FALL_DECREASE
    add $t4, $t4, $t5
    lw   $t5, MIN_FALL
    blt  $t4, $t5, keep_min
    sw   $t4, FALL_INTERVAL
    j    skip_auto_fall

keep_min:
    li $t4, 100               # clamp to minimum 100ms
    sw $t4, FALL_INTERVAL

skip_auto_fall:

    ########################################################
    # GAME UPDATES + DRAW
    ########################################################
    jal detect_streak
    jal draw_grid
    jal draw_column

    ########################################################
    # FRAME DELAY (smooth fps)
    ########################################################
    li   $v0, 32
    li   $a0, 32
    syscall

    j game_loop

special_powerup:
  lw $t0, SPECIAL_POWERUP_COUNT
  bltz $t0, reset_special_powerup
  addi $t0, $t0, -1
  sw $t0, SPECIAL_POWERUP_COUNT
  jal pick_special
  jal draw_column
  
  j game_loop

reset_special_powerup:
  li $t0, 2
  sw $t0, SPECIAL_POWERUP_COUNT
  lw $t0, BLOCKS_CLEARED
  addi $t0, $t0, -20
  sw $t0, BLOCKS_CLEARED
  jal draw_column

  j game_loop
  
keyboard_input:  
  lw $a0, 4($t7)
  
  li $a1, 0x77
  beq $a0, $a1, w_pressed

  li $a1, 0x61
  beq $a0, $a1, a_pressed

  li $a1, 0x73
  beq $a0, $a1, s_pressed

  li $a1, 0x64
  beq $a0, $a1, d_pressed

  li $a1, 0x71
  beq $a0, $a1, q_pressed

  li $a1, 0x70
  beq $a0, $a1, paused_screen

  jr $ra

w_pressed:
  # perform cyclical shift of column colours
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  lw $t4, COLUMN_COLOUR_1
  lw $t5, COLUMN_COLOUR_2
  lw $t6, COLUMN_COLOUR_3

  sw $t4, COLUMN_COLOUR_2
  sw $t5, COLUMN_COLOUR_3
  sw $t6, COLUMN_COLOUR_1

  jal draw_column

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

a_pressed:
  # move column left
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  lw $t4, CURRENT_X
  addi $t4, $t4, -1

  lw $t5, CURRENT_Y

  move $a0, $t4
  move $a1, $t5

  # detect if column is either on the left most side of the screen or touching another column
  jal collision_detection_side
  bnez $v0, on_boundary
  bltz $t4, on_boundary

  sw $t4, CURRENT_X
  jal draw_column

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

s_pressed:
  # move column down
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  lw $t4, CURRENT_Y
  lw $t5, CURRENT_X
  addi $t4, $t4, 1

  move $a0, $t5
  move $a1, $t4

  # detect wether column is directly on top of another column, or it has already reached the bottom
  jal collision_detection_down
  bnez $v0, on_top_check
  beq $t4, 16, reached_bottom

  sw $t4, CURRENT_Y

  jal draw_column

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

reached_bottom:
  # store the column into the grid
  jal store
  li $v0, 0
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

d_pressed:
  # move column right
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  lw $t4, CURRENT_X
  lw $t5, CURRENT_Y
  addi $t4, $t4, 1

  move $a0, $t4
  move $a1, $t5
  lw $t5, DISPLAY_LENGTH
  lw $t6, UNIT_BYTE
  div $t5, $t5, $t6
  div $t5, $t5, 4

  addi $t5, $t5, -1
  # detect if column is either on the left most side of the screen or touching another column
  jal collision_detection_side
  bnez $v0, on_boundary
  bgt $t4, $t5, on_boundary

  sw $t4, CURRENT_X

  jal draw_column

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

q_pressed:
  # quit game
  li $v0, 10
  syscall

collision_detection_down:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  lw $t0, BYTE_PER_ROW
  lw $t1, UNIT_BYTE 
  mul $t2, $a1, $t0
  mul $t3, $a0, $t1
  add $t1, $t2, $t3

  la  $t2, GRID
  add $t2, $t2, $t1

  lw  $t3, 0($t2)
  beqz $t3, empty
  # return 1 if column is directly below current column and s has been pressed
  li $v0, 1
  j collision_done

collision_detected:
  li $v0, 1
  j collision_done

empty:
  # return 0 if no column is touching current column
  li $v0, 0

collision_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

collision_detection_side:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  lw $t0, BYTE_PER_ROW
  lw $t1, UNIT_BYTE
  mul $t2, $a1, $t0
  mul $t3, $a0, $t1
  add $t1, $t2, $t3
  
  la $t2, GRID
  add $t2, $t2, $t1

  lw $t3, 0($t2)
  bnez $t3, collision_detected

  sub $t2, $t2, $t0
  lw $t3, 0($t2)
  bnez $t3, collision_detected

  sub $t2, $t2, $t0
  lw $t3, 0($t2)
  bnez $t3, collision_detected

  # return 0 if column is not touching another column to its side
  li $v0, 0
  j collision_done

on_top_check:
  # given the current column is touching another column below it, store the current column to the grid
  lw $t0, BYTE_PER_ROW
  lw $t1, UNIT_BYTE
  mul $t2, $s1, $t0
  mul $t3, $s0, $t1
  add $t1, $t2, $t3

  la $t2, GRID
  add $t2, $t2, $t1

  li $t3, 1
  sb $t3, 0($t2)
  
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  j store

draw_column:
  # draw all columns by first clearing screen, drawing the grid filled with previous stored columns, then drawing the current column
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  jal clear_screen
  jal draw_grid
  
  lw $t0, ADDR_DSPL
  lw $s0, CURRENT_X
  lw $s1, CURRENT_Y
  addi $t9, $s1, -2

  lw $t1, COLUMN_COLOUR_1
  lw $t2, COLUMN_COLOUR_2
  lw $t3, COLUMN_COLOUR_3

  lw $t4, UNIT_BYTE
  lw $t5, BYTE_PER_ROW
  mul $t6, $s0, $t4
  mul $t7, $t9, $t5
  add $t8, $t6, $t7

  add $t8, $t0, $t8
  move $a0, $t8
  move $a1, $t1
  jal draw_block

  add $t8, $t8, $t5
  move $a0, $t8
  move $a1, $t2
  jal draw_block

  add $t8, $t8, $t5
  move $a0, $t8
  move $a1, $t3
  jal draw_block

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

draw_block:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  sw $a1, 0($a0)

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

on_boundary:
  # do not move current column if it is on the screen boundary
  li $v0, 0

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

check_spawn_collision:
  # check if current spawn of column is being blocked by another column on the grid
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  la $t0, GRID        

  # compute offset = y*64 + x*4
  sll $t1, $a1, 6
  sll $t2, $a0, 2
  addu $t3, $t1, $t2
  addu $t3, $t3, $t0

  lw $t4, 0($t3)

  # quit game if being blocked
  li $t9, 0xff0000
  bnez $t4, draw_game_over

  j csc_done

csc_done:
  lw   $ra, 0($sp)
  addi $sp, $sp, 4
  jr   $ra

store:
    addi $sp, $sp, -16
    sw   $s1, 0($sp)
    sw   $ra, 4($sp)
    sw   $s3, 8($sp)        # save old s3
    li   $s3, 0             # explosion_flag = 0

    lw   $s0, CURRENT_X
    lw   $s1, CURRENT_Y

    ###########################################################################
    # TOP BLOCK
    ###########################################################################
    move $t0, $s1
    addi $t0, $t0, -2
    lw   $s2, COLUMN_COLOUR_1

    # check diamond
    lw   $t9, DIAMOND_COLOUR
    beq  $s2, $t9, explode_top_diamond

    # check star
    lw   $t9, STAR_COLOUR
    beq  $s2, $t9, explode_top_star

    # only store if no explosion so far
    beq  $s3, 1, skip_store_top
    move $s1, $t0
    jal  store_block

skip_store_top:
    j after_top

explode_top_diamond:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  diamond_explode_anim
    li   $s3, 1             # set explosion flag
    j after_top

explode_top_star:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  star_explode_anim
    li   $s3, 1
    j after_top

after_top:

    ###########################################################################
    # MIDDLE BLOCK
    ###########################################################################
    addi $t0, $t0, 1
    lw   $s2, COLUMN_COLOUR_2

    # check diamond
    lw   $t9, DIAMOND_COLOUR
    beq  $s2, $t9, explode_mid_diamond

    # check star
    lw   $t9, STAR_COLOUR
    beq  $s2, $t9, explode_mid_star

    beq  $s3, 1, skip_store_mid
    move $s1, $t0
    jal  store_block

skip_store_mid:
    j after_mid

explode_mid_diamond:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  diamond_explode_anim
    li   $s3, 1
    j after_mid

explode_mid_star:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  star_explode_anim
    li   $s3, 1
    j after_mid

after_mid:

    ###########################################################################
    # BOTTOM BLOCK
    ###########################################################################
    addi $t0, $t0, 1
    lw   $s2, COLUMN_COLOUR_3

    # check diamond
    lw   $t9, DIAMOND_COLOUR
    beq  $s2, $t9, explode_bot_diamond

    # check star
    lw   $t9, STAR_COLOUR
    beq  $s2, $t9, explode_bot_star

    beq  $s3, 1, skip_store_bot
    move $s1, $t0
    jal  store_block

skip_store_bot:
    j after_bot

explode_bot_diamond:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  diamond_explode_anim
    li   $s3, 1
    j after_bot

explode_bot_star:
    la   $a0, GRID
    lw   $a1, CURRENT_X
    move $a2, $t0
    jal  star_explode_anim
    li   $s3, 1
    j after_bot

after_bot:

    ###########################################################################
    # SPAWN NEXT COLUMN
    ###########################################################################
    lw $t1, INITIAL_X
    lw $t2, INITIAL_Y
    sw $t1, CURRENT_X
    sw $t2, CURRENT_Y

    lw $a0, INITIAL_X
    lw $a1, INITIAL_Y
    jal check_spawn_collision

    jal draw_initial_column

    lw $s3, 8($sp)
    lw $ra, 4($sp)
    lw $s1, 0($sp)
    addi $sp, $sp, 16
    jr $ra

diamond_explode:
    addi $sp, $sp, -40
    sw   $ra, 36($sp)
    sw   $t0, 32($sp)
    sw   $t1, 28($sp)
    sw   $t2, 24($sp)
    sw   $t3, 20($sp)
    sw   $t4, 16($sp)
    sw   $t5, 12($sp)
    sw   $t6, 8($sp)
    sw   $t7, 4($sp)
    sw   $t8, 0($sp)

    li   $t9, 9            # radius^2 = 3*3 = 9
    li   $t0, -3           # dy = -3

dy_loop:
    bgt  $t0, 3, finish_explode

    li   $t1, -3           # dx = -3

dx_loop:
    bgt  $t1, 3, next_dy

    # compute target coords x = a1+dx, y = a2+dy
    add  $t2, $a1, $t1
    add  $t3, $a2, $t0

    # bounds: 0 ≤ x < 16, 0 ≤ y < 16
    bltz $t2, skip
    bltz $t3, skip
    li   $t4, 16
    bge  $t2, $t4, skip
    bge  $t3, $t4, skip

    # radius test: dx^2 + dy^2 ≤ 9
    mul  $t5, $t1, $t1     # dx^2
    mul  $t6, $t0, $t0     # dy^2
    addu $t7, $t5, $t6
    bgt  $t7, $t9, skip

    # compute GRID address = GRID + (y*64 + x*4)
    sll  $t8, $t3, 6       # y*64
    sll  $t5, $t2, 2       # x*4
    addu $t8, $t8, $t5
    addu $t8, $t8, $a0

    # clear block
    sw   $zero, 0($t8)

skip:
    addi $t1, $t1, 1
    j dx_loop

next_dy:
    addi $t0, $t0, 1
    j dy_loop

finish_explode:
    jal draw_grid
    jal apply_gravity

    lw   $t8, 0($sp)
    lw   $t7, 4($sp)
    lw   $t6, 8($sp)
    lw   $t5,12($sp)
    lw   $t4,16($sp)
    lw   $t3,20($sp)
    lw   $t2,24($sp)
    lw   $t1,28($sp)
    lw   $t0,32($sp)
    lw   $ra,36($sp)
    addi $sp, $sp, 40
    jr $ra

star_explode:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    move $t0, $a0       # GRID base
    move $t1, $a1       # X
    move $t2, $a2       # Y
    
    lw   $t3, BYTE_PER_ROW
    lw   $t4, UNIT_BYTE

    ########################################################
    # CLEAR ENTIRE COLUMN (X fixed, Y = 0 → 15)
    ########################################################
    li   $t5, 0          # y = 0

star_col_loop:
    # address = GRID + (y * BYTE_PER_ROW) + (X * UNIT_BYTE)
    mul  $t6, $t5, $t3     # y * row_bytes
    mul  $t7, $t1, $t4     # x * unit_bytes
    add  $t8, $t0, $t6
    add  $t8, $t8, $t7

    sw   $zero, 0($t8)     # clear block

    addi $t5, $t5, 1
    blt  $t5, 16, star_col_loop



    ########################################################
    # CLEAR ENTIRE ROW (Y fixed, X = 0 → 15)
    ########################################################
    li   $t5, 0            # x = 0

star_row_loop:
    # address = GRID + (Y * BYTE_PER_ROW) + (x * UNIT_BYTE)
    mul  $t6, $t2, $t3      # y fixed row
    mul  $t7, $t5, $t4      # x loop
    add  $t8, $t0, $t6
    add  $t8, $t8, $t7

    sw   $zero, 0($t8)

    addi $t5, $t5, 1
    blt  $t5, 16, star_row_loop


    ########################################################
    # DONE
    ########################################################
    jal apply_gravity
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

pick_colours:
  # picks random colour for the column to spawn in with
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # system call to pick random integer between 0 (inclusive) and 6 (exclusive)
  li $a0, 0
  li $v0, 42
  li $a1, 6
  syscall

  la $t1, COLOUR
  sll $a0, $a0, 2
  add $t1, $t1, $a0
  lw $t1, 0($t1)
  li $a0, 0
  sw $t1, COLUMN_COLOUR_1

  li $v0, 42
  li $a1, 6
  syscall

  la $t2, COLOUR
  sll $a0, $a0, 2
  add $t2, $t2, $a0
  lw $t2, 0($t2)
  li $a0, 0
  sw $t2, COLUMN_COLOUR_2

  li $v0, 42
  li $a1, 6
  syscall

  la $t3, COLOUR
  sll $a0, $a0, 2
  add $t3, $t3, $a0
  lw $t3, 0($t3)
  li $a0, 0
  sw $t3, COLUMN_COLOUR_3

  li $v0, 42
  li $a1, 100
  syscall
  lw $t1, SPECIAL_CHANCE

  blt $a0, $t1, pick_special

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra

pick_special:
  li $a0, 0
  li $a1, 2
  li $v0, 42
  syscall
  beqz $a0, pick_star

pick_diamond:
  la $t2, COLOUR
  li $t3, 6 
  sll $t3, $t3, 2
  add $t2, $t2, $t3
  lw $t2, 0($t2)

  sw $t2, COLUMN_COLOUR_2

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra

pick_star:
  la $t2, COLOUR
  li $t3, 7
  sll $t3, $t3, 2
  add $t2, $t2, $t3
  lw $t2, 0($t2)

  sw $t2, COLUMN_COLOUR_2

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

store_block:
  # store the block onto the grid
  addi $sp, $sp, -20
  sw   $ra, 16($sp)
  sw   $t0, 12($sp)
  sw   $t1, 8($sp)
  sw   $t2, 4($sp)

  lw   $t0, UNIT_BYTE
  lw   $t1, BYTE_PER_ROW
  mul  $t3, $s1, $t1        # t3 = y * row_bytes
  mul  $t4, $s0, $t0        # t4 = x * unit_bytes
  add  $t5, $t3, $t4        # t5 = byte offset

  la   $t6, GRID
  add  $t6, $t6, $t5        # t6 = address where we will write

  sw   $s2, 0($t6)

  lw   $t2, 4($sp)
  lw   $t1, 8($sp)
  lw   $t0, 12($sp)
  lw   $ra, 16($sp)
  addi $sp, $sp, 20
  jr   $ra

draw_grid:
  # draw the current grid according to its data stored (filled with RGB values in a 2d list fashion)
  lw $t0, ADDR_DSPL
  la $t1, GRID
  li $t2, 0

grid_loop:
  # main loop to draw grid
  beq $t2, 256, grid_done
  lw $t3, 0($t1)

  sw $t3, 0($t0)
  
  add $t1, $t1, 4
  add $t0, $t0, 4
  
  add $t2, $t2, 1

  j grid_loop

grid_done:
    jr $ra

clear_screen:
  # clear the screen by setting all pixels to black
  lw $t0, ADDR_DSPL
  li $t2, 1024
  
  li $t3, 0x000000

clear_loop:
  # main loop for clearing the screen
  beq  $t2, $zero, clear_done

  sw $t3, 0($t0)
  addi $t0, $t0, 4
  addi $t2, $t2, -1
  j clear_loop

clear_done:
  jr $ra

clear_matched:
  # clear the matched grid locations
  la $t0, MATCH
  li $t1, 256

cm_loop:
  # main loop for clearing matched blocks
  beq  $t1, $zero, cm_done
  sb $zero, 0($t0)
  addi $t0, $t0, 1
  addi $t1, $t1, -1
  j cm_loop

cm_done:
  jr   $ra

detect_streak:
  # detecting a streak of the same colour in some orientation
  addi $sp, $sp, -4
  sw $ra, 0($sp)

ds_loop:
  jal mark_vertical_streaks
  jal mark_horizontal_streaks
  jal mark_diag_dl
  jal mark_diag_dr

  # if no matches, we're done
  jal match_any
  beqz $v0, ds_done

  jal blink_matches

  # there are matches: clear marked cells, reset MATCH, apply gravity, then repeat
  jal clear_marked_cells
  jal clear_matched
  jal apply_gravity

  j ds_loop

ds_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

# mark_vertical_streaks
# Scans columns x=0..16, y=0..16; marks MATCH[y*16 + x] = 1 for runs >= 3
mark_vertical_streaks:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  la $t8, GRID
  la $t9, MATCH

  li $t0, 0
  
mvs_x_loop:
  # loop while keeping y out of scope
  # outer loop
  bge $t0, 16, mvs_done

  li $t1, 0 # y = 0
  li $t2, -1 # streak_color = -1 (invalid)
  li $t3, 0 # streak_len = 0

mvs_y_loop:
  # loop using the specified x and y values
  # inner loop
  bge $t1, 16, mvs_end_column

  # compute byte_offset = x*4 + y*64
  sll $t4, $t0, 2      # x * 4
  sll $t5, $t1, 6      # y * 64
  addu $t6, $t4, $t5    # t6 = byte offset
  addu $t6, $t8, $t6    # t6 = &GRID[x,y]

  lw $t7, 0($t6)      # color (word)

  # Skip if color is black (0) - don't count empty cells in streaks
  beqz $t7, mvs_reset_streak
  
  beq $t7, $t2, mvs_same_color

mvs_new_color:
  # new color → if previous streak >= 3 mark it
  blt  $t3, 3, mvs_start_new
  # mark previous streak: a0 = x, a1 = y - streak_len, a2 = streak_len
  move $a0, $t0
  sub  $a1, $t1, $t3
  move $a2, $t3
  jal  mark_vertical_range

mvs_start_new:
  move $t2, $t7 # streak_color = color
  li $t3, 1 # streak_len = 1
  addi $t1, $t1, 1
  j mvs_y_loop

mvs_same_color:
  addi $t3, $t3, 1
  addi $t1, $t1, 1
  j mvs_y_loop

mvs_reset_streak:
  # Found empty cell - check if previous streak should be marked
  blt $t3, 3, mvs_reset_no_mark
  move $a0, $t0
  sub $a1, $t1, $t3
  move $a2, $t3
  jal mark_vertical_range
    
mvs_reset_no_mark:
  li $t2, -1          # reset streak color
  li $t3, 0           # reset streak length
  addi $t1, $t1, 1
  j mvs_y_loop

mvs_end_column:
  # final streak at column end?
  blt $t3, 3, mvs_next_col
  move $a0, $t0
  sub $a1, $t1, $t3
  move $a2, $t3
  jal mark_vertical_range

mvs_next_col:
  addi $t0, $t0, 1
  j mvs_x_loop

mvs_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

mark_vertical_range:
  move $t0, $a0
  move $t1, $a1
  move $t2, $a2

  la $t9, MATCH
  li $t3, 1

mvr_loop:
    beq $t2, $zero, mvr_done

    sll $t4, $t1, 4
    addu $t4, $t4, $t0

    addu $t5, $t9, $t4
    sb $t3, 0($t5)

    addi $t1, $t1, 1
    addi $t2, $t2, -1
    j mvr_loop

mvr_done:
    jr   $ra

# same as mark_vertical_streaks, this time horizontals
mark_horizontal_streaks:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    la $t8, GRID
    la $t9, MATCH

    li $t1, 0
mhs_y_loop:
    bge $t1, 16, mhs_done

    li $t0, 0
    li $t2, -1
    li $t3, 0

mhs_x_loop:
  bge  $t0, 16, mhs_end_row
  
  sll $t4, $t0, 2
  sll $t5, $t1, 6
  addu $t6, $t4, $t5
  addu $t6, $t8, $t6

  lw $t7, 0($t6)

  beqz $t7, mhs_reset_streak
  
  beq $t7, $t2, mhs_same_color

mhs_new_color:
  blt $t3, 3, mhs_start_new
  sub $a0, $t0, $t3
  move $a1, $t1
  move $a2, $t3
  jal mark_horizontal_range

mhs_start_new:
  move $t2, $t7
  li $t3, 1
  addi $t0, $t0, 1
  j mhs_x_loop

mhs_same_color:
  addi $t3, $t3, 1
  addi $t0, $t0, 1
  j mhs_x_loop

mhs_reset_streak:
  blt $t3, 3, mhs_reset_no_mark
  sub $a0, $t0, $t3
  move $a1, $t1
  move $a2, $t3
  jal mark_horizontal_range
    
mhs_reset_no_mark:
  li $t2, -1
  li $t3, 0
  addi $t0, $t0, 1
  j mhs_x_loop

mhs_end_row:
  blt $t3, 3, mhs_next_row
  sub $a0, $t0, $t3
  move $a1, $t1
  move $a2, $t3
  jal mark_horizontal_range

mhs_next_row:
  addi $t1, $t1, 1
  j mhs_y_loop

mhs_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

mark_horizontal_range:
  move $t0, $a0
  move $t1, $a1
  move $t2, $a2

  la $t9, MATCH
  li $t3, 1

mhr_loop:
  beq $t2, $zero, mhr_done

  sll $t4, $t1, 4
  addu $t4, $t4, $t0

  addu $t5, $t9, $t4
  sb $t3, 0($t5)

  addi $t0, $t0, 1
  addi $t2, $t2, -1
  j mhr_loop

mhr_done:
  jr $ra

# same as vertical, but this time diagonal from left to right
mark_diag_dr:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  la $t8, GRID
  la $t9, MATCH

  li $t1, 0
    
mdr_y_loop:
  bge $t1, 16, mdr_done

  li $t0, 0
  
mdr_x_loop:
  bge $t0, 16, mdr_next_row

  # load center color at (x,y)
  sll $t4, $t1, 6       # t4 = y*64
  sll $t5, $t0, 2       # t5 = x*4
  addu $t6, $t4, $t5
  addu $t6, $t6, $t8
  lw $t2, 0($t6)        # t2 = center color (word)
  beqz $t2, mdr_inc_x   # skip empty cells

  # count forward along (x+1, y+1)
  addi $t3, $t0, 1      # tx = x+1
  addi $t4, $t1, 1      # ty = y+1
  li $t5, 1             # cnt = 1  (center counted)

mdr_count_forward:
  bge $t3, 16, mdr_count_done
  bge $t4, 16, mdr_count_done

  # addr = GRID + (ty*64 + tx*4)
  sll $t6, $t4, 6
  sll $t7, $t3, 2
  addu $t6, $t6, $t7
  addu $t6, $t6, $t8
  lw $t7, 0($t6) # t7 = tile at (tx,ty)
  bne $t7, $t2, mdr_count_done

  addi $t5, $t5, 1 # cnt++
  addi $t3, $t3, 1 # tx++
  addi $t4, $t4, 1 # ty++
  j mdr_count_forward

mdr_count_done:
  li $t6, 3
  blt $t5, $t6, mdr_inc_x  # if cnt < 3 skip

  move $a0, $t0
  move $a1, $t1
  move $a2, $t5
  jal mark_diag_dr_range

mdr_inc_x:
  addi $t0, $t0, 1
  j mdr_x_loop

mdr_next_row:
  addi $t1, $t1, 1
  j mdr_y_loop

mdr_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

mark_diag_dr_range:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  move $t0, $a0
  move $t1, $a1
  move $t2, $a2

  la $t9, MATCH
  li $t3, 1

mdr_mark_loop:
  beq  $t2, $zero, mdr_mark_done
  
  sll $t4, $t1, 4
  addu $t4, $t4, $t0
  addu $t5, $t9, $t4
  sb $t3, 0($t5)

  addi $t0, $t0, 1
  addi $t1, $t1, 1
  addi $t2, $t2, -1
  j mdr_mark_loop

mdr_mark_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

# same as diagonal left to right, this time right to left
mark_diag_dl:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  la $t8, GRID
  la $t9, MATCH

  li $t1, 0
    
mdl_y_loop:
  bge $t1, 16, mdl_done

  li $t0, 0

mdl_x_loop:
  bge $t0, 16, mdl_next_row
  
  sll $t4, $t1, 6
  sll $t5, $t0, 2
  addu $t6, $t4, $t5
  addu $t6, $t6, $t8
  lw $t2, 0($t6)
  beqz $t2, mdl_inc_x

  addi $t3, $t0, -1
  addi $t4, $t1, 1
  li $t5, 1

mdl_count_forward:
  bltz $t3, mdl_count_done
  bge $t4, 16, mdl_count_done

  sll $t6, $t4, 6
  sll $t7, $t3, 2
  addu $t6, $t6, $t7
  addu $t6, $t6, $t8
  lw $t7, 0($t6)
  bne $t7, $t2, mdl_count_done

  addi $t5, $t5, 1
  addi $t3, $t3, -1
  addi $t4, $t4, 1
  j mdl_count_forward

mdl_count_done:
  li $t6, 3
  blt $t5, $t6, mdl_inc_x

  move $a0, $t0
  move $a1, $t1
  move $a2, $t5
  jal mark_diag_dl_range

mdl_inc_x:
  addi $t0, $t0, 1
  j mdl_x_loop

mdl_next_row:
  addi $t1, $t1, 1
  j mdl_y_loop

mdl_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

mark_diag_dl_range:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  move $t0, $a0
  move $t1, $a1
  move $t2, $a2

  la $t9, MATCH
  li $t3, 1

mdl_mark_loop2:
  beq $t2, $zero, mdl_mark_done2
  
  sll $t4, $t1, 4
  addu $t4, $t4, $t0
  addu $t5, $t9, $t4
  sb $t3, 0($t5)

  addi $t0, $t0, -1
  addi $t1, $t1, 1
  addi $t2, $t2, -1
  j mdl_mark_loop2

mdl_mark_done2:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

clear_marked_cells:
  la $t0, GRID
  la $t1, MATCH
  li $t2, 0
    
cmc_loop:
  bge $t2, 256, cmc_done

  add $t3, $t1, $t2
  lb $t4, 0($t3)
  
  beqz $t4, cmc_next

  sll $t5, $t2, 2
  add $t6, $t0, $t5
  sw $zero, 0($t6)

  lw $t3, BLOCKS_CLEARED
  add $t3, $t3, 1

  beq $t3, 21, skip_increment
  sw $t3, BLOCKS_CLEARED
  j cmc_next

skip_increment:
  li $t3, 20
  sw $t3, BLOCKS_CLEARED
  
cmc_next:
  addi $t2, $t2, 1
  j cmc_loop
    
cmc_done:
  jr $ra

match_any:
  # checks if any matches have been found so far
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  la $t0, MATCH
  li $t1, 0          # counter
  li $t2, 256        # limit

ma_loop:
  # main loop to check for matches
  beq $t1, $t2, ma_none
  lb $t3, 0($t0)
  bnez $t3, ma_found
  addi $t0, $t0, 1
  addi $t1, $t1, 1
  j ma_loop

ma_found:
  # match has been found, return 1
  li $v0, 1
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

ma_none:
  li $v0, 0
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

apply_gravity:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  la $t0, GRID

  li $t1, 0

col_loop:
  bge $t1, 16, ag_done # if x >= 16, end

  li $t2, 15          # t2 = writeY = 15
  li $t3, 15          # t3 = y = 15 (scan down)

scan_loop:
  bltz $t3, finish_col  # if y < 0, done scanning column

  # Compute address for (x, y)
  # offset = y*64 + x*4
  sll $t4, $t3, 6       # t4 = y * 64
  sll $t5, $t1, 2       # t5 = x * 4
  addu $t6, $t4, $t5    # t6 = byte offset
  addu $t6, $t6, $t0    # t6 = addr = GRID + offset

  lw $t7, 0($t6)        # t7 = tile value

  beqz $t7, next_y      # if EMPTY, skip

  # Compute destination address for (x, writeY)
  sll $t8, $t2, 6       # t8 = writeY * 64
  addu $t8, $t8, $t5    # reuse t5 = x*4, t8 = writeY*64 + x*4
  addu $t8, $t8, $t0    # final addr

  sw $t7, 0($t8)        # move tile down
  addi $t2, $t2, -1     # writeY--

next_y:
  addi $t3, $t3, -1     # y--
  j scan_loop

finish_col:
  # t2 = last filled index; clear from 0..t2
  bltz $t2, next_col # if writeY < 0: no clearing needed

clear_gravity_loop:
  sll $t4, $t2, 6       # t4 = clearY * 64
  addu $t4, $t4, $t5    # t5 = x*4 → combine
  addu $t4, $t4, $t0    # absolute address

  sw $zero, 0($t4)      # set to EMPTY

  addi $t2, $t2, -1     # clearY--
  bgez $t2, clear_gravity_loop

next_col:
  addi $t1, $t1, 1      # x++
  j col_loop

ag_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra


blink_matches:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  li $t9, 3

blink_loop:
  # turn matched cells white
  la $t0, MATCH
  la $t1, GRID
  li $t2, 0                # index = 0

blink_white_loop:
  bge $t2, 256, draw_white

  lb $t3, 0($t0)           # is this cell matched?
  beqz $t3, bw_next

  # compute y,x
  move $t4, $t2            # index → t4
  srl $t5, $t4, 4          # y = index / 16
  andi $t6, $t4, 15        # x = index % 16

  # compute address in GRID: y*64 + x*4
  sll $t7, $t5, 6          # y * 64
  sll $t8, $t6, 2          # x * 4
  addu $t7, $t7, $t8
  addu $t7, $t7, $t1

  li $t3, 0xFFFFFF
  sw $t3, 0($t7)

bw_next:
  addi $t0, $t0, 1
  addi $t2, $t2, 1
  j blink_white_loop

draw_white:
  jal draw_grid
  jal delay_blink

  # restore cells
  la   $t0, MATCH
  la   $t1, GRID
  li   $t2, 0

blink_restore_loop:
  bge $t2, 256, draw_normal

  lb $t3, 0($t0)
  beqz $t3, br_next

  move $t4, $t2
  srl $t5, $t4, 4
  andi $t6, $t4, 15

  sll $t7, $t5, 6
  sll $t8, $t6, 2
  addu $t7, $t7, $t8
  addu $t7, $t7, $t1

  sw $zero, 0($t7)

br_next:
  addi $t0, $t0, 1
  addi $t2, $t2, 1
  j blink_restore_loop

draw_normal:
  jal draw_grid
  jal delay_blink

  addi $t9, $t9, -1
  bgtz $t9, blink_loop

  # done
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

delay_blink:
  li $v0, 32      # sleep syscall
  lw $a0, COLUMN_BLINK_DELAY
  syscall
  jr $ra

diamond_explode_anim:
    addi $sp,$sp,-24
    sw   $ra,16($sp)
    sw   $a0,12($sp)   # save GRID (caller passed)
    sw   $a1,8($sp)    # save cx (center x)
    sw   $a2,4($sp)    # save cy (center y)

    # FRAME 1 (blue) - draw to FRAMEBUFFER, not GRID
    la   $t0, ADDR_DSPL
    lw   $a0, 0($t0)     # a0 = framebuffer base
    lw   $a1, 8($sp)     # a1 = cx
    lw   $a2, 4($sp)     # a2 = cy
    li   $a3, 0x0000FF
    jal  dea_draw_frame

    li $v0,32
    li $a0,300
    syscall

    # FRAME 2 (red)
    la   $t0, ADDR_DSPL
    lw   $a0, 0($t0)
    lw   $a1, 8($sp)
    lw   $a2, 4($sp)
    li   $a3, 0xFF0000
    jal  dea_draw_frame

    li $v0,32
    li $a0,200
    syscall

    # FRAME 3 (orange)
    la   $t0, ADDR_DSPL
    lw   $a0, 0($t0)
    lw   $a1, 8($sp)
    lw   $a2, 4($sp)
    li   $a3, 0xFFA500
    jal  dea_draw_frame

    li $v0,32
    li $a0,300
    syscall

    # Now call the logic that actually clears the blocks in GRID
    lw   $a0,12($sp)   # GRID
    lw   $a1,8($sp)    # cx
    lw   $a2,4($sp)    # cy
    jal  diamond_explode

    lw   $ra,16($sp)
    addi $sp,$sp,24
    jr   $ra

############################################################
# Helper: draw single frame
# a0 = framebuffer base
# a1 = center x
# a2 = center y
# a3 = color
############################################################
dea_draw_frame:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $t0, 3        # radius
    mul  $t1, $t0, $t0 # r^2
    li   $t2, -3       # dy

outer_dy_dea:
    li   $t0, -3       # dx
inner_dx_dea:
    add  $t3, $a1, $t0
    add  $t4, $a2, $t2

    # bounds check
    bltz $t3, dea_skip
    bltz $t4, dea_skip
    li   $t5, 16
    bge  $t3, $t5, dea_skip
    bge  $t4, $t5, dea_skip

    # radius check
    mul  $t6, $t0, $t0
    mul  $t7, $t2, $t2
    addu $t8, $t6, $t7
    bgt  $t8, $t1, dea_skip

    # framebuffer address
    lw   $t9, BYTE_PER_ROW
    lw   $t6, UNIT_BYTE
    mul  $t7, $t4, $t9
    mul  $t8, $t3, $t6
    addu $t9, $t7, $t8
    addu $t9, $a0, $t9

    # draw pixel
    sw   $a3, 0($t9)

dea_skip:
    addi $t0, $t0, 1
    ble  $t0, 3, inner_dx_dea

    addi $t2, $t2, 1
    ble  $t2, 3, outer_dy_dea

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

star_explode_anim:
    addi $sp, $sp, -40
    sw   $ra, 36($sp)
    sw   $s0, 32($sp)
    sw   $s1, 28($sp)
    sw   $s2, 24($sp)
    sw   $s3, 20($sp)
    sw   $s4, 16($sp)
    sw   $s5, 12($sp)
    sw   $s6, 8($sp)
    sw   $s7, 4($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2

    la   $t0, ADDR_DSPL
    lw   $s3, 0($t0)

    lw   $s4, BYTE_PER_ROW
    lw   $s5, UNIT_BYTE

    li   $t0, 15
    sub  $t1, $t0, $s1
    move $t2, $s1
    blt  $t1, $t2, r1
    move $t2, $t1
r1:
    move $t1, $s2
    blt  $t1, $t2, r2
    move $t2, $t1
r2:
    li   $t0, 15
    sub  $t1, $t0, $s2
    blt  $t1, $t2, r3
    move $t2, $t1
r3:
    move $s6, $t2

    li   $t3, 0

frame_loop:
    bgt  $t3, $s6, star_anim_done

    li   $t4, 0x00FFFF00

    # UP
    sub  $t5, $s2, $t3
    bltz $t5, skip_up_f
    mul  $t6, $t5, $s4
    mul  $t7, $s1, $s5
    addu $t8, $t6, $t7
    addu $t8, $t8, $s3
    sw   $t4, 0($t8)
skip_up_f:

    # DOWN
    add  $t5, $s2, $t3
    li   $t6, 16
    bge  $t5, $t6, skip_down_f
    mul  $t7, $t5, $s4
    mul  $t8, $s1, $s5
    addu $t9, $t7, $t8
    addu $t9, $t9, $s3
    sw   $t4, 0($t9)
skip_down_f:

    # LEFT
    sub  $t5, $s1, $t3
    bltz $t5, skip_left_f
    mul  $t6, $s2, $s4
    mul  $t7, $t5, $s5
    addu $t8, $t6, $t7
    addu $t8, $t8, $s3
    sw   $t4, 0($t8)
skip_left_f:

    # RIGHT
    add  $t5, $s1, $t3
    li   $t6, 16
    bge  $t5, $t6, skip_right_f
    mul  $t7, $s2, $s4
    mul  $t8, $t5, $s5
    addu $t9, $t7, $t8
    addu $t9, $t9, $s3
    sw   $t4, 0($t9)
skip_right_f:

    # delay 50 ms
    li   $v0, 32
    li   $a0, 50
    syscall

    addi $t3, $t3, 1
    j frame_loop

star_anim_done:
    # final delay 150 ms
    li   $v0, 32
    li   $a0, 150
    syscall

    # clear grid column & row (call star_explode using preserved args)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    jal  star_explode

    # restore saved registers & ra
    lw   $s7, 4($sp)
    lw   $s6, 8($sp)
    lw   $s5, 12($sp)
    lw   $s4, 16($sp)
    lw   $s3, 20($sp)
    lw   $s2, 24($sp)
    lw   $s1, 28($sp)
    lw   $s0, 32($sp)
    lw   $ra, 36($sp)
    addi $sp, $sp, 40
    jr   $ra

draw_game_over:
  jal clear_screen
    # Set up initial pointers and values
    la   $t0, GAME_OVER_BITMAP     # Load address of the bitmap (points to the 1D array)
    li   $t1, 0x10008000           # Base address for the screen (bitmap location)
    li   $t2, 0                    # Row index (assuming 16 rows)
    li   $t3, 0                    # Column index (assuming 16 columns)

go_loop_columns:
    bge  $t3, 16, go_loop_rows    # If column >= 16, go to next row

    mul  $t4, $t2, 16             # t4 = row * 16 (width of the bitmap)
    add  $t5, $t4, $t3            # t5 = row * 16 + column (pixel index)
    sll  $t5, $t5, 2              # t5 = (row * 16 + column) * 4 (word size in bytes)
    add  $t6, $t0, $t5            # t6 = address of the bitmap pixel (base + offset)

    lw   $t7, 0($t6)              # Load the pixel value (either 0 or 1) from the bitmap

    beqz $t7, go_skip_pixel       # If pixel is 0, skip drawing

go_draw_pixel:
    # If the pixel value is 1, draw it
    add  $t8, $t1, $t5            # t8 = screen address (base + offset)

    sw   $t9, 0($t8)              # Store color at the calculated screen address

go_skip_pixel:
    addi $t3, $t3, 1              # Move to the next column
    j    go_loop_columns

go_loop_rows:
    bge  $t2, 16, go_blink       # If row >= 16, end the drawing process
    addi $t2, $t2, 1              # Move to the next row
    li   $t3, 0                   # Reset column index to 0
    j    go_loop_columns

go_blink:
  li $a0, 400
  li $v0, 32
  syscall

  lw   $t7, ADDR_KBRD
  lw   $t8, 0($t7)
  beq  $t8, 1, check_r_key

switch_to_white:
  li $t9, 0xffffff
  j draw_game_over

check_r_key:
  lw $t8, 4($t7)

  li $a0, 0x72
  beq $t8, $a0, r_pressed
  beq $t9, 0xff0000, switch_to_white
  li $t9, 0xff0000

  j draw_game_over

r_pressed:
  jal reset_grid
  j main

reset_grid:
    la   $t0, GRID   # Base address of the grid
    li   $t1, 0            # Reset value (e.g., 0 for empty grid)
    li   $t2, 0            # Row index (16 rows)
    li   $t3, 16           # Number of columns (16)
    # Reset column loop: Reset each column of the current row
    li   $t4, 0            # Column index (reset to 0)

reset_grid_column_loop:
    bge  $t4, 16, next_grid_row  # If column >= 16, go to the next row

    # Calculate address for the current grid cell
    mul  $t5, $t2, 16       # t5 = row * 16 (width of the grid)
    add  $t6, $t5, $t4      # t6 = row * 16 + column (pixel index)
    sll  $t6, $t6, 2        # t6 = (row * 16 + column) * 4 (word size in bytes)
    add  $t7, $t0, $t6      # t7 = address of the grid element (base + offset)

    # Set grid cell to 0 (reset to empty)
    sw   $t1, 0($t7)        # Store the reset value (0)

    addi $t4, $t4, 1        # Move to the next column
    j    reset_grid_column_loop  # Repeat for next column

next_grid_row:
    addi $t2, $t2, 1        # Move to the next row
    bge  $t2, 16, reset_grid_done  # If row >= 16, we are done
    li   $t4, 0             # Reset column index to 0
    j    reset_grid_column_loop  # Reset columns for the new row

reset_grid_done:
  jr $ra

reset_matched:
    la  $t0, MATCH  # Base address of matched array
    li   $t1, 0                   # Reset value (e.g., 0 for no match)
    li   $t2, 0                   # Row index (16 rows)
    li   $t3, 16                  # Number of columns (16)
    # Reset column loop: Reset each column of the current row in the matched grid
    li   $t4, 0                   # Column index (reset to 0)

reset_matched_column_loop:
    bge  $t4, 16, next_matched_row  # If column >= 16, go to the next row

    # Calculate address for the current matched element
    mul  $t5, $t2, 16              # t5 = row * 16 (width of the matched array)
    add  $t6, $t5, $t4             # t6 = row * 16 + column (index)
    sll  $t6, $t6, 2               # t6 = (row * 16 + column) * 4 (word size in bytes)
    add  $t7, $t0, $t6             # t7 = address of the matched array element

    # Set matched cell to 0 (reset to no match)
    sw   $t1, 0($t7)               # Store the reset value (0)

    addi $t4, $t4, 1               # Move to the next column
    j    reset_matched_column_loop # Repeat for next column

next_matched_row:
    addi $t2, $t2, 1               # Move to the next row
    bge  $t2, 16, reset_matched_done  # If row >= 16, we are done
    li   $t4, 0                    # Reset column index to 0
    j    reset_matched_column_loop  # Reset columns for the new row

reset_matched_done:
    jr $ra

select_screen:
  li $a0, 32
  li $v0, 32
  syscall
  la $a0, SELECT_H_BITMAP
  li $a1, 0xffffff
  bne $t4, 2, skip_select_red
  jal select_red

skip_select_red:
  jal draw_select_bitmap

  la $a0, SELECT_M_BITMAP
  li $a1, 0xffffff
  bne $t4, 1, skip_select_yellow
  jal select_yellow

skip_select_yellow:
  jal draw_select_bitmap

  la $a0, SELECT_E_BITMAP
  li $a1, 0xffffff
  bne $t4, 0, skip_select_green
  jal select_green

skip_select_green:
  jal draw_select_bitmap

  lw   $t7, ADDR_KBRD
  lw   $t8, 0($t7)
  beq  $t8, 1, check_select_keypress
  j select_screen

check_select_keypress:
    lw $t7, 4($t7)
    li $a3, 0x61
    beq $t7, $a3, a_select_pressed

    li $a3, 0x64
    beq $t7, $a3, d_select_pressed

    li $a3, 0x0a
    beq $t7, $a3, enter_select_pressed

    j select_screen

a_select_pressed:
  addi $t4, $t4, -1
  bge $t4, 0, skip_a_select_overflow
  li $t4, 2

skip_a_select_overflow:
  j select_screen

d_select_pressed:
  add $t4, $t4, 1
  ble $t4, 2, skip_d_select_overflow
  li $t4, 0

skip_d_select_overflow:
  j select_screen

enter_select_pressed:
  beq $t4, 0, easy_mode
  beq $t4, 1, medium_mode
  beq $t4, 2, hard_mode

easy_mode:
  li $t0, 20
  sw $t0, SPECIAL_CHANCE
  li $t0, -2
  sw $t0, FALL_DECREASE
  li $t0, 200
  sw $t0, MIN_FALL
  li $t0, 1500
  sw $t0, FALL_INTERVAL
  li $v0, 32
  li $a0, 100
  syscall       # small delay (100 ms)

  li $v0, 30
  syscall
  sw $a0, LAST_FALL_TIME

  jal draw_initial_column

  j game_loop

medium_mode:
  li $t0, 10
  sw $t0, SPECIAL_CHANCE
  li $t0, -5
  sw $t0, FALL_DECREASE
  li $t0, 100
  sw $t0, MIN_FALL
  li $t0, 1000
  sw $t0, FALL_INTERVAL

  li $v0, 32
  li $a0, 100
  syscall       # small delay (100 ms)

  li $v0, 30
  syscall
  sw $a0, LAST_FALL_TIME

  jal draw_initial_column

  j game_loop

hard_mode:
  li $t0, 5
  sw $t0, SPECIAL_CHANCE
  li $t0, -15
  sw $t0, FALL_DECREASE
  li $t0, 50
  sw $t0, MIN_FALL
  li $t0, 800
  sw $t0, FALL_INTERVAL

  li $v0, 32
  li $a0, 100
  syscall       # small delay (100 ms)

  li $v0, 30
  syscall
  sw $a0, LAST_FALL_TIME

  jal draw_initial_column

  j game_loop

draw_select_bitmap:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  la $t0, 0x10008000
  li $t1, 0 #row 
  li $t2, 0 #column

draw_select_column_loop:
  beq $t2, 16, draw_select_row_loop

  mul $t3, $t1, 64
  mul $t5, $t2, 4
  add $t3, $t3, $t5
  add $t5, $t3, $a0
  
  lw $t5, 0($t5)
  beqz $t5, skip_select_draw
  
draw_select_draw_pixel:
  add $t5, $t3, $t0
  sw $a1, 0($t5)

skip_select_draw:
  add $t2, $t2, 1
  j draw_select_column_loop

draw_select_row_loop:
  beq $t1, 16, draw_select_done
  li $t2, 0
  add $t1, $t1, 1
  j draw_select_column_loop

draw_select_done:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

select_red:
  li $a1, 0xff0000
  jr $ra

select_yellow:
  li $a1, 0xffff00
  jr $ra

select_green:
  li $a1, 0x00ff00
  jr $ra

paused_screen:
  li $a0, 200
  li $v0, 32
  syscall
  jal clear_screen
  la $a0, PAUSED_BITMAP
  li $a1, 0xffff00
  jal draw_select_bitmap

  lw   $t7, ADDR_KBRD
  lw   $t8, 0($t7)
  beq $t8, 1, check_p_pressed

  j paused_screen

check_p_pressed:
  lw $t8, 4($t7)
  li $a1, 0x70
  bne $t8, $a1, paused_screen

  j game_loop


