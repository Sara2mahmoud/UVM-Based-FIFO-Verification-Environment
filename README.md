
# UVM-Based FIFO Verification Environment
## 📌 Project Overview

This project presents a complete Universal Verification Methodology (UVM) testbench developed to verify a synchronous FIFO (First-In-First-Out) hardware design. The verification environment is designed in SystemVerilog and structured according to UVM best practices to ensure scalability, reusability, and thorough functional coverage.

The core purpose of this environment is to validate that the FIFO module correctly handles various input and output scenarios—including simultaneous read/write operations, corner cases, and protocol compliance—through both randomized and directed test sequences.

The verification flow integrates the following key components:

* **Top-level Integration**: The DUT (FIFO) is connected to the UVM testbench through a dedicated interface, allowing seamless interaction between the design and verification components.
* **Configuration Layer**: A centralized configuration package manages virtual interface sharing and parameter setup to ensure consistent access across all verification modules.
* **Driver and Sequences**: The `FIFO_driver` applies stimulus to the DUT based on transaction-level inputs defined in the sequence layer. These sequences simulate reset, write, read, and mixed operational modes to evaluate design behavior under varying conditions.
* **Monitor and Coverage**: The `FIFO_monitor` passively captures DUT signal activity, translating it into transaction objects used for coverage and analysis. The `FIFO_coverage` component defines coverage points to verify that all meaningful functional scenarios are exercised.
* **Scoreboarding and Checking**: The `FIFO_scoreboard` compares monitored outputs against expected results derived from a reference model. It logs successes and mismatches, facilitating debug and functional verification.
* **Assertions**: Embedded SystemVerilog Assertions (SVA) verify protocol-level properties during simulation, helping to catch violations like underflow, overflow, or illegal transitions.
* **Agent and Environment**: The `FIFO_agent` encapsulates the driver, monitor, and sequencer to promote modularity. The `FIFO_env` coordinates all agents, coverage collectors, and the scoreboard to manage the simulation flow.
* **Test Control**: The `FIFO_test` class initializes and configures the environment, runs selected sequences, and reports simulation results including functional coverage and pass/fail metrics.

This structured and layered approach ensures that the FIFO module is verified thoroughly in a reusable, scalable, and maintainable way. The testbench is suitable for both simulation and coverage-driven verification environments and provides a strong foundation for extending to more complex memory-based designs.
---

## 📈 Block Diagram

<img src="BLOCK DIAGRAM.png" alt="BLOCK DIAGRAM" width="700"/>

---
## 📁 Repository Files

| File Name                    | Description                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| `FIFO.sv`                   | RTL implementation of the FIFO module.                                     |
| `FIFO_agent_pkg.sv`         | Contains UVM agent components (driver, monitor, sequencer).                |
| `FIFO_config_pkg.sv`        | UVM configuration setup for connecting components.                         |
| `FIFO_coverage_pkg.sv`      | Functional coverage definitions for FIFO behavior.                         |
| `FIFO_driver_pkg.sv`        | UVM driver logic to apply transactions to the DUT.                         |
| `FIFO_ENV_pkg.sv`           | Top-level UVM environment connections and build phase.                     |
| `FIFO_monitor_pkg.sv`       | UVM monitor to capture DUT activity.                                       |
| `FIFO_scoreboard_pkg.sv`    | Compares expected vs actual DUT output (result checker).                   |
| `FIFO_seq_item_pkg.sv`      | Defines UVM sequence item (transaction).                                   |
| `FIFO_sequencer_pkg.sv`     | UVM sequencer that drives sequences into the driver.                       |
| `FIFO_sequences.sv`         | Stimulus sequences for test scenarios.                                     |
| `FIFO_SVA.sv`               | SystemVerilog Assertions to verify protocol correctness.                   |
| `FIFO_TEST_pkg.sv`          | UVM test definitions that instantiate environments and start sequences.    |
| `FIFO_top.sv`               | Testbench top module integrating DUT and UVM environment.                  |
| `FIFO_UVM_SARA MAHMOUD.pdf` | Project documentation in PDF format.                                      |
| `interface.sv`              | SystemVerilog interface connecting DUT and UVM testbench.                  |
| `run.txt`                   | Simulation script (e.g., for ModelSim/QuestaSim).                          |
| `shared_pkg.sv`             | Shared typedefs or parameters used across the UVM environment.             |
| `src_files.list`            | File list used by simulator or scripts.                                    |
| `BLOCK DIAGRAM.png`         | High-level system block diagram of the FIFO environment.                   |
| `README.md`                 | Project documentation file (you’re reading it!).                           |
"""
---

## ✅ Features

- **Constrained random stimulus**: Tests FIFO under various read/write scenarios  
- **Functional coverage**: Monitors FIFO flags and data operations  
- **Scoreboard-based checking**: Compares DUT behavior against a reference model  
- **Assertions**: Checks for underflow, overflow, and correct flag behavior

---

## 🚀 Getting Started

### Prerequisites

- QuestaSim or VCS  
- SystemVerilog & UVM support  

### How to Run

1. Clone the repo  
   ```bash
   git clone https://github.com/Sara2mahmoud/UVM-Based-FIFO-Verification-Environment.git
   cd UVM-Based-FIFO-Verification-Environment
   ```
2. Run the simulation:
   ```tcl
   vsim -c -do "do test/run.do"
   ```
3. View coverage and waveform results.

---

## 🛠️ Verification Flow

1. **Compile** DUT and testbench components, including interface, driver, monitor, and agent.
2. **Run** randomized tests that cover various FIFO scenarios (write-only, read-only, simultaneous).
3. **Check** results via scoreboard and assertions.
4. **Report** coverage and any functional errors.

---

## 📊 Coverage & Reports

- **Functional coverage**: Tracks FIFO flags (`full`, `empty`, `almost_full`, `almost_empty`) and underflow/overflow events.  
- **Scoreboard** logs pass/fail for every transaction.

---

## 📝 Customization

To adapt for different FIFOs:

- Update DUT instantiation in `run.do`  
- Tune coverage models in `coverage.sv`  
- Add new sequences to `env/sequence/` folder

---


---

## 🙋‍♀️ Author

- **Sara Mahmoud** — [@Sara2mahmoud](https://github.com/Sara2mahmoud)
