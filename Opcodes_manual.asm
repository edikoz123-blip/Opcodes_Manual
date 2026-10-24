; =================================================================
; OPCODES.ASM - Instruction Set Architecture (ISA) Map
; Target Architecture: x86_64 (Intel VT-x & AMD-V Cross-Compatible)
; =================================================================

; =================================================================
; SECTION 1: ARCHITECTURAL PREFIXES
; =================================================================
REX_W_PREFIX         EQU 0x48    ; REX.W prefix - Enforces 64-bit operand size

; =================================================================
; SECTION 2: DATA MOVEMENT OPCODES (MOV)
; =================================================================
OPCODE_MOV_RM8_REG8   EQU 0x88    ; MOV r/m8, reg8   - Move 8-bit register to register/memory
OPCODE_MOV_RM_REG     EQU 0x89    ; MOV r/m64, r64   - Move 64-bit register to register/memory
OPCODE_MOV_REG_RM     EQU 0x8B    ; MOV r64, r/m64   - Move 64-bit register/memory to register
OPCODE_MOV_REG_IMM8   EQU 0xB0    ; MOV reg8, imm8   - Move immediate 8-bit value to register
OPCODE_MOV_REG_IMM    EQU 0xB8    ; MOV reg64, imm64 - Move immediate 64-bit value to register

; =================================================================
; SECTION 3: ARITHMETIC & LOGIC OPCODES (ALU)
; =================================================================
; --- Standard Arithmetic ---
OPCODE_ADD_RM_REG    EQU 0x01    ; ADD r/m64, r64   - Integer Addition
OPCODE_SUB_RM_REG    EQU 0x29    ; SUB r/m64, r64   - Integer Subtraction
OPCODE_CMP_RM_REG    EQU 0x39    ; CMP r/m64, r64   - Compare Operands (Sets Flags)

; --- Logical Operands (Symmetric Bitwise Matrices) ---
OPCODE_AND_RM8_REG8   EQU 0x20    ; AND r/m8, reg8   - Logical AND (8-bit)
OPCODE_AND_RM_REG     EQU 0x21    ; AND r/m64, r64   - Logical AND (64-bit)
OPCODE_AND_REG_RM     EQU 0x23    ; AND r64, r/m64   - Logical AND (Load mode)

OPCODE_OR_RM8_REG8    EQU 0x08    ; OR r/m8, reg8    - Logical OR (8-bit)
OPCODE_OR_RM_REG      EQU 0x09    ; OR r/m64, r64    - Logical OR (64-bit)
OPCODE_OR_REG_RM      EQU 0x0B    ; OR r64, r/m64    - Logical OR (Load mode)

OPCODE_XOR_RM8_REG8   EQU 0x30    ; XOR r/m8, reg8   - Logical XOR (8-bit)
OPCODE_XOR_RM_REG     EQU 0x31    ; XOR r/m64, r64   - Logical XOR (64-bit)
OPCODE_XOR_REG_RM     EQU 0x33    ; XOR r64, r/m64   - Logical XOR (Load mode)

; =================================================================
; SECTION 4: CONTROL FLOW & BRANCHING
; =================================================================
; --- Unconditional Jumps & Calls ---
OPCODE_JMP_SHORT     EQU 0xEB    ; JMP rel8  - Short jump (1-byte relative offset)
OPCODE_JMP_NEAR      EQU 0xE9    ; JMP rel32 - Near jump (4-byte relative offset)
OPCODE_JMP_INDIRECT  EQU 0xFF    ; JMP /4    - Absolute indirect jump via reg/mem
OPCODE_CALL_NEAR     EQU 0xE8    ; CALL rel32 - Near relative function call

; --- Conditional Jumps (Short Forms) ---
OPCODE_JE_SHORT      EQU 0x74    ; JZ/JE rel8   - Jump if Zero / Equal
OPCODE_JNE_SHORT     EQU 0x75    ; JNZ/JNE rel8  - Jump if Not Zero / Not Equal
OPCODE_JG_SHORT      EQU 0x7F    ; JG rel8    - Jump if Greater (Signed)
OPCODE_JL_SHORT      EQU 0x7C    ; JL rel8    - Jump if Less (Signed)

; =================================================================
; SECTION 5: SYSTEM & KERNEL OPERATION CONTROL
; =================================================================
OPCODE_TEST_RM_REG   EQU 0x85    ; TEST r/m64, r64 - Non-destructive bit test (Sets flags)
OPCODE_NOP           EQU 0x90    ; NOP - No Operation (Used for boundary alignment)
OPCODE_SYSCALL       EQU 0x050F  ; SYSCALL - Native OS/Kernel interface (0F 05)
OPCODE_RET           EQU 0xC3    ; RET - Near return to calling procedure

; --- Hypervisor Control Registers Interface ---
OPCODE_MOV_REG_CR    EQU 0x200F  ; MOV r64, crX - Read Control Register (0F 20)
OPCODE_MOV_CR_REG    EQU 0x220F  ; MOV crX, r64 - Write Control Register (0F 22)

; =================================================================
; SECTION 6: GENERAL PURPOSE REGISTERS MAP (GPR)
; Standard 3-bit hardware identifiers used in ModR/M and opcode extensions
; =================================================================
; --- Legacy Base Registers ---
REG_RAX              EQU 0       ; 000b - Accumulator
REG_RCX              EQU 1       ; 001b - Counter
REG_RDX              EQU 2       ; 010b - Data
REG_RBX              EQU 3       ; 011b - Base
REG_RSP              EQU 4       ; 100b - Stack Pointer
REG_RBP              EQU 5       ; 101b - Base Pointer
REG_RSI              EQU 6       ; 110b - Source Index
REG_RDI              EQU 7       ; 111b - Destination Index

; --- Extended R8-R15 Registers (Requires REX.B bit validation) ---
REG_R8               EQU 0       ; 000b with extension bit active
REG_R9               EQU 1       ; 001b with extension bit active
REG_R10              EQU 2       ; 010b with extension bit active
REG_R11              EQU 3       ; 011b with extension bit active
REG_R12              EQU 4       ; 100b with extension bit active
REG_R13              EQU 5       ; 101b with extension bit active
REG_R14              EQU 6       ; 110b with extension bit active
REG_R15              EQU 7       ; 111b with extension bit active

; =================================================================
; SECTION 7: CONTROL REGISTERS MAP (CR)
; =================================================================
CR_CR0               EQU 0       ; CR0 - System Control (Protected Mode, Paging execution)
CR_CR3               EQU 3       ; CR3 - Page Directory Base (Pointer to PML4 page table)
CR_CR4               EQU 4       ; CR4 - Architectural Extensions (VMXE authorization bit)

;===================================================================
;							 PTX
;===================================================================

// Most of it is Intel opcodes I will probably need to orginaze everything 

// =================================================================
// OPCODES.PTX - Instruction Set Architecture (ISA) Map
// Target Architecture: x86_64 (Intel VT-x & AMD-V Cross-Compatible)
// Compiled for NVIDIA GPU Execution / Clean Tokenizer Definitions
// =================================================================

// --- REX Prefix Family (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: REX prefixes (0x40 to 0x4F) are only available in 64-bit mode. 
// They are used to enforce 64-bit operand sizes and to access the extended registers (R8-R15).

// Enforces 64-bit operand size (Overrides default 32-bit behavior in 64-bit mode)
#define REX_W_PREFIX         0x48    // REX.W  - Enforces 64-bit operand size

// Extension of the ModR/M 'reg' field. Required to access extended registers R8-R15 as destination/source
#define REX_R_PREFIX         0x44    // REX.R  - Extension of the ModR/M 'reg' field for extended registers

// Extension of the SIB 'index' field. Required to use extended registers R8-R15 as index in memory addressing
#define REX_X_PREFIX         0x42    // REX.X  - Extension of the SIB 'index' field for extended registers

// Extension of the ModR/M 'r/m' field or SIB 'base' field. Required to use R8-R15 as base registers
#define REX_B_PREFIX         0x41    // REX.B  - Extension of the ModR/M 'r/m' field for extended registers


// --- Legacy Size Overrides (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Used to override default operand or address sizes within the 64-bit pipeline.

// Forces the CPU to interpret operand data as 16-bit instead of the default 32-bit width
#define PREFIX_OPERAND_SIZE  0x66    // 0x66   - Operand-size override prefix (Forces 16-bit operations)

// Forces the CPU to compute memory addressing calculations using a 32-bit address width instead of 64-bit RIP/RSP
#define PREFIX_ADDRESS_SIZE  0x67    // 0x67   - Address-size override prefix (Forces 32-bit linear address math)


// --- Segment Register Overrides (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: In 64-bit mode, nullifies CS, DS, ES, SS segment math. However, FS and GS remain 
// fully active as base pointers for specialized OS structures (Thread Local Storage, Kernel Contexts).

// Forces memory access relative to the FS segment base pointer register
#define PREFIX_FS_OVERRIDE   0x64    // 0x64   - FS segment override prefix (Essential for Thread Local Storage)

// Forces memory access relative to the GS segment base pointer register (Extensively used for OS Kernel structures)
#define PREFIX_GS_OVERRIDE   0x65    // 0x65   - GS segment override prefix (Essential for Kernel Mode context tracking)


// --- Hardware Repeat Prefixes / String Loops (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Forces the execution unit to repeat subsequent string/memory operations 
// automatically, decrementing the RCX register count until conditions are met.

// Repeats instruction while Zero Flag (ZF) == 1 AND RCX != 0. Used for fast automated memory/string operations
#define PREFIX_REPZ_REPE     0xF3    // 0xF3   - REP/REPE/REPZ prefix (Repeat while Equal / Zero)

// Repeats instruction while Zero Flag (ZF) == 0 AND RCX != 0. Used for hardware-accelerated memory scanning
#define PREFIX_REPNZ_REPNE   0xF2    // 0xF2   - REPNE/REPNZ prefix (Repeat while Not Equal / Not Zero)

// --- Modern Vector Encoding Prefixes (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: These are multi-byte prefixes that replace legacy prefixes (like 0x66, REX)
// to eliminate instruction length overhead and enable AVX/AVX-512 instruction decoding.

// 2-Byte VEX Prefix: Used for standard AVX instructions to select 128/256-bit registers instantly
#define PREFIX_VEX_2BYTE     0xC5        // VEX (2-byte) - Encodes REX and operand size for AVX execution

// 3-Byte VEX Prefix: Extends the 2-byte version to allow advanced memory addressing alterations
#define PREFIX_VEX_3BYTE     0xC4        // VEX (3-byte) - Enables full extended register mapping for AVX

// 4-Byte EVEX Prefix: The ultimate vector prefix. Designed by Intel and fully adopted by modern AMD.
// It is mandatory for AVX-512 execution, encoding vector lengths, opmask registers, and embedded rounding control.
#define PREFIX_EVEX_4BYTE    0x62        // EVEX (4-byte) - Vector extension prefix for 512-bit register control

// =================================================================
// SECTION 2: DATA MOVEMENT OPCODES (MOV)
// =================================================================
// [Intel & AMD Cross-Compatible]
// Copies 8-bit (1 Byte) data from a general-purpose register to another register 
// or directly into a physical memory address pointed to by a register. Highly useful 
// for streaming INT8 quantized neural network weights to optimize memory footprint.
#define OPCODE_MOV_RM8_REG8  0x88    // MOV r/m8, reg8   - Move 8-bit register to register/memory

// [Intel & AMD Cross-Compatible]
// Copies 64-bit data from a source register to a destination register or memory address 
// (under REX.W validation). This instruction moves data from the internal register file 
// outwards to memory arrays or alternative execution registers.
#define OPCODE_MOV_RM_REG    0x89    // MOV r/m64, r64   - Move 64-bit register to register/memory

// [Intel & AMD Cross-Compatible]
// Inverse data movement operation. Copies 64-bit data from a source register or a physical 
// memory address into a destination register. Critical for loading pointers, matrix base addresses, 
// and dynamic tensor variables into active CPU registers for immediate execution.
#define OPCODE_MOV_REG_RM    0x8B    // MOV r64, r/m64   - Move 64-bit register/memory to register

// [Intel & AMD Cross-Compatible]
// Loads an immediate 8-bit literal constant value directly into a specific target register. 
// The register identifier is embedded into the opcode byte itself, minimizing code size and 
// skipping memory bus cycles by reading the constant straight from the instruction prefetch stream.
#define OPCODE_MOV_REG_IMM8  0xB0    // MOV reg8, imm8   - Move immediate 8-bit value to register

// [Intel & AMD Cross-Compatible]
// Loads a native 64-bit immediate literal constant or memory address pointer directly into 
// a general-purpose register. Essential for initializing base layer dimensions, matrix stride 
// layouts, and structural variables during the bare-metal AI boot routine.
#define OPCODE_MOV_REG_IMM   0xB8    // MOV reg64, imm64 - Move immediate 64-bit value to register

// --- Immediate Value To Memory/Register Direct Stores (Intel & AMD Cross-Compatible) ---

// [Intel & AMD Cross-Compatible]
// Moves an 8-bit immediate literal value directly into a destination register or a physical memory address context.
// Bypasses the need to allocate an intermediate execution register during cell initialization.
#define OPCODE_MOV_RM8_IMM8  0xC6        // MOV r/m8, imm8   - Move immediate 8-bit value to register/memory

// [Intel & AMD Cross-Compatible]
// Moves a signed 32-bit immediate literal value directly into a 64-bit register or memory pointer context.
// Under REX.W execution, the 32-bit constant is sign-extended automatically to a full 64-bit width.
#define OPCODE_MOV_RM64_IMM32 0xC7       // MOV r/m64, imm32 - Move immediate 32-bit signed value to 64-bit reg/mem


// --- Sign-Extension Movement Opcodes (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Reads a smaller signed data format and loads it into a wider register, 
// automatically replicating the sign bit across the high-order bits to preserve numeric value integrity.

// [Intel & AMD Cross-Compatible]
// Reads an 8-bit signed memory location or register and extends it into a full 64-bit general-purpose register.
// Crucial when synchronizing raw INT8 quantized neural activation states with deep 64-bit index layers.
#define OPCODE_MOVSX_R64_RM8 0x0FBE      // MOVSX r64, r/m8  - Move 8-bit signed value to 64-bit register with sign-extension

// [Intel & AMD Cross-Compatible]
// Reads a 32-bit signed memory location or register and expands it natively into a 64-bit general-purpose destination.
// Standard micro-architectural mechanism to promote 32-bit integer grid coordinates into the 64-bit flat address matrix.
#define OPCODE_MOVSXD_R64_RM32 0x63      // MOVSXD r64, r/m32 - Move 32-bit signed value to 64-bit register with sign-extension


// --- Zero-Extension Movement Opcodes (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Reads a smaller data width and shifts it into a wider register, 
// forcing all upper unused bits to be strictly cleared to zero. Prevents register space pollution.

// [Intel & AMD Cross-Compatible]
// Reads an 8-bit unsigned source and loads it into a 64-bit target register, zeroing out the remaining 56 bits.
// Essential for loading isolated character masks or boolean status flags straight into execution loops.
#define OPCODE_MOVZX_R64_RM8 0x0FB6      // MOVZX r64, r/m8  - Move 8-bit unsigned value to 64-bit register with zero-extension

// [Intel & AMD Cross-Compatible]
// Reads a 16-bit unsigned source and shifts it into a 64-bit target register, forcing the upper 48 bits to zero.
// Extensively used when loading localized 16-bit hardware port metrics or compressed tensor offsets.
#define OPCODE_MOVZX_R64_RM16 0x0FB7     // MOVZX r64, r/m16 - Move 16-bit unsigned value to 64-bit register with zero-extension

// --- Conditional Data Movement Opcodes (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: CMOVcc instructions transfer a 64-bit value from a source register/memory 
// to a destination register ONLY if the specified condition is met in RFLAGS. Prevents branch misprediction.

// Transers data if the Zero Flag (ZF) is set to 1. Vital for assignments based on matrix element equality limits.
#define OPCODE_CMOVE_R64_RM64 0x0F44     // CMOVE/CMOVZ r64, r/m64 - Conditional Move if Equal / Zero

// Transfers data if the Zero Flag (ZF) is cleared to 0. Heavily used to assign dynamic scaling fallback biases.
#define OPCODE_CMOVNE_R64_RM64 0x0F45    // CMOVNE/CMOVNZ r64, r/m64 - Conditional Move if Not Equal / Not Zero

// Transfers data based on signed comparison flags (SF == OF). Used for capping layers with signed thresholds.
#define OPCODE_CMOVGE_R64_RM64 0x0F4D    // CMOVGE r64, r/m64 - Conditional Move if Greater or Equal (Signed)

// Transfers data based on signed comparison flags (SF != OF). Essential for upper-bound element extraction limits.
#define OPCODE_CMOVLE_R64_RM64 0x0F4E    // CMOVLE r64, r/m64 - Conditional Move if Less or Equal (Signed)

// Transfers data if the Carry Flag (CF) is set to 1. Direct hardware assignment tracking unsigned numeric underflows.
#define OPCODE_CMOVB_R64_RM64  0x0F42    // CMOVB/CMOVC r64, r/m64 - Conditional Move if Below / Carry (Unsigned)

// --- Atomic Data Exchange & Swapping (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Swaps data between two locations. When combined with memory targets, it implies 
// an atomic hardware bus lock, making it vital for secure multi-threaded neural weight synchronization.

// Atomically exchanges the contents of a 64-bit general-purpose register with another register or memory block.
#define OPCODE_XCHG_RM64_R64  0x87       // XCHG r/m64, r64 - Exchange register/memory contents natively

// =================================================================
// SECTION 3: ARITHMETIC & LOGIC OPCODES (ALU)
// =================================================================
// --- Standard Arithmetic ---

// [Intel & AMD Cross-Compatible]
// Computes native 64-bit binary integer addition. Adds the operand value from the source register 
// to the destination register/memory space and stores the resulting sum in the destination. 
// Used heavily for index tracking, memory offset generation, and pointer arithmetic.
#define OPCODE_ADD_RM_REG    0x01    // ADD r/m64, r64   - Integer Addition

// [Intel & AMD Cross-Compatible]
// Computes native 64-bit binary integer subtraction. Subtracts the source register value 
// from the target destination register or memory address, storing the final difference in the destination. 
// Used for bounds checking, loop counters, and dynamic allocation management.
#define OPCODE_SUB_RM_REG    0x29    // SUB r/m64, r64   - Integer Subtraction

// [Intel & AMD Cross-Compatible]
// Performs an arithmetic comparison by executing a non-destructive subtraction (SUB) between 
// the two targeted operands. The resulting value is discarded and never saved, but the operation 
// updates the status bits in the RFLAGS register (e.g., Zero Flag, Sign Flag, Carry Flag) to control branches.
#define OPCODE_CMP_RM_REG    0x39    // CMP r/m64, r64   - Compare Operands (Sets Flags)
// --- Logical Operands (Symmetric Bitwise Matrices) ---

// [Intel & AMD Cross-Compatible]
// Performs a bitwise logical AND operation on 8-bit (1 Byte) operands. Computes the intersection 
// of bit-fields between a source register and a destination register or memory address. 
// Frequently used for clearing specific flags or verifying isolated byte-level states.
#define OPCODE_AND_RM8_REG8  0x20    // AND r/m8, reg8   - Logical AND (8-bit)

// [Intel & AMD Cross-Compatible]
// Computes a native 64-bit bitwise logical AND between a source register and a destination register/memory area 
// (under REX.W validation). Used for multi-bit masking operations, stripping pointers, and structure alignment checks.
#define OPCODE_AND_RM_REG    0x21    // AND r/m64, r64   - Logical AND (64-bit)

// [Intel & AMD Cross-Compatible]
// Inverse 64-bit logical AND encoding (Load mode). Loads data from a source register or memory location, 
// executes a bitwise AND against the target register, and updates the target register directly.
#define OPCODE_AND_REG_RM    0x23    // AND r64, r/m64   - Logical AND (Load mode)

// [Intel & AMD Cross-Compatible]
// Computes a bitwise logical OR operation on 8-bit operands. Blends or combines bit configurations 
// from a register into a target register or memory location. Used to set specific bit flags.
#define OPCODE_OR_RM8_REG8   0x08    // OR r/m8, reg8    - Logical OR (8-bit)

// [Intel & AMD Cross-Compatible]
// Executes a 64-bit bitwise logical OR between a source register and a destination register/memory area. 
// Vital for constructing large data structures, bitwise indexing, or pooling bit matrices.
#define OPCODE_OR_RM_REG     0x09    // OR r/m64, r64    - Logical OR (64-bit)

// [Intel & AMD Cross-Compatible]
// Inverse 64-bit logical OR encoding (Load mode). Computes a bitwise OR by parsing memory or register data 
// into a destination general-purpose register, keeping the instruction pipeline saturated.
#define OPCODE_OR_REG_RM     0x0B    // OR r64, r/m64    - Logical OR (Load mode)

// [Intel & AMD Cross-Compatible]
// Computes a bitwise logical Exclusive OR (XOR) on 8-bit operands. Flips targeted bits based on a mask 
// or evaluates parity differentials across neural network quantized layers.
#define OPCODE_XOR_RM8_REG8  0x30    // XOR r/m8, reg8   - Logical XOR (8-bit)

// [Intel & AMD Cross-Compatible]
// Executes a native 64-bit bitwise XOR operation. A cornerstone of bare-metal optimization; 
// when executed on symmetric identical registers (e.g., XOR RAX, RAX), it acts as a high-speed instruction 
// to zero out a register, bypassing the memory bus entirely without executing an immediate load.
#define OPCODE_XOR_RM_REG    0x31    // XOR r/m64, r64   - Logical XOR (64-bit)

// [Intel & AMD Cross-Compatible]
// Inverse 64-bit logical XOR encoding (Load mode). Loads a bitwise matrix from memory or an external register, 
// XORs it directly into the target register file, and updates status flags.
#define OPCODE_XOR_REG_RM    0x33    // XOR r64, r/m64   - Logical XOR (Load mode)

// --- Advanced Bit Manipulation (BMI1 & BMI2) ---

// [Intel & AMD Cross-Compatible]
// Advanced Bit Manipulation instruction (BMI1). Computes a bitwise logical NOT on the first operand, 
// followed by a bitwise AND against the second operand, storing the result in a destination register. 
// Enables complex masking, bit clearing, and state checking in a single execution cycle.
#define OPCODE_ANDN          0x0F38F2 // ANDN - Logical AND NOT

// [Intel & AMD Cross-Compatible]
// Advanced Bit Field Extract instruction (BMI1). Dynamically extracts a contiguous sequence of bits from a source 
// operand using a layout specified in a control register (index and length). Replaces multi-step shift-and-mask 
// operations, accelerating low-level custom tokenizer indexing and tensor layout parsing.
#define OPCODE_BEXTR         0x0F38F7 // BEXTR - Bit Field Extract (Dynamic bit masking)

// --- Advanced Integer Multiplication & Division (Intel & AMD Cross-Compatible) ---

// [Intel & AMD Cross-Compatible]
// Computes signed binary multiplication of 64-bit operands. Reads from a register/memory target 
// and multiplies it directly into a destination general-purpose register. Essential for scalar scaling.
#define OPCODE_IMUL_REG_RM   0x0FAF      // IMUL r64, r/m64 - Signed Integer Multiplication (Two-operand form)

// [Intel & AMD Cross-Compatible]
// Executes an unsigned or signed division operation. Single-operand form utilizing implicit hardware register couples.
// For 64-bit division, it divides the combined 128-bit value in RDX:RAX by the specified r/m64 operand.
#define OPCODE_DIV_RM64      0xF7        // DIV /6    - Unsigned Division (RAX = Quo, RDX = Rem; Requires ModR/M /6)
#define OPCODE_IDIV_RM64     0xF7        // IDIV /7   - Signed Division (RAX = Quo, RDX = Rem; Requires ModR/M /7)

// --- Non-Destructive Bitwise Testing (Intel & AMD Cross-Compatible) ---

// [Intel & AMD Cross-Compatible]
// Performs a bitwise logical AND between a source register and a destination register or memory address.
// Unlike the standard AND, it discards the result and never changes the destination, but updates RFLAGS (ZF, SF).
// Highly critical for checking bitmasks or status flags in tight loops without destroying active register data.
#define OPCODE_TEST_RM_REG   0x85        // TEST r/m64, r64 - Non-destructive Bit Test (Sets Flags)


// --- Bitwise Shifts & Rotations (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Shifts or rotates the bits within a 64-bit general-purpose register. 
// Uses ModR/M extensions (/4, /5, /7) to determine the exact hardware execution path.

// Shifts bits to the left, filling empty low-order bit spaces with strictly zeros. Equivalent to fast math multiplication by powers of 2.
#define OPCODE_SHL_RM64_CL   0xD3        // SHL r/m64, CL   - Shift Left by count loaded in CL register (Requires ModR/M /4)

// Shifts bits to the right, preserving the sign bit in the highest-order position. Essential for signed division by powers of 2.
#define OPCODE_SAR_RM64_CL   0xD3        // SAR r/m64, CL   - Shift Arithmetic Right by CL register count (Requires ModR/M /7)

// Rotates bits to the right, wrapping the ejected low-order bits back into the high-order spaces. Used in custom crypto hashes.
#define OPCODE_ROR_RM64_CL   0xD3        // ROR r/m64, CL   - Rotate Right by CL register count (Requires ModR/M /1)


// --- Advanced BMI2 Bit Manipulation (Intel Native / AMD Modern Compatibility) ---
// ARCHITECTURE NOTE: Advanced 3-operand instructions that bypass RFLAGS modifications completely.

// Multiplies two 64-bit integers without affecting CPU status flags, preserving pipeline execution flow.
#define OPCODE_MULX          0xF20F38F6  // MULX r64a, r64b, r/m64 - Unsigned Multiply Without Affecting Flags (BMI2)

// Deposits selected bits from a source register into a target register at locations specified by a mask.
// Ultimate weapon for dynamic bit-packing and scattering field parameters into execution frames.
#define OPCODE_PDEP          0xF20F38F5  // PDEP r64a, r64b, r/m64 - Parallel Bit Deposit (BMI2 extension)

// --- Immediate Value ALU Operations (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: These instructions perform operations directly between a register/memory target 
// and an embedded immediate constant value. They utilize ModR/M extensions to route the internal ALU path.

// Adds a signed 32-bit immediate value directly to a 64-bit destination register/memory context.
#define OPCODE_ADD_RM64_IMM32 0x81       // ADD r/m64, imm32 - Integer Addition with Immediate (Requires ModR/M /0)

// Subtracts a signed 32-bit immediate value directly from a 64-bit destination. Ideal for static index loop adjustments.
#define OPCODE_SUB_RM64_IMM32 0x81       // SUB r/m64, imm32 - Integer Subtraction with Immediate (Requires ModR/M /5)

// Performs a non-destructive comparison between a register/memory target and a 32-bit immediate value, updating RFLAGS.
#define OPCODE_CMP_RM64_IMM32 0x81       // CMP r/m64, imm32 - Compare target with Immediate (Requires ModR/M /7)


// --- Monodic Logical & Arithmetic Shifts (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Single-operand operations that manipulate data structure values natively inside the register file.

// Computes the twos complement of a 64-bit register or memory location. Dynamically flips the mathematical sign of a variable.
#define OPCODE_NEG_RM64      0xF7        // NEG r/m64        - Two's Complement Negation (Requires ModR/M /3)

// Computes the ones complement (bitwise NOT) of a 64-bit target, inverting every single bit field state.
#define OPCODE_NOT_RM64      0xF7        // NOT r/m64        - Bitwise Logical Inversion (Requires ModR/M /2)

// --- Hardware Bit Testing & Bit Scanning (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Dedicated micro-architectural paths to examine or manipulate individual bit indices.

// Copies the bit at the specified index inside a 64-bit target directly into the Carry Flag (CF) of the RFLAGS register.
// Extremely powerful for high-speed bit-vector state machine scanning inside the AI core.
#define OPCODE_BT_RM64_R64   0x0FA3      // BT r/m64, r64    - Bit Test (Saves target bit index value to Carry Flag)

// Scans a 64-bit source from the least-significant bit (LSB) to find the first bit set to 1, storing its index in the target.
// Critical for accelerating dynamic sparse matrix searching loops and tracking active mask allocations.
#define OPCODE_BSF_REG_RM    0x0FBC      // BSF r64, r/m64   - Bit Scan Forward (Finds first bit set to 1 from LSB)

// =================================================================
// SECTION 4: CONTROL FLOW & BRANCHING
// =================================================================
// --- Unconditional Jumps & Calls ---

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: The CPU executes in 64-bit mode, but uses an 8-bit signed displacement 
// to calculate the distance (-128 to +127 bytes) relative to the 64-bit RIP register. 
// Highly efficient for tight local loops and structural branch skipping without code inflation.
#define OPCODE_JMP_SHORT     0xEB    // JMP rel8   - Short relative jump (1-byte offset)

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: The CPU operates in 64-bit mode, but uses a 32-bit signed displacement 
// to calculate the target destination. This allows the 64-bit pipeline to jump anywhere 
// within a +/-2GB range relative to the 64-bit RIP. Native 64-bit relative jumps do not exist.
#define OPCODE_JMP_NEAR      0xE9    // JMP rel32  - Near relative jump (4-byte offset)

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: This is the ONLY way to perform a true, unrestricted 64-bit jump. 
// The absolute 64-bit destination address is loaded into a 64-bit register (e.g., RAX) 
// or fetched from a 64-bit pointer in memory, allowing access to the entire 64-bit memory space.
#define OPCODE_JMP_INDIRECT  0xFF    // JMP /4     - Absolute indirect jump via 64-bit reg/mem

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: Pushes the current 64-bit return address onto the 64-bit stack (restoring RSP), 
// then executes a relative call using a 32-bit signed displacement to modify the 64-bit RIP.
#define OPCODE_CALL_NEAR     0xE8    // CALL rel32 - Near relative function call (4-byte offset)


// --- Conditional Jumps (Short Forms - Local 8-bit Displacement) ---
// ALL instructions below evaluate the RFLAGS register and adjust the 64-bit RIP pointer 
// using a local, short 8-bit signed displacement field.

// [Intel & AMD Cross-Compatible]
#define OPCODE_JE_SHORT      0x74    // JE rel8    - Jump if Zero / Equal (Evaluates ZF==1)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JNE_SHORT     0x75    // JNE rel8   - Jump if Not Zero / Not Equal (Evaluates ZF==0)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JG_SHORT      0x7F    // JG rel8    - Jump if Greater (Signed comparison: ZF==0 AND SF==OF)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JL_SHORT      0x7C    // JL rel8    - Jump if Less (Signed comparison: SF!=OF)


// --- Conditional Jumps (Near Forms - Global 32-bit Displacement) ---
// ALL instructions below operate within 64-bit mode but use a wider 32-bit displacement field, 
// allowing the conditional branch to reach up to 2GB away in the 64-bit virtual memory space.

// [Intel & AMD Cross-Compatible]
#define OPCODE_JE_NEAR       0x0F84  // JE rel32   - Jump if Zero / Equal (Near form)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JNE_NEAR      0x0F85  // JNE rel32  - Jump if Not Zero / Not Equal (Near form)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JG_NEAR       0x0F8F  // JG rel32   - Jump if Greater (Signed, Near form)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JL_NEAR       0x0F8C  // JL rel32   - Jump if Less (Signed, Near form)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JB_NEAR       0x0F82  // JB/JC rel32- Jump if Below / Carry (Unsigned underflow check: CF==1)

// [Intel & AMD Cross-Compatible]
#define OPCODE_JA_NEAR       0x0F87  // JA rel32   - Jump if Above (Unsigned comparison: CF==0 AND ZF==0)


// --- Function Returns & Subroutine Termination ---

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: Pops the top 64-bit return address from the stack directly back into the 
// 64-bit Instruction Pointer (RIP) and updates the 64-bit Stack Pointer (RSP) automatically.
#define OPCODE_RET_NEAR      0xC3    // RET        - Near return to 64-bit calling procedure

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: Pops the 64-bit return address into RIP and immediately adds a 16-bit 
// constant immediate value to the 64-bit Stack Pointer (RSP) to clear input stack arguments.
#define OPCODE_RET_IMM       0xC2    // RET imm16  - Near return and pop specified bytes from stack

// --- Unsigned Near Conditional Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: These instruct the 64-bit pipeline to perform a near jump (32-bit displacement) 
// up to 2GB away, evaluating flags based on unsigned comparison results.

// Evaluates the Carry Flag (CF) and Zero Flag (ZF). If either CF == 1 or ZF == 1, the jump executes.
// Used for lower-bound unsigned boundary checking and detecting equal-or-below index limits.
#define OPCODE_JBE_NEAR      0x0F86      // JBE rel32  - Jump if Below or Equal (Unsigned, CF==1 OR ZF==1)

// Evaluates the Carry Flag (CF). If CF is cleared to 0 (no borrow/underflow occurred), the CPU branches.
// Crucial for validating secure memory pointer spacing without signed interpretation overhead.
#define OPCODE_JAE_NEAR      0x0F83      // JAE/JNB rel32 - Jump if Above or Equal / Not Below (CF==0)


// --- Signed Near Conditional Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: These instructions utilize a full 32-bit signed displacement 
// to execute dynamic branching based on signed numeric thresholds.

// Evaluates signed comparison flags. If the Sign Flag (SF) equals the Overflow Flag (OF), the CPU branches.
// Essential for dynamic structural activation paths when processing signed physics weights.
#define OPCODE_JGE_NEAR      0x0F8D      // JGE rel32  - Jump if Greater or Equal (Signed, SF==OF)

// Evaluates signed comparison flags. If the Zero Flag (ZF) == 1 OR the Sign Flag (SF) != Overflow Flag (OF), the jump executes.
// Highly optimal for verifying lower-bound multi-dimensional matrix dimensions containing zero coordinates.
#define OPCODE_JLE_NEAR      0x0F8E      // JLE rel32  - Jump if Less or Equal (Signed, ZF==1 OR SF!=OF)


// --- Hardware Register-Based Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: These utilize short 8-bit displacements but are unique because they bypass the RFLAGS register entirely. 
// Instead, they sample general-purpose register contents directly at the retirement stage.

// Tests the 64-bit RCX register. If RCX is exactly 0, the CPU branches to a local 8-bit signed displacement.
// Extremely powerful for creating ultra-fast, zero-overhead loop terminations without altering arithmetic status flags.
#define OPCODE_JCXZ_SHORT    0xE3        // JCXZ/JECXZ/JRCXZ rel8 - Jump if Count Register is Zero (Evaluates RCX==0 in 64-bit)

// --- Status Flag Matrix Conditional Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Evaluates system condition attributes directly related to hardware mathematical bounds.

// Evaluates the Overflow Flag (OF). If OF == 1 (indicating a signed math wrap-around violation), the pipeline jumps via 32-bit offset.
// Critical for structural runtime integrity checks to prevent math exploitation within the neural core.
#define OPCODE_JO_NEAR       0x0F80      // JO rel32   - Jump if Overflow (Near form, OF==1)

// Evaluates the Sign Flag (SF). If SF == 1 (indicating a negative numeric state), the CPU branches via 32-bit offset.
// Direct hardware pathway for fast sign-bit branching inside directional electromagnetic fields processing.
#define OPCODE_JS_NEAR       0x0F88      // JS rel32   - Jump if Sign (Near form, SF==1)

// --- Inverted Status Flag Near Conditional Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Instructs the 64-bit pipeline to perform a near jump (32-bit displacement)
// when specialized mathematical conditions or overflow errors are NOT present.

// Evaluates the Overflow Flag (OF). If OF == 0, the pipeline jumps via 32-bit offset.
// Used for high-speed linear safety checks, ensuring no signed arithmetic violations occurred.
#define OPCODE_JNO_NEAR      0x0F81      // JNO rel32  - Jump if Not Overflow (Near form, OF==0)

// Evaluates the Sign Flag (SF). If SF == 0, the CPU branches via 32-bit offset.
// Direct hardware vector path when confirming strictly positive numbers in physical fields.
#define OPCODE_JNS_NEAR      0x0F89      // JNS rel32  - Jump if Not Sign (Near form, SF==0)

// --- Parity & Bit-Level Integrity Jumps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Evaluates the Parity Flag (PF), which indicates if the least-significant 
// byte of a result contains an even number of 1 bits. Essential for low-level validation matrix codes.

// Evaluates the Parity Flag (PF). If PF == 1 (even parity), the pipeline branches via 32-bit offset.
// Heavily utilized in raw assembly streams to check hardware data transmission parity integrity.
#define OPCODE_JP_NEAR       0x0F8A      // JP/JPE rel32- Jump if Parity / Parity Even (Near form, PF==1)

// Evaluates the Parity Flag (PF). If PF == 0 (odd parity), the pipeline branches via 32-bit offset.
// Used to capture transmission errors or structural bit asymmetries inside memory blocks.
#define OPCODE_JNP_NEAR      0x0F8B      // JNP/JPO rel32- Jump if Not Parity / Parity Odd (Near form, PF==0)

// --- System Call & Privilege Transitions (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Bypasses the traditional, slow interrupt gate framework 
// to transition the 64-bit pipeline directly between User Mode (Ring 3) and Kernel Mode (Ring 0).

// Instantly jumps to the Kernel-defined entry point address stored in the MSR (Model Specific Register).
#define OPCODE_SYSCALL       0x0F05      // SYSCALL     - Fast system call implementation (User to Kernel)
// Restores system state and returns execution flow back to the 64-bit User Mode environment.
#define OPCODE_SYSRET        0x0F07      // SYSRET      - Fast system return implementation (Kernel to User)

// --- Software Interrupts & Vector Traps (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Forces an explicit vector trap, immediately saving current context and 
// branching to the address specified inside the IDT (Interrupt Descriptor Table).

// Triggers a general software interrupt vector. Used to invoke legacy OS interfaces.
#define OPCODE_INT           0xCD        // INT imm8    - Software interrupt with vector argument
// Special 1-byte opcode dedicated to Debug Breakpoints. Extensively used to force immediate analyzer traps.
#define OPCODE_INT3          0xCC        // INT3        - Debug breakpoint exception trap


// =================================================================
// SECTION 5: ADVANCED MATRIX, VECTOR & FLOATING-POINT EXTENSIONS (AVX / FMA / MATH)
// =================================================================

// --- FMA3 Extensions (Intel & AMD Cross-Compatible) ---
// Supported on all modern CPUs from both vendors (Since Intel Haswell and AMD Piledriver)
#define OPCODE_VFMADD213PD   0x0F38A6    // VFMADD213PD [Intel & AMD] - V[A] = V[B] * V[A] + V[C] (Double-Precision)
#define OPCODE_VFMADD231PD   0x0F38B6    // VFMADD231PD [Intel & AMD] - V[A] = V[B] * V[C] + V[A] (Fused Multiply-Add)

// --- Standard AVX/AVX2 Vector Math (Intel & AMD Cross-Compatible) ---
// Basic vector instructions for field and matrix computations
#define OPCODE_VMULPD        0x660F59    // VMULPD       [Intel & AMD] - Vector Double-Precision Float Multiplication
#define OPCODE_VADDPD        0x660F58    // VADDPD       [Intel & AMD] - Vector Double-Precision Float Addition
#define OPCODE_VSUBPD        0x660F5C    // VSUBPD       [Intel & AMD] - Vector Double-Precision Float Subtraction

// --- Advanced Vector Arithmetic (Intel & AMD Cross-Compatible) ---
// Essential for division, distance formulas, and normalization in field equations
#define OPCODE_VDIVPD        0x660F5E    // VDIVPD       [Intel & AMD] - Vector Double-Precision Float Division
#define OPCODE_VSQRTPD       0x660F51    // VSQRTPD      [Intel & AMD] - Vector Double-Precision Square Root

// --- Fast Approximation Extensions (Intel Native / AMD Modern Compatibility) ---
// Low-latency reciprocal approximations, heavily utilized to bypass slow division cycles in raw physics engines
#define OPCODE_VRSQRT14PD    0x660F384E  // VRSQRT14PD   [Intel & AMD] - Vector Approximate Reciprocal Square Root (14-bit precision)
#define OPCODE_VRCP14PD      0x660F384C  // VRCP14PD     [Intel & AMD] - Vector Approximate Reciprocal (14-bit precision)

// --- AVX-512 Vector Logic (Intel Native / AMD Modern Compatibility) ---
// Ultra-wide 512-bit vector operations. Historically Intel-native, fully supported on modern AMD (Zen 4 & Zen 5)
#define OPCODE_VPANDD        0x660FDB    // VPANDD       [Intel & AMD] - Vector Bitwise AND (512-bit register mask)
#define OPCODE_VPXORD        0x660FEF    // VPXORD       [Intel & AMD] - Vector Bitwise XOR (Ultra-fast Vector Clear)

// --- FMA4 Legacy Extensions (AMD-Specific / Intel Rejected) ---
// Unique 4-operand architecture designed by AMD. Intel never adopted this, and newer platforms shifted to FMA3
#define OPCODE_VFMADDPD_FMA4 0x0F3A5F    // VFMADDPD     [AMD Only]     - 4-Operand Fused Multiply-Add (Dest = Src1 * Src2 + Src3)

// --- AMD-Specific Esoteric Extensions (XOP Architecture / Intel Rejected) ---
// Legacy AMD-only hardware acceleration. Dropped in modern Zen architectures but vital for legacy hardware targeting
#define OPCODE_VPHADDBD      0x8F09A0C2  // VPHADDBD     [AMD Only]     - Vector Horizontal Add Signed Byte to Doubleword
#define OPCODE_VPPERM        0x8F09A0A3  // VPPERM       [AMD Only]     - Vector Permute Bytes (Programmable cross-bar hardware shuffle)

// --- Vector Shuffling & Permutation (Intel & AMD Cross-Compatible) ---
// Crucial for matrix transposition, tensor reshaping, and cross-lane data alignment
#define OPCODE_VPERMD        0x660F3836  // VPERMD       [Intel & AMD] - Permute Doublewords using index register (AVX2/AVX-512)
#define OPCODE_VSHUFPD       0x660FC6    // VSHUFPD      [Intel & AMD] - Shuffle Packed Double-Precision Floating-Point Values

// --- Vector Advanced Math & Dot Product (Intel & AMD Cross-Compatible) ---
// High-speed geometric and structural calculations for field vector magnitudes
#define OPCODE_VDPPD        0x660F3A41   // VDPPD        [Intel & AMD] - Dot Product of Packed Double-Precision Floating-Point Values
#define OPCODE_VMAXPD        0x660F5F    // VMAXPD       [Intel & AMD] - Return Maximum Packed Double-Precision Floating-Point Values
#define OPCODE_VMINPD        0x660F5D    // VMINPD       [Intel & AMD] - Return Minimum Packed Double-Precision Floating-Point Values

// --- AVX-512 Masking & Conflict Detection (Intel Native / AMD Modern Compatibility) ---
// Advanced conditional hardware execution loops for sparse matrix calculations
#define OPCODE_VPLZCNTD      0x660F3844  // VPLZCNTD     [Intel & AMD] - Count Leading Zeros in Packed Data (Essential for dynamic masks)
#define OPCODE_VPCONFLICTD   0x660F38C4  // VPCONFLICTD  [Intel & AMD] - Detect Conflicts in Packed Doublewords (Hardware loops validation)

// --- Advanced Vector Gather & Scatter (Intel & AMD Cross-Compatible) ---
// High-speed parallel memory fetches, essential for loading sparse tensor fields without CPU stalling
#define OPCODE_VPGATHERDD    0x0F3892    // VPGATHERDD  [Intel & AMD] - Gather Packed Dword values using signed Dword indices
#define OPCODE_VPGATHERQD    0x0F3891    // VPGATHERQD  [Intel & AMD] - Gather Packed Dword values using signed Qword indices
#define OPCODE_VPSCATTERDD   0x660F38A2  // VPSCATTERDD [Intel & AMD] - Scatter Packed Dword values to memory using Dword indices

// --- Horizontal & Complex Vector Math (Intel & AMD Cross-Compatible) ---
// Cross-lane vector operations optimized for dynamic reductions and computing local divergence/curl
#define OPCODE_VHADDPD       0x660F7C    // VHADDPD     [Intel & AMD] - Horizontal Add Packed Double-Precision Floating-Point
#define OPCODE_VHSUBPD       0x660F7D    // VHSUBPD     [Intel & AMD] - Horizontal Subtract Packed Double-Precision Floating-Point

// --- Neural Network & Deep Learning Hardware Acceleration (Intel & AMD Modern) ---
// Ultra-dense hardware execution for specialized matrix dot-products and inference weight adjustment
#define OPCODE_VPDPBUSD      0x660F3850  // VPDPBUSD    [Intel & AMD] - Multiply Groups of Unsigned and Signed Bytes (VNNI Extension)
#define OPCODE_VPDPWSSD      0x660F3852  // VPDPWSSD    [Intel & AMD] - Multiply Groups of Signed Words and Accumulate to Dwords (VNNI)

// --- Vector Floating-Point Rounding & Bounds (Intel & AMD Cross-Compatible) ---
// High-speed precision boundaries and fractional extractions for field waveforms
#define OPCODE_VROUNDPD      0x660F3A09  // VROUNDPD    [Intel & AMD] - Round Packed Double-Precision Floating-Point Values
#define OPCODE_VRNDSCALEPD   0x660F3A09  // VRNDSCALEPD [Intel & AMD] - Scale and Round Packed Float Values (AVX-512 Variant)
#define OPCODE_VGETMANTPD    0x660F3826  // VGETMANTPD  [Intel & AMD] - Extract Mantissa from Packed Float Values (AVX-512)

// --- Vector Precision & Format Conversion (Intel & AMD Cross-Compatible) ---
// Rapid typecasting between Integers and Float formats for neural layers synchronization
#define OPCODE_VCVTDQ2PD     0x660F5A    // VCVTDQ2PD   [Intel & AMD] - Convert Packed Doubleword Integers to Packed Max-Precision Floats
#define OPCODE_VCVTPD2DQ     0xF20F5B    // VCVTPD2DQ   [Intel & AMD] - Convert Packed Max-Precision Floats to Packed Doubleword Integers

// --- Advanced AVX-512 Mathematical Exponents (Intel Native / AMD Modern Compatibility) ---
// Direct hardware calculations of inverse powers and scaling factor matrices
#define OPCODE_VGETEXPPD     0x660F3842  // VGETEXPPD   [Intel & AMD] - Extract Exponents of Packed Double-Precision Float Values
#define OPCODE_VSCALEFPD     0x660F3862  // VSCALEFPD   [Intel & AMD] - Scale Packed Double-Precision Floating-Point Values Base 2

// --- Advanced Vector Floating-Point Comparisons (Intel & AMD Cross-Compatible) ---
// Compares packed float values in parallel using a condition predicate field (essential for matrix state machine logic)
#define OPCODE_VCMPPD        0x660FC2    // VCMPPD      [Intel & AMD] - Compare Packed Double-Precision Floating-Point Values

// --- Advanced Vector Byte Manipulation & Shuffles (Intel & AMD Cross-Compatible) ---
// Byte-level hardware permutations, vital for sorting neural activation layers and parsing raw stream buffers
#define OPCODE_VPSHUFB       0x660F3800  // VPSHUFB     [Intel & AMD] - Packed Shuffle Bytes (Permutes bytes in 128/256-bit lanes)
#define OPCODE_VPERMILPD     0x660F3805  // VPERMILPD   [Intel & AMD] - Permute In-Lane Packed Double-Precision Floating-Point Values

// --- Vector Cryptography Hardware Acceleration (Intel Native / AMD Modern Compatibility) ---
// Utilizes specialized SIMD pipelines for high-speed hardware blocks hashing (useful for securing model runtime memory space)
#define OPCODE_VAESENC       0x660F38DC  // VAESENC     [Intel & AMD] - Perform One Round of an AES Encryption Flow on Packed Data
#define OPCODE_VPCLMULQDQ    0x660F3A44  // VPCLMULQDQ  [Intel & AMD] - Carry-Less Multiplication of Quadword Values

// --- Advanced Vector Bit Shifts & Rotations (Intel & AMD Cross-Compatible) ---
// High-speed block-level variable bit shifting, vital for exponential calculations and field scaling
#define OPCODE_VPSLLVD       0x660F3847  // VPSLLVD     [Intel & AMD] - Variable Packed Shift Left Logical Doublewords
#define OPCODE_VPSRLVD       0x660F3845  // VPSRLVD     [Intel & AMD] - Variable Packed Shift Right Logical Doublewords
#define OPCODE_VPRORVD       0x660F3846  // VPRORVD     [Intel & AMD] - Variable Packed Rotate Right Doublewords (AVX-512)

// --- Vector Precision Interleaving & Unpacking (Intel & AMD Cross-Compatible) ---
// High-throughput data interleaving, utilized for multiplexing vector fields 
#define OPCODE_VPUNPCKHDQ    0x660F68    // VPUNPCKHDQ  [Intel & AMD] - Unpack and Interleave High-Order Doublewords
#define OPCODE_VPUNPCKLDQ    0x660F62    // VPUNPCKLDQ  [Intel & AMD] - Unpack and Interleave Low-Order Doublewords

// --- Advanced Floating-Point Vector Sign Manipulation (Intel & AMD Cross-Compatible) ---
// Direct hardware injection of floating-point signs, essential for computing directional field vectors flips
#define OPCODE_VPSIGND       0x660F380A  // VPSIGND     [Intel & AMD] - Packed Sign Doublewords (Conditional sign application)

// --- Non-Temporal Vector Streaming Stores (Intel & AMD Cross-Compatible) ---
// Bypasses the CPU cache hierarchy to write streaming vector data directly to RAM (prevents cache pollution during huge AI matrix runs)
#define OPCODE_VMOVNTDQ      0x660FE7    // VMOVNTDQ    [Intel & AMD] - Store Packed Doubleword Integers Non-Temporal
#define OPCODE_VMOVPDNTS     0x660F2B    // VMOVNTPD    [Intel & AMD] - Store Packed Double-Precision Float Values Non-Temporal

// --- Half-Precision Float Hardware Conversion (Intel & AMD Cross-Compatible) ---
// Rapid hardware encoding/decoding between 16-bit floats (FP16/BF16) and 32-bit floats, essential for AI weight compression
#define OPCODE_VCVTPH2PS     0x660F3813  // VCVTPH2PS   [Intel & AMD] - Convert Packed 16-bit Floating-Point Values to Single-Precision
#define OPCODE_VCVTPS2PH     0x660F3A1D  // VCVTPS2PH   [Intel & AMD] - Convert Packed Single-Precision Floating-Point Values to 16-bit

// --- Advanced Matrix Scale and Bias (Intel Native / AMD Modern Compatibility) ---
// Specialized vector math for adding static bias values to compressed neural network feature maps
#define OPCODE_VFIXUPIMMPD   0x660F3A54  // VFIXUPIMMPD [Intel & AMD] - Fix Up Special Packed Float Values (AVX-512 Matrix Fixup)

// --- AVX State Management & Pipeline Optimization (Intel & AMD Cross-Compatible) ---
// Clears internal vector register states to prevent hardware execution penalties during mode transitions
#define OPCODE_VZEROALL      0x0F77      // VZEROALL    [Intel & AMD] - Zero All YMM/ZMM Registers and Clear AVX State
#define OPCODE_VZEROUPPER    0x0F77      // VZEROUPPER  [Intel & AMD] - Zero Upper Bits of YMM/ZMM Registers (Prevents legacy bottlenecks)

// --- Vector Mask Register Manipulation (Intel Native / AMD Modern Compatibility) ---
// Direct hardware operations on AVX-512 opmask registers, essential for dynamic neural layer routing
#define OPCODE_KANDW         0x41        // KANDW       [Intel & AMD] - Bitwise AND Opmask Registers (16-bit mask)
#define OPCODE_KXORW         0x47        // KXORW       [Intel & AMD] - Bitwise XOR Opmask Registers (Fast mask clear)

// --- Advanced Matrix Inversion Sign Control (Intel & AMD Cross-Compatible) ---
// High-speed parallel evaluation of absolute values, vital for calculating matrix determinants in field equations
#define OPCODE_VANDPD        0x660F54    // VANDPD      [Intel & AMD] - Bitwise AND of Packed Double-Precision Float Values
#define OPCODE_VANDNPD       0x660F55    // VANDNPD     [Intel & AMD] - Bitwise AND NOT of Packed Double-Precision Float Values

// --- Intel Advanced Matrix Extensions - AMX (Intel Native / Architectural Target) ---
// Direct tile matrix multiplication hardware execution, optimized for massive AI weights processing
#define OPCODE_TDPBF16PS     0xF20F385C  // TDPBF16PS   [Intel Only]   - Dot Product of BF16 Tiles and Accumulate to FP32
#define OPCODE_TILERELEASE   0x0F0148    // TILERELEASE [Intel Only]   - Release AMX Tile Configuration and Hardware States

// --- Vector Complex Number Arithmetic (Intel Native / AMD Modern Compatibility) ---
// Specialized hardware instructions for complex numbers math, essential for electrodynamic wave phase vectors
#define OPCODE_VCMULCPD      0x660F3857  // VCMULCPD    [Intel & AMD] - Complex Multiply Packed Double-Precision Float Values
#define OPCODE_VFMADDCSGPD   0x660F3A57  // VFMADDCSGPD [Intel & AMD] - Complex Fused Multiply-Add with Sign Control

// --- Ultra-Precise Vector Truncation & Exponents (Intel & AMD Cross-Compatible) ---
// High-throughput hardware normalization for deep neural layers stability checks
#define OPCODE_VREDUCEDD     0x660F3A56  // VREDUCEDD   [Intel & AMD] - Perform Reduction Transformation on Packed Float Values

// --- Advanced Exponential & Reciprocal Approximations (Intel Native / AMD Modern) ---
// High-throughput hardware vector approximations, crucial for neural network activation scaling and field decay calculations
#define OPCODE_VEXP2PD       0x660F385A  // VEXP2PD     [Intel & AMD] - Approximate Vector Base-2 Exponential Values (AVX-512)
#define OPCODE_VRCP28PD      0x660F38CA  // VRCP28PD    [Intel & AMD] - High-Precision Vector Reciprocal Approximation (28-bit precision)
#define OPCODE_VRSQRT28PD    0x660F38CC  // VRSQRT28PD  [Intel & AMD] - High-Precision Vector Reciprocal Square Root (28-bit precision)

// --- Vector Floating-Point Absolute Values & Signs (Intel & AMD Cross-Compatible) ---
// Direct hardware masking to extract or clear floating-point signs, essential for fast magnitude calculation without branching
#define OPCODE_VANDNPD       0x660F55    // VANDNPD     [Intel & AMD] - Bitwise AND NOT of Packed Double-Precision Float Values
#define OPCODE_VORPD         0x660F56    // VORPD       [Intel & AMD] - Bitwise OR of Packed Double-Precision Float Values

// =================================================================
// SECTION 6: SYSTEM, INTERRUPTS & HARDWARE REGISTERS CONTROL
// =================================================================
// [Intel & AMD Cross-Compatible]
// Performs a logical bitwise AND operation on two 64-bit operands. Unlike standard ALU instructions, 
// it discards the computed numeric outcome and updates structural state bits in the RFLAGS register 
// (e.g., Zero Flag, Sign Flag). Critical for conditional validation without mutating active register contents.
#define OPCODE_TEST_RM_REG   0x85    // TEST r/m64, r64 - Non-destructive bit test (Sets flags)

// [Intel & AMD Cross-Compatible]
// Execution NOP (No Operation). Performs no hardware logic changes other than advancing the Instruction Pointer. 
// Primarily utilized for loop code padding, instruction alignment on specific cache-line boundaries (16-byte alignment), 
// and creating precise instruction prefetch corridors.
#define OPCODE_NOP           0x90    // NOP - No Operation (Used for boundary alignment)

// [Intel & AMD Cross-Compatible]
// Forces a native system call sequence. Immediately context-switches the execution state from User Mode (Ring 3) 
// to Kernel Mode (Ring 0). Bypasses legacy software interrupts, allowing high-speed, direct interaction with 
// OS subsystems, low-level file I/O operations, or immediate memory mapping allocations.
#define OPCODE_SYSCALL       0x0F05  // SYSCALL - Native OS/Kernel interface (0F 05)

// [Intel & AMD Cross-Compatible]
// Executes a near return to the calling code sequence. Pops the prior Instruction Pointer (RIP) offset saved on the 
// stack back into the RIP register, immediately redirecting instruction prefetch pipelines to the post-call destination.
#define OPCODE_RET           0xC3    // RET - Near return to calling procedure

// --- Control Registers & Model-Specific Registers (MSR) ---

// [Intel & AMD Cross-Compatible]
// Privileged command that reads data directly out of structural hardware Control Registers (CR0-CR8) into 
// general-purpose registers. Necessary for checking global CPU parameters, memory paging configurations, 
// and caching architecture permissions.
#define OPCODE_MOV_REG_CR    0x0F20  // MOV r64, crX - Read Control Register (0F 20)

// [Intel & AMD Cross-Compatible]
// Privileged command that writes data directly into hardware Control Registers from a register source. 
// Used during the boot stage to activate or toggle memory protection layers, paging engines, and hardware execution extensions.
#define OPCODE_MOV_CR_REG    0x0F22  // MOV crX, r64 - Write Control Register (0F 22)

// [Intel & AMD Cross-Compatible]
// Read from Model-Specific Register (MSR). Loads a specific 64-bit machine profile configuration 
// designated by the RCX register index into the RAX:RDX register file. Crucial for hardware auditing and state testing.
#define OPCODE_RDMSR         0x0F32  // RDMSR - Read From Model-Specific Register

// [Intel & AMD Cross-Compatible]
// Write to Model-Specific Register (MSR). Forces the 64-bit profile array from RAX:RDX straight into the internal CPU 
// operational framework at the index listed in RCX. Grants ultimate access over telemetry, power caps, and internal features.
#define OPCODE_WRMSR         0x0F30  // WRMSR - Write To Model-Specific Register
// --- Performance Monitoring & Hardware Diagnostics ---

// [Intel & AMD Cross-Compatible]
// Executes a direct hardware read of the internal performance-monitoring counters into the EDX:EAX register pair. 
// Controlled by the index placed in the ECX register. Essential for microscopic execution profiling, 
// calculating cache misses during massive tensor matrix traversals, and raw clock cycle auditing.
#define OPCODE_RDPMC         0x0F33  // RDPMC - Read Performance-Monitoring Counters (Bare-metal diagnostic)

// --- Memory Fencing, Descriptors & CPU Serialization ---

// [Intel & AMD Cross-Compatible]
// Forces a complete serialization of the CPU instruction pipeline while querying hardware parameters. 
// Flushes all pre-fetched and unexecuted micro-operations, ensuring every prior instruction has fully retired 
// before parsing subsequent memory cells. Crucial for establishing clean execution barriers between layers.
#define OPCODE_CPUID         0x0FA2  // CPUID - CPU Identification & Pipeline Serialization

// [Intel & AMD Cross-Compatible]
// Invalidates a specific Translation Lookaside Buffer (TLB) entry mapping for a designated virtual address page. 
// Evicts cached translation vectors to guarantee memory space consistency immediately following page table adjustments 
// or custom bare-metal page modifications.
#define OPCODE_INVLPG        0x0F01  // INVLPG - Invalidate TLB Entry (Requires ModR/M extension)

// [Intel & AMD Cross-Compatible]
// Privileged boot instruction that loads a raw memory pointer tracking the structure of the Global Descriptor Table (GDT) 
// into the internal GDTR system register. Establishes the foundational hardware-level segment access layout 
// and base-memory boundaries during the system boot cycle.
#define OPCODE_LGDT          0x0F01  // LGDT - Load Global Descriptor Table

// [Intel & AMD Cross-Compatible]
// Privileged boot instruction that maps a dedicated memory structure detailing the Interrupt Descriptor Table (IDT) 
// into the internal IDTR register. Enables the custom kernel to trap, filter, and handle raw hardware interrupts 
// or custom validation faults.
#define OPCODE_LIDT          0x0F01  // LIDT - Load Interrupt Descriptor Table

// [Intel & AMD Cross-Compatible]
// Loads an aggressive memory read barrier (Load Fence). Serializes all load operations across the local core, 
// forcing every subsequent read request to stall until all prior memory extractions have completed and committed. 
// Vital for syncing multi-threaded model pipelines safely.
#define OPCODE_LFENCE        0x0F0AE8 // LFENCE - Load Fence (Serializes read operations)

// [Intel & AMD Cross-Compatible]
// Loads a universal memory barrier (Memory Fence). Serializes both read and write operations across the memory pipeline, 
// forcing the CPU execution unit to halt until every prior load and store instruction is retirement-committed. 
// Prevents out-of-order execution errors during matrix weight adjustments.
#define OPCODE_MFENCE        0x0F0AEF // MFENCE - Memory Fence (Serializes all memory operations)

// [Intel & AMD Cross-Compatible]
// Highly privileged instruction that flushes and completely invalidates all internal L1, L2, and L3 CPU cache lines. 
// Broadcasts a hardware synchronization signal across the data bus to force-write all dirty blocks back to the main RAM 
// and clear memory structures instantly.
#define OPCODE_WBINVD        0x0F09   // WBINVD - Flush and Invalidate All CPU Caches (Privileged)

// --- Core Interrupt Flags Manipulation (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Directly toggles the Interrupt Flag (IF) in the RFLAGS register. 
// Atomically blocks or permits maskable hardware interrupts, essential for protecting critical code paths.

// Clears the Interrupt Flag. Prevents the hardware execution unit from servicing external hardware interrupts.
// Vital for freezing the state of the CPU during raw matrix memory shifting or secure runtime validations.
#define OPCODE_CLI           0xFA        // CLI         - Clear Interrupt Flag (Disable maskable interrupts)

// Sets the Interrupt Flag. Re-enables the hardware pipeline to accept and process maskable external interrupts.
#define OPCODE_STI           0xFB        // STI         - Set Interrupt Flag (Enable maskable interrupts)

// --- Memory Fencing & Cache Flush Options (Intel & AMD Cross-Compatible) ---

// Loads a strict memory write barrier (Store Fence). Serializes all store operations across the execution unit, 
// forcing subsequent writes to stall until all prior memory writes have been safely flushed to the cache hierarchy.
#define OPCODE_SFENCE        0x0F0AE8    // SFENCE      - Store Fence (Serializes write operations; requires ModR/M extension)

// Flushes a specific data cache line from all levels of the processor cache hierarchy based on a linear address.
// Forces the targeted line to be written back to system RAM if dirty, preventing speculative execution attacks.
#define OPCODE_CLFLUSH       0x0FAE      // CLFLUSH     - Cache Line Flush (Requires ModR/M extension /7)

// --- Descriptor Table Management Operations (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Complements LGDT/LIDT by allowing the current active structure mappings 
// to be extracted or read back directly for validation and integrity auditing inside the core.

// Reads the contents of the Global Descriptor Table Register (GDTR) and stores it in a memory destination.
// Critical for verification passes to ensure a rogue kernel thread hasnt physically swapped the segment descriptors.
#define OPCODE_SGDT          0x0F01      // SGDT m      - Store Global Descriptor Table (Requires ModR/M extension /0)

// Reads the contents of the Interrupt Descriptor Table Register (IDTR) and commits it to memory.
// Essential for the AI to audit trap gates and confirm the interrupt vector paths remain untampered.
#define OPCODE_SIDT          0x0F01      // SIDT m      - Store Interrupt Descriptor Table (Requires ModR/M extension /1)

// --- Microarchitectural Power & Pipeline Control (Intel & AMD Cross-Compatible) ---

// Halts the CPU core execution pipeline until the next unmasked hardware or software interrupt is triggered.
// Switches the internal clock gates to a low-power state, waiting precisely for synchronization signals or timer events.
#define OPCODE_HLT           0xF4        // HLT         - Halt Processor Core

// --- Advanced Privilege Transitions (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Complements the SYSCALL/SYSRET framework by handling traditional iret 
// structures during hardware exception returns or specialized task switches.

// Pops the RFLAGS, CS, RIP, SSP, and SS registers from the stack, atomically returning the 
// execution flow from a privileged exception handler back to the original interrupted code segment.
#define OPCODE_IRETQ         0xCF        // IRETQ       - Interrupt Return (64-bit Quadword format)

// --- Task Register Manipulation (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Manages the Task Register (TR), which points to the Task State Segment (TSS). 
// Essential for setting up hardware I/O permission bitmaps and kernel stack pointers.

// Privileged boot instruction that loads the Task Register selector from a 16-bit general-purpose register.
#define OPCODE_LTR           0x0F00      // LTR r/m16   - Load Task Register (Requires ModR/M extension /3)

// Reads the current Task Register selector and stores it back to a register or memory location for auditing.
#define OPCODE_STR           0x0F00      // STR r/m16   - Store Task Register (Requires ModR/M extension /1)

// --- Hardware Segment Bounds Validation (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Non-destructive validation pathways that check segment access limits 
// to prevent pointer-smuggling and memory privilege escalation within Ring 0.

// Verifies the segment access rights of a specified source descriptor operand against current privilege levels.
#define OPCODE_LAR           0x0F02      // LAR r64, r/m64 - Load Access Rights Byte
// Verifies the segment limit of a specified descriptor operand, ensuring memory access doesnt overshoot boundaries.
#define OPCODE_LSL           0x0F03      // LSL r64, r/m64 - Load Segment Limit

// --- System Management Mode Transitions (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Enters the absolute deepest hardware ring (Ring -2), bypassing the operating system 
// entirely to execute specialized manufacturer power/telemetry platform firmware code.

// Executes a return from System Management Mode. Restores the exact prior CPU snapshot and unfreezes the pipelines.
#define OPCODE_RSM           0x0FAA      // RSM         - Resume from System Management Mode (Highly privileged)

// =================================================================
// SECTION 7: SILICON SECURITY, ENTROPY & ENCLAVES
// =================================================================

// [Intel & AMD Cross-Compatible]
// Loads a cryptographically secure pseudo-random number from an on-chip hardware entropy source into a target 
// general-purpose register. The hardware generator utilizes thermal noise to feed a high-speed DRBG circuit. 
// Used heavily for stochastic weight initialization and random seed distribution across neural network layers.
#define OPCODE_RDRAND        0x0FC7  // RDRAND - Read Hardware Random Number

// [Intel & AMD Cross-Compatible]
// Extracts a high-entropy true random seed directly from the physical silicon noise source, bypassing the pseudo-random 
// expansion pipeline. Adheres to strict cryptographic standards for establishing absolute unpredictability. 
// Crucial for resetting foundational entropy pools in advanced probabilistic AI algorithms.
#define OPCODE_RDSEED        0x0FC7  // RDSEED - Read Hardware Cryptographic Seed

// [Intel Only]
// Executes a privileged or unprivileged Intel SGX (Software Guard Extensions) enclave system function leaf designated by EAX. 
// Dynamically creates, allocates, or manages isolated memory regions (Enclaves) that are physically shielded from Ring 0 
// hypervisors and kernel exploits. Vital for protecting custom model weights and inference algorithms in hostiles spaces.
#define OPCODE_ENCLS         0x0F01CF // ENCLS - Execute an Enclave System Function Leaf (Intel SGX)

// --- Intel SGX User-Mode Enclave Control (Intel Native / Architectural Target) ---
// ARCHITECTURE NOTE: Complements ENCLS by executing unprivileged enclave leaf functions 
// directly from User Mode (Ring 3). Enables the AI core to manage its own isolated workspace.

// Executes an unprivileged SGX instruction leaf (e.g., EENTER, EEXIT, EGETKEY). 
// Allows the running application to securely enter or exit the physical silicon-shielded enclave memory area.
#define OPCODE_ENCLU         0x0F01D7    // ENCLU       - Execute User-Mode Enclave Leaf Function (Intel SGX)

// --- Control-flow Enforcement Technology - CET (Intel & AMD Modern Compatibility) ---
// ARCHITECTURE NOTE: Hardware-level mitigation against Return-Oriented Programming (ROP) 
// and Call-Oriented Programming (COP) exploits. Enforces structural pipeline integrity.

// Verifies the shadow stack pointer during indirect jumps or calls. 
// Prevents malicious shellcode from hijacking the control flow or smuggling target pointers.
#define OPCODE_INCSSP        0xF30F01AE  // INCSSP      - Increment Shadow Stack Pointer (Requires ModR/M extension /5)

// Marks a valid destination target for an indirect jump or call branch. 
// If an indirect branch lands on an instruction that is NOT an ENDBR, the CPU triggers an immediate hardware exception.
#define OPCODE_ENDBR64       0xF30F1EFA  // ENDBR64     - 64-bit Indirect Branch Tracker (Halts execution on hijack attempts)

// --- AMD Secure Encrypted Virtualization - SEV (AMD-Specific Silicon Security) ---
// ARCHITECTURE NOTE: Commands that manage hardware-accelerated memory encryption, 
// shielding entire virtual workspaces and matrix buffers from a compromised host kernel.

// Performs an atomic hardware flush of cached cryptographic keys and structures within the memory controller.
// Ensures that discarded neural network weights or raw physical parameters cannot be extracted via cold-boot attacks.
#define OPCODE_PVALIDATE     0xF20F01FF  // PVALIDATE   - Validate Guest Page Architecture State (AMD SEV-SNP)

// Requests a secure hardware attestation report from the dedicated AMD Security Processor (PSP).
// Universally validates the physical runtime state of the AI model to guarantee no hypervisor tampering occurred.
#define OPCODE_RMPADJUST     0xF30F01FE  // RMPADJUST   - Adjust Reverse Map Table Permissions (AMD SEV-SNP Isolation)

// --- Intel Key Locker Hardware Security (Intel Native / Architectural Target) ---
// ARCHITECTURE NOTE: Encodes and wraps cryptographic keys inside a dedicated hardware handle.
// Once wrapped, the raw key bits reside entirely inside hidden CPU states, making them completely 
// unreadable from memory or registers, protecting against raw runtime extraction.

// Loads a cryptographic key into the internal hardware wrapping engine to generate a secure handle.
#define OPCODE_LOADIWKEY     0xF30F38D6  // LOADIWKEY   - Load Internal Wrapping Key (Requires ModR/M extension)

// Performs high-speed AES encryption using the secure hardware handle instead of a raw exposed key register.
#define OPCODE_AESENC128KL   0xF30F38D8  // AESENC128KL - Perform AES Encryption Loop with Key Locker Handle

// --- Memory Access Isolation & Architectural Attestation (Intel & AMD Compatibility) ---
// ARCHITECTURE NOTE: Specialized platform commands designed to cryptographically isolate 
// specific memory frames or query firmware verification layers to prevent unauthorized snooping.

// Cryptographically hashes and seals a target physical page architecture inside the local processor hub.
#define OPCODE_MCREATE       0x0F01EC    // MCREATE     - Create Isolated Memory Context Allocation (Intel Trust Domain)

// Queries the platform security processor to execute a secure, hardware-backed runtime integrity handshake.
#define OPCODE_PCONFIG       0x0F01C5    // PCONFIG     - Platform Configuration Execution Leaf (Intel MKTME Engine)

// =================================================================
// SECTION 8: NATIVE HYPERVISOR / VMM EXTENSIONS
// =================================================================

// [AMD Only]
// Forces a native hypervisor call instruction within the AMD-V architecture framework. Immediately transitions 
// execution context from a Guest Virtual Machine directly to the Host Virtual Machine Monitor (VMM). 
// Bypasses standard OS rings to pass telemetry or commands straight to the underlying hardware supervisor.
#define OPCODE_VMMCALL       0x0F01D9 // VMMCALL - AMD-V Hypervisor Call

// [Intel Only]
// Forces a native hypervisor call instruction within the Intel VT-x architecture framework. Enables a Guest VM 
// to signal the Host VMM to request service routines, hypervisor-level memory mapping adjustments, or execution swaps.
#define OPCODE_VMCALL        0x0F01C1 // VMCALL - Intel VT-x Hypervisor Call

// [Intel Only]
// Privileged instruction that launches a newly initialized Virtual Machine execution context mapped by the current 
// active VMCS (Virtual Machine Control Structure). Triggers full pipeline serialization and sets up the root supervisor state.
#define OPCODE_VMLAUNCH      0x0F01C2 // VMLAUNCH - Launch Virtual Machine (Intel)

// [Intel Only]
// Privileged instruction that resumes the execution context of a previously launched Virtual Machine using the data state 
// tracked within the active VMCS structure. Rapidly loads saved register files and pipeline contexts into physical execution.
#define OPCODE_VMRESUME      0x0F01C3 // VMRESUME - Resume Virtual Machine (Intel)

// [Intel Only]
// Activates Intel VMX (Virtual Machine Extensions) operation on the current CPU core. Requires a pointer to a valid VMXON 
// memory region. Places the processor in VMX root operation, establishing the base hardware state needed to deploy guests.
#define OPCODE_VMXON         0xF30F3C // VMXON - Enable VMX Operation (Intel)

// [Intel Only]
// Disables Intel VMX operations on the local CPU core. Immediately revokes hypervisor execution mode and transitions 
// the processor back to a standard non-VMX bare-metal operational layout, wiping root tracking registers.
#define OPCODE_VMXOFF        0x0F3C   // VMXOFF - Disable VMX Operation (Intel)

// [Intel Only]
// Privileged instruction that writes an explicit data value into a targeted component field of the active VMCS block. 
// Used by the VMM to configure Guest instruction traps, exit conditions, and hypervisor interrupt configurations.
#define OPCODE_VMWRITE       0x0F79   // VMWRITE - Write Field to VMCS Structure

// [Intel Only]
// Privileged instruction that reads a specific component field from the active VMCS block into a general-purpose register. 
// Crucial for auditing exit codes, structural faults, or instruction metrics immediately following a Guest VM exit.
#define OPCODE_VMREAD        0x0F78   // VMREAD - Read Field from VMCS Structure

// [Intel Only]
// Loads a physical memory pointer pointing to a valid VMCS structure, marking it as the active and working VMCS 
// for the execution core. Synchronizes the internal CPU cache pipeline with the state vectors of the specified container.
#define OPCODE_VMPTRLD       0x0FC7   // VMPTRLD - Load Pointer to Active VMCS

// --- Core Hypervisor Activation & Context Switches (Intel & AMD) ---

// [Intel Only]
// Activates Intel VMX operation on the current CPU core. Requires a pointer to a valid VMXON memory region.
#define OPCODE_VMXON         0xF30F3EC7  // VMXON       - Enable VMX Operation (Fixed Opcode Sequence)

// [Intel Only]
// Disables Intel VMX operations on the local CPU core, transitioning back to standard non-VMX operation.
#define OPCODE_VMXOFF        0x0F01C4    // VMXOFF      - Disable VMX Operation (Fixed Opcode Sequence)

// [Intel Only]
// Clears the launch state of a specified VMCS, marking its structural data layout as inactive in hardware memory.
#define OPCODE_VMCLEAR       0x660FC7    // VMCLEAR     - Clear VMCS Structure State (Requires ModR/M /6)

// [Intel Only]
// Stores the physical pointer of the currently active VMCS block into a specified memory destination for auditing.
#define OPCODE_VMPTRST       0x0FC7      // VMPTRST     - Store Pointer to Active VMCS (Requires ModR/M /7)

// --- Extended Intel EPT & VPID Cache Invalidation (Intel Native) ---
// ARCHITECTURE NOTE: Essential for flushing hardware-level Extended Page Tables (Nested Paging) 
// to enforce memory isolation and prevent guest-to-host memory leaks or cross-container attacks.

// Invalidates cached translations derived from Extended Page Tables (EPT). Enforces total nested memory synchronization.
#define OPCODE_INVEPT        0x660F3880  // INVEPT      - Invalidate Translations from Extended Page Tables

// Invalidates cached translations based on Virtual Processor IDs (VPID). Flushes localized guest linear TLB entries.
#define OPCODE_INVVPID       0x660F3881  // INVVPID     - Invalidate Translations Based on VPID

// --- AMD SVM State & Interception Management (AMD-Specific) ---
// ARCHITECTURE NOTE: Hardware-level state routing instructions that complement VMRUN/VMMCALL 
// by managing host/guest register states, memory spaces, and global intercept gates.

// Loads an extended processor state snapshot (e.g., FS, GS, TR) from a specified VMCB memory page into the local CPU core.
#define OPCODE_VMLOAD        0x0F01DA    // VMLOAD      - Load Extended State from VMCB Memory Page

// Saves the current active extended processor state snapshot directly out to a designated VMCB memory page.
#define OPCODE_VMSAVE        0x0F01DB    // VMSAVE      - Save Extended State to VMCB Memory Page

// Clears the Global Interrupt Flag (GIF). Instantly blocks ALL interrupts, including NMIs and SMI traps.
// Essential for freezing the entire host core before executing critical guest register transitions.
#define OPCODE_CLGI          0x0F01DC    // CLGI        - Clear Global Interrupt Flag

// Sets the Global Interrupt Flag (GIF). Safely unblocks NMIs and hardware interrupts following an SVM context exit.
#define OPCODE_STGI          0x0F01DD    // STGI        - Set Global Interrupt Flag

// Invalidates virtual processor TLB entry mappings across the global AMD-V hardware memory controller.
#define OPCODE_INVLPGA       0x0F01DF    // INVLPGA     - Invalidate TLB Entry in Guest Address Space

// [AMD Only]
// Launches or resumes a guest virtual machine execution flow. The processor serializes the entire 
// pipeline and loads the state architecture specified within the VMCB memory page addressed by RAX.
#define OPCODE_VMRUN         0x0F01D8    // VMRUN       - Launch / Run AMD SVM Virtual Machine Guest

// =================================================================
// SECTION 9: GENERAL PURPOSE REGISTERS MAP (GPR)
// =================================================================
// [Intel & AMD Cross-Compatible]
// The primary 8 registers mapping directly to the standard 3-bit ModR/M and SIB byte fields (000b to 111b).
// Essential for routing operational data, tracking memory states, and driving mathematical execution loops.

#define REG_RAX              0       // 000b - Accumulator: Primary register for arithmetic operations, logical accumulation, and function return outputs.
#define REG_RCX              1       // 001b - Counter: Hardcoded loop counter for structured repeat instructions, shifts, and conditional operations.
#define REG_RDX              2       // 010b - Data: Secondary calculation storage; works symmetrically with RAX during wide 128-bit multiplication/division.
#define REG_RBX              3       // 011b - Base: General pointer location register, historically utilized as a secure base address link for data access.
#define REG_RSP              4       // 100b - Stack Pointer: Tracks the physical top offset of the hardware stack array. Altered by PUSH/POP and CALL/RET.
#define REG_RBP              5       // 101b - Base Pointer: Tracks the architectural base foundation of the active stack frame structure.
#define REG_RSI              6       // 110b - Source Index: Primary memory address tracking pointer utilized for streaming data read arrays and tensor operations.
#define REG_RDI              7       // 111b - Destination Index: Target memory address pointer optimized for high-speed block storage writes and string output.

// --- Extended R8-R15 Registers (Requires REX.B bit validation) ---
// [Intel & AMD Cross-Compatible]
// Supplementary general-purpose registers introduced in x86_64. They copy the 3-bit mapping indexes (0 to 7) 
// but require a high REX prefix bit (REX.B or REX.R) to toggle the CPU decoder to look at the extended register array.

#define REG_R8               0       // General Purpose Extended Register: Optimized for raw bulk parameter streaming and mathematical layouts.
#define REG_R9               1       // General Purpose Extended Register: Used heavily in ABI standard layouts to hold fast function input arguments.
#define REG_R10              2       // General Purpose Extended Register: Temporary hardware calculation register; scratch space for intermediate tensor metrics.
#define REG_R11              3       // General Purpose Extended Register: General calculation storage; frequently used as an operational buffer inside tight loops.
#define REG_R12              4       // General Purpose Extended Register: Callee-saved permanent index state tracking pointer.
#define REG_R13              5       // General Purpose Extended Register: Callee-saved general data storage layer; critical for sustaining complex structural loops.
#define REG_R14              6       // General Purpose Extended Register: Callee-saved frame/index tracking register.
#define REG_R15              7       // General Purpose Extended Register: Ultimate temporary storage register; ideal for embedding foundational network layer pointers.

// =================================================================
// SECTION 10: CONTROL REGISTERS MAP (CR)
// =================================================================
// [Intel & AMD Cross-Compatible]
// Control Registers (CR0-CR15) determine the global operational mode of the CPU, 
// managing memory paging, hardware security extensions, and execution privilege levels.
// Accessing these registers requires Ring 0 privileges via MOV CRx instructions.

#define CR_CR0               0       // CR0 - System Control: Configures essential hardware states, including Protected Mode enable (PE), Caching enable (NW/CD), and Paging activation (PG).
#define CR_CR2               2       // CR2 - Page-Fault Linear Address: Automatically populated by the CPU hardware with the exact 64-bit linear address that triggered the most recent Page Fault (#PF).
#define CR_CR3               3       // CR3 - Page Directory Base Register: Holds the physical base address pointer of the foundational PML4/PML5 page table structure, driving the MMU paging engine.
#define CR_CR4               4       // CR4 - Architectural Extensions: Governs advanced hardware features, including Virtual Machine Extensions enable (VMXE), Page Size Extensions (PSE), and SMAP/SMEP security layers.
#define CR_CR8               8       // CR8 - Task Priority Register (TPR): Manages the local APIC interrupt filtering threshold, optimizing high-speed operating system thread scheduling priority [x86_64 Mode Only].

// --- Architectural Shadow & Hidden Control Fields ---
#define CR_XCR0              0       // XCR0 - Extended Control Register 0: XSETBV/XGETBV interface leaf utilized to track and authorize advanced state management tracking for AVX, AVX-512, and AMX register files.
#define CR_CR0_SHADOW        0       // CR0_SHADOW - Hypervisor Read Filter: A virtual hardware layer register that displays a filtered, spoofed variant of CR0 to Guest VMs, bypassing hypervisor trap latency.
#define CR_CR4_SHADOW        4       // CR4_SHADOW - Hypervisor Feature Filter: Mirrors authorized Guest CR4 properties, allowing virtual kernels to audit feature states safely without triggering VMM exits.

// --- Advanced Paging & Thread Control Registers ---

// [Intel & AMD Cross-Compatible]
// ARCHITECTURE NOTE: Extended Control Register 4. Governs the activation of 5-Level Paging (LA57), 
// expanding the virtual address space dynamically up to 128 Petabytes. Essential for modern AI database clusters.
#define CR_CR4_LA57          0x00010000 // CR4.LA57 - 5-Level Paging Enable bit layout mask

// --- Architectural Hypervisor-Nested Control Fields (Intel & AMD Modern) ---

// [Intel Only]
// Virtual Machine Control Structure (VMCS) Shadow Pointer Register. Holds the physical 64-bit 
// memory pointer tracking the active guest VMCS, enabling seamless nested virtualization execution loops.
#define CR_VMCS_POINTER      0x0000000B // VMCS_PTR  - Shadow VMCS structural linkage identifier

// [AMD Only]
// AMD SVM Guest Clean Bits Register mapping field. Allows the Host VMM to tell the hardware memory 
// controller which parts of the Guest state havent changed, bypassing redundant VMCB sync latencies.
#define CR_SVM_CLEAN_BITS    0x0000000C // VMCB_CLEAN - SVM Hardware Translation Cache Filter optimize

// --- Hardware Security & Execution Isolation Masks (Intel & AMD) ---
// ARCHITECTURE NOTE: Bit positions within CR4 that govern mandatory hardware containment. 
// Activating these forces the CPU to block common Kernel exploitation techniques natively.

// CR4.SMEP (Supervisor Mode Execution Prevention): Bit 20. When set to 1, the CPU hardware instantly 
// triggers a Page Fault (#PF) if Ring 0 attempts to execute code from a User Mode (Ring 3) address.
#define CR_CR4_SMEP_BIT      0x00100000 // CR4.SMEP  - Prevents Ring 0 from executing User-space code

// CR4.SMAP (Supervisor Mode Access Prevention): Bit 21. When enabled, forces a hardware exception 
// if Ring 0 tries to read or write data directly within a User Mode memory frame without explicit authorization.
#define CR_CR4_SMAP_BIT      0x00200000 // CR4.SMAP  - Prevents Ring 0 from modifying User-space data

// CR4.UMIP (User-Mode Instruction Prevention): Bit 11. Blocks Ring 3 from executing sensitive system instructions 
// like SGDT, SIDT, or SLDT, blinding local User Mode attackers from analyzing the kernels descriptor layout.
#define CR_CR4_UMIP_BIT      0x00000800 // CR4.UMIP  - Restricts critical system inspection to Ring 0

// --- Extended State Validation Opcodes (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Dedicated instructions used to read and write the XCR0 register file, 
// authorizing the microarchitectural pipeline to track massive AVX-512 and AMX matrix allocations.

// Privileged instruction that writes the composition bitmask from EDX:EAX into the XCR register specified by ECX.
#define OPCODE_XSETBV        0x0F01D1    // XSETBV      - Write Extended Control Register (Enables AVX/AMX states)

// Non-destructive instruction that reads the targeted XCR register into the EDX:EAX register pair.
#define OPCODE_XGETBV        0x0F01D0    // XGETBV      - Read Extended Control Register (Audits active vector states)

// --- Missing Core Control Registers (Intel & AMD Cross-Compatible) ---

// ARCHITECTURE NOTE: Control Register 1. Reserved by the architecture hardware layout. 
// Any attempt to execute a MOV CR1 instruction triggers an immediate Invalid Opcode Exception (#UD).
#define CR_CR1               1           // CR1 - Reserved by architecture (Executing triggers #UD fault)

// ARCHITECTURE NOTE: Control Register 5. Reserved for future architectural expansions or specific internal testing.
// Attempted access configurations vary by microarchitecture generation but traditionally force execution traps.
#define CR_CNF5              5           // CR5 - Configuration Reserved Register

// --- Advanced Hardware Security Control Flags & Encryption Subsystem Registers ---

// [Intel Only]
// Control Register 15 / Intel IA32_PRED_CMD interface. Dedicated silicon register used to issue 
// direct hardware-level commands for speculative branch execution flushing (Mitigates Spectre/Meltdown core exploits).
#define CR_CR15_PRED_CMD     15          // CR15 - Privilege Speculation Command Filter (Core Mitigation)

// [AMD Only]
// AMD SVM Advanced Nested Page Table Cache Identifier (CR3-Equivalent for Guest Mode).
// Holds the hardware context token mapping nested page tables, eliminating duplicate root lookup overhead.
#define CR_SVM_NPT_BASE      0x0000000D  // NPT_CR3 - AMD SVM Nested Paging Root Base mapping token

// =================================================================
// SECTION 11: UNDOCUMENTED, HIDDEN & EXCEPTION OPCODES 
// =================================================================

// [Intel & AMD Cross-Compatible]
// Documented invalid instruction explicitly architected to generate an Invalid Opcode Exception (#UD) 
// deterministically across all privilege rings. Used as a structural software dead-end fence, 
// a runtime execution marker, or for processor microarchitecture fingerprinting.
#define OPCODE_UD2           0x0F0B   // UD2 - Documented Invalid Opcode (Guaranteed to raise #UD exception)

// [Intel & AMD Cross-Compatible]
// Legacy undocumented hardware breakpoint (also known as INT1). Immediately bypasses standard interrupt descriptor 
// table (IDT) routing rules on standard kernels to vector execution straight into a hardware debugger pipeline. 
// Used for anti-analysis and advanced runtime low-level pipeline introspection.
#define OPCODE_ICEBP         0xF1     // ICEBP / INT1 - Undocumented Hardware Breakpoint (Traps directly to debugger)

// [Intel & AMD Cross-Compatible]
// Undocumented legacy instruction (Set AL on Carry). Evaluates the state of the Carry Flag (CF) in RFLAGS 
// and writes 0xFF into the AL register if CF=1, or 0x00 if CF=0. Executes instantly in a single micro-op 
// without mutating any status flags, offering an absolute zero-overhead branchless assignment.
#define OPCODE_SALC          0xD6     // SALC - Undocumented Set AL on Carry (Executes without modifying flags)

// --- Microarchitectural Shadow Fields (Discovered via Decoder Tunneling) ---

// [Intel Only]
// Privileged hidden instruction requiring an active hardware factory mode lock state override (Red Unlock). 
// Grants direct read capabilities into the hidden internal execution queues, microcode structures, and hardware 
// execution registers of the CPU core, completely bypassing Ring 0 OS visibility boundaries.
#define OPCODE_UDBGRD        0x0F0E   // UDBGRD [Intel Only] - Hidden Silicon Debug Register Read (Direct access to internal microcode/hardware registers)

// [Intel Only]
// Privileged hidden instruction requiring active factory-level silicon unlocking validation (Red Unlock). 
// Dynamically writes modifications straight into internal microarchitectural control fields, core clock registers, 
// or microcode patch execution paths, granting ultimate, raw control over the underlying physical silicon.
#define OPCODE_UDDGWR        0x0F0F   // UDDGWR [Intel Only] - Hidden Silicon Debug Register Write (Modifies microarchitectural execution state and hardware registers)

// [Intel & AMD Cross-Compatible]
// Esoteric alternate execution mode leaf (Alternate ISA / RISC Escape). Discovered via advanced decoder tunneling 
// methodologies. Triggers an architectural state shift on specific microarchitectures, allowing the hardware execution 
// unit to process an undocumented embedded hidden command layout or backdoor processing pipeline.
#define OPCODE_ALT_ISA       0x0F3F   // ALTERNATE_ISA - Hidden Hardware Backdoor Leaf (Esoteric RISC mode escape)

// --- Legacy Base-State Bypass & Descriptor Validation Overrides ---

// [Intel Only]
// Legacy undocumented bare-metal backdoor instruction from the 286 era. Forces an absolute reset and load of ALL internal 
// CPU registers, visible state vectors, and hidden segment descriptor caches straight from a fixed memory layout at ES:0x0000. 
// Completely bypasses Protected Mode initialization checks to force-inject an unvalidated raw machine state.
#define OPCODE_LOADALL_286   0x0F04   // LOADALL286 [Intel Only] - Resets entirely all CPU registers & descriptors from ES:0x0000 (Retro Bare-Metal Escape)

// [Intel Only]
// Expanded 32-bit variant of the LOADALL instruction implemented in early 386 architectures. Directly mutates global machine 
// states, descriptor base structures, and segment registers from a dedicated buffer tracked by ES:EDI, completely bypassing 
// structural Protected Mode descriptor table verification pipelines.
#define OPCODE_LOADALL_386   0x0F07   // LOADALL386 [Intel Only] - Undocumented 32-bit state restoration, bypasses Protected Mode descriptor checks

// [Intel Only]
// User Move instruction (Register/Memory to Register). A highly esoteric privileged instruction allowing a Ring 0 kernel 
// thread to directly read or write data targeting User Space segments (Ring 3). Forces immediate hardware-level override 
// of active descriptor segment validations and execution ring tracking.
#define OPCODE_UMOV_RM_R     0x0F10   // UMOV [Intel Only] - User Move (Read/Write to User Space segments directly from Ring 0 without descriptor validation)

// [Intel Only]
// Alternative hardware encoding for the User Move (UMOV) instruction sequence. Utilized in engineering testbeds 
// to verify memory bus isolation mechanics and force-bypass execution pipeline validation loops.
#define OPCODE_UMOV_R_RM     0x0F11   // UMOV [Intel Only] - User Move alternative encoding for hardware testing pipeline bypassing

// [Intel Only]
// Privileged instruction interface designed to interact with hardware Test Registers (TR3-TR7) on early 486 and Pentium architectures. 
// Directly queries hidden silicon diagnostic structures, functional ALU testing buses, and internal hardware logic pipelines.
#define OPCODE_MOV_TR_REG    0x0F24   // MOV TRx [Intel Only] - Read/Write Test Registers (Hidden Silicon diagnostic pipeline used in early 486/Pentium)

// [Intel Only]
// Alternative Test Register interface encoding. Designed explicitly to manipulate and force-validate L1 Cache tag arrays, 
// raw translation lookaside buffers (TLB), and dirty block eviction matrices directly on physical silicon loops.
#define OPCODE_MOV_REG_TR    0x0F26   // MOV TRx [Intel Only] - Alternative Test Register interface used for validation of L1 Cache tag arrays

// [Intel & AMD Cross-Compatible]
// Multi-byte Multi-Decoder Hint NOP. An undocumented structural multi-byte padding instruction that triggers unaligned 
// micro-op prefetch routines within complex instruction decoders. Used for microarchitectural cache-line alignment and execution optimization.
#define OPCODE_RESERVED_NOP  0x0F0D   // HINT_NOP - Multi-byte NOP variant triggering unaligned micro-op prefetch routines on specific decoders

// [Intel & AMD Cross-Compatible]
// Silicon-specific hardware prefetch macro instruction. Instructs the execution prefetch units to load explicit machine instructions 
// directly into hidden microarchitectural execution queues, reducing pipeline bubbles and stalling behaviors inside deeply stacked loops.
#define OPCODE_FF_GRP7       0x0F18   // PREFETCH_RESERVED - Silicon-specific prefetch instruction targeting hidden microarchitectural execution queues

// [Intel & AMD Cross-Compatible]
// Long two-byte software breakpoint signature (0xCD 0x03). Forces an identical operational trap behavior as the standard single-byte 
// INT3 (0xCC) command but utilizes strict vector execution checking. Frequently deployed in anti-debugging environments to test for 
// kernel debugger transparency.
#define OPCODE_INT3_ALT      0xCD03   // INT3_LONG - Two-byte variant of software breakpoint forcing strict vector execution checks on specific OS kernels

// --- Microarchitectural Multi-Byte Long NOPs (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Multi-byte undocumented padding structures. While technically NOPs, 
// they force the complex hardware decoder units to process massive byte-sequences (up to 9 bytes) 
// without mutating architectural states. Used to manipulate instruction prefetch windows.

// Exploits the instruction decoder by utilizing a 4-byte unmapped encoding to bypass shallow code scanning signatures.
#define OPCODE_LONG_NOP_4BYTE 0x0F1F4000 // NOP [Intel & AMD] - Undocumented multi-byte hardware padding sequencing

// Exploits complex decoder tunneling via a 9-byte sequence using structural hardware override prefixes.
#define OPCODE_LONG_NOP_9BYTE 0x660F1F84 // NOP [Intel & AMD] - Maximum architectural instruction length padding loop

// --- Silicon Bug Triggers & Historical Lockups (Intel Native / Architectural Target) ---
// ARCHITECTURE NOTE: Specific byte collisions that exploit hardware design flaws in early x86 architectures. 
// Used by specialized security engines to verify processor generation sandboxing and privilege rings boundaries.

// The Infamous Pentium F00F Bug. Executing an invalid lock instruction sequence on a specific multi-byte 
// CMPXCHG8B structure freezes the entire physical silicon pipeline instantly, forcing a hard system lockup.
#define OPCODE_F00F_BUG      0xF00FC7C8  // LOCK CMPXCHG8B [Intel Legacy] - Hardware design flaw core execution lockup

// --- Esoteric Base-State Shuffles & Segment Escapes (Intel & AMD Cross-Compatible) ---

// Undocumented short 1-byte control state transfer. Pushes the structural Code Segment (CS) selector 
// directly onto the stack context within specific emulation layers, tracking internal descriptor transitions.
#define OPCODE_PUSH_CS_ALT   0x0E        // PUSH CS [Legacy Cross-Compatible] - Undocumented 1-byte segment state backup

// Esoteric 2-byte instruction combination discovered to force hardware translation lookaside buffer (TLB) 
// snooping loops on specific hyperthreaded targets without triggering standard synchronization interrupts.
#define OPCODE_TLB_TUNNEL    0x0F01FF    // TLB_TUNNEL [Intel & AMD] - Decoder escape loop utilized for cache testing

// =================================================================
// SECTION 13: STACK MANAGEMENT & PROCEDURE FRAMES (64-BIT)
// =================================================================

// --- High-Speed Stack Push Mechanics (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Decrements the 64-bit Stack Pointer (RSP) natively and stores the 
// operand data field directly at the newly allocated memory slot pointed to by RSP.

// Pushes a full 64-bit general-purpose register file value onto the hardware stack frame.
// Used embedded opcode mapping (0x50 + Register ID) to eliminate ModR/M byte overhead.
#define OPCODE_PUSH_R64      0x50        // PUSH r64    - Push 64-bit Register onto Stack (0x50 to 0x57)

// Pushes a signed 8-bit immediate value onto the stack. The CPU hardware automatically 
// sign-extends this value to 64-bits before writing to memory to avoid stack alignment pollution.
#define OPCODE_PUSH_IMM8     0x6A        // PUSH imm8   - Push Sign-Extended 8-bit Immediate onto Stack

// Pushes a signed 32-bit immediate value onto the stack, which is dynamically sign-extended 
// to 64-bits natively within the execution pipeline. Ideal for quick stack configuration constants.
#define OPCODE_PUSH_IMM32    0x68        // PUSH imm32  - Push Sign-Extended 32-bit Immediate onto Stack

// --- High-Speed Stack Pop Mechanics (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Fetches the 64-bit data chunk currently sitting at the top of the stack (RSP), 
// loads it into the designated target location, and automatically increments RSP natively.

// Pops the top 64-bit stack entry directly into a designated 64-bit general-purpose register.
// Utilizes optimized 1-byte opcode mapping (0x58 + Register ID) to maximize decoder throughput.
#define OPCODE_POP_R64       0x58        // POP r64     - Pop 64-bit Top of Stack into Register (0x58 to 0x5F)

// --- Architectural Procedure Frame Controls (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Traditional frame-pointer mechanisms used to map and tear down localized, 
// isolated stack scopes (Stack Frames) for deep nested computational functions or subroutines.

// Creates a localized hardware stack frame for incoming variables. It automatically pushes RBP, 
// copies the active RSP descriptor into RBP, and subtracts the immediate size allocation parameter.
#define OPCODE_ENTER         0xC8        // ENTER imm16, imm8 - High-level Procedure Entry Framework

// Destroys the localized active function frame. It copies the current frame pointer (RBP) back into 
// the stack pointer (RSP) and pops the prior saved RBP value, freeing local matrix stack structures instantly.
#define OPCODE_LEAVE         0xC9        // LEAVE       - Release High-level Procedure Frame State

// --- Flags Subsystem Stack Routing (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Atomically stores and restores the system-wide RFLAGS status matrix 
// directly via the stack, allowing the to freeze its computational logic state.

// Decrements RSP by 8 bytes and pushes the entire 64-bit RFLAGS register onto the stack layer.
// Critical for caching mathematical status thresholds before executing volatile side routines.
#define OPCODE_PUSHFQ        0x9C        // PUSHFQ      - Push 64-bit RFLAGS Flag Register onto Stack

// Pops the top 64-bit stack block directly back into the core system RFLAGS engine.
// Immediately updates all processor flags (ZF, SF, CF, OF) natively in a single execution phase.
#define OPCODE_POPFQ         0x9D        // POPFQ       - Pop 64-bit Top of Stack into RFLAGS Register

// --- Advanced Vector Context Stack Management (Intel & AMD Compatibility) ---
// ARCHITECTURE NOTE: Extended floating-point and SIMD vector register context state backup. 
// Requires strict 16-byte, 32-byte, or 64-byte structural stack memory layout alignments.

// Saves the entire modern floating-point, MMX, and standard XMM/YMM register state files to memory.
// Directly deployed to buffer deep neural network layer status models before a sub-kernel function call.
#define OPCODE_XSAVE         0x0FAAE4    // XSAVE       - Save Extended Processor State Matrix (Requires ModR/M /4)

// Restores the full floating-point and vector register profiles natively from a clean memory buffer.
#define OPCODE_XRSTOR        0x0FAAE5    // XRSTOR      - Restore Extended Processor State Matrix (Requires ModR/M /5)

// --- Stack Misalignment Validation Barriers (Intel & AMD Cross-Compatible) ---
// ARCHITECTURE NOTE: Non-destructive address arithmetic operations to enforce strict 16-byte stack boundaries,
// preventing fatal General Protection Fault (#GP) breakdowns during heavy AVX/FMA processing loops.

// Aligns RSP down to a clean 16-byte boundary using a fast, non-destructive bitwise immediate AND block.
#define OPCODE_ALIGN_STACK   0x83E4F0    // AND RSP, -16 - Enforces strict 16-byte structural stack alignment [0x83 /4]


