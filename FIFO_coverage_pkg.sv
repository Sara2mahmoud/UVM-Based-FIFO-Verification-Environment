package FIFO_coverage_pkg;
import uvm_pkg::*;
import FIFO_driver_pkg::*;
import FIFO_seq_item_pkg::*;
import FIFO_sequencer_pkg::*;
import FIFO_config_pkg::*;
import FIFO_monitor_pkg::*;
import shared_pkg::*;

`include "uvm_macros.svh"
  class FIFO_coverage extends  uvm_component;
    `uvm_component_utils(FIFO_coverage);
    uvm_analysis_export #(FIFO_seq_item) cov_export;
      uvm_tlm_analysis_fifo #(FIFO_seq_item) cov_fifo;
        FIFO_seq_item seq_item_cov;
	covergroup FIFO_coverage_gp ;
    wr_ack:coverpoint seq_item_cov.wr_ack{
    bins wr_ack_1={1};
    bins wr_ack_0={0};
    }
    wr_en:coverpoint seq_item_cov.wr_en{
    bins wr_en_1={1};
    bins wr_en_0={0};
    }
    rd_en:coverpoint seq_item_cov.rd_en{
    bins rd_en_1={1};
    bins rd_en_0={0};
    }
    full:coverpoint seq_item_cov.full{
    bins full_1={1};
    bins full_0={0};
    }
    underflow:coverpoint seq_item_cov.underflow{
    bins underflow_1={1};
    bins underflow_0={0};
    }
    overflow:coverpoint seq_item_cov.overflow{
    bins overflow_1={1};
    bins overflow_0={0};
    }
      // Cross coverage of wr_en, rd_en, and all control signals 
     empty_cv:cross seq_item_cov.wr_en, seq_item_cov.rd_en, seq_item_cov.empty; 
     almostfull_cv:cross seq_item_cov.wr_en, seq_item_cov.rd_en, seq_item_cov.almostfull; 
     almostempty_cv:cross seq_item_cov.wr_en, seq_item_cov.rd_en, seq_item_cov.almostempty ;
      wr_ack_cv: cross wr_en, rd_en, wr_ack {
            ignore_bins wr_ack_cv_excl_0_1_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_1)&&binsof(wr_ack.wr_ack_1);
            ignore_bins wr_ack_cv_excl_0_0_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_0)&&binsof(wr_ack.wr_ack_1);
        }

        overflow_cv: cross wr_en, rd_en, overflow {
            ignore_bins overflow_cv_excl_0_1_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_1)&&binsof(overflow.overflow_1);
            ignore_bins overflow_cv_excl_0_0_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_0)&&binsof(overflow.overflow_1);
        }

        full_cv: cross wr_en, rd_en, full {
            ignore_bins full_cv_excl_1_1_1 = binsof(wr_en.wr_en_1)&&binsof(rd_en.rd_en_1)&&binsof(full.full_1);
            ignore_bins full_cv_excl_0_1_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_1)&&binsof(full.full_1);
        }

        underflow_cv: cross wr_en, rd_en, underflow {
            ignore_bins underflow_cv_excl_1_0_1 = binsof(wr_en.wr_en_1)&&binsof(rd_en.rd_en_0)&&binsof(underflow.underflow_1);
            ignore_bins underflow_cv_excl_0_0_1 = binsof(wr_en.wr_en_0)&&binsof(rd_en.rd_en_0)&&binsof(underflow.underflow_1);
        }
		
	endgroup : FIFO_coverage_gp
	        function  new(string name="FIFO_coverage_gp", uvm_component parent =null);
    super.new(name,parent); 
    FIFO_coverage_gp=new();
  endfunction : new

    function void build_phase(uvm_phase phase);
          super.build_phase(phase);
           cov_export=new("cov_export",this);
           cov_fifo=new("cov_fifo",this);
           endfunction

      function void connect_phase(uvm_phase phase) ;
       super.connect_phase(phase);
       cov_export.connect(cov_fifo.analysis_export);
         endfunction  

         task run_phase(uvm_phase phase);
          super.run_phase(phase);
          forever
          begin
            cov_fifo.get(seq_item_cov);
            FIFO_coverage_gp.sample();
          end
          
         endtask : run_phase

endclass : FIFO_coverage
	
endpackage : FIFO_coverage_pkg