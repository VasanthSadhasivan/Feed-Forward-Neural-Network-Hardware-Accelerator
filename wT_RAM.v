`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 11:42:55 PM
// Design Name: 
// Module Name: wT_RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wT_RAM(
    input CLK,
    input rw,
    input integer layer_index,
    input integer neuron_index,
    input integer column_index,
    input ARR column,
    output ARR wT_out
    );
    
    W_MATRIX_FILE main_ram;
    
    initial
    begin
        for (integer i = 0; i < `MAX_DEPTH; i++) begin
            for(integer j=0; j < `MAX_NEURONS; j++) begin
                main_ram[i][j][`MAX_NEURONS-1] = 0;
            end
        end
    end
    
    always @(posedge CLK) 
    begin
        if(rw == 0)
        begin
            if(layer_index >= 0 && layer_index < `MAX_DEPTH &&
                neuron_index >= 0 && neuron_index <`MAX_NEURONS)
                wT_out <= main_ram[layer_index][neuron_index];
        end
        else
        begin
            if(layer_index >= 0 && layer_index < `MAX_DEPTH &&
                column_index >= 0 && column_index <`MAX_NEURONS)
                begin
                    for (integer i = 0; i < `MAX_NEURONS; i++) begin
                        main_ram[layer_index][i][column_index] <= column[i];
                    end
                end
        end
    end
    
endmodule
