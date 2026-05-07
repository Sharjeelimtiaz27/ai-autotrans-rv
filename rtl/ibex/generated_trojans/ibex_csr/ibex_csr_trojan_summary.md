# Trojan Generation Summary

**Module:** ibex_csr
**File:** ibex_csr.sv
**Type:** Sequential
**Total Candidates:** 3

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (1):**
- wr_en_i

**Payload Signals (1):**
- wr_en_i

**Generated File:** T1_ibex_csr_DoS.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (4):**
- wr_data_i
- rd_data_o
- rd_data_o
- rdata_q

**Payload Signals (4):**
- wr_data_i
- rd_data_o
- rd_data_o
- rdata_q

**Generated File:** T2_ibex_csr_Integrity.sv

---

### T3: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (4):**
- wr_data_i
- rd_data_o
- rd_data_o
- rdata_q

**Payload Signals (4):**
- wr_data_i
- rd_data_o
- rd_data_o
- rdata_q

**Generated File:** T3_ibex_csr_Covert.sv

---

