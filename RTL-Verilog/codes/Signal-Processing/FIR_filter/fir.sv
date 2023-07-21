module fir #(
  parameter N=49,                 // tap length
  parameter infile="/home/hp/Documents/FIR_axi/src/h_bin.dat",   // coefficient
  parameter W_in=16,              // input word length
  parameter W_in_F=14,
  parameter W_out=W_in+N,             // output word length
  parameter W_coef=16             // coefficient width
) (
  input clk,
  input resetn,
  input signed [W_in-1:0] t_data_in,
  input t_valid_in,
  output t_ready,  
  //output [W_out-1:0] out_data,
    output signed [W_in-1:0] out_data,

  output out_valid
  );

reg signed [W_coef-1:0] h_tap[N-1:0];
initial $readmemb(infile, h_tap);   // initialize filter coefficient

reg signed [W_in-1:0] x_buff[N-1:0];
reg dout_valid_reg;
reg filter_mode=0;

// Buffering input
genvar iin;
for (iin = 0; iin < N; iin++) begin
    always @(posedge clk) begin
        if (!resetn)
        begin 
            x_buff[iin]<=0;
        end
        else if (t_valid_in) 
        begin
            if (iin == 0)  
            begin
                x_buff[iin] <= t_data_in;
            end
            else  
            begin        
                x_buff[iin] <= x_buff[iin - 1]; 
            end
        end
    end
end    

// FSM for buffering
localparam S0 = 'd0;    // reset state
localparam S1 = 'd1;    // reading mode
reg [2:0] state, n_state;
reg n_s_tready,s_tready;
assign t_ready=s_tready;

always @(posedge clk) begin
    if (~resetn) begin
        state <= S0;
        s_tready<=0;
        filter_mode=0;
        dout_valid_reg<=0;
    end else if (t_valid_in) begin
        state <= n_state;
        s_tready <= n_s_tready;
        filter_mode=1;
        dout_valid_reg<=1;
    end
end

always @(*) begin
    // Defaults
    //n_s_tready = s_tready                   ;
    // Conditional:
    case (state)
        S0: begin   // reset
            if (t_valid_in) begin n_state = S1; n_s_tready=1;end
            else begin n_state = S0; n_s_tready=0; end
        end
        S1: begin    // filtering mode
            n_state = S1; 
            n_s_tready=1; 
            end                
        default: begin
            n_state = S0;n_s_tready=0;
        end
    endcase
end

// multiplications and rounding
reg signed [W_in+W_coef-1:0] temp [N-1:0];
reg signed [W_in-1:0] prod[N-1:0];
//reg [W_out-1:0] sum;
reg signed [80:0] sum;


always_comb begin
for (integer ip = 0; ip < N; ip++) begin   
    if (!resetn) begin prod[ip]=0;  end
    else if (filter_mode) begin
    temp[ip] = x_buff[ip]*h_tap[ip];                 // fp Q(W_in+W_coe).(W_in_F+W_coe_F) Full width required
   // prod[ip]=temp[W_in_F+W_in-1:W_in_F];       // fp Q(W_in).W_in_F truncating
    end
end 
end

always_comb 
begin  
  sum<=0;
  /*
  for (integer isum = 0; isum < N; isum++) begin  
    sum=sum+temp[isum];                           // fp Q(W_in+N).W_in_F full width 
    */
    sum <= temp[0] + temp[1]+temp[2]+temp[3]+temp[4]+temp[5]+temp[6]+temp[7]+temp[8]+temp[9]+temp[10]+temp[11]+temp[12]+
    temp[13]+temp[14]+temp[15]+temp[16]+temp[17]+temp[18]+temp[19]+temp[20]+temp[21]+temp[22]+temp[23]+temp[24]+temp[25]+temp[26]+
    temp[27]+temp[28]+temp[29]+temp[30]+temp[31]+temp[32]+temp[33]+temp[34]+temp[35]+temp[36]+temp[37]+temp[38]+temp[39]+temp[40]+
    temp[41]+temp[42]+temp[43]+temp[44]+temp[45]+temp[46]+temp[47]+temp[48]; 
     
  end
//end
assign out_data=sum[W_in + W_in_F -1 : W_in_F];
assign out_valid=dout_valid_reg;
endmodule
