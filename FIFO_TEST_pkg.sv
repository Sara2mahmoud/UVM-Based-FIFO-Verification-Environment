package FIFO_TEST_pkg;
import uvm_pkg::*;
import FIFO_ENV_pkg::*;
import FIFO_config_pkg::*;
import FIFO_sequences::*;
`include "uvm_macros.svh"	
class FIFO_test extends uvm_test;
`uvm_component_utils(FIFO_test)
function  new(string name="FIFO_test", uvm_component parent =null);
	super.new(name,parent);	
endfunction : new
FIFO_Env env;
FIFO_config_obj FIFO_config_obj_test;
FIFO_reset reset_seq;
FIFO_main_write  write_seq;
FIFO_main_read   read_seq;
FIFO_main_wr     wr_seq;  

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=FIFO_Env::type_id::create("env",this);
FIFO_config_obj_test=FIFO_config_obj::type_id::create("FIFO_config_obj_test",this);
reset_seq=FIFO_reset::type_id::create("reset_seq",this);
write_seq=FIFO_main_write::type_id::create("write_seq",this);
read_seq=FIFO_main_read::type_id::create("read_seq",this);
wr_seq=FIFO_main_wr::type_id::create("wr_seq",this);
if(!uvm_config_db#(virtual FIFO_interface)::get(this,"","FIFO_interface",FIFO_config_obj_test.FIFO_config_vif))
	`uvm_error("build_phase","Test - Unable to get the virtual interface of the shifth reg from the uvm_config_db");

uvm_config_db #(FIFO_config_obj)::set(this,"*","FIFO_test_vif",FIFO_config_obj_test);
endfunction
task run_phase(uvm_phase phase);
   super.run_phase(phase);
	phase.raise_objection(this);
	`uvm_info("run_phase","Resset asserted.",UVM_LOW);
	reset_seq.start(env.agt.sqr);
	`uvm_info("run_phase","Resset deasserted.",UVM_LOW);

	`uvm_info("run_phase","stimulus generation started.",UVM_LOW);
	write_seq.start(env.agt.sqr);
	`uvm_info("run_phase","Resset stimulus generation Ended.",UVM_LOW);
	// phase.drop_objection(this);

	`uvm_info("run_phase","stimulus generation started.",UVM_LOW);
	read_seq.start(env.agt.sqr);
	`uvm_info("run_phase","Resset stimulus generation Ended.",UVM_LOW);
	// phase.drop_objection(this);

	`uvm_info("run_phase","stimulus generation started.",UVM_LOW);
	wr_seq.start(env.agt.sqr);
	`uvm_info("run_phase","Resset stimulus generation Ended.",UVM_LOW);
	phase.drop_objection(this);	
endtask : run_phase
	endclass : FIFO_test	
endpackage : FIFO_TEST_pkg