# ===========================================================
# Proj1_mergesort.s
# Iterative bottom-up Merge Sort
# Works on our CPRE 3810 minimal RV32I processor
# Uses iterative merging instead of recursion
# Ends with WFI after sorting is complete
# ===========================================================

.data
N:      .word 8
array:  .word 7, 2, 9, 1, 6, 3, 8, 5
temp:   .space 32        # temporary buffer (8 words)

.text
.globl _start

_start:
# Initialize stack pointer
lui x2, 0x7FFFF
addi x2, x2, 0xF0

# Load addresses and variables
la x5, N
lw x10, 0(x5)            # x10 -> N
la x11, array            # x11 -> base address of array
la x12, temp             # x12 -> base address of temp buffer

addi x13, x0, 1          # curr_size -> 1

# -----------------------------------------------------------
# Outer loop
# Repeats merging subarrays of size curr_size
# Doubles curr_size each pass until curr_size >= N
# -----------------------------------------------------------
outer_loop:
blt x13, x10, merge_pass
jal exit

# -----------------------------------------------------------
# Merge pass
# Performs merge on each pair of subarrays of size curr_size
# -----------------------------------------------------------
merge_pass:
addi x14, x0, 0          # left_start -> 0

merge_loop:
addi x15, x10, -1
bge x14, x15, inc_size   # if left_start >= N-1 -> next pass

# mid -> left_start + curr_size - 1
add x16, x14, x13
addi x16, x16, -1

# right_end -> left_start + 2*curr_size - 1
slli x17, x13, 1
add x17, x17, x14
addi x17, x17, -1
addi x18, x10, -1
blt x17, x18, keep_re
add x17, x18, x0
keep_re:

# Call merge(array, left_start, mid, right_end)
jal merge

# Move to next pair of subarrays
slli x19, x13, 1
add x14, x14, x19
jal merge_loop

# Increase subarray size and repeat
inc_size:
slli x13, x13, 1
jal outer_loop

# -----------------------------------------------------------
# Merge function
# Merges two sorted subarrays into a temporary buffer
# Left -> [left_start .. mid]
# Right -> [mid+1 .. right_end]
# -----------------------------------------------------------
merge:
add x20, x14, x0         # i -> left_start
addi x21, x16, 1         # j -> mid + 1
addi x22, x0, 0          # k -> 0 (index in temp)

# Main merge loop
merge_loop_main:
blt x20, x16, check_j1
jal copy_right
check_j1:
blt x21, x17, compare_ok
jal copy_left
compare_ok:

# Load arr[i]
slli x23, x20, 2
add x23, x11, x23
lw x24, 0(x23)

# Load arr[j]
slli x25, x21, 2
add x25, x11, x25
lw x26, 0(x25)

# Compare arr[i] and arr[j]
# If arr[i] <= arr[j], copy arr[i]
blt x26, x24, take_right

# Copy arr[i] to temp[k]
slli x27, x22, 2
add x27, x12, x27
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal merge_loop_main

# Copy arr[j] to temp[k]
take_right:
slli x27, x22, 2
add x27, x12, x27
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal merge_loop_main

# -----------------------------------------------------------
# Copy remaining elements from left subarray
# -----------------------------------------------------------
copy_left:
bge x20, x16, copy_back
slli x23, x20, 2
add x23, x11, x23
lw x24, 0(x23)
slli x27, x22, 2
add x27, x12, x27
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal copy_left

# -----------------------------------------------------------
# Copy remaining elements from right subarray
# -----------------------------------------------------------
copy_right:
bge x21, x17, copy_back
slli x25, x21, 2
add x25, x11, x25
lw x26, 0(x25)
slli x27, x22, 2
add x27, x12, x27
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal copy_right

# -----------------------------------------------------------
# Copy temp array back into main array
# -----------------------------------------------------------
copy_back:
addi x28, x0, 0          # m -> 0
copy_back_loop:
slt x29, x28, x22
beq x29, x0, merge_return

# Load from temp[m]
slli x30, x28, 2
add x30, x12, x30
lw x31, 0(x30)

# Store into array[left_start + m]
add x30, x14, x28
slli x30, x30, 2
add x30, x11, x30
sw x31, 0(x30)

addi x28, x28, 1
jal copy_back_loop

# -----------------------------------------------------------
# Return to outer loop or finish sorting
# -----------------------------------------------------------
merge_return:
jal exit

# Final exit
exit:
wfi

