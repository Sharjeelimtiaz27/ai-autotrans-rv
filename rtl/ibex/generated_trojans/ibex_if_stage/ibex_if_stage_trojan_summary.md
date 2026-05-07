# Trojan Generation Summary

**Module:** ibex_if_stage
**File:** ibex_if_stage.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (30):**
- req_i
- instr_req_o
- instr_rvalid_i
- ic_tag_req_o
- ic_data_req_o
- ... and 25 more

**Payload Signals (30):**
- req_i
- instr_req_o
- instr_rvalid_i
- ic_tag_req_o
- ic_data_req_o
- ... and 25 more

**Generated File:** T1_ibex_if_stage_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (13):**
- ic_tag_write_o
- ic_data_write_o
- csr_mepc_i
- csr_depc_i
- csr_mtvec_i
- ... and 8 more

**Payload Signals (56):**
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- ic_tag_addr_o
- ic_tag_wdata_o
- ... and 51 more

**Generated File:** T2_ibex_if_stage_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (29):**
- boot_addr_i
- instr_addr_o
- ic_tag_write_o
- ic_tag_addr_o
- ic_data_write_o
- ... and 24 more

**Payload Signals (6):**
- csr_mepc_i
- csr_mtvec_i
- csr_mtvec_init_o
- csr_mepc_i
- csr_mtvec_i
- ... and 1 more

**Generated File:** T3_ibex_if_stage_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (48):**
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- ic_tag_addr_o
- ic_tag_wdata_o
- ... and 43 more

**Payload Signals (36):**
- instr_rdata_i
- ic_tag_write_o
- ic_tag_wdata_o
- ic_tag_rdata_i
- ic_data_req_o
- ... and 31 more

**Generated File:** T4_ibex_if_stage_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (21):**
- req_i
- instr_req_o
- instr_rvalid_i
- ic_tag_req_o
- ic_data_req_o
- ... and 16 more

**Payload Signals (18):**
- instr_gnt_i
- instr_rvalid_i
- ic_scr_key_valid_i
- instr_valid_id_o
- instr_valid_clear_i
- ... and 13 more

**Generated File:** T5_ibex_if_stage_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (38):**
- instr_rdata_i
- ic_tag_wdata_o
- ic_tag_rdata_i
- ic_data_req_o
- ic_data_write_o
- ... and 33 more

**Payload Signals (49):**
- instr_rvalid_i
- instr_rdata_i
- ic_tag_wdata_o
- ic_tag_rdata_i
- ic_data_req_o
- ... and 44 more

**Generated File:** T6_ibex_if_stage_Covert.sv

---

