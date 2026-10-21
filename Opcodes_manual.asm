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

// =================================================================
// OPCODES.PTX - Instruction Set Architecture (ISA) Map
// Target Architecture: x86_64 (Intel VT-x & AMD-V Cross-Compatible)
// Compiled for NVIDIA GPU Execution / Clean Tokenizer Definitions
// =================================================================

// =================================================================
// SECTION 1: ARCHITECTURAL PREFIXES
// =================================================================
#define REX_W_PREFIX         0x48    // REX.W prefix - Enforces 64-bit operand size

// =================================================================
// SECTION 2: DATA MOVEMENT OPCODES (MOV)
// =================================================================
#define OPCODE_MOV_RM8_REG8  0x88    // MOV r/m8, reg8   - Move 8-bit register to register/memory
#define OPCODE_MOV_RM_REG    0x89    // MOV r/m64, r64   - Move 64-bit register to register/memory
#define OPCODE_MOV_REG_RM    0x8B    // MOV r64, r/m64   - Move 64-bit register/memory to register
#define OPCODE_MOV_REG_IMM8  0xB0    // MOV reg8, imm8   - Move immediate 8-bit value to register
#define OPCODE_MOV_REG_IMM   0xB8    // MOV reg64, imm64 - Move immediate 64-bit value to register

// =================================================================
// SECTION 3: ARITHMETIC & LOGIC OPCODES (ALU)
// =================================================================
// --- Standard Arithmetic ---
#define OPCODE_ADD_RM_REG    0x01    // ADD r/m64, r64   - Integer Addition
#define OPCODE_SUB_RM_REG    0x29    // SUB r/m64, r64   - Integer Subtraction
#define OPCODE_CMP_RM_REG    0x39    // CMP r/m64, r64   - Compare Operands (Sets Flags)

// --- Logical Operands (Symmetric Bitwise Matrices) ---
#define OPCODE_AND_RM8_REG8  0x20    // AND r/m8, reg8   - Logical AND (8-bit)
#define OPCODE_AND_RM_REG    0x21    // AND r/m64, r64   - Logical AND (64-bit)
#define OPCODE_AND_REG_RM    0x23    // AND r64, r/m64   - Logical AND (Load mode)

#define OPCODE_OR_RM8_REG8   0x08    // OR r/m8, reg8    - Logical OR (8-bit)
#define OPCODE_OR_RM_REG     0x09    // OR r/m64, r64    - Logical OR (64-bit)
#define OPCODE_OR_REG_RM     0x0B    // OR r64, r/m64    - Logical OR (Load mode)

#define OPCODE_XOR_RM8_REG8  0x30    // XOR r/m8, reg8   - Logical XOR (8-bit)
#define OPCODE_XOR_RM_REG    0x31    // XOR r/m64, r64   - Logical XOR (64-bit)
#define OPCODE_XOR_REG_RM    0x33    // XOR r64, r/m64   - Logical XOR (Load mode)

// =================================================================
// SECTION 4: CONTROL FLOW & BRANCHING
// =================================================================
// --- Unconditional Jumps & Calls ---
#define OPCODE_JMP_SHORT     0xEB    // JMP rel8  - Short jump (1-byte relative offset)
#define OPCODE_JMP_NEAR      0xE9    // JMP rel32 - Near jump (4-byte relative offset)
#define OPCODE_JMP_INDIRECT  0xFF    // JMP /4    - Absolute indirect jump via reg/mem
#define OPCODE_CALL_NEAR     0xE8    // CALL rel32 - Near relative function call

// --- Conditional Jumps (Short Forms) ---
#define OPCODE_JE_SHORT      0x74    // JZ/JE rel8   - Jump if Zero / Equal
#define OPCODE_JNE_SHORT     0x75    // JNZ/JNE rel8  - Jump if Not Zero / Not Equal
#define OPCODE_JG_SHORT      0x7F    // JG rel8    - Jump if Greater (Signed)
#define OPCODE_JL_SHORT      0x7C    // JL rel8    - Jump if Less (Signed)

// =================================================================
// SECTION 5: SYSTEM & KERNEL OPERATION CONTROL
// =================================================================
#define OPCODE_TEST_RM_REG   0x85    // TEST r/m64, r64 - Non-destructive bit test (Sets flags)
#define OPCODE_NOP           0x90    // NOP - No Operation (Used for boundary alignment)
#define OPCODE_SYSCALL       0x0F05  // SYSCALL - Native OS/Kernel interface (0F 05)
#define OPCODE_RET           0xC3    // RET - Near return to calling procedure

// --- Control Registers Interface ---
#define OPCODE_MOV_REG_CR    0x0F20  // MOV r64, crX - Read Control Register (0F 20)
#define OPCODE_MOV_CR_REG    0x0F22  // MOV crX, r64 - Write Control Register (0F 22)

// --- Native Hypervisor / VMM Extensions ---
#define OPCODE_VMMCALL       0x0F01D9 // VMMCALL - AMD-V Hypervisor Call (0F 01 D9)
#define OPCODE_VMCALL        0x0F01C1 // VMCALL - Intel VT-x Hypervisor Call (0F 01 C1)
#define OPCODE_VMLAUNCH      0x0F01C2 // VMLAUNCH - Launch Virtual Machine (Intel)
#define OPCODE_VMRESUME      0x0F01C3 // VMRESUME - Resume Virtual Machine (Intel)

// =================================================================
// SECTION 6: GENERAL PURPOSE REGISTERS MAP (GPR)
// Standard 3-bit hardware identifiers used in ModR/M and opcode extensions
// =================================================================
// --- Legacy Base Registers ---
#define REG_RAX              0       // 000b - Accumulator
#define REG_RCX              1       // 001b - Counter
#define REG_RDX              2       // 010b - Data
#define REG_RBX              3       // 011b - Base
#define REG_RSP              4       // 100b - Stack Pointer
#define REG_RBP              5       // 101b - Base Pointer
#define REG_RSI              6       // 110b - Source Index
#define REG_RDI              7       // 111b - Destination Index

// --- Extended R8-R15 Registers (Requires REX.B bit validation) ---
#define REG_R8               0       // 000b with extension bit active
#define REG_R9               1       // 001b with extension bit active
#define REG_R10              2       // 010b with extension bit active
#define REG_R11              3       // 011b with extension bit active
#define REG_R12              4       // 100b with extension bit active
#define REG_R13              5       // 101b with extension bit active
#define REG_R14              6       // 110b with extension bit active
#define REG_R15              7       // 111b with extension bit active

// =================================================================
// SECTION 7: CONTROL REGISTERS MAP (CR)
// =================================================================
#define CR_CR0               0       // CR0 - System Control
#define CR_CR3               3       // CR3 - Page Directory Base (Pointer to PML4)
#define CR_CR4               4       // CR4 - Architectural Extensions (VMXE authorization bit)

// =================================================================
// SECTION 8: HARDWARE MSRS COMMANDS 
// =================================================================
// --- TLB, Descriptors & CPU Synchronization ---
#define OPCODE_CPUID         0x0FA2  // CPUID - CPU Identification & Pipeline Serialization
#define OPCODE_INVLPG        0x0F01  // INVLPG - Invalidate TLB Entry (Requires ModR/M extension)
#define OPCODE_LGDT          0x0F01  // LGDT - Load Global Descriptor Table
#define OPCODE_LIDT          0x0F01  // LIDT - Load Interrupt Descriptor Table

// --- Model-Specific Registers (MSR) Control ---
#define OPCODE_RDMSR         0x0F32  // RDMSR - Read From Model-Specific Register
#define OPCODE_WRMSR         0x0F30  // WRMSR - Write To Model-Specific Register

// --- Advanced Intel VT-x VMX Management ---
#define OPCODE_VMXON         0xF30F3C // VMXON - Enable VMX Operation (Intel)
#define OPCODE_VMXOFF        0x0F3C   // VMXOFF - Disable VMX Operation (Intel)
#define OPCODE_VMWRITE       0x0F79   // VMWRITE - Write Field to VMCS Structure
#define OPCODE_VMREAD        0x0F78   // VMREAD - Read Field from VMCS Structure
#define OPCODE_VMPTRLD       0x0FC7   // VMPTRLD - Load Pointer to Active VMCS




