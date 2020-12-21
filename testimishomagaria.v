`timescale 1ns / 1ps

//
////////////////////////////////////////////////////////////////////////////////

module testimishomagaria;

	// Inputs
	reg clk_in;

	// Instantiate the Unit Under Test (UUT)
	HW9 uut (
		.clk_in(clk_in)
	);
always begin
#2;clk_in = 1;
#2;clk_in = 0;
end
	initial begin
		// Initialize Inputs
		clk_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

