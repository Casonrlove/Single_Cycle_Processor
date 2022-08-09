`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
   output [63:0] BusA; //output
   output [63:0] BusB; //output
   input [63:0]  BusW; //input
   input [4:0] 	 RW, RA, RB; //RA and RB are selector inputs into registers
   input 	 RegWr; //Enables to write to a register
   input 	 Clk;   //Clock :)
   reg [63:0] 	 registers [31:0]; //creating our own little registers
                                   //ARMv8 has 32x64 bit registers
   initial
     begin
	registers[0] = 64'h0;
	registers[1] = 64'h0;
	registers[2] = 64'h0;
	registers[3] = 64'h0;
	registers[4] = 64'h0;
	registers[5] = 64'h0;
	registers[6] = 64'h0;
	registers[7] = 64'h0;
	registers[8] = 64'h0;
	registers[9] = 64'h0;
	registers[10] = 64'h0;
	registers[11] = 64'h0;
	registers[12] = 64'h0;
	registers[13] = 64'h0;
	registers[14] = 64'h0;
	registers[15] = 64'h0;
	registers[16] = 64'h0;
	registers[17] = 64'h0;
	registers[18] = 64'h0;
	registers[19] = 64'h0;
	registers[20] = 64'h0;
	registers[21] = 64'h0;
	registers[22] = 64'h0;
	registers[23] = 64'h0;
	registers[24] = 64'h0;
	registers[25] = 64'h0;
	registers[26] = 64'h0;
	registers[27] = 64'h0;
	registers[28] = 64'h0;
	registers[29] = 64'h0;
	registers[30] = 64'h0;
	registers[31] = 64'h0;
        
	
     end
   
   assign  BusA = registers[RA]; 
   assign  BusB = registers[RB];
   
   always @ (negedge Clk)  //falling edge
     begin
	if(RegWr)
          registers[RW] <=  BusW; //nonblocking so it is sequential #3
	
	registers[31] <=  64'h0; //making sure register 31 is always reading 0  #3
	//could take out to not write every single clock period and save power but
	//not required for this
	
     end
endmodule
