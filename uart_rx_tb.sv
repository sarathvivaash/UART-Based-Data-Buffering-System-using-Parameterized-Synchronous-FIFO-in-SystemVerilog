`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2026 17:20:35
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb;
 parameter clk_freq = 100000000; 
 parameter baud_rate = 115200;
 localparam clks_per_bit = clk_freq/baud_rate;
 logic clk;
 logic reset_n;
 logic rx;
 logic [7:0] data_out;
 logic data_valid;
 
 uart_rx #(.clk_freq(clk_freq),.baud_rate(baud_rate))
 DUT(.clk(clk),.reset_n(reset_n),.rx(rx),.data_out(data_out),.data_valid(data_valid));
 
 always #5 clk = ~clk;
 
 task send(input [7:0] data);
   integer i;
   begin
     rx = 0;
     repeat(clks_per_bit)
       @(posedge clk);
     
     for(i=0; i<8; i=i+1)begin
        rx = data[i];
        repeat(clks_per_bit)
          @(posedge clk);
     end
     
     rx = 1;
     repeat(clks_per_bit-1)
       @(posedge clk);
    end
  endtask
  
  initial begin
     clk = 0;
     reset_n = 0;
     rx = 1;
     
     #20;
     reset_n = 1;
     
     $display("\n DATA 1");
     send(8'h55);
     repeat(20) @(posedge clk);
     $display("received = %h", data_out);
     #1000;
     
     $display("\n DATA 2");
     send(8'hA5);
     repeat(20) @(posedge clk);
     $display("received = %h", data_out);
     #1000;
     
     $display("\n DATA 3");
     send(8'hFF);
     repeat(20) @(posedge clk);
     $display("received = %h", data_out);
     #1000;
     
     $display("\n DATA 4");
     send(8'h00);
     repeat(20) @(posedge clk);
     $display("received = %h", data_out);
     #1000;
     
     $finish;
   end
endmodule
     
     

