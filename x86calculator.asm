; %include "asm_io.inc"

%macro begin_alignment 0
    push rbp
    mov rbp, rsp
    mov rax, rsp
    and rax, 15
    and rsp, rax
%endmacro

%macro end_alignment 0
    mov rsp, rbp
    pop rbp
%endmacro

segment .text

global asm_main
global print_int
global print_char
global print_string
global print_nl
global read_int
global read_char
extern printf
extern putchar
extern puts
extern scanf
extern getchar

print_int:
    sub rsp, 8

    mov rsi, rdi

    mov rdi, print_int_format
    mov rax, 1 ; setting rax (al) to number of vector inputs
    call printf
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_char:
    sub rsp, 8

    call putchar
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_string:
    sub rsp, 8

    call puts
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_nl:
    sub rsp, 8

    mov rdi, 10
    call putchar
    
    add rsp, 8 ; clearing local variables from stack

    ret


read_int:
    sub rsp, 8

    mov rsi, rsp
    mov rdi, read_int_format
    mov rax, 1 ; setting rax (al) to number of vector inputs
    call scanf

    mov rax, [rsp]

    add rsp, 8 ; clearing local variables from stack

    ret


read_char:
    sub rsp, 8

    call getchar

    add rsp, 8 ; clearing local variables from stack

    ret

addition:
    mov r12, 0 ;carry
    mov r13, 79 ;index
    mov r14, 80 ;loop counter
lop:
    movzx rax, byte [num1 + r13]
    movzx rbx, byte [num2 + r13]
    adc rax, rbx
    adc rax, r12 ;add with carry
    mov r12, 0
    cmp rax, 10
    jl continue
    mov r12, 1
    sub rax, 10
continue:
    mov [sum + r13], al
    dec r13
    dec r14
    cmp r14, 1
    jge lop
    ret
    

multiplication:
    mov r12, 159 ;result index
    mov r13, 79 ;i
luup2:
    xor r14, r14 ;carry
    mov r15, r12 ;currentIndex
    mov rbx, 79 ;j
luup1:
    movzx rax, byte [inp11 + rbx]
    movzx rbp, byte [inp22 + r13]
    mul rbp
    add rax, r14
    movzx r8, byte [mul_result + r15]
    add rax, r8 ;product
    mov rdi, 10
    cqo
    div rdi ;rem is in rdx , q is in rax
    mov byte [mul_result + r15], dl
    mov r14, rax
    dec r15
    dec rbx
    cmp rbx, 0
    jge luup1
    mov rax, r14
    mov byte[mul_result + r15], al
    dec r12
    dec r13
    cmp r13, 0
    jge luup2
    ret

multiplication_for_pow:
    mov r12, 159 ;result index
    mov r13, 79 ;i
luup21:
    xor r14, r14 ;carry
    mov r15, r12 ;currentIndex
    mov rbx, 79 ;j
luup12:
    movzx rax, byte [divisor + rbx]
    movzx rbp, byte [ten + r13]
    mul rbp
    add rax, r14
    movzx r8, byte [pow + r15]
    add rax, r8 ;product
    mov rdi, 10
    cqo
    div rdi ;rem is in rdx , q is in rax
    mov byte [pow + r15], dl
    mov r14, rax
    dec r15
    dec rbx
    cmp rbx, 0
    jge luup12
    mov rax, r14
    mov byte[pow + r15], al
    dec r12
    dec r13
    cmp r13, 0
    jge luup21
    mov r12, 80
    mov rbx, 0
llllllll:
    mov rax, [pow + r12]
    mov [divisor + r12 - 80], rax
    mov [pow + r12], rbx
    add r12, 8
    cmp r12, 152
    jle llllllll

    ret


isSmaller:
    xor r12, r12
lp:
    movzx rax, byte [inp11 + r12]
    movzx rbx, byte [inp22 + r12]
    cmp rax, 0
    jne compare
    cmp rbx, 0
    jne compare
    inc r12
    jmp lp
compare:
    movzx rax, byte [inp11 + r12]
    movzx rbx, byte [inp22 + r12]
    cmp rax, rbx
    jl true
    jg false
    inc r12
    cmp r12, 79
    jle compare
false:
    mov rax, 0
    ret
true:
    mov rax, 1
    ret


subtraction:
    call isSmaller
    mov byte [sub_sign], al
    cmp rax, 1
    je swap_inputs
sub_numbers:
    mov r12, 79 ;index
    xor r13, r13 ;borrow flag
lp1:
    movzx rax, byte [inp11 + r12]
    movzx rbx, byte [inp22 + r12]
    sub rax, r13
    xor r13, r13
    sub rax, rbx
    cmp rax, 0
    jl set_borrow
LL12:
    mov byte [sub_result + r12], al
    dec r12
    cmp r12, 0
    jge lp1
    jmp end_sub
set_borrow:
    mov r13, 1
    add rax, 10
    jmp LL12
swap_inputs:
    xor r14, r14 ;index
lup: ;help = inp11
    mov rax, [inp11 + r14]
    mov [help + r14], rax
    add r14, 8
    cmp r14, 72
    jle lup
    
    xor r14, r14
lup1: ;inp11 = inp22
    mov rax, [inp22 + r14]
    mov [inp11 + r14], rax
    add r14, 8
    cmp r14, 72
    jle lup1

    xor r14, r14
lup2: ;inp22 = help
    mov rax, [help + r14]
    mov [inp22 + r14], rax
    add r14, 8
    cmp r14, 72
    jle lup2
    jmp sub_numbers

end_sub:
    ret


division:
    call mov_inputes ; qoutient = inp11, divisor = inp22 , save_divisor = inp22
    call calculate_diff
    mov byte [diff], al ;digit difference
    movzx rax, byte [index]
    xor rax, rax
    mov byte [index], al ;index for store answer
caLop:
    call calculate_pow
    call division_by_sub
    movzx rax, byte [diff]
    dec rax
    mov byte [diff], al
    cmp rax, 0
    jge caLop
    ret

calculate_pow:
    xor r12, r12
dlop:
    mov rax, [save_divisor + r12]
    mov [divisor + r12], rax
    add r12, 8
    cmp r12, 72
    jle dlop

    movzx r10, byte [diff] 
    cmp r10, 0
    je endd
plop:
    push r10
    call multiplication_for_pow
    pop r10
    dec r10
    cmp r10, 0
    jg plop
endd:
    ret

division_by_sub:
; R := N
; Q := 0
; while R ≥ D do
;   R := R − D
;   Q := Q + 1
; end
; return (Q,R)
    xor r14, r14 ; for div quotient
    call move_inverse
sub_loop:
    push r14
    call isSmaller
    pop r14
    cmp rax, 1
    je end_div
    push r14
    call subtraction
    pop r14
    inc r14
    xor r12, r12
m:
    mov rax, [sub_result + r12]
    mov [inp11 + r12], rax
    add r12, 8
    cmp r12, 72
    jle m
    jmp sub_loop

end_div:
    xor r12, r12
qlop: ;store reminder
    mov rax, [inp11 + r12]
    mov [quotient + r12], rax
    add r12, 8
    cmp r12, 72
    jle qlop
    
    cmp r14, 0
    je check_index
edame:
    movzx rax, byte [index]
    mov byte [help + rax], r14b 
    inc rax
    mov byte [index], al
    jmp final

check_index:
    movzx rax, byte [index]
    cmp rax, 0
    jnz edame
final:
    ret

mov_inputes:
    xor r12, r12
looop5:
    mov rax, [inp11 + r12]
    mov rbx, [inp22 + r12]
    mov [quotient + r12], rax
    mov [divisor + r12], rbx
    mov [save_divisor + r12], rbx
    cmp r12, 72
    je end_c
    add r12, 8
    jmp looop5

end_c:
    ret

move_inverse:
    xor r12, r12
looop56:
    mov rax, [quotient + r12]
    mov rbx, [divisor + r12]
    mov [inp11 + r12], rax
    mov [inp22 + r12], rbx
    cmp r12, 72
    je end_c1
    add r12, 8
    jmp looop56

end_c1:
    ret


calculate_diff:
    call isSmaller
    cmp rax, 1
    je start_inp22
    jmp start_inp11
start_inp22:
    mov r12, 0
ll5:
    movzx rdi, byte [inp22 + r12]
    inc r12
    cmp rdi, 0
    jz ll5
    dec r12
    xor r13, r13
lop22:
    movzx rax, byte [inp11 + r12]
    cmp rax, 0
    jne end_calculate
    inc r13
    inc r12
    cmp r12, 79
    jle lop22
start_inp11:
    mov r12, 0
ll51:
    movzx rdi, byte [inp11 + r12]
    inc r12
    cmp rdi, 0
    jz ll51
    dec r12
    xor r13, r13
lop221:
    movzx rax, byte [inp22 + r12]
    cmp rax, 0
    jne end_calculate
    inc r13
    inc r12
    cmp r12, 79
    jle lop221


end_calculate:
    mov rax, r13
    ret


clear_inputs:
    xor rax, rax
    xor r12, r12
clop:
    mov [inp11 + r12], rax
    mov [inp22 + r12], rax
    add r12, 8
    cmp r12, 72
    jle clop
    ret

clear_sub:
    xor rax, rax
    xor r12, r12
clop1:
    mov [sub_result + r12], rax
    add r12, 8
    cmp r12, 72
    jle clop1
    ret

clear_sum:
    xor rax, rax
    xor r12, r12
clop11:
    mov [sum + r12], rax
    add r12, 8
    cmp r12, 72
    jle clop11
    ret

clear_mul:
    xor rax, rax
    xor r12, r12
clop111:
    mov [mul_result + r12], rax
    add r12, 8
    cmp r12, 152
    jle clop111
    ret

clear_div:
    xor rax, rax
    xor r12, r12
    mov byte [index], al
clop1112:
    mov [div_result + r12], rax
    mov [help + r12], rax
    mov [quotient + r12], rax
    add r12, 8
    cmp r12, 72
    jle clop1112
    ret

is_mul_zero:
    mov r13, 152
mlop:
    mov rax, [mul_result + r13]
    cmp rax, 0
    jnz false
    sub r13, 8
    cmp r13, 0
    jge mlop
    jmp true

is_sum_zero:
    mov r13, 72
slop:
    mov rax, [sum + r13]
    cmp rax, 0
    jnz false
    sub r13, 8
    cmp r13, 0
    jge slop
    jmp true

is_sub_zero:
    mov r13, 72
sslop:
    mov rax, [sub_result + r13]
    cmp rax, 0
    jnz false
    sub r13, 8
    cmp r13, 0
    jge sslop
    jmp true

is_div_zero:
    mov r13, 72
sslop1:
    mov rax, [div_result + r13]
    cmp rax, 0
    jnz false
    sub r13, 8
    cmp r13, 0
    jge sslop1
    jmp true

is_rem_zero:
    mov r13, 72
sslop10:
    mov rax, [quotient + r13]
    cmp rax, 0
    jnz false
    sub r13, 8
    cmp r13, 0
    jge sslop10
    jmp true



print_result:
    mov r12, 159
    call is_mul_zero
    cmp rax, 1
    je print_loop
    movzx rax, byte [mul_sign]
    cmp rax, 0
    je con_mul
    mov rdi, 45
    call print_char
con_mul:
    mov r12, 0
ll:
    movzx rdi, byte [mul_result + r12]
    inc r12
    cmp rdi, 0
    jz ll

    dec r12
print_loop:
    mov rdi, [mul_result + r12]
    add rdi, 48
    call print_char
    inc r12
    cmp r12, 159
    jle print_loop
    
    call print_nl
    ret

print_div_result:
    mov r12, 79
    call is_div_zero
    cmp rax, 1
    je print_loop13
    movzx rax, byte [div_sign]
    cmp rax, 0
    je con_div
    mov rdi, 45
    call print_char
con_div:
    mov r12, 0
ll111:
    movzx rdi, byte [div_result + r12]
    inc r12
    cmp rdi, 0
    jz ll111

    dec r12
print_loop13:
    mov rdi, [div_result + r12]
    add rdi, 48
    call print_char
    inc r12
    cmp r12, 79
    jle print_loop13
    
    call print_nl
    ret

print_rem_result:
    mov r12, 79
    call is_rem_zero
    cmp rax, 1
    je print_loop133
    movzx rax, byte [rem_sign]
    cmp rax, 0
    je con_rem
    mov rdi, 45
    call print_char
con_rem:
    mov r12, 0
ll1111:
    movzx rdi, byte [quotient + r12]
    inc r12
    cmp rdi, 0
    jz ll1111

    dec r12
print_loop133:
    mov rdi, [quotient + r12]
    add rdi, 48
    call print_char
    inc r12
    cmp r12, 79
    jle print_loop133
    
    call print_nl
    ret

print_sum_result:
    mov r12, 79
    call is_sum_zero
    cmp rax, 1
    je print_loop1
    movzx rax, byte [sum_sign]
    cmp rax, 0
    je con_sum
    mov rdi, 45
    call print_char
con_sum:
    mov r12, 0
ll1:
    movzx rdi, byte [sum + r12]
    inc r12
    cmp rdi, 0
    jz ll1

    dec r12
print_loop1:
    mov rdi, [sum + r12]
    add rdi, 48
    call print_char
    inc r12
    cmp r12, 79
    jle print_loop1
    
    call print_nl
    ret

print_sub_result:
    mov r12, 79
    call is_sub_zero
    cmp rax, 1
    je print_loop2
    movzx rax, byte [sub_sign]
    cmp rax, 0
    je continue_sub
    mov rdi, 45
    call print_char
continue_sub:
    xor r12, r12
ll2:
    movzx rdi, byte [sub_result + r12]
    inc r12
    cmp rdi, 0
    jz ll2

    dec r12
print_loop2:
    mov rdi, [sub_result + r12]
    add rdi, 48
    call print_char
    inc r12
    cmp r12, 79
    jle print_loop2
    
    call print_nl
    ret


get_inputs:
    call clear_signs
    xor r12, r12 ;index for help
start1:
    call read_char
    cmp rax, 10
    je get_second
    cmp rax, 45
    je set_first_neg
    sub rax, 48
    mov byte [help + r12], al
    inc r12
    jmp start1
get_second:
    dec r12
    mov r13, 79
l1:
    movzx rax, byte [help + r12]
    mov byte [inp11 + r13], al
    dec r12
    dec r13
    cmp r12, 0
    jge l1

    xor r12, r12
start2:
    call read_char
    cmp rax, 10
    je store_inp22
    cmp rax, 45
    je set_second_neg
    sub rax, 48
    mov byte [help + r12], al
    inc r12
    jmp start2
store_inp22:
    dec r12
    mov r13, 79 
l2:
    movzx rax, byte [help + r12]
    mov byte [inp22 + r13], al
    dec r12
    dec r13
    cmp r12, 0
    jge l2
    call set_mul_sign
    ret

set_mul_sign:
    movzx rax, byte [sign1]
    movzx rbx, byte [sign2]
    mov byte [rem_sign], al
    mov r14, rax
    xor r14, rbx
    mov byte [div_sign], r14b
    cmp rax, 1
    je cmp_rbx
    cmp rbx, 1
    je t
    ret

cmp_rbx:
    cmp rbx, 1
    je end_set
t:
    mov r14, 1
    mov byte [mul_sign], r14b
    ret

end_set:
    ret


set_first_neg:
    movzx rax, byte [sign1]
    mov rax, 1
    mov byte [sign1], al
    jmp start1

set_second_neg:
    movzx rax, byte [sign2]
    mov rax, 1
    mov byte [sign2], al
    jmp start2


mov_help_to_div:
    movzx r12, byte [index]
    dec r12
    mov r13, 79
movLop:
    movzx rax, byte [help + r12]
    mov byte [div_result + r13], al
    dec r13
    dec r12
    cmp r12, 0
    jge movLop
    ret

swap_inputs1:
    xor r14, r14 ;index
lupi: ;help = inp11
    mov rax, [inp11 + r14]
    mov [help + r14], rax
    add r14, 8
    cmp r14, 72
    jle lupi
    
    xor r14, r14
lupi1: ;inp11 = inp22
    mov rax, [inp22 + r14]
    mov [inp11 + r14], rax
    add r14, 8
    cmp r14, 72
    jle lupi1

    xor r14, r14
lupi2: ;inp22 = help
    mov rax, [help + r14]
    mov [inp22 + r14], rax
    add r14, 8
    cmp r14, 72
    jle lupi2
    ret

clear_signs:
    mov rax, 0
    mov byte [sign1], al
    mov byte [sign2], al
    mov byte [sub_sign], al
    mov byte [sum_sign], al
    mov byte [mul_sign], al
    mov byte [div_sign], al
    mov byte [rem_sign], al
    ret




asm_main:
	push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp, 8

    ;|write your code here|'
    ; call multiplication
    ; call print_result
    ; call addition
    ; call print_sum_result
input_loop:
    call read_char
    cmp rax, "q"
    je end
    cmp rax, "+"
    je add_nums
    cmp rax, "-"
    je sub_nums
    cmp rax, "*"
    je mul_nums
    cmp rax, "/"
    je div_nums
    jmp rem_nums


    
add_nums:
    call read_char
    call get_inputs
start_sum:
    movzx rax, byte [sign1]
    cmp rax, 1
    je decision_inp22
    jmp inp11_positive
d_done:
    movzx rbx, byte [sign2]
    cmp rbx, 1
    je set_sum_sign
set_done:
    xor r12, r12
looop:
    mov rax, [inp11 + r12]
    mov rbx, [inp22 + r12]
    mov [num1 + r12], rax
    mov [num2 + r12], rbx
    cmp r12, 72
    je continue1
    add r12, 8
    jmp looop
continue1:
    call addition
    call print_sum_result
    call clear_inputs
    call clear_sum
    jmp input_loop
    

sub_nums:
    call read_char
    call get_inputs
    movzx rax, byte [sign1]
    cmp rax, 1
    je dec_sub_inp22
    jmp inpp11_sub_positive
start_sub:
    call subtraction
    call print_sub_result
    call clear_inputs
    call clear_sub
    jmp input_loop

mul_nums:
    call read_char
    call get_inputs
    call multiplication
    call print_result
    call clear_inputs
    call clear_mul
    jmp input_loop

div_nums:
    call read_char
    call get_inputs
    call division
    call mov_help_to_div 
    call print_div_result
    call clear_inputs
    call clear_div
    jmp input_loop

rem_nums:
    call read_char
    call get_inputs
    call division
    call print_rem_result
    call clear_inputs
    call clear_div
    jmp input_loop

decision_inp22:
    movzx rbx, byte [sign2]
    cmp rbx, 0
    je sub_instead_sum
    jmp d_done
sub_instead_sum:
    call swap_inputs1
    call subtraction
    call print_sub_result
    call clear_inputs
    call clear_sub
    jmp input_loop

set_sum_sign:
    mov rax, 1
    mov byte [sum_sign], al
    jmp set_done

inp11_positive:
    movzx rbx, byte [sign2]
    cmp rbx, 1
    je start_sub
    jmp set_done

dec_sub_inp22:
    movzx rax, byte [sign2]
    cmp rax, 1
    je sub_reverse
    mov rax, 1
    mov byte [sign2], al
    jmp start_sum


sub_reverse:
    call swap_inputs1
    jmp start_sub

inpp11_sub_positive:
    movzx rax, byte [sign2]
    cmp rax, 0
    je start_sub
    mov rax, 0
    mov byte [sign2], al
    jmp start_sum
    




end: 
    add rsp, 8

	pop r15
	pop r14
	pop r13
	pop r12
    pop rbx
    pop rbp

	ret

segment .data

print_int_format: db        "%ld", 0

read_int_format: db         "%ld", 0

num1:   times 80 db 0
num2:   times 80 db 0
inp1:   times 80 db 0
inp2:   times 80 db 0
inp11:  times 80 db 0
inp22:  times 80 db 0
sum:    times 80 db 0
mul_result: times 160 db 0
sub_result: times 80 db 0
div_result: times 80 db 0
quotient: times 80 db 0
reminder: times 80 db 0
divisor: times 80 db 0
save_divisor: times 80 db 0
pow: times 160 db 0
diff: db 0
ten: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
help:   times 80 db 0
sub_sign: db 0
sum_sign: db 0
mul_sign: db 0
div_sign: db 0
rem_sign: db 0
product: db 0
index: db 0
sign1: db 0
sign2: db 0