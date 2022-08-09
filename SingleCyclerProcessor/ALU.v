`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111
`timescale 1ns / 1ps

module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: begin
                BusW =  BusA &  BusB;
            end
	  
	    `OR: begin
	       BusW =  BusA | BusB;
	    end
	    `ADD: begin
	       BusW =  BusA + BusB;
	    end

	    `SUB: begin
	       BusW =  BusA - BusB;
	    end
	  
	    `PassB: begin
	       BusW = BusB;
	    end
	    default: begin
	       BusW = 64'b0;
	    end
	  
        endcase
    end

   assign  Zero = BusW===0;
   
		    
endmodule
