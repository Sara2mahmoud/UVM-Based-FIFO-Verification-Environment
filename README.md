
# UVM-Based FIFO Verification Environment

A SystemVerilog/UVM testbench environment for verifying a synchronous FIFO design.

---

## 🧩 Repository Structure

# Create the README section with .md format for repository files
repo_files_md = """
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

# Save it to a Markdown file
file_path_repo_files = "/mnt/data/UVM_FIFO_File_List.md"
with open(file_path_repo_files, "w") as f:
    f.write(repo_files_md)

file_path_repo_files
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

## 📈 Block Diagram

<img src="BLOCK DIAGRAM.png" alt="BLOCK DIAGRAM" width="700"/>

---

## 📝 Customization

To adapt for different FIFOs:

- Update DUT instantiation in `run.do`  
- Tune coverage models in `coverage.sv`  
- Add new sequences to `env/sequence/` folder

---

## 👫 Contributing

- Fork the repo  
- Add new verification scenarios  
- Enhance coverage or assertion models  
- Submit a pull request for review

---


---

## 🙋‍♀️ Author

- **Sara Mahmoud** — [@Sara2mahmoud](https://github.com/Sara2mahmoud)
