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

// =================================================================
// SECTION 1: ARCHITECTURAL PREFIXES
// =================================================================
// [Intel & AMD Cross-Compatible]
// REX.W prefix is prepended before the main opcode byte. It overrides the default 
// 32-bit operand size in x86_64 mode, forcing the CPU execution unit to process 
// the target registers and operations using a native 64-bit width.
#define REX_W_PREFIX         0x48    // REX.W prefix - Enforces 64-bit operand size

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
// =================================================================
// SECTION 4: CONTROL FLOW & BRANCHING
// =================================================================
// --- Unconditional Jumps & Calls ---

// [Intel & AMD Cross-Compatible]
// Performs an unconditional relative jump to a target address within a signed 8-bit displacement (-128 to +127 bytes). 
// The hardware execution unit updates the Instruction Pointer (RIP) immediately, bypassing subsequent linear bytes. 
// Highly efficient for tight local loops and structural branch skipping.
#define OPCODE_JMP_SHORT     0xEB    // JMP rel8  - Short jump (1-byte relative offset)

// [Intel & AMD Cross-Compatible]
// Performs an unconditional relative jump using a full signed 32-bit displacement. Allows the pipeline to branch 
// anywhere within a 2GB range relative to the current instruction pointer. Essential for jumping between larger 
// assembly blocks or distinct neural network layers.
#define OPCODE_JMP_NEAR      0xE9    // JMP rel32 - Near jump (4-byte relative offset)

// [Intel & AMD Cross-Compatible]
// Executes an absolute indirect jump. The target destination address is loaded dynamically from a specified 
// general-purpose register or a raw memory pointer. Critical for building jump tables and accelerating dynamic 
// execution routing based on AI kernel configurations.
#define OPCODE_JMP_INDIRECT  0xFF    // JMP /4    - Absolute indirect jump via reg/mem

// [Intel & AMD Cross-Compatible]
// Pushes the current return address (RIP of the next instruction) onto the stack and executes a relative call 
// to a procedure using a signed 32-bit displacement. Used for branching into subsystem initializations, 
// hardware setup routines, or modular computational subroutines.
#define OPCODE_CALL_NEAR     0xE8    // CALL rel32 - Near relative function call

// --- Conditional Jumps (Short Forms) ---

// [Intel & AMD Cross-Compatible]
// Evaluates the Zero Flag (ZF) in the RFLAGS register. If ZF is set to 1 (indicating a result of zero or equality 
// from a previous operation like CMP or TEST), the CPU branches to a signed 8-bit relative offset. 
// Used for terminating exact vector loops and verifying operational statuses.
#define OPCODE_JE_SHORT      0x74    // JZ/JE rel8   - Jump if Zero / Equal

// [Intel & AMD Cross-Compatible]
// Evaluates the Zero Flag (ZF). If ZF is cleared to 0 (indicating a non-zero or non-equal result), the execution 
// pipeline jumps to a signed 8-bit relative offset. Vital for sustaining inner tensor matrix loops until boundaries are reached.
#define OPCODE_JNE_SHORT     0x75    // JNZ/JNE rel8  - Jump if Not Zero / Not Equal

// [Intel & AMD Cross-Compatible]
// Evaluates signed comparison flags. If the Zero Flag (ZF) is 0 AND the Sign Flag (SF) equals the Overflow Flag (OF), 
// the CPU executes a relative 8-bit jump. Used to process signed matrix dimensions or mathematical scale activations.
#define OPCODE_JG_SHORT      0x7F    // JG rel8    - Jump if Greater (Signed)

// [Intel & AMD Cross-Compatible]
// Evaluates signed comparison flags. If the Sign Flag (SF) does not equal the Overflow Flag (OF), the CPU branches 
// to a signed 8-bit relative displacement. Essential for lower-bound checking and sub-matrix element constraints.
#define OPCODE_JL_SHORT      0x7C    // JL rel8    - Jump if Less (Signed)

// =================================================================
// SECTION 5: ADVANCED SIMD, VECTOR & ACCELERATION (AVX-512)
// =================================================================
// [Intel & AMD Cross-Compatible]
// Executes a vector SIMD parallel addition of packed double-precision (64-bit) floating-point values. 
// Processes multiple scientific values simultaneously across wide vector registers (e.g., ZMM or YMM). 
// Highly optimized for bulk tensor normalization and vector scaling operations on the CPU core.
#define OPCODE_VADDPD        0x660F58 // VADDPD - Vector Double-Precision Float Addition

// [Intel & AMD Cross-Compatible]
// Computes a vector SIMD parallel multiplication of packed double-precision (64-bit) floating-point matrices. 
// Multiplies sequential data chunks in a single pipeline cycle. Core instruction for executing manual non-GPU 
// linear algebra operations, weight dot-products, and high-precision forward propagation.
#define OPCODE_VMULPD        0x660F59 // VMULPD - Vector Double-Precision Float Multiplication

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

// =================================================================
// SECTION 11: UNDOCUMENTED, HIDDEN & EXCEPTION OPCODES (SILICON ZERO-DAY)
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
