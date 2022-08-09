`timescale 1ns / 1ps
`default_nettype none

//Ctrl
//00 I-type
//01 D-type
//10 B-type
//11 CBZ

module SignExtender(BusImm, Imm16, Ctrl);
   output reg [63:0] BusImm;
   input [25:0]      Imm16;
   input [2:0] 	     Ctrl;

   //wire 	     extBit;
   
   wire [1:0] 	     ShiftAmount;
   
   //assign ShiftAmount = Imm16[22:21] << 4;
   
   
   always@(*)
     begin

	case(Ctrl)
	  //------------------------------------------------------------
	  3'b000: 
	    begin
	       BusImm = {{52{1'b0}},Imm16[21:10]};
	    end
	  //------------------------------------------------------------
	  3'b001: 
	    begin
	       BusImm = {{55{Imm16[20]}}, Imm16[20:12]};
	    end
	  //------------------------------------------------------------
	  3'b010: 
	    begin
	       BusImm = {{38{Imm16[25]}}, Imm16[25:0]};
	    end
	  //------------------------------------------------------------
	  3'b011:
	    begin
	       BusImm = {{45{Imm16[23]}}, Imm16[23:5]};
	    end
	  //------------------------------------------------------------
	  3'b111:
	    begin
	       case(Imm16[22:21])
		 2'b00:
		   begin
		      BusImm = {{48{1'b0}},Imm16[20:5]} << 0;
		   end
		 2'b01:
		   begin
		      BusImm = {{48{1'b0}},Imm16[20:5]} << 16;
		   end
		 2'b10:
		   begin
		      BusImm = {{48{1'b0}},Imm16[20:5]} << 32;
		   end
		 2'b11:
		   begin
		      BusImm = {{48{1'b0}},Imm16[20:5]} << 48;
		   end
		 
	       endcase // case (Imm16[22:21])
	       
	    end // case: 3'b111
	  default:
	    BusImm = 64'hx;
	  
	  
	endcase // case (Ctrl)
	
     end // always@ (*)
   
endmodule      
