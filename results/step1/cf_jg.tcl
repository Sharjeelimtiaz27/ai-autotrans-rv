clear -all

analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_pkg.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_controller.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/assertions/translated/cf_bind.sv}

elaborate -top ibex_controller
clock clk_i
reset -expression {!rst_ni}

prove -all

report -results -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/cf_fpv_baseline.txt}
catch {report -vacuity -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/cf_vacuity.txt}}
catch {report -cov     -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/cf_cov.txt}}
exit
