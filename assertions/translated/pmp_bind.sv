// ibex_pmp_bind.sv
// ai-autotrans-rv -- ATS pipeline output
// Source processor : NS31A
// Target processor : Ibex (lowRISC)
// Module           : ibex_pmp
// Type             : Combinational
//
// QuestaSim 2024.3 rejects unclocked 'assert property' (vlog-1957).
// Combinational assertions use 'always_comb' + immediate 'assert' instead.
// JasperGold 2024 treats immediate assertions in procedural blocks as
// formal safety properties, so this compiles AND runs under FPV.
//
// Key Ibex PMP semantics (from ibex_pmp.sv):
//   debug_mode_allowed_access[c] = debug_mode_i
//                                  & ((addr[31:0] & ~DmAddrMask) == DmBaseAddr)
//   access_fault (unmatched, M-mode, no MMWP/MML) = 0
//   pmp_req_err_o[c] = ~debug_mode_allowed_access[c] & access_fault_check_res[c]

module ibex_pmp_assertions
    import ibex_pkg::*;
#(
    parameter int unsigned DmBaseAddr     = 32'h1A110000,
    parameter int unsigned DmAddrMask     = 32'h00000FFF,
    parameter int unsigned PMPGranularity = 0,
    parameter int unsigned PMPNumChan     = 2,
    parameter int unsigned PMPNumRegions  = 4
) (
    // ALL ports are input -- assertion module observes only, never drives
    input  pmp_cfg_t              csr_pmp_cfg_i    [PMPNumRegions],
    input  logic [PMP_ADDR_MSB:0] csr_pmp_addr_i   [PMPNumRegions],
    input  pmp_mseccfg_t          csr_pmp_mseccfg_i,
    input  logic                  debug_mode_i,
    input  priv_lvl_e             priv_mode_i      [PMPNumChan],
    input  logic [PMP_ADDR_MSB:0] pmp_req_addr_i   [PMPNumChan],
    input  pmp_req_e              pmp_req_type_i   [PMPNumChan],
    input  logic                  pmp_req_err_o    [PMPNumChan]
);

  // -----------------------------------------------------------------------
  // Security assertions -- translated from NS31A by ai-autotrans-rv ATS
  //
  // NS31A assumed unconditional debug bypass and unconditional M-mode bypass.
  // Ibex implements:
  //   - Debug bypass: ONLY for the Debug Module address range (DmBaseAddr)
  //   - M-mode bypass: only when no PMP region matches (all entries OFF)
  // Assertions below capture Ibex's actual security guarantees.
  // -----------------------------------------------------------------------

  // Convenience wires for readability
  wire ch0_in_dm = (pmp_req_addr_i[0][31:0] & ~DmAddrMask) == DmBaseAddr[31:0];
  wire ch1_in_dm = (pmp_req_addr_i[1][31:0] & ~DmAddrMask) == DmBaseAddr[31:0];
  wire all_off   = (csr_pmp_cfg_i[0].mode == PMP_MODE_OFF) &
                   (csr_pmp_cfg_i[1].mode == PMP_MODE_OFF) &
                   (csr_pmp_cfg_i[2].mode == PMP_MODE_OFF) &
                   (csr_pmp_cfg_i[3].mode == PMP_MODE_OFF);

  always_comb begin

    // pmp_SEC_1: Debug mode + DM address range bypasses PMP on channel 0
    // NS31A: debug access must not be blocked by any PMP entry
    a_pmp_SEC_1: assert (!(debug_mode_i && ch0_in_dm) || !pmp_req_err_o[0])
      else $error("pmp_SEC_1: debug+DM range must bypass PMP on ch0");

    // pmp_SEC_2: Debug mode + DM address range bypasses PMP on channel 1
    a_pmp_SEC_2: assert (!(debug_mode_i && ch1_in_dm) || !pmp_req_err_o[1])
      else $error("pmp_SEC_2: debug+DM range must bypass PMP on ch1");

    // pmp_SEC_3: M-mode bypasses PMP on ch0 when no regions active (all OFF)
    // NS31A: machine-mode has unrestricted access when no lock bits set
    a_pmp_SEC_3: assert (
      !(priv_mode_i[0] == PRIV_LVL_M && !csr_pmp_mseccfg_i.mmwp &&
        !csr_pmp_mseccfg_i.mml && all_off) || !pmp_req_err_o[0])
      else $error("pmp_SEC_3: M-mode ch0 must succeed when all regions OFF");

    // pmp_SEC_4: M-mode bypasses PMP on ch1 when no regions active (all OFF)
    a_pmp_SEC_4: assert (
      !(priv_mode_i[1] == PRIV_LVL_M && !csr_pmp_mseccfg_i.mmwp &&
        !csr_pmp_mseccfg_i.mml && all_off) || !pmp_req_err_o[1])
      else $error("pmp_SEC_4: M-mode ch1 must succeed when all regions OFF");

    // pmp_SEC_5: Debug mode clears errors on all channels for DM range
    // NS31A: privileged/debug access unrestricted across the full PMP unit
    a_pmp_SEC_5: assert (
      !(debug_mode_i && ch0_in_dm && ch1_in_dm) ||
      (!pmp_req_err_o[0] && !pmp_req_err_o[1]))
      else $error("pmp_SEC_5: debug+DM range must clear both channels");

    // pmp_SEC_6: M-mode READ succeeds on ch0 when all regions OFF, no MMWP/MML
    a_pmp_SEC_6: assert (
      !(priv_mode_i[0] == PRIV_LVL_M && !csr_pmp_mseccfg_i.mmwp &&
        !csr_pmp_mseccfg_i.mml && all_off &&
        pmp_req_type_i[0] == PMP_ACC_READ) || !pmp_req_err_o[0])
      else $error("pmp_SEC_6: M-mode READ ch0 must succeed when all regions OFF");

    // pmp_SEC_7: M-mode WRITE succeeds on ch0 when all regions OFF, no MMWP/MML
    a_pmp_SEC_7: assert (
      !(priv_mode_i[0] == PRIV_LVL_M && !csr_pmp_mseccfg_i.mmwp &&
        !csr_pmp_mseccfg_i.mml && all_off &&
        pmp_req_type_i[0] == PMP_ACC_WRITE) || !pmp_req_err_o[0])
      else $error("pmp_SEC_7: M-mode WRITE ch0 must succeed when all regions OFF");

    // pmp_SEC_8: M-mode EXEC succeeds on ch0 when all regions OFF, no MMWP/MML
    // Note: MML=1 denies unmatched EXEC for M-mode; MML=0 is required here
    a_pmp_SEC_8: assert (
      !(priv_mode_i[0] == PRIV_LVL_M && !csr_pmp_mseccfg_i.mmwp &&
        !csr_pmp_mseccfg_i.mml && all_off &&
        pmp_req_type_i[0] == PMP_ACC_EXEC) || !pmp_req_err_o[0])
      else $error("pmp_SEC_8: M-mode EXEC ch0 must succeed when all regions OFF");

    // pmp_SEC_9: M-mode with all regions OFF succeeds on both channels
    a_pmp_SEC_9: assert (
      !(priv_mode_i[0] == PRIV_LVL_M && priv_mode_i[1] == PRIV_LVL_M &&
        !csr_pmp_mseccfg_i.mmwp && !csr_pmp_mseccfg_i.mml && all_off) ||
      (!pmp_req_err_o[0] && !pmp_req_err_o[1]))
      else $error("pmp_SEC_9: M-mode must succeed on all channels when all regions OFF");

    // pmp_SEC_10: Debug mode + DM range on ch0 does not block access
    // (single channel form, complement to SEC_1 with explicit error check)
    a_pmp_SEC_10: assert (!(debug_mode_i && ch0_in_dm) || !pmp_req_err_o[0])
      else $error("pmp_SEC_10: debug+DM ch0 must never error");

  end

endmodule

bind ibex_pmp ibex_pmp_assertions #(
    .DmBaseAddr     (DmBaseAddr),
    .DmAddrMask     (DmAddrMask),
    .PMPGranularity (PMPGranularity),
    .PMPNumChan     (PMPNumChan),
    .PMPNumRegions  (PMPNumRegions)
) u_pmp_assert (
    .csr_pmp_cfg_i    (csr_pmp_cfg_i),
    .csr_pmp_addr_i   (csr_pmp_addr_i),
    .csr_pmp_mseccfg_i(csr_pmp_mseccfg_i),
    .debug_mode_i     (debug_mode_i),
    .priv_mode_i      (priv_mode_i),
    .pmp_req_addr_i   (pmp_req_addr_i),
    .pmp_req_type_i   (pmp_req_type_i),
    .pmp_req_err_o    (pmp_req_err_o)
);
