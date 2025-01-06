# SDRAM Verification Testbench

This repository contains a comprehensive **verification environment** for testing an SDRAM controller and model. The project includes modules for stimuli generation, golden model comparison, error checking, and coverage measurement.

---

## **Table of Contents**
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [Features](#features)
---

## **Overview**
The SDRAM Verification Testbench ensures the behavior of an SDRAM controller and memory model is correct. It validates data read/write operations using a **Golden Model** and **Checker** for error detection. The project also provides detailed coverage analysis and debugging capabilities.

---

## **Project Structure**
```plaintext
├── src/
│   ├── sdram_model.v           # SDRAM memory model
│   ├── sdram_controller.v      # SDRAM controller with FSM
│   ├── sdram_top.v             # Top-level module integrating controller and model
│   ├── Stimuli.v               # Stimuli generator for test scenarios
│   ├── RandomStimuli.v         # Random stimuli generator
│   ├── GoldenModel.v           # Golden model for reference comparison
│   ├── Checker.v               # Checker module for DUT vs Golden Model comparison
│   ├── Scoreboard.v            # Scoreboard for tracking coverage and errors
│   └── sdram_top_tb.v          # Testbench module
├── README.md                   # Project documentation
└── LICENSE                     # License information
```
## **Modules**

### **1. SDRAM Model**
- **Purpose:** Simulates the behavior of an SDRAM chip.
- **Key Features:**  
  - Memory array divided into banks, rows, and columns.
  - Handles read and write operations based on control signals (CS, RAS, CAS, WE).

### **2. SDRAM Controller**
- **Purpose:** Manages read/write requests and interacts with the SDRAM model.
- **Key Features:**  
  - Implements a finite state machine (FSM) for SDRAM operations.
  - Decodes address into bank, row, and column.
  - Ensures timing constraints of SDRAM commands.

### **3. Stimuli**
- **Purpose:** Generates predefined test scenarios for SDRAM testing.
- **Key Features:**  
  - Includes tasks for initialization, sequential writing, and reading.
  - Covers specific scenarios like timing-based writes and invalid commands.

### **4. RandomStimuli**
- **Purpose:** Provides randomized inputs for robust testing.
- **Key Features:**  
  - Randomly generates control signals, addresses, and data.
  - Ensures edge-case testing and corner-case validation.

### **5. GoldenModel**
- **Purpose:** Serves as the reference implementation of SDRAM behavior.
- **Key Features:**  
  - Simple memory model that mimics SDRAM functionality.
  - Used to verify the correctness of the DUT (Device Under Test).

### **6. Checker**
- **Purpose:** Compares outputs of the DUT and Golden Model to detect mismatches.
- **Key Features:**  
  - Highlights any discrepancies between expected and actual outputs.
  - Logs errors for debugging.

### **7. Scoreboard**
- **Purpose:** Tracks the performance and coverage of the testbench.
- **Key Features:**  
  - Counts the number of reads, writes, and errors.
  - Measures test coverage based on executed scenarios.

### **8. Testbench (sdram_top_tb.v)**
- **Purpose:** Integrates all modules into a unified testing environment.
- **Key Features:**  
  - Orchestrates stimuli, DUT, Golden Model, Checker, and Scoreboard.
  - Executes simulations and logs results for analysis.

---

## **Features**
- **Comprehensive FSM Testing:** Verifies all states of the SDRAM controller FSM.
- **Golden Model Verification:** Ensures the correctness of SDRAM operations.
- **Randomized Testing:** Validates robustness with randomly generated scenarios.
- **Error Detection:** Identifies mismatches between expected and actual results.
- **Coverage Analysis:** Tracks the execution of test cases to ensure completeness.

