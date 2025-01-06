
module sdram_top_tb();

    // Testbench signals
    reg        clock;
    wire        tb_HRESET;
    wire        tb_HWRITE;
    wire        tb_HSEL;
    wire [31:0] tb_HWDATA;
    wire [31:0] tb_HADDR;
    
    wire        tb_HREADY;
    wire [31:0] tb_HRDATA;
    wire [31:0] golden_HRDATA;
    wire error;
    wire [31:0] coverage;

    //............
    //wire [31:0] WriteData = 32'h49856712;
    //reg [31:0] ReadData;
    Stim stim(
        .tb_HCLK(clock),
        .tb_HREADY(tb_HREADY),
        .tb_HRESET(tb_HRESET),
        .tb_HWRITE(tb_HWRITE),
        .tb_HSEL(tb_HSEL),
        .tb_HWDATA(tb_HWDATA),
        .tb_HADDR(tb_HADDR),
        .tb_HRDATA(tb_HRDATA)
        );
    // RandStim randstim(
    //     .tb_HCLK(clock),
    //     .tb_HREADY(tb_HREADY),
    //     .tb_HRESET(tb_HRESET),

    //     .tb_HWRITE(tb_HWRITE),
    //     .tb_HSEL(tb_HSEL),
    //     .tb_HWDATA(tb_HWDATA),
    //     .tb_HADDR(tb_HADDR),
    //     .tb_HRDATA(tb_HRDATA)
    //     );
    golden_model GoldenModel(
        .tb_HCLK(clock),
        .tb_HRESET(tb_HRESET),
        .tb_HSEL(tb_HSEL),
        .tb_HWRITE(tb_HWRITE),
        .tb_HADDR(tb_HADDR),
        .tb_HWDATA(tb_HWDATA),
        .golden_HRDATA(golden_HRDATA)
    );
    // Instance of design under test
    sdram_top DUT(
        .in_HCLK(clock),
        .in_HRESET(tb_HRESET),
        .in_HWRITE(tb_HWRITE),
        .in_HSEL(tb_HSEL),
        .in_HWDATA(tb_HWDATA),
        .in_HADDR(tb_HADDR),
        .out_HREADY(tb_HREADY),
        .out_HRDATA(tb_HRDATA)
    );

    checker Checker(
        .clk(clock),
        .reset(tb_HRESET),
        .golden_HRDATA(golden_HRDATA),
        .duv_HRDATA(tb_HRDATA),
        .error_detected(error)
    );

    scoreboard ScoreBoard(
        .clk(clock),
        .reset(tb_HRESET),
        .golden_HRDATA(golden_HRDATA),
        .duv_HRDATA(tb_HRDATA),
        .tb_HADDR(tb_HADDR),
        .tb_HWDATA(tb_HWDATA),
        .tb_HSEL(tb_HSEL),
        .tb_HWRITE(tb_HWRITE),
        .coverage(coverage)
    );
    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end
    
        //                               [31:31] 2 bits    [29:25] 5 bits  [24:16] 9 bits    [15:14] 2 bits  [13:0] 14 bits 
			// ADRESS DECODING: [31:0] ==>       10              bbbbb          bbbbbbbbb             bb         bbbbbbbbbbbbbb
			//                             Memory mapped I/O    INVALID        COLUMN ADRESS      BANK ADRESS      ROW ADRESS
    
    // Test stimulus
    initial begin

       
        // // Initialize signals
        // tb_HRESET = 1;
        // tb_HWRITE = 0;
        // tb_HSEL = 0;
        // tb_HWDATA = 32'h0;
        // tb_HADDR = 32'h0;
        
        // // Reset period
        // #100;
        // tb_HRESET = 0;
        // #20;
        // //First Senario (Write And Read)
        // // Write operation
        // $display("Starting Write Operation at time %0t", $time);
        // @(posedge tb_HCLK);
        // tb_HSEL = 1;
        // tb_HWRITE = 1;    // Write = 1
        // tb_HWDATA = WriteData;
        // tb_HADDR = 32'h80000000;  // Bank 0, Row 0, Column 0
        
        // // Wait for HREADY to assert
        // while (!tb_HREADY) @(posedge tb_HCLK);
        
        // // Deassert signals
        // @(posedge tb_HCLK);
        // tb_HSEL = 0;
        // tb_HWRITE = 0;
        // tb_HWDATA = 32'h0;
        // tb_HADDR = 32'h0;
        
        // // Wait a few cycles
        // #50;
        
        // // Read operation
        // $display("Starting Read Operation at time %0t", $time);
        // @(posedge tb_HCLK);
        // tb_HSEL = 1;
        // tb_HWRITE = 0;  // Read = 0
        // tb_HADDR = 32'h80000000;  // Same address as write
        // ReadData = tb_HRDATA;

        // if(WriteData == ReadData) $display("First Senario is Done");
        
       
        
        
    end
    
    

endmodule