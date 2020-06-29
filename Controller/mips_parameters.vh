
// states
parameter IF = 4'b0000, // Instruction Fetch
			ID = 4'b0001, // Instruction Decode 
			Mem_Ex = 4'b0010, // 
			Mem_RD = 4'b0011, // Read memory
			LW_WB = 4'b0100,
			Mem_W = 4'b0101, // Write memory
			R_Exe = 4'b0110, // Execute R type
			R_WB = 4'b0111, // R type writeback
			Beq_Exe = 4'b1000, 
			J = 4'b1001, // jump
			I_Exe = 4'b1010, // Execute I type
			I_WB = 4'b1011, // I type writeback
			Lui_WB = 4'b1100, 
			Bne_Exe = 4'b1101,
			Jr = 4'b1110, // jump register
			Jal = 4'b1111; // 
			
// define datapath signal output for states
parameter value_IF		= 18'b100101000001000001,
			value_ID			= 18'b000000000011000000,
			value_Mem_Ex	= 18'b000000000010100000,
			value_Mem_RD	= 18'b001100000010100001,
			value_LW_WB		= 18'b000000010000010000,
			value_Mem_WD	= 18'b001010000010100001,
			value_R_Exe		= 18'b000000000000100000,
			value_R_WB		= 18'b000000000000110100,
			value_Beq_Exe	= 18'b010000000100100010,
			value_J			= 18'b100000001011000000,
			value_I_Exe		= 18'b000000000010100000,
			value_I_WB		= 18'b000000000010110000,
			value_Lui_WB	= 18'b000000100011010000,
			value_Bne_Exe	= 18'b000000000100100000,
			value_Jr			= 18'b100000000000100000,
			value_Jal		= 18'b100000111011011000;
			
// define ALU opcode
parameter AND	= 4'b0000,
			OR 	= 4'b0001,
			ADD	= 4'b0010,
			SUB	= 4'b0110,
			NOR	= 4'b0100,
			SLT	= 4'b0111,
			XOR	= 4'b1000,
			SLL	= 4'b0011, // A as data, B as payload
			SRL	= 4'b0101;

