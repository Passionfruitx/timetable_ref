module cpu_if(
    //{{{interface
    input             clk_50m              ,
    input             rst_core_n           ,
    input             scan_en              ,
    input             test_mode            ,
    
    output            cpuif_mode           ,//配置CPU的工作模式
    output            cpuif_port_sel       ,//配置CPU的端口选择A/B
    input             spt_cpuif_head_err   ,
    input             spt_cpuif_tail_err   ,
    input             spt_cpuif_short_pkt  ,
    input             spt_cpuif_long_pkt   ,
    input             spt_cpuif_ok_pkt     ,
    
    output            cpuif_core_test_start,
    output            cpuif_core_test_end  ,
    output [31:0]     ok_pkt_cnt           ,
    input             core_cpuif_d_err     ,
    input             core_cpuif_a_err     ,
    input             core_cpuif_s_end     ,
    input             core_cpuif_s_busy    ,
    output [23:0]     cpuif_core_test_00   ,//测试内部表象，16个，位宽24
    output [23:0]     cpuif_core_test_01   ,
    output [23:0]     cpuif_core_test_02   ,
    output [23:0]     cpuif_core_test_03   ,
    output [23:0]     cpuif_core_test_04   ,
    output [23:0]     cpuif_core_test_05   ,
    output [23:0]     cpuif_core_test_06   ,
    output [23:0]     cpuif_core_test_07   ,
    output [23:0]     cpuif_core_test_08   ,
    output [23:0]     cpuif_core_test_09   ,
    output [23:0]     cpuif_core_test_10   ,
    output [23:0]     cpuif_core_test_11   ,
    output [23:0]     cpuif_core_test_12   ,
    output [23:0]     cpuif_core_test_13   ,
    output [23:0]     cpuif_core_test_14   ,
    output [23:0]     cpuif_core_test_15   ,
    
    input             CPU_CS_N             ,
    input             CPU_RD_N             ,
    input             CPU_WE_N             ,
    input  [15:0]     CPU_ADDR             ,
    output reg[31:0]  CPU_RDATA            ,
    input  [31:0]     CPU_WDATA            ,
    output            CPU_RDY_N            
    //}}}
);
 
// ------------------------------------------------------------
// parameter and wire declare
// ------------------------------------------------------------
//{{{
localparam PORT_SEL_ADDR            = 16'h4000;
localparam MODE_SEL_ADDR            = 16'h4004;
localparam SPT_HEAD_ERR_CNT_ADDR    = 16'h4100;
localparam SPT_TAIL_ERR_CNT_ADDR    = 16'h4104;
localparam SPT_SHT_PKT_CNT_ADDR     = 16'h4108;
localparam SPT_LNG_PKT_CNT_ADDR     = 16'h410C;
localparam SPT_OK_PKT_CNT_ADDR      = 16'h4110;
localparam TEST_DATA0_ADDR          = 16'h8000;
localparam TEST_STATUS_ADDR         = 16'h8100;
localparam TEST_ALARM_ADDR          = 16'h8200;
 
//reg signal
wire reg_port_sel_cpu_en;
wire reg_port_sel_cpu_rdata;
 
wire reg_mode_sel_cpu_en;
wire reg_mode_sel_cpu_rdata;
 
wire reg_spt_head_err_cnt_cpu_en;
wire [31:0]reg_spt_head_err_cnt_rdata;
 
wire reg_spt_tail_err_cnt_cpu_en;
wire [31:0]reg_spt_tail_err_cnt_rdata;
 
wire reg_spt_sht_pkt_cnt_cpu_en;
wire [31:0]reg_spt_sht_pkt_cnt_rdata;
 
wire reg_spt_lng_pkt_cnt_cpu_en;
wire [31:0]reg_spt_lng_pkt_cnt_rdata;
 
wire reg_spt_ok_pkt_cnt_cpu_en;
wire [31:0]reg_spt_ok_pkt_cnt_rdata;
 
wire [15:0]reg_test_data_cpu_en;
wire [23:0]reg_test_data[16];
 
wire reg_test_status_rtl_wen;
wire [1:0]reg_test_status_a, reg_test_status_b;
wire [3:0]reg_test_status_rdata;
 
wire reg_test_alarm_cpu_en;
wire reg_test_alarm_rtl_wen;
wire [3:0]reg_test_alarm_rtl_wdata;
wire [3:0]reg_test_alarm_rdata;
//}}}
 
// ------------------------------------------------------------
// cpu if async
// ------------------------------------------------------------
//{{{
reg cpu_cs_n_ff1, cpu_cs_n_ff2;
reg cpu_rd_n_ff1, cpu_rd_n_ff2, cpu_rd_n_ff3, cpu_rd_n_ff4;
reg cpu_we_n_ff1, cpu_we_n_ff2, cpu_we_n_ff3, cpu_we_n_ff4;
 
always @(posedge clk_50m or negedge rst_core_n)begin
    if(!rst_core_n) begin
        cpu_cs_n_ff1 <= 1'b1;
        cpu_cs_n_ff2 <= 1'b1;
        cpu_rd_n_ff1 <= 1'b1;
        cpu_rd_n_ff2 <= 1'b1;
        cpu_rd_n_ff3 <= 1'b1;
        cpu_rd_n_ff4 <= 1'b1;
        cpu_we_n_ff1 <= 1'b1;
        cpu_we_n_ff2 <= 1'b1;
        cpu_we_n_ff3 <= 1'b1;
        cpu_we_n_ff4 <= 1'b1;
    end
    else begin
        cpu_cs_n_ff1 <= CPU_CS_N;
        cpu_cs_n_ff2 <= cpu_cs_n_ff1;
        cpu_rd_n_ff1 <= CPU_RD_N;
        cpu_rd_n_ff2 <= cpu_rd_n_ff1;
        cpu_rd_n_ff3 <= cpu_rd_n_ff2;
        cpu_rd_n_ff4 <= cpu_rd_n_ff3;
        cpu_we_n_ff1 <= CPU_WE_N;
        cpu_we_n_ff2 <= cpu_we_n_ff1;
        cpu_we_n_ff3 <= cpu_we_n_ff2;
        cpu_we_n_ff4 <= cpu_we_n_ff3;
    end
end
 
//CPU_RDY_N
reg [2:0]cpu_rdy_status;
always @(posedge clk_50m or negedge rst_core_n)begin
    if(!rst_core_n)begin
        cpu_rdy_status <= 3'b0;
    end
    else begin
        case(cpu_rdy_status)
            3'd0: begin//CPU_RDY_N = 0
                if(!cpu_cs_n_ff2 && !CPU_RDY_N) cpu_rdy_status <= 3'd1;
            end
            3'd1: begin//CPU_RDY_N = 1
                if(!cpu_rd_n_ff4)      cpu_rdy_status <= 3'd2;
                else if(!cpu_we_n_ff4) cpu_rdy_status <= 3'd3;
            end
            3'd2: begin//CPU_RDY_N = 0
                if(cpu_rd_n_ff2) cpu_rdy_status <= 3'd4;
            end
            3'd3: begin//CPU_RDY_N = 0
                if(cpu_we_n_ff2) cpu_rdy_status <= 3'd4;
            end
            3'd4: begin//CPU_RDY_N = 1
                if(cpu_cs_n_ff2) cpu_rdy_status <= 3'd0;
            end
            default: cpu_rdy_status <= cpu_rdy_status;
        endcase
    end
end
 
assign CPU_RDY_N = (cpu_rdy_status == 3'd0 || cpu_rdy_status == 3'd2 || cpu_rdy_status == 3'd3) ? 1'b0 : 1'b1;
//read and write power
wire cpu_r_en = (cpu_rd_n_ff2 == 1'b0 && cpu_rd_n_ff3 == 1'b1);
wire cpu_w_en = (cpu_we_n_ff2 == 1'b0 && cpu_we_n_ff3 == 1'b1);
wire cpu_en    = cpu_r_en || cpu_w_en;
wire [31:0]cpu_r_data = ((CPU_ADDR == PORT_SEL_ADDR)         ? {31'b0, reg_port_sel_cpu_rdata} : 32'b0) |
                        ((CPU_ADDR == MODE_SEL_ADDR)         ? {31'b0, reg_mode_sel_cpu_rdata} : 32'b0) |
                        ((CPU_ADDR == SPT_HEAD_ERR_CNT_ADDR) ? reg_spt_head_err_cnt_rdata : 32'b0)      |
                        ((CPU_ADDR == SPT_TAIL_ERR_CNT_ADDR) ? reg_spt_tail_err_cnt_rdata : 32'b0)      |
                        ((CPU_ADDR == SPT_SHT_PKT_CNT_ADDR)  ? reg_spt_sht_pkt_cnt_rdata : 32'b0)       |
                        ((CPU_ADDR == SPT_LNG_PKT_CNT_ADDR)  ? reg_spt_lng_pkt_cnt_rdata : 32'b0)       |
                        ((CPU_ADDR == SPT_OK_PKT_CNT_ADDR)   ? reg_spt_ok_pkt_cnt_rdata : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*0)   ? {8'b0, reg_test_data[0]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*1)   ? {8'b0, reg_test_data[1]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*2)   ? {8'b0, reg_test_data[2]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*3)   ? {8'b0, reg_test_data[3]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*4)   ? {8'b0, reg_test_data[4]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*5)   ? {8'b0, reg_test_data[5]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*6)   ? {8'b0, reg_test_data[6]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*7)   ? {8'b0, reg_test_data[7]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*8)   ? {8'b0, reg_test_data[8]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*9)   ? {8'b0, reg_test_data[9]} : 32'b0)        |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*10)  ? {8'b0, reg_test_data[10]} : 32'b0)       |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*11)  ? {8'b0, reg_test_data[11]} : 32'b0)       |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*12)  ? {8'b0, reg_test_data[12]} : 32'b0)       |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*13)  ? {8'b0, reg_test_data[13]} : 32'b0)       |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*14)  ? {8'b0, reg_test_data[14]} : 32'b0)       |
                        ((CPU_ADDR == TEST_DATA0_ADDR+4*15)  ? {8'b0, reg_test_data[15]} : 32'b0)       |
                        ((CPU_ADDR == TEST_STATUS_ADDR)      ? {28'b0, reg_test_status_rdata} : 32'b0)  |
                        ((CPU_ADDR == TEST_ALARM_ADDR)       ? {28'b0,reg_test_alarm_rdata} : 32'b0)    ;
 
always @(posedge clk_50m or negedge rst_core_n)begin
    if(!rst_core_n)begin
        CPU_RDATA <= 32'b0;
    end
    else if(cpu_r_en)begin
        CPU_RDATA <= cpu_r_data;
    end
end
//}}}
// ------------------------------------------------------------
// reg inst
// ------------------------------------------------------------
//{{{
//PORT_SEL
assign reg_port_sel_cpu_en = (CPU_ADDR == PORT_SEL_ADDR) && cpu_en;
rw_field #(.WD(1))
u_reg_port_sel(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_port_sel_cpu_en),
    .cpu_w_en   (cpu_w_en),
    .cpu_wdata  (CPU_WDATA[1]),
    .rtl_wen    (1'b0),
    .rtl_wdata  (1'b0),
    .rdata      (reg_port_sel_cpu_rdata)
);
//MODE_SEL
assign reg_mode_sel_cpu_en = (CPU_ADDR == MODE_SEL_ADDR) && cpu_en;
rw_field #(.WD(1))
u_reg_mode_sel(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_mode_sel_cpu_en),
    .cpu_w_en   (cpu_w_en),
    .cpu_wdata  (CPU_WDATA[1]),
    .rtl_wen    (1'b0),
    .rtl_wdata  (1'b0),
    .rdata      (reg_mode_sel_cpu_rdata)
);
//SPT_HEAD_ERR_CNT
assign reg_spt_head_err_cnt_cpu_en = (CPU_ADDR == SPT_HEAD_ERR_CNT_ADDR) && cpu_en;
rc_cnt_field
u_reg_spt_head_err_cnt(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_spt_head_err_cnt_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (spt_cpuif_head_err),
    .rdata      (reg_spt_head_err_cnt_rdata)
);
//SPT_TAIL_ERR_CNT
assign reg_spt_tail_err_cnt_cpu_en = (CPU_ADDR == SPT_TAIL_ERR_CNT_ADDR) && cpu_en;
rc_cnt_field
u_reg_spt_tail_err_cnt(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_spt_tail_err_cnt_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (spt_cpuif_head_err),
    .rdata      (reg_spt_tail_err_cnt_rdata)
);
//SPT_SHT_PKT_CNT
assign reg_spt_sht_pkt_cnt_cpu_en = (CPU_ADDR == SPT_SHT_PKT_CNT_ADDR) && cpu_en;
rc_cnt_field
u_reg_spt_sht_pkt_cnt(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_spt_sht_pkt_cnt_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (spt_cpuif_head_err),
    .rdata      (reg_spt_sht_pkt_cnt_rdata)
);
//SPT_LNG_PKT_CNT
assign reg_spt_lng_pkt_cnt_cpu_en = (CPU_ADDR == SPT_LNG_PKT_CNT_ADDR) && cpu_en;
rc_cnt_field
u_reg_spt_lng_pkt_cnt(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_spt_lng_pkt_cnt_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (spt_cpuif_head_err),
    .rdata      (reg_spt_lng_pkt_cnt_rdata)
);
//SPT_OK_PKT_CNT
assign reg_spt_ok_pkt_cnt_cpu_en = (CPU_ADDR == SPT_OK_PKT_CNT_ADDR) && cpu_en;
rc_cnt_field
u_reg_spt_ok_pkt_cnt(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_spt_ok_pkt_cnt_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (spt_cpuif_head_err),
    .rdata      (reg_spt_ok_pkt_cnt_rdata)
);
//TEST_DATA0~15
localparam TEST_DATA_RST = {
    24'h5f_5f5f,
    24'hfa_fafa,
    24'hf5_f5f5,
    24'haf_afaf,
    24'h50_5050,
    24'h05_0505,
    24'ha0_a0a0,
    24'h0a_0a0a,
    24'ha5_a5a5,
    24'h5a_5a5a,
    24'haa_aaaa,
    24'h55_5555,
    24'hf0_f0f0,
    24'h0f_0f0f,
    24'hff_ffff, 
    24'h00_0000};
genvar i;
generate
    for(i=0; i<16; i=i+1)begin: TEST_DATA_REG
        assign reg_test_data_cpu_en[i] = (CPU_ADDR == TEST_DATA0_ADDR+i*4) && cpu_en;
        rw_field #(.WD(24), .RST(TEST_DATA_RST[i*24 +:24]))
        u_reg_test_data(
            .clk        (clk_50m),
            .rst_n      (rst_core_n),
            .cpu_en     (reg_test_data_cpu_en[i]),
            .cpu_w_en   (cpu_w_en),
            .cpu_wdata  (CPU_WDATA[23:0]),
            .rtl_wen    (1'b0),
            .rtl_wdata  (24'b0),
            .rdata      (reg_test_data[i])
        );
    end
endgenerate
//TEST_STATUS
assign reg_test_status_rtl_wen = core_cpuif_s_end || cpuif_core_test_start || cpuif_core_test_end;
assign reg_test_status_a       = cpuif_port_sel ? reg_test_status_rdata[3:2] :
                                 cpuif_core_test_start ? 2'b01 :
                                 cpuif_core_test_end ? 2'b00 :
                                 core_cpuif_s_end ? 2'b10 : reg_test_status_rdata[3:2];
assign reg_test_status_b       = !cpuif_port_sel ? reg_test_status_rdata[1:0] :
                                 cpuif_core_test_start ? 2'b01 :
                                 cpuif_core_test_end ? 2'b00 :
                                 core_cpuif_s_end ? 2'b10 : reg_test_status_rdata[1:0];
ro_field #(.WD(4))
u_reg_test_status(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .rtl_wen    (reg_test_status_rtl_wen),
    .rtl_wdata  ({reg_test_status_a, reg_test_status_b}),
    .rdata      (reg_test_status_rdata)
);
//TEST_ALARM
assign reg_test_alarm_cpu_en = (CPU_ADDR == TEST_ALARM_ADDR) && cpu_en;
assign reg_test_alarm_rtl_wen = core_cpuif_d_err || core_cpuif_d_err;
assign alarm_data_err_a =  cpuif_port_sel ? reg_test_alarm_rdata[0] : core_cpuif_d_err;
assign alarm_addr_err_a =  cpuif_port_sel ? reg_test_alarm_rdata[1] : core_cpuif_a_err;
assign alarm_data_err_b = !cpuif_port_sel ? reg_test_alarm_rdata[2] : core_cpuif_d_err;
assign alarm_addr_err_b = !cpuif_port_sel ? reg_test_alarm_rdata[3] : core_cpuif_a_err;
rc_field #(.WD(4))
u_reg_test_alarm(
    .clk        (clk_50m),
    .rst_n      (rst_core_n),
    .cpu_en     (reg_test_alarm_cpu_en),
    .cpu_r_en   (cpu_r_en),
    .rtl_wen    (reg_test_alarm_rtl_wen),
    .rtl_wdata  ({alarm_addr_err_b, alarm_data_err_b ,alarm_addr_err_a, alarm_data_err_a}),
    .rdata      (reg_test_alarm_rdata)
);
//}}}
// ------------------------------------------------------------
// to rtl
// ------------------------------------------------------------
//{{{
assign cpuif_mode            = reg_mode_sel_cpu_rdata;
assign cpuif_port_sel        = reg_port_sel_cpu_rdata;
assign cpuif_core_test_start = (cpu_w_en && CPU_WDATA[7:0] == 8'h55);
assign cpuif_core_test_end   = (cpu_w_en && CPU_WDATA[7:0] == 8'haa);
assign ok_pkt_cnt            = reg_spt_ok_pkt_cnt_rdata;
assign cpuif_core_test_00    = reg_test_data[0];
assign cpuif_core_test_01    = reg_test_data[1];
assign cpuif_core_test_02    = reg_test_data[2];
assign cpuif_core_test_03    = reg_test_data[3];
assign cpuif_core_test_04    = reg_test_data[4];
assign cpuif_core_test_05    = reg_test_data[5];
assign cpuif_core_test_06    = reg_test_data[6];
assign cpuif_core_test_07    = reg_test_data[7];
assign cpuif_core_test_08    = reg_test_data[8];
assign cpuif_core_test_09    = reg_test_data[9];
assign cpuif_core_test_10    = reg_test_data[10];
assign cpuif_core_test_11    = reg_test_data[11];
assign cpuif_core_test_12    = reg_test_data[12];
assign cpuif_core_test_13    = reg_test_data[13];
assign cpuif_core_test_14    = reg_test_data[14];
assign cpuif_core_test_15    = reg_test_data[15];
//}}}
endmodule
