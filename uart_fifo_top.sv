`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2026 11:07:12
// Design Name: 
// Module Name: uart_fifo_top
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


module uart_fifo_top(input logic clk, input logic reset_n, input logic rx, input logic read_enable, output logic [7:0] data_out, output logic empty, output logic full);

logic [7:0] uart_data;
logic uart_valid;

uart_rx UART_RX (.clk(clk),.reset_n(reset_n),.rx(rx),.data_out(uart_data),.data_valid(uart_valid));
sync_fifo SYNC_FIFO (.clk(clk),.reset_n(reset_n),.write_enable(uart_valid),.read_enable(read_enable),.data_in(uart_data),.data_out(data_out),.full(full),.empty(empty)); 

endmodule
