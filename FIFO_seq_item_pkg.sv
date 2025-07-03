package FIFO_seq_item_pkg;
	import uvm_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"

class FIFO_seq_item extends  uvm_sequence_item;
`uvm_object_utils(FIFO_seq_item)
parameter FIFO_WIDTH = 16;
logic clk;
rand bit [FIFO_WIDTH-1:0] data_in;
rand bit  rst_n, wr_en, rd_en;

logic [FIFO_WIDTH-1:0] data_out;

logic wr_ack, overflow;

logic full, empty, almostfull, almostempty, underflow;

 // Integers for distribution percentages
 integer RD_EN_ON_DIST;
 integer WR_EN_ON_DIST;

 function  new(string name ="FIFO_seq_item",int rd_dist = 30, int wr_dist = 70);
	super.new(name);
    this.RD_EN_ON_DIST = rd_dist;
    this.WR_EN_ON_DIST = wr_dist;	
endfunction : new
		
function string convert2string();
	return $sformatf("%s rst =0b%0b, data_in=0h%0h , wr_en=0b%0b , rd_en=0b%0b , data_out=0h%0h ,wr_ack=0b%0b , overflow=0b%0b , full=0b%0b , empty=0b%0b ,almostfull=0b%0b , almostempty=0b%0b ,underflow=0h%0b ",super.convert2string, 
		rst_n,data_in, wr_en, rd_en, data_out, wr_ack,overflow,full, empty, almostfull,almostempty,underflow);
	
endfunction : convert2string
	
function string convert2string_stimulus();
return $sformatf(" rst =0b%0b, data_in=0b%0b , wr_en=0b%0b , rd_en=0b%0b",rst_n, data_in, wr_en, rd_en);
	
endfunction : convert2string_stimulus

    constraint rst_transaction_const {
      rst_n dist {1'b1 :=98, 1'b0 := 2};  // 90% chance of being deactivated (active low reset)
    }

     constraint wr_transaction_const {
      wr_en dist {1 := WR_EN_ON_DIST, 0 := (100 - WR_EN_ON_DIST)};
    }   

     constraint rd_transaction_const {
      rd_en dist {1 := RD_EN_ON_DIST, 0 := (100 - RD_EN_ON_DIST)};
    }   	

endclass : FIFO_seq_item
endpackage : FIFO_seq_item_pkg