# FPGA Stopwatch
Simple multi-mode stopwatch for the Basys3 FPGA Eval Board written for UT Austin's ECE 316 (Digital Logic Design) by April Douglas and Jenna Jacob

## File Description
- clk_div_disp.v (clock divider for the display to reduce power consumption)
- clkdiv.v (clock divider for the timer, tuned to 1 millisecond)
- counter.v (transfer function based on the current mode for the next timestep)
- FSM.v (finite state machine for changing modes and active timing state)
- hex2base10.v (breaks up a 16 bit binary number into 4 base 10 digits)
- hexto7segment.v (converts a 4 digit binary number to the corresponding segments on a seven-segment display)
- stopwatch.v (top level module for the entire stopwatch)
- time_multiplexing_main.v (top level module for the seven-sgement display)
- time_mux_state_machine.v (finite state machine for the multiplexing required for display output)
