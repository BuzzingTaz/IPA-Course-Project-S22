# Execution begins at address 0 
    .pos 0
    irmovq stack, %rsp      # Set up stack pointer
    call main       # Execute main program
    halt            # Terminate program 
    

main:   irmovq $0x10,%rdx
    irmovq $0xc,%rbx
    call gcd        # gcd(a,b)
    ret

# gcd(quad a, quad b)
# a in %rdx, b in %rbx
gcd:
  irmovq $0x0, %rax
  jmp check
check:
  addq %rax, %rbx 
  je rbxres  
  addq %rax, %rdx
  je rdxres 
  jmp loop2 
loop2:
  rrmovq %rdx, %rsi 
  rrmovq %rbx, %rdi
  
  subq %rbx, %rsi
  jge ab1  
  subq %rdx, %rdi 
  jge ab2
ab1:
  rrmovq %rbx, %rdx
  rrmovq %rsi, %rbx
  jmp check
ab2:
  rrmovq %rbx, %rdx
  rrmovq %rdi, %rbx
  jmp check
rbxres:
  rrmovq %rdx, %rcx
  ret
rdxres:
  rrmovq %rbx, %rcx
  ret                  # Return

# Stack starts here and grows to lower addresses
    .pos 1023
stack:

    