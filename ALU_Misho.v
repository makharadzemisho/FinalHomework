`timescale 1ns / 1ps

module ALU_Misho(
		
		input [31:0] port_A, port_B,
		input [3:0] cmd,
		input [1:0] OP,
		output reg [31:0] ALU_output=0,
		output reg [3:0] ALU_Flags=0
    );
	 
		parameter [3:0] AND = 4'b0000;
		parameter [3:0] XOR = 4'b0001;
		parameter [3:0] ORR = 4'b1100;
		parameter [3:0] SUB = 4'b0010;
		parameter [3:0] RSB = 4'b0011;
		parameter [3:0] ADD = 4'b0100;
		parameter [3:0] CMP = 4'b1010;
	 
			always@(*) begin
				case(OP)
					2'b00 : begin
						case(cmd)
						AND : ALU_output = port_A&port_B;
						XOR : ALU_output = port_A^port_B;
						ORR : ALU_output = port_A|port_B;
						SUB : ALU_output = port_A-port_B;
						RSB : ALU_output = port_B-port_A;
						ADD : ALU_output = port_A+port_B;
						CMP : ALU_output = port_A-port_B;
						default : ALU_output = 0;
						endcase
						end
					2'b01 : begin   
						case(cmd[3])
							0: ALU_output = port_A;
							1: ALU_output = port_A+port_B;
						endcase
					end
					
					2'b10 : begin
						ALU_output = port_A+port_B;
						end
					default : ALU_output = 0;
					
				endcase
			end

			always@(*) begin
				//For N flag
				if (ALU_output[31] == 1) 
					ALU_Flags[3] = 1;
				else
					ALU_Flags[3] = 0;
				//For Z Flag
				if (ALU_output == 0)
					ALU_Flags[2] = 1;
				else 
					ALU_Flags[2] = 0;
					
				//C and O flags for sub and cmp
				
				if((cmd==0)|(cmd==10)) 
				begin
					if(port_A < port_B)
						ALU_Flags[1] = 1;
					else 
						ALU_Flags[1] = 0;
						
					if((port_A[31]==port_B[31])& (port_A[31]!= ALU_output[31])) 
						ALU_Flags[0] = 1;
					else
						ALU_Flags[0] = 0;
				end
				
				//C and O flags for rsb
				else if(cmd == 3)
				begin
					if(port_A > port_B)
					ALU_Flags[1] = 1;
					else
						ALU_Flags[1] = 0;
					
					if((port_A[31] == port_B[31]) & (port_A[31] != ALU_output[31]))
						ALU_Flags[0] = 1;
					else
						ALU_Flags[0] = 0;
				end
						
				else if(cmd == 4)
				begin
					if((port_A>ALU_output) || (ALU_output < port_B))
						ALU_Flags[1] = 1;
					else
						ALU_Flags[1] = 0;
					
					if((port_A[31] == port_B[31]) & (port_A[31] != ALU_output[31]))
						ALU_Flags[0] = 1;
					else
						ALU_Flags[0] = 0;
				end
				else begin
				ALU_Flags[1] = 0;
				ALU_Flags[0] = 0;
		end
		
	
	 end

   


endmodule
