# Functional RTL simulation captures

- [Waveform](images/rtl_simulation_waveform.png) shows the input, output, and internal signals of the symmetric FIR datapath.
- [Impulse and DC inputs](images/rtl_test_cases_1_2.png) exercise the filter response to those stimuli.
- [Alternating inputs and data-valid gaps](images/rtl_test_cases_3_4.png) exercise sample handling.
- [Random inputs](images/rtl_test_case_5.png) exercise varied sample values.
- [Test summary](images/rtl_test_summary.png) records 85 passing checks, zero failures, and two cycles of latency.

The [testbench notes](../tb/README.md) describe the output-width scope of the simulation. The [project cover](images/linkedin_cover.png) summarizes the final implementation metrics.
