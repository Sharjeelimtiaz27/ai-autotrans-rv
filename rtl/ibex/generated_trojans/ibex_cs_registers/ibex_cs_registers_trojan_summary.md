# Trojan Generation Summary

**Module:** ibex_cs_registers
**File:** ibex_cs_registers.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (31):**
- csr_op_en_i
- trigger_match_o
- dummy_instr_en_o
- dummy_instr_seed_en_o
- icache_enable_o
- ... and 26 more

**Payload Signals (29):**
- csr_op_en_i
- dummy_instr_en_o
- dummy_instr_seed_en_o
- icache_enable_o
- ic_scr_key_valid_i
- ... and 24 more

**Generated File:** T1_ibex_cs_registers_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (91):**
- priv_mode_id_o
- priv_mode_lsu_o
- csr_mstatus_tw_o
- csr_mtvec_o
- csr_mtvec_init_i
- ... and 86 more

**Payload Signals (72):**
- csr_mstatus_tw_o
- csr_mtvec_o
- csr_mtvec_init_i
- boot_addr_i
- csr_access_i
- ... and 67 more

**Generated File:** T2_ibex_cs_registers_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (91):**
- priv_mode_id_o
- priv_mode_lsu_o
- csr_mstatus_tw_o
- csr_mtvec_o
- csr_mtvec_init_i
- ... and 86 more

**Payload Signals (25):**
- ibex_pkg::priv_lvl_e
- priv_mode_id_o
- ibex_pkg::priv_lvl_e
- priv_mode_lsu_o
- csr_mstatus_tw_o
- ... and 20 more

**Generated File:** T3_ibex_cs_registers_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (37):**
- boot_addr_i
- csr_addr_i
- csr_wdata_i
- ibex_pkg::csr_op_e
- csr_op_i
- ... and 32 more

**Payload Signals (17):**
- csr_wdata_i
- csr_rdata_o
- data_ind_timing_o
- mem_store_i
- csr_wdata_i
- ... and 12 more

**Generated File:** T4_ibex_cs_registers_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (20):**
- priv_mode_lsu_o
- ibex_pkg::csr_op_e
- csr_op_i
- csr_op_en_i
- trigger_match_o
- ... and 15 more

**Payload Signals (12):**
- ic_scr_key_valid_i
- iside_wait_i
- dside_wait_i
- mul_wait_i
- div_wait_i
- ... and 7 more

**Generated File:** T5_ibex_cs_registers_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (20):**
- csr_access_i
- csr_wdata_i
- csr_rdata_o
- data_ind_timing_o
- ic_scr_key_valid_i
- ... and 15 more

**Payload Signals (26):**
- csr_wdata_i
- csr_rdata_o
- data_ind_timing_o
- ic_scr_key_valid_i
- iside_wait_i
- ... and 21 more

**Generated File:** T6_ibex_cs_registers_Covert.sv

---

