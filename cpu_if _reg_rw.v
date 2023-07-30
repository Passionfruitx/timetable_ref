module rw_field #(
    parameter WD   = 32,
    parameter RST  = {WD{1'b0}},
    parameter MODE = 0 //rtl first, cpu next
)(
    input  clk,
    input  rst_n,
 
    input  cpu_en,
    input  cpu_w_en,
    input  [WD -1:0]cpu_wdata,

    output [WD -1:0]rdata
);

wire cpu_wen = cpu_en && cpu_w_en;
wire [WD -1:0]wdata = cpu_wdata;

reg [WD -1:0]field;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        field <= RST;
    else if(cpu_wen)
        field <= wdata;
end
assign rdata = field;
 
endmodule

module rc_cnt_field #(
    parameter WD   = 32,
    parameter RST  = {WD{1'b0}},
    parameter MAX  = {WD{1'b1}},
    parameter MODE = 0//0 for hold, 1 for to-zero
)(
    input  clk,
    input  rst_n,
 
    input  cpu_en,
    input  cpu_r_en,
 
    input  rtl_wen,
 
    output [WD -1:0]rdata
);
 
wire cpu_ren = cpu_en && cpu_r_en;
 
reg [WD -1:0]field;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        field <= RST;
    else if(cpu_ren && rtl_wen)
        field <= {{(WD-1){1'b0}}, 1'b1};
    else if(rtl_wen && field == MAX)
        field <= RST;
    else if(rtl_wen)
        field <= field + 1'b1;
    else if(cpu_ren)
        field <= RST;
end
assign rdata = field;
endmodule

module ro_field #(
    parameter WD   = 32,
    parameter RST  = {WD{1'b0}},
    parameter MODE = 0 //rtl first, cpu next
)(
    input  clk,
    input  rst_n,
 
    input  rtl_wen,
    input  [WD -1:0]rtl_wdata,
 
    output [WD -1:0]rdata
);
 
reg [WD -1:0]field;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        field <= RST;
    else if(rtl_wen)
        field <= rtl_wdata;
end
 
assign rdata = field;
 
endmodule