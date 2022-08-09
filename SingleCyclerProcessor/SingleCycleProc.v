module singlecycle(
    input resetl,
    input [63:0] startpc,
    output reg [63:0] currentpc,
    output [63:0] dmemout,
    input CLK
);

    // Next PC connections
    wire [63:0] nextpc;       // The next PC, to be updated on clock cycle

    // Instruction Memory connections
    wire [31:0] instruction;  // The current instruction

    // Parts of instruction
    wire [4:0] rd;            // The destination register
    wire [4:0] rm;            // Operand 1
    wire [4:0] rn;            // Operand 2
    wire [10:0] opcode;

    // Control wires
   wire 	reg2loc;       
   wire 	alusrc;       
   wire 	mem2reg;
   wire 	regwrite;
   wire 	memread;
   wire 	memwrite;
   wire 	branch;
   wire 	uncond_branch;
   wire [3:0] 	aluctrl;
   wire [2:0] 	signop;

   // Register file connections
   wire [63:0] regoutA;     // Output A
   wire [63:0] regoutB;     // Output B
   
   wire [63:0] ALU2ndInput; //mine

   // ALU connections
   wire [63:0] aluout;
   wire        zero;
   
   // Sign Extender connections
   wire [63:0] extimm;

   //Data Memory connections
   wire [63:0] d1mem;
   

   // PC update logic
   always @(negedge CLK)
     begin
        if (resetl)
          currentpc <= nextpc;
        else
          currentpc <= startpc;
     end

   // Parts of instruction
   assign rd = instruction[4:0];
   assign rm = instruction[9:5];
   assign rn = reg2loc ? instruction[4:0] : instruction[20:16];
   assign opcode = instruction[31:21];

   //ADDING imm26 or equivalent of Imm16 in SignExtender
   wire [25:0] imm26;
   assign imm26 = instruction[25:0];

   //----------LAB9-COMPONETS----------
   InstructionMemory imem(
			  .Data(instruction),
			  .Address(currentpc)
			  );

   control control(
		   .reg2loc(reg2loc),
		   .alusrc(alusrc),
		   .mem2reg(mem2reg),
		   .regwrite(regwrite),
		   .memread(memread),
		   .memwrite(memwrite),
		   .branch(branch),
		   .uncond_branch(uncond_branch),
		   .aluop(aluctrl),
		   .signop(signop),
		   .opcode(opcode)
		   );
   DataMemory DeezData(
	      .ReadData(d1mem),
	      .Address(aluout),
	      .WriteData(regoutB),
	      .MemoryRead(memread),
	      .MemoryWrite(memwrite),
	      .Clock(CLK)
	      );

   //-------------DMmux----------------
   
   assign dmemout = mem2reg ? d1mem[63:0] : aluout[63:0];
	      
      
   //----------LAB8-COMPONETS----------
   NextPClogic NPCL(
		    .NextPC(nextpc),
		    .CurrentPC(currentpc),
		    .SignExtImm64(extimm),
		    .Branch(branch),
		    .ALUZero(zero),
		    .Uncondbranch(uncond_branch)
		    );
   RegisterFile RF(
		   .BusA(regoutA),
		   .BusB(regoutB),
		   .BusW(dmemout),
		   .RA(rm),
		   .RB(rn), //might be backwards for these two
		   .RW(rd),
		   .RegWr(regwrite),
		   .Clk(CLK)
		   );
   //----------LAB7-COMPONETS----------

   //--------------ALUmux--------------
   assign ALU2ndInput = alusrc ? extimm[63:0] : regoutB[63:0];
   //----------------------------------
   
   ALU ALUMAIN(
	       .BusW(aluout),
	       .BusA(regoutA),
	       .BusB(ALU2ndInput),
	       .ALUCtrl(aluctrl),
	       .Zero(zero)
	       );
   SignExtender SE(
		   .BusImm(extimm),
		   .Imm16(imm26),
		   .Ctrl(signop)
		   );
   //Maybe done?
	       
      
   /*
    * Connect the remaining datapath elements below.
    * Do not forget any additional multiplexers that may be required.
    */



endmodule

