`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module register__misho(
    input [3:0] addr_portA_in, //19:16
    input [3:0] addr_portB_in, //15:12
    input [31:0] pc_r15_in,
    input write_en_in,
    input [31:0] data_in,
    input clk_in,
    output [31:0] data_portA_out,
    output [31:0] data_portB_out
    );
	 
	 
	 reg [31:0] register_file [0:15];
	 
	 	 always @(negedge clk_in) begin
		 register_file[0] = 12;
		 end
	 assign data_portA_out = register_file[addr_portA_in];
	 assign data_portB_out = register_file[addr_portB_in];


	 always @(posedge clk_in)
	 begin
		register_file[15] = pc_r15_in; //update the PC register 
		
		if (write_en_in == 1)
			register_file[addr_portB_in] = data_in;
	 end


endmodule
