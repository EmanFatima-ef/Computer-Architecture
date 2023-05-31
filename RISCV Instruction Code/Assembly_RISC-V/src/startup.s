 # Reset handler and interrupt vector table entries
.global reset_handler
reset_handler:
  j gcd
