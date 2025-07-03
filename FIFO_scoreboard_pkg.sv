package FIFO_scoreboard_pkg;
import uvm_pkg::*;
import FIFO_driver_pkg::*;
import FIFO_seq_item_pkg::*;
import FIFO_sequencer_pkg::*;
import FIFO_config_pkg::*;
import FIFO_monitor_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"  
	class FIFO_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(FIFO_scoreboard)
  uvm_analysis_export #(FIFO_seq_item) sb_export;
  uvm_tlm_analysis_fifo #(FIFO_seq_item) sb_fifo;
  FIFO_seq_item seq_item_sb;

	 logic [FIFO_WIDTH-1:0] data_in_ref;
    logic rst_n_ref, wr_en_ref, rd_en_ref;
    logic [FIFO_WIDTH-1:0] data_out_ref;
    logic wr_ack_ref, overflow_ref;
    logic full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref,write_read;
    reg [2:0] write_pointer=0;
    reg [2:0] read_pointer=0;
    integer  fifo_count = 0;
    reg [FIFO_WIDTH-1:0] mem_ref [FIFO_DEPTH-1:0];
function  new(string name="FIFO_scoreboard", uvm_component parent =null);
    super.new(name,parent); 
    this.write_pointer=0;
      this.read_pointer=0;
      this.fifo_count=0;
  endfunction : new
function void build_phase(uvm_phase phase);
super.build_phase(phase);
sb_export=new("sb_export",this);
sb_fifo=new("sb_fifo",this);
endfunction
function void connect_phase(uvm_phase phase) ;
  super.connect_phase(phase);
  sb_export.connect(sb_fifo.analysis_export);
endfunction 
task run_phase(uvm_phase phase);
  super.run_phase(phase);
    forever begin
  sb_fifo.get(seq_item_sb);
  ref_model(seq_item_sb);
 if(data_out_ref ===seq_item_sb.data_out)
     begin
      `uvm_info("run_phase",$sformatf("correct DATA OUT:%S",seq_item_sb.convert2string()),UVM_HIGH);
      correct_count++;  
  end 
else
  begin
      `uvm_error("run_phase",$sformatf("comparison failed,transaction received by the DUT:%s while the reference data_out:0h%0h",seq_item_sb.convert2string(),data_out_ref));
      error_count++;
    end
  end
endtask : run_phase
    // Reference model function to calculate expected values based on input object
task ref_model(FIFO_seq_item seq_item_chk);
    	data_in_ref=seq_item_chk.data_in;
    	rst_n_ref=seq_item_chk.rst_n;
    	wr_en_ref=seq_item_chk.wr_en;
        rd_en_ref=seq_item_chk.rd_en;
       write_read=wr_en_ref && rd_en_ref &&write_pointer==read_pointer;
       // Implement the golden model logic based on FIFO behavior
            // Calculate full_ref, empty_ref, almostfull_ref, almostempty_ref based on fifo_count
      full_ref       = (fifo_count == 8);    // Full when count reaches 8
      empty_ref      = (fifo_count == 0);    // Empty when count is 0
      almostfull_ref = (fifo_count == 6);    // Almost full at 7
      almostempty_ref = (fifo_count == 1);   // Almost empty at 1
      underflow_ref  = (rd_en_ref && empty_ref);  // Underflow condition
// Update fifo_count based on wr_en and rd_en conditions
      if(!rst_n_ref)
        fifo_count=0;
      else if (wr_en_ref && !rd_en_ref && !full_ref) begin
        fifo_count++;
      end
      else if (rd_en_ref && !wr_en_ref && !empty_ref) begin
        fifo_count--;
      end
    else if ( ({wr_en_ref, rd_en_ref} == 2'b11) && empty_ref) 
       fifo_count++;
    else if ( ({wr_en_ref, rd_en_ref} == 2'b11) && full_ref)
      fifo_count--;
      // Write operation: Check if write enable is high and FIFO is not full
     if (!rst_n_ref) begin
  write_pointer = 0;
  read_pointer = 0;
end else begin
  // Handle simultaneous write and read when write_pointer == read_pointer
  if (wr_en_ref && rd_en_ref && (write_pointer == read_pointer) && !full_ref && !empty_ref) begin
        // Read the old data before it gets overwritten
    data_out_ref = mem_ref[read_pointer];
    // Write the new data
    mem_ref[write_pointer] = data_in_ref;
    
    // Increment both pointers (wrap them around using modulo logic)
    write_pointer = (write_pointer + 1) ;
    read_pointer = (read_pointer + 1) ;
  end else begin
    // Write operation: Check if write enable is high and FIFO is not full
    if (wr_en_ref && !full_ref) begin
      mem_ref[write_pointer] = data_in_ref;
      write_pointer = (write_pointer + 1) ;  // Increment write pointer with wrap around
    end
    // Read operation: Check if read enable is high and FIFO is not empty
    if (rd_en_ref && !empty_ref) begin
      data_out_ref = mem_ref[read_pointer];  // Provide the data for read
      read_pointer = (read_pointer + 1) ;  // Increment read pointer with wrap around
    end
  end
end
  endtask: ref_model
  function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("report_phase",$sformatf("total successful transaction:%0d",correct_count),UVM_MEDIUM);
         `uvm_info("reprt_phase",$sformatf("total failed transaction:%0d",error_count),UVM_MEDIUM); 
    endfunction : report_phase
	endclass : FIFO_scoreboard
	
endpackage : FIFO_scoreboard_pkg