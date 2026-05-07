# Trojan Generation Summary

**Module:** instantiates
**File:** ibex_lockstep.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (26):**
- instr_req_i
- instr_rvalid_i
- data_req_i
- data_rvalid_i
- data_we_i
- ... and 21 more

**Payload Signals (26):**
- instr_req_i
- instr_rvalid_i
- data_req_i
- data_rvalid_i
- data_we_i
- ... and 21 more

**Generated File:** T1_instantiates_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (11):**
- data_we_i
- rf_we_wb_i
- ic_tag_write_i
- ic_data_write_i
- debug_req_i
- ... and 6 more

**Payload Signals (52):**
- boot_addr_i
- instr_addr_i
- instr_rdata_i
- data_req_i
- data_gnt_i
- ... and 47 more

**Generated File:** T2_instantiates_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (51):**
- boot_addr_i
- instr_addr_i
- instr_rdata_i
- data_req_i
- data_gnt_i
- ... and 46 more

**Payload Signals (43):**
- instr_rdata_i
- data_req_i
- data_gnt_i
- data_rvalid_i
- data_we_i
- ... and 38 more

**Generated File:** T3_instantiates_Integrity.sv

---

### T4: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (18):**
- instr_req_i
- instr_rvalid_i
- data_req_i
- data_rvalid_i
- ic_tag_req_i
- ... and 13 more

**Payload Signals (10):**
- instr_gnt_i
- instr_rvalid_i
- data_gnt_i
- data_rvalid_i
- ic_scr_key_valid_i
- ... and 5 more

**Generated File:** T4_instantiates_Availability.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (43):**
- instr_rdata_i
- data_req_i
- data_gnt_i
- data_rvalid_i
- data_we_i
- ... and 38 more

**Payload Signals (47):**
- instr_rvalid_i
- instr_rdata_i
- data_req_i
- data_gnt_i
- data_rvalid_i
- ... and 42 more

**Generated File:** T5_instantiates_Covert.sv

---

