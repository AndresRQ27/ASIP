module VGA#(
    parameter ColorBits = 3,
    parameter screenX = 50,
    parameter screenY = 50)(
    clock,
    readValueMemory,
    hsync,
    vsync,
    red,
    green,
    blue,
    blank,
    clkVGA,
    XRead,
    YRead
);

//Inputs
input logic clock;
input logic [ColorBits-1:0] readValueMemory;

//Output
output logic hsync;
output logic vsync;
output logic [7:0] red;
output logic [7:0] green;
output logic [7:0]  blue;
output logic blank;
output logic clkVGA;
output logic [9-1:0] XRead;
output logic [8-1:0] YRead;

//------------------------------------------
//DECLARACION DE VARIABLES
//------------------------------------------
logic [9:0] posicionX, posicionY;

//------------------------------------------
//INSTANCIAS
//------------------------------------------
divisorFrecuencia clk25MHz(
    .clock(clock),
    .clk25Mhz(clkVGA)
);

controladorVGA controladorVGA(
    .clock(clkVGA),
    .hsync(hsync),
    .vsync(vsync),
    .video_on(blank),
    .pixelX(posicionX),
    .pixelY(posicionY)
);

//Color del pixel en la pantalla
regionPantalla #(screenX, screenY)
colorPantalla(
    .clock    (clock),
    .readValueMemory(readValueMemory),
    .posicionX(posicionX),
    .posicionY(posicionY),
    .red      (red),
    .green    (green),
    .blue     (blue)
);

assign XRead = posicionX; //Trunca el número para leer el color en memoria
assign YRead = posicionY; //En caso que se salga de la pantalla, el color se ignora en otro módulo

endmodule