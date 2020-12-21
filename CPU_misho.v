`timescale 1ns / 1ps

module HW9(
	input clk_in
    );

		// Inputs
	
	
	// Outputs
	wire [7:0] output_PC;
	wire [7:0] output_R15;

	// Instantiate the Unit Under Test (UUT)
	Counter_misho misho5 (
		.Selector(en_jump), 
		.CLK(clk_in), 
		.Jump_to(ALU_output), 
		.output_PC(output_PC), 
		.output_R15(output_R15)
	);
	
	// Inputs
	reg [31:0] port_B_ALU=0;
	
	
	always @(OP) begin
	if(OP==2) begin
	port_B_ALU = (Iminstruction[23]) ? ~(0):0;
	port_B_ALU = Iminstruction;
	end
	else begin
	port_B_ALU = 0;
	port_B_ALU = Iminstruction_memory;
	end
	end
	// Outputs
	wire [31:0] ALU_output;
	wire [3:0] ALU_Flags;

	// Instantiate the Unit Under Test (UUT)
	ALU_Misho misho4 (
		.port_A(data_portA_out), 
		.port_B(port_B_ALU), 
		.cmd(Bits), 
		.OP(OP), 
		.ALU_output(ALU_output), 
		.ALU_Flags(ALU_Flags)
	);
	
	
	// Inputs
	reg [3:0] flags;
	always @(posedge clk_in) begin
	if(en_flags)
	flags <= ALU_Flags;
	end
	// Outputs
	wire [1:0] OP;
	wire [3:0] Base;
	wire [3:0] Bits;
	wire [3:0] Reg_data;
	wire [23:0] Iminstruction;
	wire [11:0] Iminstruction_memory;
	wire en_jump;
	wire en_regjump;
	wire en_flags;
	wire en_datawr;
	wire datamemory;
	wire data_memory;
	wire en_datamemory;

	// Instantiate the Unit Under Test (UUT)
	Decoder_misho misho0 (
		.flags(flags),
		.instruction(instruction_out), 
		.OP(OP), 
		.Base(Base), 
		.Bits(Bits), 
		.Reg_data(Reg_data), 
		.Iminstruction(Iminstruction), 
		.Iminstruction_memory(Iminstruction_memory), 
		.en_jump(en_jump), 
		.en_regjump(en_regjump), 
		.en_flags(en_flags), 
		.en_datawr(en_datawr), 
		.datamemory(datamemory), 
		.data_memory(data_memory), 
		.en_datamemory(en_datamemory)
	);
	
	// Inputs
	
	reg write_en_in;
	reg [7:0] addr_in;
	

	// Outputs
	wire [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	data_mem_misho misho1 (
		.clk_in(clk_in), 
		.write_en_in(en_datamemory), 
		.addr_in(ALU_output), 
		.data_in(data_portB_out), 
		.data_out(data_out)
	);
	// Inputs


	// Outputs
	wire [31:0] instruction_out;

	// Instantiate the Unit Under Test (UUT)
	instr_mem_misho misho2 (
		.instr_addr_in(output_PC), 
		.instruction_out(instruction_out)
	);
	 
  
    reg [31:0] data_in; //
	 always @(data_out,ALU_output) begin
	 if(datamemory)
		data_in = data_out;
	else
		data_in = ALU_output;
	 end
   
    wire [31:0] data_portA_out;
    wire [31:0] data_portB_out;
	 
	register__misho misho_magaria(
	.addr_portA_in(Base), //19:16
    .addr_portB_in(Reg_data), //15:12
     .pc_r15_in(output_R15),
     .write_en_in(en_datawr),
    .data_in(data_in),
    .clk_in(clk_in),
    .data_portA_out(data_portA_out),
    .data_portB_out(data_portB_out)
	);
	
endmodule
