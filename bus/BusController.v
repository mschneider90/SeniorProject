`timescale 1ns / 1ps

module BusController #(parameter NUM_DEVICES = 8,
                       parameter BUS_WIDTH = 32,
                       parameter CTRL_WIDTH = 8)
                      (input clk, 
                       input  [NUM_DEVICES-1:0] req,
                       output [NUM_DEVICES-1:0] master_ack,
                       output [NUM_DEVICES-1:0] slave_en,
                       input  [CTRL_WIDTH-1:0] ctrl_in_0,
                       input  [CTRL_WIDTH-1:0] ctrl_in_1,
                       input  [CTRL_WIDTH-1:0] ctrl_in_2,
                       input  [CTRL_WIDTH-1:0] ctrl_in_3,
                       input  [CTRL_WIDTH-1:0] ctrl_in_4,
                       input  [CTRL_WIDTH-1:0] ctrl_in_5,
                       input  [CTRL_WIDTH-1:0] ctrl_in_6,
                       input  [CTRL_WIDTH-1:0] ctrl_in_7,
                       output [CTRL_WIDTH-1:0] ctrl_out,                       
                       input  [BUS_WIDTH-1:0] bus_in_0,
                       input  [BUS_WIDTH-1:0] bus_in_1,
                       input  [BUS_WIDTH-1:0] bus_in_2,
                       input  [BUS_WIDTH-1:0] bus_in_3,
                       input  [BUS_WIDTH-1:0] bus_in_4,
                       input  [BUS_WIDTH-1:0] bus_in_5,
                       input  [BUS_WIDTH-1:0] bus_in_6,
                       input  [BUS_WIDTH-1:0] bus_in_7,                       
                       output [BUS_WIDTH-1:0] bus_out);
                       
// Bus Control signals are defined as:
// Wait: ctrl[0]
// WE  : ctrl[1]
// Burst: ctrl[4:2]
// Reserved: ctrl[7:5]
wire we;
assign we = ctrl_out[1];
wire [2:0] burst;
assign burst = ctrl_out[4:2];

// Stores the slave device
reg writeSlaveDevice;
reg resetSlaveDevice;
wire [NUM_DEVICES-1:0] slaveDeviceEn;
wire [NUM_DEVICES-1:0] device_en;
d_reg #(.WIDTH(NUM_DEVICES))slaveDevice(.clk(clk),
                  .en(writeSlaveDevice),
                  .reset(resetSlaveDevice),
                  .d(device_en),
                  .q(slaveDeviceEn));
                  
// Stores whether or not the transfer is a write
reg writeWriteTransfer;
wire isWriteTransfer;
d_reg #(.WIDTH(1)) isWriteTransferReg
                 (.clk(clk),
                  .en(writeWriteTransfer),
                  .reset(0),
                  .d(we),
                  .q(isWriteTransfer));


// Stores the burst length
wire [2:0] burstLength;
reg writeBurstLength;
d_reg #(.WIDTH(3)) burstLengthReg
                 (.clk(clk),
                  .en(writeBurstLength),
                  .reset(0),
                  .d(burst),
                  .q(burstLength));
                       
// In the case of multiple REQs at the same time, this chooses one based on 
// a simple priority
wire [NUM_DEVICES-1:0] pri_out;
reg pri_en;
reg pri_reset;
PriorityGen pri(.pri_in(req),
                .clk(clk),
                .en(pri_en),
                .reset(pri_reset),
                .pri_out(pri_out));

// Captures the master that initiated the transfer
reg writeInitiatingDevice;
wire [NUM_DEVICES-1:0] initiatingDevice;
d_reg #(.WIDTH(NUM_DEVICES)) initiatingDeviceReg 
       (.clk(clk),
        .en(writeInitiatingDevice),
        .reset(0),
        .d(pri_out),
        .q(initiatingDevice));
     
// There are two possible devices that need to control the bus
//   a. The master which initiated the transfer
//   b. The slave which is sending data back to master, in the case of a read transfer
// This mux selects between the two   
reg busControl; 
wire [NUM_DEVICES-1:0] bus_mux_sel;      
mux21 bus_mux_in(.in_a(slaveDeviceEn),  //ACK from stored address
              .in_b(pri_out),   //ACK from priority encoder
              .sel(busControl),
              .out(bus_mux_sel));
                   
//Bus control mux
parameter MASTER = 1;
parameter SLAVE = 0;
    
// The main mux that controls access to the bus    
wire [BUS_WIDTH-1:0] bus_mux_out;    
BusMux #(.D_WIDTH(BUS_WIDTH)) bus_mux 
               (.in_0(bus_in_0),
                .in_1(bus_in_1),
                .in_2(bus_in_2),
                .in_3(bus_in_3),
                .in_4(bus_in_4),
                .in_5(bus_in_5),
                .in_6(bus_in_6),
                .in_7(bus_in_7),
                .sel(bus_mux_sel),
                .out(bus_mux_out));
 
reg ctrlControl;  
wire [NUM_DEVICES-1:0] ctrl_mux_sel;    
mux21 ctrl_mux(.in_a(slaveDeviceEn),  
               .in_b(pri_out),   
               .sel(ctrlControl),
               .out(ctrl_mux_sel));  
               
// 11/23 - separate master and slave ack
assign slave_en = slaveDeviceEn;
assign master_ack = pri_out;               
                
// Controls access to the control signal bus 
wire [NUM_DEVICES-1:0] ctrl_mux_out;
BusMux #(.D_WIDTH(CTRL_WIDTH)) bus_ctrl_mux 
                (.in_0(ctrl_in_0),
                 .in_1(ctrl_in_1),
                 .in_2(ctrl_in_2),
                 .in_3(ctrl_in_3),
                 .in_4(ctrl_in_4),
                 .in_5(ctrl_in_5),
                 .in_6(ctrl_in_6),
                 .in_7(ctrl_in_7),
                 .sel(ctrl_mux_sel),
                 .out(ctrl_mux_out));
                 
// Data on the bus can either be an address or data. If it's an address, we need
// it to go through the BusAddressTranslator. If not, it's sent straight through.
wire [BUS_WIDTH-1:0] phys_addr;
wire [BUS_WIDTH-1:0] addr_mux_out;
reg addr_mux_sel;    
mux21 addr_mux (.in_a(phys_addr),
                .in_b(bus_mux_out),
                .sel(addr_mux_sel),
                .out(addr_mux_out));

// Holds the address for one cycle longer so that the slave can see it
reg[BUS_WIDTH-1:0] previousData;
reg sel_current;
always@(posedge clk) begin
    previousData <= bus_out;
end
mux21 #(.D_WIDTH(BUS_WIDTH)) final_bus_mux
       (.in_a(previousData),
        .in_b(addr_mux_out),
        .sel(sel_current),
        .out(bus_out));
 
// Used to assert "WAIT" and "WE" (maybe) while the slave device is ACKed 
parameter FORCE_WAIT = 1;
parameter ORIGINAL_CTRL = 0;
reg ctrlOutMuxSel;
mux21 #(.D_WIDTH(CTRL_WIDTH)) ctrl_out_mux 
       (.in_a(ctrl_mux_out),
        .in_b({3'b000, burstLength, isWriteTransfer, 1'b1}),
        .sel(ctrlOutMuxSel),
        .out(ctrl_out));
   
parameter ADDR = 0;
parameter DATA = 1;

// Translates addresses from the unified virtual address space to each device's
// physical address space
BusAddressTranslator bat(.virtual_addr(bus_mux_out), 
                         .phys_addr(phys_addr),
                         .device_en(device_en));
                         
wire [7:0] reqDropped;
assign reqDropped = initiatingDevice & req;

wire didReqDrop;
assign didReqDrop = (reqDropped == 0)? 1:0;
                         
// States                  
reg [2:0] currentState;
reg [2:0] nextState;

parameter STATE_IDLE = 0;
parameter STATE_ACK = 1;
parameter STATE_ADDR = 2;
parameter STATE_ACK_SLAVE = 3;
parameter STATE_BUSY = 4;
parameter STATE_FINISH = 5;

initial begin
    currentState <= 0;
    nextState <= 0;
end

always@(posedge clk) begin
    currentState <= nextState;
end

// State Machine Outputs
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            busControl <= MASTER;
            ctrlControl <= MASTER;
            addr_mux_sel <= ADDR;
            writeSlaveDevice <= 0;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 1;
            sel_current <= 1;
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 0;
            pri_reset <= 0;
        end
        STATE_ACK: begin
            busControl <= MASTER;
            ctrlControl <= MASTER;
            addr_mux_sel <= ADDR;
            writeSlaveDevice <= 0;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 0;
            sel_current <= 1;
            writeInitiatingDevice <= 1;
            writeBurstLength <= 1;
            writeWriteTransfer <= 1;
            pri_reset <= 0;
        end
        STATE_ADDR: begin
            //isWriteTransfer <= we;
            
            busControl <= MASTER;
            ctrlControl <= MASTER;
            addr_mux_sel <= ADDR;
            writeSlaveDevice <= 1;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 0;
            sel_current <= 1;
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 0;
            pri_reset <= 0;
        end
        STATE_ACK_SLAVE: begin
            busControl <= MASTER;
            ctrlControl <= SLAVE;
            addr_mux_sel <= DATA;
            writeSlaveDevice <= 0;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= FORCE_WAIT;
            pri_en <= 0;
            sel_current <= 0; // hold address for slave device to see
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 0;
            pri_reset <= 0;
        end
        STATE_BUSY: begin
            if (isWriteTransfer) begin
                busControl <= MASTER;
            end
            else begin 
                busControl <= SLAVE;
            end
            ctrlControl <= SLAVE;
            
            addr_mux_sel <= DATA;
            writeSlaveDevice <= 0;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 0;
            sel_current <= 1;
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 0;
            pri_reset <= 0;
        end
        STATE_FINISH: begin
            if (isWriteTransfer) begin
                busControl <= MASTER;
            end
            else begin 
                busControl <= SLAVE;
            end
            ctrlControl <= SLAVE;

            addr_mux_sel <= DATA;
            resetSlaveDevice <= 1;
            writeSlaveDevice <= 0;
            sel_current <= 1;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 1;
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 1;
            pri_reset <= 1;
        end
        default: begin //shouldn't happen
            busControl <= MASTER;
            ctrlControl <= MASTER;
            addr_mux_sel <= ADDR;
            writeSlaveDevice <= 0;
            resetSlaveDevice <= 0;
            ctrlOutMuxSel <= ORIGINAL_CTRL;
            pri_en <= 1;
            sel_current <= 1;
            writeInitiatingDevice <= 0;
            writeBurstLength <= 0;
            writeWriteTransfer <= 0;
            pri_reset <= 0;
        end
    endcase
end
      
// Next state logic      
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (req != 0) begin
                nextState <= STATE_ACK;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_ACK: begin
            nextState <= STATE_ADDR;
        end
        STATE_ADDR: begin
            nextState <= STATE_ACK_SLAVE;
        end
        STATE_ACK_SLAVE: begin
            nextState <= STATE_BUSY;
        end
        STATE_BUSY: begin
            // Check to see if the initiating device has dropped its REQ flag
            // e.g., initiatingDevice = 0010
            //       current req = 1001
            // initiatingDevice & req = 0000 -> back to idle
            if (didReqDrop) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_BUSY;
            end
        end
        STATE_FINISH: begin
            nextState <= STATE_IDLE;
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

endmodule
