module scoreboard (
    input clk,
    input reset,
    input [31:0] golden_HRDATA,
    input [31:0] duv_HRDATA,
    input [31:0] tb_HADDR,
    input [31:0] tb_HWDATA,
    input tb_HSEL,
    input tb_HWRITE,
    output reg [31:0] coverage
);

    reg [31:0]total_tests;
    reg [31:0]passed_tests;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            total_tests <= 0;
            passed_tests <= 0;
            coverage <= 0;
        end else begin
            if (tb_HSEL) begin
                total_tests <= total_tests + 1;
                if (golden_HRDATA === duv_HRDATA) begin
                    passed_tests <= passed_tests + 1;
                end
                coverage <= (passed_tests * 100) / total_tests;
            end
        end
    end

endmodule
