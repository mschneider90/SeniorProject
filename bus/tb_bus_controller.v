`timescale 1ns / 1ps

module tb_bus_controller();

reg [7:0] req;
wire [7:0] ack;
reg clk;

BusController controller(.req(req), .clk(clk), .ack(ack));

initial begin
    req <= 0;
    clk <= 0;
end

initial begin
    #10
    req <= 1; //Device 1 requests
    #10
    req <= 3; //Device 2 requests in conflict with Device 1
    #10
    req <= 2; //Device 1 finishes, should transfer ack to Device 2
    #30
    req <= 3; //Device 1 requests in conflict with Device 2. Even though it's higher priority,
              //should remain ACKed to device 2
    #10
    req <= 0; //No device
    #20
    req <= 3; //Device 1 and 2 REQ at the same time. Device 1 has higher priority so it should
              //get the ACK
    #10
    req <= 0;
end

always begin
    #5 clk = ~clk;
end



endmodule
