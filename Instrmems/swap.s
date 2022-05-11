# Execution begins at address 0 
    .pos 0
    irmovq stack, %rsp      # Set up stack pointer
    call main       # Execute main program
    halt            # Terminate program 
    

main:   irmovq $0x10,%rdi
    irmovq $0xc,%rsi
    call swap        # swap(a,b)
    ret

# gcd(quad a, quad b)
# a in %rdx, b in %rbx
swap:
  pushq %rdi
  pushq %rsi
  
  popq %rdi
  popq %rsi
  ret                  # Return

# Stack starts here and grows to lower addresses
    .pos 1023
stack:

    