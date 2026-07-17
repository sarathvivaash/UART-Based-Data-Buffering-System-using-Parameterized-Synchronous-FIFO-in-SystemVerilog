`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 10:57:35
// Design Name: 
// Module Name: sync_fifo_tb
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


module sync_fifo_tb;
    parameter data_width = 8;
    parameter depth = 16;
    
    logic clk;
    logic reset_n;
    logic write_enable;
    logic read_enable;
    logic [data_width-1:0] data_in;
    logic [data_width-1:0] data_out;
    logic full;
    logic empty;
    
    sync_fifo #(.data_width(data_width),.depth(depth))
    DUT(.clk(clk),.reset_n(reset_n),.write_enable(write_enable),.read_enable(read_enable),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));
    
    always #5 clk = ~clk;
    
    task write_fifo( input [data_width-1:0] data);
    begin
     @(posedge clk);
     if(!full) begin
      write_enable = 1;
      data_in = data;
     end
     
     @(posedge clk);
     write_enable = 0;
    end
    endtask
    
    task read_fifo();
    begin
     @(posedge clk);
     if(!empty) begin
      read_enable = 1;
     end
     
     @(posedge clk);
     read_enable = 0;
    end
    endtask
    
    initial begin
     clk = 0; reset_n = 0; write_enable = 0; read_enable = 0; data_in = 0;
     #20;
     reset_n = 1;
     
     $display("\n TEST 1: WRITE ");
     write_fifo(8'h11);
     write_fifo(8'h22);
     write_fifo(8'h33);
     
     $display("\n TEST 2: READ ");
     read_fifo();
     $display("Read Data = %h", data_out);
     read_fifo();
     $display("Read Data = %h", data_out);
     read_fifo();
     $display("Read Data = %h", data_out);
     
     $display("\n TEST 3: FILL FIFO ");
     repeat(depth)
      write_fifo($random);
      
      
     $display("\n TEST 4: EMPTY FIFO ");
     repeat(depth)
      read_fifo();
      
      #20;
     $finish;
    end
endmodule