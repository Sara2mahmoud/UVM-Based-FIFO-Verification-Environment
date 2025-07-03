package FIFO_sequences;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*;
import FIFO_sequencer_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"
class FIFO_reset extends  uvm_sequence #(FIFO_seq_item);
	`uvm_object_utils(FIFO_reset);
	FIFO_seq_item seq_item_reset;
function  new(string name ="FIFO_reset");
	super.new(name);
	endfunction : new
task body();
seq_item_reset =FIFO_seq_item::type_id::create("seq_item_reset");
start_item(seq_item_reset);
seq_item_reset.data_in=0; 
seq_item_reset.rst_n=0;
seq_item_reset.rd_en=0;
seq_item_reset.wr_en=0;
finish_item(seq_item_reset);	
endtask : body	
endclass : FIFO_reset
class FIFO_main_write extends  uvm_sequence #(FIFO_seq_item);
	`uvm_object_utils(FIFO_main_write);
	FIFO_seq_item write_seq;

function  new(string name ="FIFO_main_write");
	super.new(name);
endfunction : new

task body();
     repeat(1000) begin
     write_seq = FIFO_seq_item::type_id::create("write_seq");
     start_item(write_seq);
            write_seq.randomize() with { write_seq.rd_en == 0; write_seq.wr_en==1;}; 
     finish_item(write_seq);
     end
endtask : body	
endclass : FIFO_main_write
class FIFO_main_read extends  uvm_sequence #(FIFO_seq_item);
  `uvm_object_utils(FIFO_main_read);
  FIFO_seq_item seq_item_main;
    FIFO_seq_item read_seq;
function  new(string name ="FIFO_main_read");
  super.new(name); 
endfunction : new
task body();
        repeat(1000) begin
        read_seq = FIFO_seq_item::type_id::create("read_seq");
        start_item(read_seq);
           read_seq.randomize() with { read_seq.rd_en == 1; read_seq.wr_en==0;};
       finish_item(read_seq);
      end 
endtask : body 
endclass : FIFO_main_read
class FIFO_main_wr extends  uvm_sequence #(FIFO_seq_item);
  `uvm_object_utils(FIFO_main_wr);
  FIFO_seq_item seq_item_main;
  FIFO_seq_item write_seq;
    FIFO_seq_item read_seq;
    FIFO_seq_item wr_seq;
function  new(string name ="FIFO_main_wr");
  super.new(name); 
endfunction : new
task body();
     repeat(1000) begin
        wr_seq = FIFO_seq_item::type_id::create("wr_seq");
        start_item(wr_seq);
        assert(wr_seq.randomize()); 
       finish_item(wr_seq);
     end
endtask : body 
endclass : FIFO_main_wr	
endpackage : FIFO_sequences