module Stim(
    input tb_HCLK ,tb_HREADY,
    input [31:0] tb_HRDATA,
    output reg tb_HRESET,tb_HWRITE,tb_HSEL,
    output reg [31:0] tb_HWDATA,tb_HADDR
    //output CMD_VLD , 
    //output [3:0] CMD , 
    //output [31:0] DATA_IN ,CMD_ADDR,
   // output [7:0] CMD_TAG_IN,
    );
    //Generator genarator(.clk(CLK),.WriteData(WriteData).Address(Address));

    task initialize_and_Reset;
        begin
           tb_HRESET = 1;
        tb_HWRITE = 0;
        tb_HSEL = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        
        // Reset period
        #100;
        tb_HRESET = 0;
        #20; 
        end
    endtask

    task Sen1_Writing;
        begin
         
        
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'h000f0100;
        tb_HADDR = 32'h000f0100;  
        
        // Wait for HREADY to assert
        //while (!tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
        // Deassert signals 
        #50;

        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        end
    endtask
    task Sen2_writing_4word;
        begin
         
        
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'hfff000ff;
        tb_HADDR = 32'h0f0a0c05;  
        
        // Wait for HREADY to assert
        //while (!tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
        
        #50

        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'hffabfc00;
        tb_HADDR = 32'h5d00a0f0;  
        
        // Wait for HREADY to assert
        //while (!tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
 
        #50;
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'hffabfc01;
        tb_HADDR = 32'h80f0f020;  
        
        // Wait for HREADY to assert
        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
        
        #50;

        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'hffabfc02;
        tb_HADDR = 32'h8fff0210;  
        
        // Wait for HREADY to assert
        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
        
        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        end

    endtask
    task Sen3_reading;
        begin
             
        
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h000f0100; 

        //while (!tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        

        end
    endtask

    
    task Sen4_reading_4Word;
        begin
             
        
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h0f0a0c05; 

        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50

        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h5d00a0f0; 

        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h80f0f020; 

        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h8fff0210; 

        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        end
    endtask

    task Sen5_Timming_Writing;
        begin
           // $display("Start of Write %0t", $time);
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;    
        tb_HWDATA = 32'hfff00fff;
        tb_HADDR = 32'h80f0f0f0;  
        
        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);
        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
        //$display("End Of Write %0t", $time);
        end
    endtask
    task Sen6_Timming_reading;
        begin
          //  $display("Start of Read %0t", $time);
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h80f0f0f0; 

        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);

        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;
       // $display("End Of Read %0t", $time);
        end
    endtask
    
    task Sen7_Error_InvalidReading;
         begin
             
        
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 0;  
        tb_HADDR = 32'h811x1111; 
        
        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;

         end

    endtask

    task Sen8_Error_InvalidWriting;
        begin
        @(posedge tb_HCLK);
        tb_HSEL = 1;
        tb_HWRITE = 1;   
        tb_HWDATA = 32'hffffffff;
        tb_HADDR = 32'h811x1111;  
        
        // Wait for HREADY to assert
        //while (tb_HREADY) @(posedge tb_HCLK);
        $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);

        #50;
        tb_HSEL = 0;
        tb_HWRITE = 0;
        tb_HWDATA = 32'h0;
        tb_HADDR = 32'h0;

        
        end
    endtask

    task Sen9_WriteAndRead;
        begin
             @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 1;   
            tb_HWDATA = 32'hffffffff;
            tb_HADDR = 32'h80000006;  
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);

            //...
            #50;

             @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 0;  
            tb_HADDR = 32'h80000006; 

            //while (!tb_HREADY) @(posedge tb_HCLK);
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
            #50;
            tb_HSEL = 0;
            tb_HWRITE = 0;
            tb_HWDATA = 32'h0;
            tb_HADDR = 32'h0;

        end

    endtask

        task Sen10_WriteAndRead2;
        begin
             @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 1;   
            tb_HWDATA = 32'hffffffff;
            tb_HADDR = 32'h00000101;  
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);

            //...
            #50;

             @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 0;  
            tb_HWDATA = 32'h0;
            tb_HADDR = 32'h00000101; 

            //while (!tb_HREADY) @(posedge tb_HCLK);
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
            #50;
            @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 1;   
            tb_HWDATA = 32'h5f7f6ff8;
            tb_HADDR = 32'h0000000f;  
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HWDATA: %h\n", $time, tb_HREADY, tb_HWDATA);

            //...
            #50;

             @(posedge tb_HCLK);
            tb_HSEL = 1;
            tb_HWRITE = 0;  
            tb_HWDATA = 32'h0;
            tb_HADDR = 32'h0000000f; 

            //while (!tb_HREADY) @(posedge tb_HCLK);
            $fwrite(file, "Time: %0t | tb_HREADY: %b | tb_HRDATA: %h\n", $time, tb_HREADY, tb_HRDATA);
            #50;
            tb_HSEL = 0;
            tb_HWRITE = 0;
            tb_HWDATA = 32'h0;
            tb_HADDR = 32'h0;

        end

    endtask
    integer file;  
    //Generator genarator();
    initial begin
        file   =   $fopen("D:Daneshgah/Master/Term 4031/Verfication/Tamrin2/sdram/sdram/rtl/output.txt","w");
        //$fwrite(file,"Starting initialize_and_Reset %0t \n", $time);
        initialize_and_Reset();
        //$fwrite(file,"Ending initialize_and_Reset %0t \n", $time);
        #20;
        Sen10_WriteAndRead2();
        #20
        Sen9_WriteAndRead();
        #20
        Sen1_Writing();
        //$fwrite(file,"Ending Sen1_Writing %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen1_Writing %0t \n", $time);
        Sen3_reading();
        //$fwrite(file,"Ending Sen3_reading %0t \n", $time);
        #20;
        Sen1_Writing();
        //$fwrite(file,"Ending Sen1_Writing %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen2_writing_4word %0t \n", $time);
        Sen2_writing_4word();
        //$fwrite(file,"Ending Sen2_writing_4word %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen3_reading %0t \n", $time);
        Sen3_reading();
        //$fwrite(file,"Ending Sen3_reading %0t \n", $time);
        #20;
       // $fwrite(file,"Starting Sen4_reading_4Word %0t \n", $time);
        Sen4_reading_4Word();
        //$fwrite(file,"Ending Sen4_reading_4Word %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen5_Timming_Writing %0t \n", $time);
        Sen5_Timming_Writing();
        //$fwrite(file,"Ending Sen5_Timming_Writing %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen6_Timming_reading %0t \n", $time);
        Sen6_Timming_reading();
        //$fwrite(file,"Ending Sen6_Timming_reading %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen7_Error_InvalidReading %0t \n", $time);
        Sen7_Error_InvalidReading();
        //$fwrite(file,"Ending Sen7_Error_InvalidReading %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen8_Error_InvalidWriting %0t \n", $time);
        Sen8_Error_InvalidWriting();
        //$fwrite(file,"Ending Sen8_Error_InvalidWriting %0t \n", $time);
        #20;
        //$fwrite(file,"Starting Sen9_WriteAndRead %0t \n", $time);
        Sen9_WriteAndRead();
        //$fwrite(file,"Ending Sen9_WriteAndRead %0t \n", $time);
        #50;
        //$fwrite(file,"The End %0t \n", $time);
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

        // //if(WriteData == ReadData) $display("First Senario is Done");
        
       
        
        
    end


endmodule
