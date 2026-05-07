# Trojan Generation Summary

**Module:** of
**File:** ibex_core.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (66):**
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- data_we_o
- ... and 61 more

**Payload Signals (70):**
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- data_we_o
- ... and 65 more

**Generated File:** T1_of_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (31):**
- data_we_o
- rf_we_wb_o
- ic_tag_write_o
- ic_data_write_o
- debug_req_i
- ... and 26 more

**Payload Signals (149):**
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- data_req_o
- data_gnt_i
- ... and 144 more

**Generated File:** T2_of_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (79):**
- boot_addr_i
- instr_addr_o
- data_we_o
- data_addr_o
- rf_raddr_a_o
- ... and 74 more

**Payload Signals (11):**
- rvfi_mode
- rvfi_ext_debug_mode
- rvfi_mode
- rvfi_ext_debug_mode
- multdiv_signed_mode_ex
- ... and 6 more

**Generated File:** T3_of_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (146):**
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- data_req_o
- data_gnt_i
- ... and 141 more

**Payload Signals (102):**
- instr_rdata_i
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_we_o
- ... and 97 more

**Generated File:** T4_of_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (59):**
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- ic_tag_req_o
- ... and 54 more

**Payload Signals (39):**
- instr_gnt_i
- instr_rvalid_i
- data_gnt_i
- data_rvalid_i
- ic_scr_key_valid_i
- ... and 34 more

**Generated File:** T5_of_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (98):**
- instr_rdata_i
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_we_o
- ... and 93 more

**Payload Signals (126):**
- instr_rvalid_i
- instr_rdata_i
- data_req_o
- data_gnt_i
- data_rvalid_i
- ... and 121 more

**Generated File:** T6_of_Covert.sv

---

