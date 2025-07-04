package FIFO_ENV_pkg;
import uvm_pkg::*;
import FIFO_driver_pkg::*;
import FIFO_sequencer_pkg::*;
import FIFO_agent_pkg::*;
import FIFO_scoreboard_pkg::*;
import FIFO_coverage_pkg::*;


`include "uvm_macros.svh"

class FIFO_Env extends  uvm_env;
	`uvm_component_utils(FIFO_Env);

FIFO_driver driver;
FIFO_sequencer FIFO_sqr;
FIFO_agent agt;
FIFO_coverage cov;
FIFO_scoreboard sb;


	function  new(string name="FIFO_Env", uvm_component parent =null);
		super.new(name,parent);
		
	endfunction : new

function void build_phase(uvm_phase phase);

	super.build_phase(phase);
	agt=FIFO_agent::type_id::create("agt",this);
	cov=FIFO_coverage::type_id::create("cov",this);
	sb=FIFO_scoreboard::type_id::create("sb",this);	
endfunction : build_phase

function void connect_phase(uvm_phase phase) ;
	super.connect_phase(phase);
	//driver.seq_item_port.connect(FIFO_sqr.seq_item_export);
	agt.agt_ap.connect(sb.sb_export);
	agt.agt_ap.connect(cov.cov_export);

endfunction 

	
endclass : FIFO_Env


endpackage : FIFO_ENV_pkg
