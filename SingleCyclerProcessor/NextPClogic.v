`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input  [63:0] CurrentPC, SignExtImm64; 
   input   Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC;

   reg 		 MuxSignal;

   //MuxSignal = UncondBranch | (Branch & ALUZero);
	
   always@(*)
     begin

	MuxSignal = Uncondbranch | (Branch & ALUZero);
	
	
	case(MuxSignal)
    
	  //----------------------------------------
	     1'b0: 
	      begin
		NextPC = CurrentPC + 4'b0100; //#1
	      end
	  //----------------------------------------
	    1'b1:
	      begin
	        NextPC = CurrentPC + 4*SignExtImm64; //#2
	      end
	  //----------------------------------------
	endcase // case (MuxSignal)
     end
	
endmodule
