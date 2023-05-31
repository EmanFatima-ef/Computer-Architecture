 # Reset handler and interrupt vector table entries
.global reset_handler
reset_handler:
# Load the initial stack pointer value.
  la   sp, _sp


# Call user 'main(0,0)' (.data/.bss sections initialized there)
  li   a0, 0
  li   a1, 0
  call main
