`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 07:09:38 PM
// Design Name: 
// Module Name: d_RAM
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

module d_RAM(
    input CLK,
    input integer neuron_index,
    input integer layer_index,
    input rw,
    input integer d_in,
    output ARR d_out
    );
    
    VAL_MATRIX main_ram;
    
    initial
    begin
        for (integer i = 0; i < `MAX_DEPTH; i++) begin
            main_ram[i][`MAX_NEURONS-1] = 0;
        end
    end
    
    always @(posedge CLK)
    begin
        if(rw == 0)
        begin
            if(layer_index > 0 && layer_index < `MAX_DEPTH)
                d_out <= main_ram[layer_index];
        end
        else
        begin
            main_ram[layer_index][neuron_index] <= d_in;
        end
    end

endmodule
