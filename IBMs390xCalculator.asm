.text
.globl asm_main
.globl print_int
.globl print_char
.globl print_nl
.globl print_string
.globl read_int
.globl read_uint
.globl read_char

    print_int:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        lr      %r3,  %r2
        larl    %r2,  print_int_format
        brasl   %r14, printf
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


    print_uint:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        lr      %r3,  %r2
        larl    %r2,  print_uint_format
        brasl   %r14, printf
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


     print_char:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        brasl   %r14, putchar
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


     print_nl:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
	la      %r2,  10
        brasl   %r14, putchar
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14

	
     print_string:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        brasl   %r14, puts
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


     read_int:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        lay     %r3,  0(%r15)
        larl    %r2,  read_int_format
        brasl   %r14, scanf
	l       %r2,  0(%r15)
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


     read_uint:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        lay     %r3,  0(%r15)
        larl    %r2,  read_uint_format
        brasl   %r14, scanf
	l       %r2,  0(%r15)
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


     read_char:
	stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        brasl   %r14, getchar
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
        br      %r14


addition:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, num1
    larl 5, num2
    larl 6, sum
    la 2, 0 # carry reg
    la 7, 316 # index
    la 8, 80 # loop cpunter
lop:
    l 9, 0(4, 7) # load num1
    l 10, 0(5, 7) # load num2
    ar 9, 10
    ar 9, 2
    xr 2, 2
    chi 9, 10
    jl continue
    la 2, 1
    ahi 9, -10
continue:
    st 9, 0(6, 7) # store in sum
    ahi 7, -4
    ahi 8, -1
    chi 8, 1
    jhe lop
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

multiplication:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    # larl 1, inp11
    # larl 2, inp22
    # larl 3, mul_result
    la 4, 636 # result index
    la 5, 316 # i
luup2:
    xr 13, 13 #carry
    lr 6, 4 #currIndex
    la 7, 316 #j
luup1:
    larl 1, inp11
    l 3, 0(1, 7)
    larl 1, inp22
    l 8, 0(1, 5)
    mr 2, 8   #result is in r3 (mr 2, 8 = r3 * r8)
    ar 3, 13
    larl 1, mul_result
    l 9, 0(1, 6)
    ar 3, 9 #rax is 3
    la 10, 10
    dr 2, 10 # reminder is in r2, quotient is in r3
    larl 1, mul_result
    st 2, 0(1, 6)
    lr 13, 3 #move quotient to carry
    ahi 6, -4
    ahi 7, -4
    chi 7, 0
    jhe luup1
    lr 3, 13
    larl 1, mul_result
    st 3, 0(1, 6)
    ahi 4, -4
    ahi 5, -4
    chi 5, 0
    jhe luup2
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

multiplication_for_pow:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    # larl 1, inp11
    # larl 2, inp22
    # larl 3, mul_result
    la 4, 636 # result index
    la 5, 316 # i
luup205:
    xr 13, 13 #carry
    lr 6, 4 #currIndex
    la 7, 316 #j
luup111:
    larl 1, divisor
    l 3, 0(1, 7)
    larl 1, ten
    l 8, 0(1, 5)
    mr 2, 8   #result is in r3 (mr 2, 8 = r3 * r8)
    ar 3, 13
    larl 1, pow
    l 9, 0(1, 6)
    ar 3, 9 #rax is 3
    la 10, 10
    dr 2, 10 # reminder is in r2, quotient is in r3
    larl 1, pow
    st 2, 0(1, 6)
    lr 13, 3 #move quotient to carry
    ahi 6, -4
    ahi 7, -4
    chi 7, 0
    jhe luup111
    lr 3, 13
    larl 1, pow
    st 3, 0(1, 6)
    ahi 4, -4
    ahi 5, -4
    chi 5, 0
    jhe luup205
    la 8, 320
    xr 7, 7
    larl 4, pow
    larl 5, divisor
llll4:
    l 6, 0(4, 8)
    ahi 8, -320
    st 6, 0(5, 8)
    ahi 8, 320
    st 7, 0(4, 8)
    ahi 8, 4
    chi 8, 636
    jle llll4

    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

isSmaller:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    xr 8, 8 # index
    larl 4, inp11
    larl 5, inp22
lp:
    l 6, 0(4, 8)
    l 7, 0(5, 8)
    chi 6, 0
    jne compare
    chi 7, 0
    jne compare
    ahi 8, 4
    j lp
compare:
    l 6, 0(4, 8)
    l 7, 0(5, 8)
    cr 6, 7
    jl true
    jh false
    ahi 8, 4
    chi 8, 316
    jle compare
    j false

subtraction:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    brasl 14, isSmaller
    larl 8, sub_sign
    st 2, 0(8)
    chi 2, 1
    je swap_inputs
sub_numbers:
    la 8, 316 # index
    xr 7, 7 # borrow
    larl 4, inp11
    larl 5, inp22
    larl 6, sub_result
lp1:
    l 9, 0(4, 8) # rax
    l 10, 0(5, 8) #rbx
    sr 9, 7 # rax - borrow
    xr 7, 7
    sr 9, 10
    chi 9, 0
    jl set_borrow
LL12:
    st 9, 0(6, 8)
    ahi 8, -4
    chi 8, 0
    jhe lp1
    j end_sub
set_borrow:
    la 7, 1
    ahi 9, 10
    j LL12


swap_inputs:
    larl 4, inp11
    larl 5, inp22
    larl 6, help
    xr 8, 8 #index
lup:
    l 7, 0(4, 8) # rax
    st 7, 0(6, 8) # store in help
    ahi 8, 4
    chi 8, 316
    jle lup

    xr 8, 8
lup1:
    l 7, 0(5, 8)
    st 7, 0(4, 8)
    ahi 8, 4
    chi 8, 316
    jle lup1

    xr 8, 8
lup2:
    l 7, 0(6, 8) # rax
    st 7, 0(5, 8) # store in help
    ahi 8, 4
    chi 8, 316
    jle lup2
    j sub_numbers

end_sub:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

division:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    brasl 14, mov_inputs
    # brasl 14, isSmaller
    # chi 2, 1
    # je endd
    brasl 14, calculate_diff
    larl 1, diff
    st 2, 0(1)
    larl 1, index
    xr 2, 2
    st 2, 0(1)
caLop:
    brasl 14, calculate_pow
    brasl 14, division_by_sub
    larl 1, diff
    l 7, 0(1)
    ahi 7, -1
    st 7, 0(1)
    chi 7, 0
    jhe caLop
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

calculate_pow:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    xr 8, 8
    larl 4, save_divisor
    larl 5, divisor
dlop:
    l 6, 0(4, 8)
    st 6, 0(5, 8)
    ahi 8, 4
    chi 8, 316
    jle dlop

    larl 1, diff
    l 10, 0(1)
    chi 10, 0
    je endd
plop:
    larl 1, reg10
    st 10, 0(1)
    brasl 14, multiplication_for_pow
    larl 1, reg10
    l 10, 0(1)
    ahi 10, -1
    chi 10, 0
    jh plop
endd:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

division_by_sub:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    xr 6, 6 #quotient
    larl 1, reg6
    st 6, 0(1)
    brasl 14, move_inverse
    larl 1, reg6
    l 6, 0(1)
sub_loop:
    larl 1, reg6
    st 6, 0(1)
    brasl 14, isSmaller
    larl 1, reg6
    l 6, 0(1)
    chi 2, 1
    je end_div
    larl 1, reg6
    st 6, 0(1)
    brasl 14, subtraction
    larl 1, reg6
    l 6, 0(1)
    ahi 6, 1
    xr 8, 8
m:
    larl 1, sub_result
    l 7, 0(1, 8)
    larl 1, inp11
    st 7, 0(1, 8)
    ahi 8, 4
    chi 8, 316
    jle m
    j sub_loop
end_div:
    xr 8, 8
    larl 4, inp11
    larl 5, quotient
qlop:
    l 7, 0(4, 8)
    st 7, 0(5, 8)
    ahi 8, 4
    chi 8, 316
    jle qlop

    chi 6, 0
    je check_index
edame:
    larl 4, index
    larl 5, help
    l 7, 0(4)
    st 6, 0(5, 7)
    ahi 7, 4
    st 7, 0(4)
    j final
check_index:
    larl 1, index
    l 7, 0(1)
    chi 7, 0
    jnz edame
final:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14




mov_inputs:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    xr 8, 8
    larl 4, inp11
    larl 5, inp22
    larl 6, quotient
    larl 7, divisor
    larl 9, save_divisor
looop5:
    l 10, 0(4, 8)
    l 2, 0(5, 8)
    st 10, 0(6, 8)
    st 2, 0(7, 8)
    st 2, 0(9, 8)
    chi 8, 316
    je end_c
    ahi 8, 4
    j looop5

end_c:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

move_inverse:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    xr 8, 8
    larl 4, quotient
    larl 5, divisor
    larl 6, inp11
    larl 7, inp22
looop56:
    l 10, 0(4, 8)
    l 2, 0(5, 8)
    st 10, 0(6, 8)
    st 2, 0(7, 8)
    chi 8, 316
    je end_c1
    ahi 8, 4
    j looop56

end_c1:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

calculate_diff:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    brasl 14, isSmaller
    chi 2, 1
    je start_inp22
    j start_inp11
start_inp22:
    xr 8, 8
    larl 5, inp22
ll5:
    l 6, 0(5, 8)
    ahi 8, 4
    chi 6, 0
    je ll5
    ahi 8, -4
    xr 7, 7 #difference
    larl 4, inp11
lop22:
    l 9, 0(4, 8)
    chi 9, 0
    jne end_calculate
    ahi 7, 1
    ahi 8, 4
    chi 8, 316
    jle lop22
start_inp11:
    xr 8, 8
    larl 4, inp11
ll51:
    l 6, 0(4, 8)
    ahi 8, 4
    chi 6, 0
    jz ll51
    ahi 8, -4
    xr 7, 7
    larl 5, inp22
lop221:
    l 9, 0(5, 8)
    chi 9, 0
    jne end_calculate
    ahi 7, 1
    ahi 8, 4
    chi 8, 316
    jle lop221
end_calculate:
    lr 2, 7
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14



get_inputs:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    brasl 14, clear_signs 
    la 8, 0 # r12 (index for help)
    larl 9, help
    larl 10, inp11
start1:
    brasl 14, read_char
    chi 2, 10
    je get_second
    chi 2, 45
    je set_first_neg
    ahi 2, -48
    st 2, 0(9, 8)
    ahi 8, 4
    j start1
get_second:
    ahi 8, -4
    la 6, 316 # index for inp11
l1:
    l 4, 0(9, 8) # load help+r8 in r4
    st 4, 0(10, 6) # store in inp11
    ahi 8, -4
    ahi 6, -4
    chi 8, 0
    jhe l1

    la 8, 0 # index again!
    larl 10, inp22
start2:
    brasl 14, read_char
    chi 2, 10
    je store_inp22
    chi 2, 45
    je set_second_neg
    ahi 2, -48
    st 2, 0(9, 8)
    ahi 8, 4
    j start2
store_inp22:
    ahi 8, -4
    la 6, 316
l2:
    l 4, 0(9, 8) # load help+r8 in r4
    st 4, 0(10, 6) # store in inp11
    ahi 8, -4
    ahi 6, -4
    chi 8, 0
    jhe l2
    brasl 14, set_mul_sign
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

set_first_neg:
    larl 6, sign1
    la 7, 1
    st 7, 0(6)
    j start1

set_second_neg:
    larl 13, sign2
    la 7, 1
    st 7, 0(13)
    j start2

set_mul_sign:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    larl 4, sign1
    larl 5, sign2
    larl 8, rem_sign
    larl 9, div_sign
    l 6, 0(4) # sign1
    l 7, 0(5) # sign2
    st 6, 0(8) # store in rem sign
    lr 10, 6
    xr 10, 7
    st 10, 0(9) # store in div sign
    chi 6, 1
    je cmp_7
    chi 7, 1
    je t
end_set:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14
cmp_7:
    chi 7, 1
    je end_set
t:
    larl 8, mul_sign
    la 10, 1
    st 10, 0(8)
    j end_set

clear_signs:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, sign1
    larl 5, sign2
    larl 6, sub_sign
    larl 7, sum_sign
    larl 8, mul_sign
    larl 9, div_sign
    larl 10, rem_sign
    la 13, 0
    st 13, 0(4)
    st 13, 0(5)
    st 13, 0(6)
    st 13, 0(7)
    st 13, 0(8)
    st 13, 0(9)
    st 13, 0(10)
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

is_sum_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 316
    larl 9, sum
slop:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe slop
    j true

is_help_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 316
    larl 9, help
slop878:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe slop878
    j true

true:
    la 2, 1
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14
false:
    la 2, 0
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

is_sub_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 316
    larl 9, sub_result
sslop:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe sslop
    j true

is_div_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 316
    larl 9, div_result
sslop554:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe sslop554
    j true

is_rem_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 316
    larl 9, quotient
sslop556:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe sslop556
    j true

is_mul_zero:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)

    la 10, 636
    larl 9, mul_result
sslop78:
    l 6, 0(9, 10) 
    chi 6, 0
    jnz false
    ahi 10, -4
    chi 10, 0
    jhe sslop78
    j true


print_sum_result:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    la 8, 316
    brasl 14, is_sum_zero
    larl 9, sum_sign
    chi 2, 1
    je print_loop1
    l 6, 0(9)
    chi 6, 0
    je con_sum
    la 2, 45
    brasl 14, print_char
con_sum:
    xr 8, 8
    larl 9, sum
ll1:
    l 2, 0(9, 8)
    ahi 8, 4
    chi 2, 0
    je ll1

    ahi 8, -4
print_loop1:
    l 2, 0(9, 8)
    ahi 2, 48
    brasl 14, print_char
    ahi 8, 4
    chi 8, 316
    jle print_loop1

    brasl 14, print_nl
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

print_sub_result:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    la 8, 316
    brasl 14, is_sub_zero
    larl 9, sub_sign
    chi 2, 1
    je print_loop2
    l 6, 0(9)
    chi 6, 0
    je continue_sub
    la 2, 45
    brasl 14, print_char
continue_sub:
    xr 8, 8
    larl 9, sub_result
ll2:
    l 2, 0(9, 8)
    ahi 8, 4
    chi 2, 0
    je ll2

    ahi 8, -4
print_loop2:
    l 2, 0(9, 8)
    ahi 2, 48
    brasl 14, print_char
    ahi 8, 4
    chi 8, 316
    jle print_loop2

    brasl 14, print_nl
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

print_mul_result:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    la 8, 636
    brasl 14, is_mul_zero
    larl 9, mul_sign
    chi 2, 1
    je print_loop24
    l 6, 0(9)
    chi 6, 0
    je continue_mul
    la 2, 45
    brasl 14, print_char
continue_mul:
    xr 8, 8
    larl 9, mul_result
ll28:
    l 2, 0(9, 8)
    ahi 8, 4
    chi 2, 0
    je ll28

    ahi 8, -4
print_loop24:
    l 2, 0(9, 8)
    ahi 2, 48
    brasl 14, print_char
    ahi 8, 4
    chi 8, 636
    jle print_loop24

    brasl 14, print_nl
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

print_div_result:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    la 8, 316
    brasl 14, is_div_zero
    larl 9, div_sign
    chi 2, 1
    je print_loopi241
    l 6, 0(9)
    chi 6, 0
    je continue_div
    la 2, 45
    brasl 14, print_char
continue_div:
    xr 8, 8
    larl 9, div_result
ll28044:
    l 2, 0(9, 8)
    ahi 8, 4
    chi 2, 0
    je ll28044

    ahi 8, -4
print_loopi241:
    l 2, 0(9, 8)
    ahi 2, 48
    brasl 14, print_char
    ahi 8, 4
    chi 8, 316
    jle print_loopi241

    brasl 14, print_nl
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

print_rem_result:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    la 8, 316
    brasl 14, is_rem_zero
    larl 9, rem_sign
    chi 2, 1
    je print_loop2418
    l 6, 0(9)
    chi 6, 0
    je continue_rem
    la 2, 45
    brasl 14, print_char
continue_rem:
    xr 8, 8
    larl 9, quotient
ll2801:
    l 2, 0(9, 8)
    ahi 8, 4
    chi 2, 0
    je ll2801

    ahi 8, -4
print_loop2418:
    l 2, 0(9, 8)
    ahi 2, 48
    brasl 14, print_char
    ahi 8, 4
    chi 8, 316
    jle print_loop2418

    brasl 14, print_nl
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

mov_help_to_div:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    brasl 14, is_help_zero
    chi 2, 1
    je end_h
    larl 10, index
    l 8, 0(10)
    ahi 8, -4
    chi 8, 0
    jl end_h
    la 9, 316
    larl 4, help
    larl 5, div_result
movlop:
    l 7, 0(4, 8)
    st 7, 0(5, 9)
    ahi 9, -4
    ahi 8, -4
    chi 8, 0
    jhe movlop
end_h:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

clear_inputs:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, inp11
    larl 5, inp22
    xr 6, 6
    xr 7, 7
clop:
    st 6, 0(4, 7)
    st 6, 0(5, 7)
    ahi 7, 4
    chi 7, 316
    jle clop
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

clear_sum:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, sum
    xr 6, 6
    xr 7, 7
clop11:
    st 6, 0(4, 7)
    ahi 7, 4
    chi 7, 316
    jle clop11
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

clear_mul:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, mul_result
    xr 6, 6
    xr 7, 7
clop1171:
    st 6, 0(4, 7)
    ahi 7, 4
    chi 7, 636
    jle clop1171
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

clear_sub:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, sub_result
    xr 6, 6
    xr 7, 7
clop117:
    st 6, 0(4, 7)
    ahi 7, 4
    chi 7, 316
    jle clop117
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

clear_div:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, div_result
    xr 6, 6
    xr 7, 7
    larl 1, index
    st 6, 0(1)
    larl 5, help
    larl 8, quotient
clop1179:
    st 6, 0(4, 7)
    st 6, 0(5, 7)
    st 6, 0(8, 7)
    ahi 7, 4
    chi 7, 316
    jle clop1179
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14

swap_inputs1:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
    larl 4, inp11
    larl 5, inp22
    larl 6, help
    xr 8, 8 #index
lupi:
    l 7, 0(4, 8) # rax
    st 7, 0(6, 8) # store in help
    ahi 8, 4
    chi 8, 316
    jle lupi

    xr 8, 8
lupi1:
    l 7, 0(5, 8)
    st 7, 0(4, 8)
    ahi 8, 4
    chi 8, 316
    jle lupi1

    xr 8, 8
lupi2:
    l 7, 0(6, 8) # rax
    st 7, 0(5, 8) # store in help
    ahi 8, 4
    chi 8, 316
    jle lupi2
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14


    asm_main:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
	
    # ---------------------------	
    larl 7, ten
    la 8, 312
    la 6, 1
    st 6, 0(7, 8) #store 10 in ten
input_loop:
    brasl 14, read_char
    chi 2, 113
    je end
    chi 2, 43
    je add_nums
    chi 2, 45
    je sub_nums
    chi 2, 42
    je mul_nums
    chi 2, 47
    je div_nums
    j rem_nums


add_nums:
    brasl 14, read_char
    brasl 14, get_inputs
start_sum:
    larl 8, sign1
    l 7, 0(8) # load sign1 in r7
    chi 7, 1
    je decision_inp22
    j inp11_positive
d_done:
    larl 8, sign2
    l 6, 0(8)
    chi 6, 1
    je set_sum_sign
set_done:
    la 8, 0 # index for input
    larl 9, inp11
    larl 10, inp22
    larl 5, num1
    larl 4, num2
looop:
    l 6, 0(9, 8) # mov r6, [inp11 + r8]
    l 7, 0(10, 8)
    st 6, 0(5, 8)
    st 7, 0(4, 8)
    chi 8, 316
    je continue1
    ahi 8, 4
    j looop
    
continue1:
    brasl 14, addition
    brasl 14, print_sum_result
    brasl 14, clear_inputs
    brasl 14, clear_sum
    j input_loop

sub_nums:
    brasl 14, read_char
    brasl 14, get_inputs
    larl 5, sign1
    l 6, 0(5)
    chi 6, 1
    je dec_sub_inp22
    j inpp11_sub_positive
start_sub:
    brasl 14, subtraction
    brasl 14, print_sub_result
    brasl 14, clear_inputs
    brasl 14, clear_sub
    j input_loop

mul_nums:
    brasl 14, read_char
    brasl 14, get_inputs
    brasl 14, multiplication
    brasl 14, print_mul_result
    brasl 14, clear_inputs
    brasl 14, clear_mul
    j input_loop

div_nums:
    brasl 14, read_char
    brasl 14, get_inputs
    brasl 14, division
    brasl 14, mov_help_to_div
    brasl 14, print_div_result
    brasl 14, clear_inputs
    brasl 14, clear_div
    j input_loop

rem_nums:
    brasl 14, read_char
    brasl 14, get_inputs
    brasl 14, division
    brasl 14, print_rem_result
    brasl 14, clear_inputs
    brasl 14, clear_div
    j input_loop

decision_inp22:
    larl 4, sign2
    l 6, 0(4)
    chi 6, 0
    je sub_instead_sum
    j d_done
sub_instead_sum:
    brasl 14, swap_inputs1
    brasl 14, subtraction
    brasl 14, print_sub_result
    brasl 14, clear_inputs
    brasl 14, clear_sub
    j input_loop

inp11_positive:
    larl 8, sign2
    l 7, 0(8)
    chi 7, 1
    je start_sub
    j set_done

set_sum_sign:
    la 7, 1
    larl 8, sum_sign
    st 7, 0(8)
    j set_done

dec_sub_inp22:
    larl 4, sign2
    l 6, 0(4)
    chi 6, 1
    je sub_reverse
    la 6, 1
    st 6, 0(4)
    j start_sum

sub_reverse:
    brasl 14, swap_inputs1
    j start_sub

inpp11_sub_positive:
    larl 4, sign2
    l 6, 0(4)
    chi 6, 0
    je start_sub
    xr 6, 6
    st 6, 0(4)
    j start_sum

    # ---------------------------	
end:
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14


.data
print_int_format:  .asciz "%d"
    print_uint_format: .asciz "%u"
    read_int_format:   .asciz "%d"
    read_uint_format:  .asciz "%u"
num1:   .zero 320
num2:   .zero 320
inp1:   .zero 320
inp2:   .zero 320
inp11:   .zero 320
inp22:   .zero 320
sum:   .zero 320
mul_result:   .zero 640
sub_result:   .zero 320
div_result:   .zero 320
quotient:   .zero 320
reminder:   .zero 320
divisor:   .zero 320
save_divisor:   .zero 320
pow:   .zero 640
diff:   .zero 4
ten:   .zero 320 # havaset vashe
help:   .zero 320
sub_sign:   .zero 4
sum_sign:   .zero 4
mul_sign:   .zero 4
div_sign:   .zero 4
rem_sign:   .zero 4
product:   .zero 4
index:   .zero 4
sign1:   .zero 4
sign2:   .zero 4
reg10:  .zero 4
reg6:   .zero 4