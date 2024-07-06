
# Digital Verification using SystemVerilog UVM
## Project Overview

This project involves testing and verifying three designs: SPI Slave wrapper, Dual-port RAM, and Synchronous FIFO. Each participant will be assigned a specific design to work on. For more details on your assigned design, please refer to the [sheet here](#).

### Designs to be Verified
1. **Synchronous FIFO**
2. **Dual-port RAM**
3. **SPI Slave Wrapper**

## Synchronous FIFO

### Parameters
- **FIFO_WIDTH**: Width of data in/out and memory word (default: 16)
- **FIFO_DEPTH**: Memory depth (default: 8)

### Ports

| Port         | Direction | Function                                                                 |
|--------------|-----------|--------------------------------------------------------------------------|
| `data_in`    | Input     | Write Data: Input data bus for writing to the FIFO.                      |
| `wr_en`      | Input     | Write Enable: Asserts to write data when FIFO is not full.               |
| `rd_en`      | Input     | Read Enable: Asserts to read data when FIFO is not empty.                |
| `clk`        | Input     | Clock signal.                                                           |
| `rst_n`      | Input     | Active low asynchronous reset.                                          |
| `data_out`   | Output    | Read Data: Output data bus for reading from the FIFO.                   |
| `full`       | Output    | Full Flag: Indicates FIFO is full.                                       |
| `almostfull` | Output    | Almost Full: Indicates FIFO is nearly full.                              |
| `empty`      | Output    | Empty Flag: Indicates FIFO is empty.                                     |
| `almostempty`| Output    | Almost Empty: Indicates FIFO is nearly empty.                            |
| `overflow`   | Output    | Overflow: Indicates write request was rejected due to full FIFO.         |
| `underflow`  | Output    | Underflow: Indicates read request was rejected due to empty FIFO.        |
| `wr_ack`     | Output    | Write Acknowledge: Indicates successful write request.                   |

## Testbench Overview

### Top Module
The top module generates the clock signal, passes it to the interface, and then to the DUT (Design Under Test), testbench (tb), and monitor modules. The tb module resets the DUT and randomizes the inputs. At the end of the test, the tb asserts a `test_finished` signal. The `error_count` and `correct_count` signals are defined in a shared package named `shared_pkg`.

### Monitor Module
The monitor module:
1. Creates objects of three classes: `FIFO_transaction`, `FIFO_scoreboard`, and `FIFO_coverage`.
2. Samples the interface data at each negative clock edge and assigns it to a `FIFO_transaction` object.
3. Calls the `sample_data` method of `FIFO_coverage` and the `check_data` method of `FIFO_scoreboard`.
4. Checks the `test_finished` signal, stops the simulation, and displays a summary of correct and error counts.

## Steps to Implement

1. Adjust the design to take an interface and change the file extension to `.sv`.
2. Create a package with a class named `FIFO_transaction`:
   - Include FIFO inputs and outputs as properties.
   - Add constraints for `wr_en` and `rd_en`.
3. Create a package with a class named `FIFO_coverage`:
   - Import `FIFO_transaction` package.
   - Create a function `sample_data` to assign data and trigger covergroup sampling.
   - Define a covergroup for cross-coverage.
4. Create a package named `FIFO_scoreboard`:
   - Import `FIFO_transaction` package.
   - Add reference variables.
   - Create functions `check_data` and `reference_model` to compare outputs and increment counters.
5. Add assertions to the FIFO design for output flags and internal counters.

## Additional Design Verification

### SPI Slave & RAM Verification

- Verify functionality of Dual-port RAM and SPI wrapper.
- Plan for functional coverage and assertions.
- Use SV Interface (optional).
- Bind assertion file in top/testbench.


