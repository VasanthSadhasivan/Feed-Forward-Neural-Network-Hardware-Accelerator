`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2020 03:04:48 AM
// Design Name: 
// Module Name: activation_function
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


module activation_function(
    input int x, //input has been scaled by factor of 10, and shifted by fifty
    output int f //output scaled by 255
    );
    
    always_comb
    begin
        case(x)
            0       : f=1;
            1       : f=1;
            2       : f=2;
            3       : f=2;
            4       : f=2;
            5       : f=2;
            6       : f=3;
            7       : f=3;
            8       : f=3;
            9       : f=4;
            10      : f=4;
            11      : f=5;
            12      : f=5;
            13      : f=6;
            14      : f=6;
            15      : f=7;
            16      : f=8;
            17      : f=9;
            18      : f=9;
            19      : f=10;
            20      : f=12;
            21      : f=13;
            22      : f=14;
            23      : f=16;
            24      : f=17;
            25      : f=19;
            26      : f=21;
            27      : f=23;
            28      : f=25;
            29      : f=27;
            30      : f=30;
            31      : f=33;
            32      : f=36;
            33      : f=39;
            34      : f=42;
            35      : f=46;
            36      : f=50;
            37      : f=54;
            38      : f=59;
            39      : f=63;
            40      : f=68;
            41      : f=73;
            42      : f=79;
            43      : f=84;
            44      : f=90;
            45      : f=96;
            46      : f=102;
            47      : f=108;
            48      : f=114;
            49      : f=121;
            50      : f=127;
            51      : f=133;
            52      : f=140;
            53      : f=146;
            54      : f=152;
            55      : f=158;
            56      : f=164;
            57      : f=170;
            58      : f=175;
            59      : f=181;
            60      : f=186;
            61      : f=191;
            62      : f=195;
            63      : f=200;
            64      : f=204;
            65      : f=208;
            66      : f=212;
            67      : f=215;
            68      : f=218;
            69      : f=221;
            70      : f=224;
            71      : f=227;
            72      : f=229;
            73      : f=231;
            74      : f=233;
            75      : f=235;
            76      : f=237;
            77      : f=238;
            78      : f=240;
            79      : f=241;
            80      : f=242;
            81      : f=244;
            82      : f=245;
            83      : f=245;
            84      : f=246;
            85      : f=247;
            86      : f=248;
            87      : f=248;
            88      : f=249;
            89      : f=249;
            90      : f=250;
            91      : f=250;
            92      : f=251;
            93      : f=251;
            94      : f=251;
            95      : f=252;
            96      : f=252;
            97      : f=252;
            98      : f=252;
            99      : f=253;
            default : f=0.0;
        endcase
    end
    
endmodule
