## Go Algorithms – Usage Guide

This folder contains Go implementations of classic algorithms and data structures. You can use these as learning material or as a base for your own projects.

### How to Run

1. **Install Go**  
   Make sure you have Go installed. You can download it from [golang.org](https://golang.org/dl/).

2. **Clone the Repository**  
   Clone this repository to your local machine.

3. **Navigate to the Go Folder**  
   ```sh
   cd algorithms_go
   ```

4. **Run a Specific Algorithm**  
   Use the main file to run a specific algorithm. For example:
   ```sh
   go run main.go array binary-search
   ```

5. **Run Tests**  
   To run all tests in the `array` package:
   ```sh
   cd array
   go test -v
   ```
   Or run a specific test file:
   ```sh
   go test -v binary-search_test.go
   ```


### Running with VS Code

You can also run and debug algorithms or tests directly in [Visual Studio Code](https://code.visualstudio.com/):

1. Open this folder in VS Code.
2. Go to the Run and Debug panel (or press `Ctrl+Shift+D`).
3. Choose one of the pre-configured launch options, such as running a specific algorithm or running tests.
4. You can set breakpoints and step through the code for easier debugging.

### Structure

- `main.go`: Entry point to run algorithms by category and name.
- `array/`, `linked-list/`, etc.: Folders with Go files for each algorithm and their tests.
- `samples/` - is just algorithms of learning go

Let me know if you want this added to your README.md automatically!