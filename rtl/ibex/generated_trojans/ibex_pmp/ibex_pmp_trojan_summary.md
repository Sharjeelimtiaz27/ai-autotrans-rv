# Trojan Generation Summary

**Module:** ibex_pmp
**File:** ibex_pmp.sv
**Type:** Combinational
**Total Candidates:** 5

---

## Generated Trojans

### T1: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (7):**
- csr_pmp_cfg_i
- csr_pmp_addr_i
- csr_pmp_mseccfg_i
- debug_mode_i
- priv_mode_i
- ... and 2 more

**Payload Signals (7):**
- csr_pmp_cfg_i
- csr_pmp_addr_i
- csr_pmp_mseccfg_i
- pmp_req_addr_i
- region_start_addr
- ... and 2 more

**Generated File:** T1_ibex_pmp_Leak.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (4):**
- csr_pmp_addr_i
- pmp_req_addr_i
- region_start_addr
- region_addr_mask

**Payload Signals (1):**
- result

**Generated File:** T2_ibex_pmp_Integrity.sv

---

### T3: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (3):**
- access_fault_check_res
- debug_mode_allowed_access
- access_fail

**Payload Signals (1):**
- result

**Generated File:** T3_ibex_pmp_Covert.sv

---

### T4: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 0.80
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (6):**
- pmp_req_addr_i
- ibex_pkg::pmp_req_e
- pmp_req_type_i
- pmp_req_err_o
- pmp_req_err_o
- ... and 1 more

**Payload Signals (6):**
- pmp_req_addr_i
- ibex_pkg::pmp_req_e
- pmp_req_type_i
- pmp_req_err_o
- pmp_req_err_o
- ... and 1 more

**Generated File:** T4_ibex_pmp_DoS.sv

---

### T5: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 0.80
**Description:** Escalates privilege level to machine mode

**Trigger Signals (10):**
- csr_pmp_cfg_i
- csr_pmp_addr_i
- csr_pmp_mseccfg_i
- debug_mode_i
- priv_mode_i
- ... and 5 more

**Payload Signals (5):**
- debug_mode_i
- ibex_pkg::priv_lvl_e
- priv_mode_i
- debug_mode_allowed_access
- |region_csr_pmp_cfg.mode

**Generated File:** T5_ibex_pmp_Privilege.sv

---

