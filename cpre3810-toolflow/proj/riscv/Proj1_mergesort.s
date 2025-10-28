# ===========================================================
# Proj1_mergesort.s  (fixed)
# Bottom-up iterative mergesort for minimal RV32I
# ===========================================================

.data
N:      .word 8
array:  .word 7, 2, 9, 1, 6, 3, 8, 5
temp:   .space 32

.text
.globl _start

_start:
lui x2, 0x7FFFF
addi x2, x2, 0xF0

la x5, N
lw x10, 0(x5)            # N
la x11, array            # base A
la x12, temp             # base TMP

addi x13, x0, 1          # curr_size = 1

outer_loop:
blt x13, x10, merge_pass
jal x0, exit

merge_pass:
addi x14, x0, 0          # left_start = 0

merge_loop:
addi x15, x10, -1
bge x14, x15, inc_size   # if left_start >= N-1 => next pass

# mid = min(left_start + curr_size - 1, N-1)
add x16, x14, x13
addi x16, x16, -1
addi x18, x10, -1
blt x16, x18, mid_ok
add x16, x18, x0
mid_ok:

# right_end = min(left_start + 2*curr_size - 1, N-1)
slli x17, x13, 1
add x17, x17, x14
addi x17, x17, -1
blt x17, x18, keep_re
add x17, x18, x0
keep_re:

# call merge(A, left_start, mid, right_end)
jal x1, merge

# left_start += 2*curr_size
slli x19, x13, 1
add x14, x14, x19
jal x0, merge_loop

inc_size:
slli x13, x13, 1
jal x0, outer_loop

# ----------------------------------------------------------
# merge: merges A[left..mid] and A[mid+1..right] into TMP
# uses: x20=i, x21=j, x22=k, x6=mid+1, x7=right+1
# ----------------------------------------------------------
merge:
add x20, x14, x0         # i = left
addi x21, x16, 1         # j = mid+1
addi x22, x0, 0          # k = 0
addi x6,  x16, 1         # mid+1
addi x7,  x17, 1         # right+1

merge_loop_main:
# if i > mid -> copy_right
blt x20, x6, check_j1
jal x0, copy_right
check_j1:
# if j > right -> copy_left
blt x21, x7, compare_ok
jal x0, copy_left
compare_ok:
# load A[i]
slli x23, x20, 2
add x23, x11, x23
lw x24, 0(x23)
# load A[j]
slli x25, x21, 2
add x25, x11, x25
lw x26, 0(x25)
# if A[j] < A[i] take_right
blt x26, x24, take_right
# write A[i] -> TMP[k]
slli x27, x22, 2
add x27, x12, x27
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal x0, merge_loop_main

take_right:
slli x27, x22, 2
add x27, x12, x27
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal x0, merge_loop_main

# copy remaining left while i <= mid  (i < mid+1)
copy_left:
blt x20, x6, copy_left_do
jal x0, copy_back
copy_left_do:
slli x23, x20, 2
add x23, x11, x23
lw x24, 0(x23)
slli x27, x22, 2
add x27, x12, x27
sw x24, 0(x27)
addi x20, x20, 1
addi x22, x22, 1
jal x0, copy_left

# copy remaining right while j <= right (j < right+1)
copy_right:
blt x21, x7, copy_right_do
jal x0, copy_back
copy_right_do:
slli x25, x21, 2
add x25, x11, x25
lw x26, 0(x25)
slli x27, x22, 2
add x27, x12, x27
sw x26, 0(x27)
addi x21, x21, 1
addi x22, x22, 1
jal x0, copy_right

# copy TMP[0..k-1] back to A[left..left+k-1]
copy_back:
addi x28, x0, 0
copy_back_loop:
slt x29, x28, x22
beq x29, x0, merge_return
slli x30, x28, 2
add x30, x12, x30
lw x31, 0(x30)
add x30, x14, x28
slli x30, x30, 2
add x30, x11, x30
sw x31, 0(x30)
addi x28, x28, 1
jal x0, copy_back_loop

merge_return:
jalr x0, x1, 0          # return

exit:
wfi

