import shared_pkg::*;

module FIFO_SVA(FIFO_interface.DUT FIFO_if);
	// ASSERTIONS
  // Count Validity Property: Ensure that count stays within valid limits
  property count_valid;
    @(posedge FIFO_if.clk) disable iff(FIFO_if.rst_n==0) (FIFO_top.dut.count <= FIFO_DEPTH);
  endproperty

  assert_count_valid: assert property(count_valid) else $error("Error: FIFO count exceeds FIFO_DEPTH");
  cover_count_valid: cover property(count_valid);

  // Overflow Condition Property: Overflow only happens when FIFO_if.full and write is enabled
  property overflow_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.full && FIFO_if.wr_en)|=>FIFO_if.overflow==1;
  endproperty

  assert_overflow_cond: assert property(overflow_cond) else $error("Error: Overflow assertion failed");
  cover_overflow_cond: cover property(overflow_cond);

  // Underflow Condition Property: Underflow only happens when FIFO_if.empty and read is enabled
  property underflow_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.empty && FIFO_if.rd_en)|=>(FIFO_if.underflow ==1);
  endproperty

  assert_underflow_cond: assert property(underflow_cond) else $error("Error: Underflow assertion failed");
  cover_underflow_cond: cover property(underflow_cond);

  // Full Flag Property: Full flag is set when count equals FIFO_DEPTH
  property full_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.full == (FIFO_top.dut.count == FIFO_DEPTH));
  endproperty

  assert_full_cond: assert property(full_cond) else $error("Error: Full flag assertion failed");
  cover_full_cond: cover property(full_cond);

  // Empty Flag Property: Empty flag is set when count equals 0
  property empty_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.empty == (FIFO_top.dut.count == 0));
  endproperty

  assert_empty_cond: assert property(empty_cond) else $error("Error: Empty flag assertion failed");
  cover_empty_cond: cover property(empty_cond);

  // Almost Full Flag Property: Almost FIFO_if.full flag is set when count equals FIFO_DEPTH-2
  property almostfull_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.almostfull == (FIFO_top.dut.count == FIFO_DEPTH-2));
  endproperty

  assert_almostfull_cond: assert property(almostfull_cond) else $error("Error: Almost FIFO_if.full flag assertion failed");
  cover_almostfull_cond: cover property(almostfull_cond);

  // Almost Empty Flag Property: Almost FIFO_if.empty flag is set when count equals 1
  property almostempty_cond;
    @(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) (FIFO_if.almostempty == (FIFO_top.dut.count == 1));
  endproperty

  assert_almostempty_cond: assert property(almostempty_cond) else $error("Error: Almost FIFO_if.empty flag assertion failed");
  cover_almostempty_cond: cover property(almostempty_cond);

  // Write Pointer Boundaries Property: Write pointer is always within bounds
  property wr_ptr_valid;
    @(posedge FIFO_if.clk) (FIFO_top.dut.wr_ptr < FIFO_DEPTH);
  endproperty

  assert_wr_ptr_valid: assert property(wr_ptr_valid) else $error("Error: Write pointer out of bounds");
  cover_wr_ptr_valid: cover property(wr_ptr_valid);

  // Read Pointer Boundaries Property: Read pointer is always within bounds
  property rd_ptr_valid;
    @(posedge FIFO_if.clk) (FIFO_top.dut.rd_ptr < FIFO_DEPTH);
  endproperty

  assert_rd_ptr_valid: assert property(rd_ptr_valid) else $error("Error: Read pointer out of bounds");
  cover_rd_ptr_valid: cover property(rd_ptr_valid);

  
endmodule : FIFO_SVA