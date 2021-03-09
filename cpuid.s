.data
  s0: .asciz "CPUID: 0x%.6x\n"
  s1: .asciz "Largest basic function number implemented: 0x%.2x\n"
  s2: .asciz "Vendor ID: %s\n"
  s3: .asciz "Highest supported argument: 0x%.6x\n"

.text
.globl _main

_main:
  pushq %rbp
  movq  %rsp, %rbp
  subq  $16, %rsp

  movl  $1, %eax
  cpuid

  leaq  s0(%rip), %rdi
  movl  %eax, %esi
  xorl  %eax, %eax
  call  _printf

  xorl  %eax, %eax
  cpuid

  movl  %ebx, 0(%rsp)
  movl  %edx, 4(%rsp)
  movl  %ecx, 8(%rsp)

  leaq  s1(%rip), %rdi
  movl  %eax, %esi
  xorl  %eax, %eax
  call  _printf

  leaq  s2(%rip), %rdi
  movq  %rsp, %rsi
  xorl  %eax, %eax
  call  _printf

  movl  $0x80000000, %eax
  cpuid

  leaq  s3(%rip), %rdi
  movl  %eax, %esi
  xorl  %eax, %eax
  call  _printf

  movq  %rbp, %rsp
  popq  %rbp

  ret
