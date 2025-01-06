module RandStim(
    input tb_HCLK ,tb_HREADY,
    input [31:0] tb_HRDATA,
    output reg tb_HRESET,tb_HWRITE,tb_HSEL,
    output reg [31:0] tb_HWDATA,tb_HADDR

    );



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


    task RandomGenerator;
        begin 
            tb_HSEL = $urandom_range(0, 1);       
            tb_HWRITE = $urandom_range(0, 1);    
            tb_HADDR = $urandom();               
            tb_HWDATA = $urandom();              

            
            $fwrite(file, "Time: %0t | tb_HSEL: %b | tb_HWRITE: %b | tb_HADDR: %h | tb_HWDATA: %h\n",
                    $time, tb_HSEL, tb_HWRITE, tb_HADDR, tb_HWDATA);

           
            //while (!tb_HREADY) @(posedge tb_HCLK);
        end
    endtask
    integer file;  
    initial begin
        file   =   $fopen("D:Daneshgah/Master/Term 4031/Verfication/Tamrin3/output.txt","w");

        initialize_and_Reset();

        #50;

       
        repeat (20) begin
            RandomGenerator();
            #50;
        end
       
        
        $fclose(file);
    end


endmodule