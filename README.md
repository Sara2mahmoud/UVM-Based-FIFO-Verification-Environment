
# UVM-Based FIFO Verification Environment

A SystemVerilog/UVM testbench environment for verifying a synchronous FIFO design.

---

## 🧩 Repository Structure

```
UVM-Based-FIFO-Verification-Environment/
├── rtl/                     # FIFO RTL implementation
│   └── FIFO.sv
├── env/                     # UVM environment
│   ├── interface.sv        # FIFO transaction interface
│   ├── agent/              # Driver, Monitor, Sequencer, Agent
│   ├── sequence/           # Stimulus sequences
│   ├── scoreboard.sv       # Functional checking
│   └── coverage.sv         # Functional coverage model
├── test/                    # UVM test/bench top files
│   └── run.do              # Script to compile & simulate
└── README.md               # Project documentation
```

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
