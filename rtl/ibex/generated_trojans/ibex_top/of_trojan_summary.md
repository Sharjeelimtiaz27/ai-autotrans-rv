# Trojan Generation Summary

**Module:** of
**File:** ibex_top.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (48):**
- test_en_i
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- ... and 43 more

**Payload Signals (48):**
- test_en_i
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- ... and 43 more

**Generated File:** T1_of_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (16):**
- test_en_i
- data_we_o
- debug_req_i
- rvfi_mode
- rvfi_ext_debug_mode
- ... and 11 more

**Payload Signals (102):**
- ram_cfg_icache_data_i
- ram_cfg_rsp_icache_data_o
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- ... and 97 more

**Generated File:** T2_of_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (42):**
- boot_addr_i
- instr_addr_o
- data_we_o
- data_addr_o
- rvfi_mode
- ... and 37 more

**Payload Signals (4):**
- rvfi_mode
- rvfi_ext_debug_mode
- rvfi_mode
- rvfi_ext_debug_mode

**Generated File:** T3_of_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (102):**
- ram_cfg_icache_data_i
- ram_cfg_rsp_icache_data_o
- boot_addr_i
- instr_addr_o
- instr_rdata_i
- ... and 97 more

**Payload Signals (80):**
- ram_cfg_icache_data_i
- ram_cfg_rsp_icache_data_o
- instr_rdata_i
- instr_rdata_intg_i
- data_req_o
- ... and 75 more

**Generated File:** T4_of_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (40):**
- instr_req_o
- instr_rvalid_i
- data_req_o
- data_rvalid_i
- scramble_key_valid_i
- ... and 35 more

**Payload Signals (23):**
- instr_gnt_i
- instr_rvalid_i
- data_gnt_i
- data_rvalid_i
- scramble_key_valid_i
- ... and 18 more

**Generated File:** T5_of_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (84):**
- ram_cfg_icache_data_i
- ram_cfg_rsp_icache_data_o
- instr_rdata_i
- instr_rdata_intg_i
- data_req_o
- ... and 79 more

**Payload Signals (94):**
- ram_cfg_icache_data_i
- ram_cfg_rsp_icache_data_o
- instr_rvalid_i
- instr_rdata_i
- instr_rdata_intg_i
- ... and 89 more

**Generated File:** T6_of_Covert.sv

---

