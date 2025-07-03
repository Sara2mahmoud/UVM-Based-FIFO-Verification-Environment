module FIFO_top ();
     import uvm_pkg::*;
`include "uvm_macros.svh" 
import FIFO_TEST_pkg::*;
  
bit clk;
	initial
begin
    clk=0;
    forever
    begin
         #1 clk=~clk;
     end
end
FIFO_interface FIFO_if(clk);
FIFO dut(FIFO_if);
bind FIFO FIFO_SVA FIFO_SVA_IF(FIFO_if);
initial
begin
    uvm_config_db#(virtual FIFO_interface)::set(null,"uvm_test_top","FIFO_interface",FIFO_if);
    run_test("FIFO_test");
end


endmodule : FIFO_top