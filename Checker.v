module checker (
    input clk,
    input reset,
    input [31:0] golden_HRDATA,
    input [31:0] duv_HRDATA,
    output reg error_detected
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            error_detected <= 1'b0;
        end else begin
            if (golden_HRDATA !== duv_HRDATA) begin
                error_detected <= 1'b1;
                $display("Error Detected at time %0t | Golden: %h | DUV: %h", $time, golden_HRDATA, duv_HRDATA);
            end else begin
                error_detected <= 1'b0;
            end
        end
    end

endmodule
