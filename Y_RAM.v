`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 07:07:09 PM
// Design Name: 
// Module Name: Y_RAM
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
`include "library_file.v" 

module Y_RAM(
    input CLK,
    input rw,
    input integer neuron_index,
    input ARR master_input,
    input integer layer_index,
    input integer y_in,
    output ARR y_out,
    output ARR last_layer
    );
    
    VAL_MATRIX main_ram;
    
    initial
    begin
        for (integer i = 0; i < `MAX_DEPTH; i++) begin
            main_ram[i][`MAX_NEURONS-1] = 1;
        end
    end
    
    assign last_layer = main_ram[`MAX_DEPTH - 1];
    
    always @(posedge CLK) 
    begin
        if(rw == 0)
        begin
            if(layer_index == 0)
                y_out <= master_input;
            else if(layer_index > 0 && layer_index < `MAX_DEPTH)
                y_out <= main_ram[layer_index];
        end
        else
        begin
            main_ram[layer_index][neuron_index] <= y_in;
        end
    end
    
    
endmodule
