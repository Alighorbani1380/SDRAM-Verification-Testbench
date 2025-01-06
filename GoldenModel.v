module golden_model (
    input  tb_HCLK,
    input  tb_HRESET,
    input  tb_HSEL,
    input  tb_HWRITE,
    input  [31:0] tb_HADDR,
    input  [31:0] tb_HWDATA,
    output reg [31:0] golden_HRDATA
);

    reg [31:0] memory [0:1][0:16384][0:512]; 

    reg [16384:0] row_addr;
    reg [512:0] col_addr;
    reg [1:0] bank_addr;
    reg [31:0] HoldData;


    reg [3:0] state, next_state;
    localparam IDLE       = 4'b0000,
               READ_ACT   = 4'b0001,
               READ_NOP1  = 4'b0010, 
               READ_CAS   = 4'b0011, 
               READ_NOP2  = 4'b0100, 
               READ_DATA  = 4'b0101,
               WRITE_ACT  = 4'b0110,
               WRITE_NOP1 = 4'b0111, 
               WRITE_CAS  = 4'b1000,
               WRITE_NOP2 = 4'b1001, 
               WRITE_DATA = 4'b1010;



    always @(posedge tb_HCLK or posedge tb_HRESET) begin
        if (tb_HRESET) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;


        case (state)
            IDLE: begin
                if (tb_HSEL && !tb_HWRITE) begin
                    next_state = READ_ACT; 
                    row_addr = tb_HADDR[13:0];
                    bank_addr = tb_HADDR[15:14];
                    HoldData = tb_HWDATA;
                end else if (tb_HSEL && tb_HWRITE) begin
                    next_state = WRITE_ACT;
                    row_addr = tb_HADDR[13:0];
                    bank_addr = tb_HADDR[15:14];
                    HoldData = tb_HWDATA;

                end
            end

            READ_ACT: begin
                next_state = READ_NOP1;
                col_addr = tb_HADDR[24:16];
            end

            READ_NOP1: begin
                next_state = READ_CAS; 
            end

            READ_CAS: begin
                next_state = READ_NOP2; 
            end

            READ_NOP2: begin
                next_state = READ_DATA;
            end

            READ_DATA: begin

                golden_HRDATA = memory[bank_addr][row_addr][col_addr];
                next_state = IDLE;
            end

            WRITE_ACT: begin
                next_state = WRITE_NOP1;
            end

            WRITE_NOP1: begin
                next_state = WRITE_CAS;
            end

            WRITE_CAS: begin
                next_state = WRITE_NOP2; 
                col_addr = tb_HADDR[24:16];
            end

            WRITE_NOP2: begin
                next_state = WRITE_DATA;
            end

            WRITE_DATA: begin
                memory[bank_addr][row_addr][col_addr] = HoldData;
                next_state = IDLE;
            end
        endcase
    end

endmodule
