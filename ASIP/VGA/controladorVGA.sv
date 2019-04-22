module controladorVGA(
    clock,
    hsync,
    vsync,
    video_on,
    pixelX,
    pixelY
);

//Inputs
input logic clock; //Clock de 25MHz

//Outputs
output wire hsync;
output wire vsync;
output wire video_on;
output logic [9:0] pixelX;
output logic [9:0] pixelY;


initial 
    begin
        pixelX = 0;
        pixelY = 0;
    end
    
logic refreshPx; //Reset de la posición en X cuando se pasa a la siguiente fila
logic refreshPy; //Reset de la posición en Y cuando se acaba la pantalla
logic h_video_on;
logic v_video_on;

//Movimiento en X de la posición en la pantalla
always @(posedge clock)
    begin
        if(refreshPx) begin 
            pixelX <= 0;
        end else begin 
            pixelX <= pixelX + 1'b1;
        end
    end

//Movimiento en Y de la posición de la pantalla
always @(posedge clock)
    begin
        if(refreshPy) begin 
            pixelY <= 0;
        end else begin
            if(pixelX == 799)
                pixelY <= pixelY + 1'b1;
            else
                pixelY <= pixelY;
        end
    end

    assign h_video_on = pixelX < 640; //Margen de la pantalla donde está activado horizontalmente
    assign v_video_on = pixelY < 480; //Margen de la pantalla donde está activado verticalmente
    assign hsync = pixelX < 655 || pixelX > 750; //Pulso de sincronización horizontal
    assign vsync = pixelY < 489 || pixelY > 490; //Pulso de sincronización vertical
    
    assign refreshPx = pixelX == 799; //Simboliza el final de la pantalla horizontal
    assign refreshPy = pixelX == 799 && pixelY==524; //Simboliza el final de la pantalla vertical
    assign video_on = h_video_on && v_video_on;
    
endmodule
    


