module regionPantalla#( 
	parameter ColorBits = 3,
	parameter screenX = 320,
	parameter screenY = 240) (
	clock,
	readValueMemory,
	posicionX,
	posicionY,
	red,
	green,
	blue
);

//Inputs
input logic clock;
input logic [9:0] posicionX;
input logic [9:0] posicionY;
input logic [ColorBits-1:0] readValueMemory;

//Outputs
output logic [7:0] red;
output logic [7:0] green;
output logic [7:0] blue;

initial
	begin

	end

always @(posedge clock)
	begin
		if(posicionX < screenX) begin
			if(posicionY < screenY) begin
				if(readValueMemory[0] == 1) begin
					red <= 8'hFF;
				end else begin
					red <= 8'h00;
				end
				if(readValueMemory[1] == 1) begin
					green <= 8'hFF;
				end else begin
					green <= 8'h00;
				end
				if(readValueMemory[2] == 1) begin
					blue <= 8'hFF;
				end else begin
					blue <= 8'h00;
				end
			end else begin
				red <= 8'hFF;
				green <= 8'hFF;
				blue <= 8'hFF;
			end
		end else begin
			red <= 8'hFF;
			green <= 8'hFF;
			blue <= 8'hFF;
		end
	end

endmodule