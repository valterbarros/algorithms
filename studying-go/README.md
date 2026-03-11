### Study notes

Some notes about go and important links
  - [Links](./notes/LINKS.md)
  - [Commands](./notes/COMMANDS.md)
  - [Samples of go with notes](https://github.com/valterbarros/algorithms/wiki)

## Go Algorithms – Usage Guide

This folder contains Go implementations about basics like arrays, strings, etc
You can use these as learning material or as a base for your own projects.

### Run menu with algorithms
```sh
./running.sh
```

### Generate .md files
> That projects has a script to extract comments and code from .go files and put on a .md file <br>
> All those files .md are in samples

example:

```shell
go run parser_cmd/main.go -file-run variables
```

### Testes
generate big file

```shell
go run ./cmd/fixturegen -lines 20000 -out tests/fixtures/source.huge.source
```

run testes

```shell
go test ./parser
```

run dlv debug

```shell
dlv debug --headless --listen=:2345 --accept-multiclient --continue --only-same-user=false --log
```

### Running with VS Code

You can also run and debug algorithms or tests directly in [Visual Studio Code](https://code.visualstudio.com/):

1. Open this folder in VS Code.
2. Go to the Run and Debug panel (or press `Ctrl+Shift+D`).
3. Choose one of the pre-configured launch options, such as running a specific algorithm or running tests.
4. You can set breakpoints and step through the code for easier debugging.

### Structure

- `main.go`: Entry point to run algorithms by category and name.
- `samples/` - is just algorithms of learning go
