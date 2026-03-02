package main

import (
	"bufio"
	"data-structures/algorithms_go/samples"
	"fmt"
	"os"
	"os/signal"
	"sort"
	"strings"
)

var samplesMap = map[string]samples.Sample{
	"structs":   samples.StructsType{},
	"pointers":  samples.PointersType{},
	"goroutine": samples.GoroutineType{},
	"strings":   samples.StringsType{},
	"enums":     samples.EnumsType{},
	"variables": samples.VariablesType{},
	"types":     samples.TypesType{},
	"functions": samples.FunctionsType{},
}

func showMenu() {
	fmt.Println("\n--- MENU SAMPLES ---")

	// Para o menu ficar sempre em ordem alfabética (opcional)
	keys := make([]string, 0, len(samplesMap))
	for k := range samplesMap {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		fmt.Printf("-> %s\n", k)
	}
	fmt.Print("\nChoose an option (l: leave): ")
}

const cacheFile = ".last_sample"

func saveLast(command string) {
	os.WriteFile(cacheFile, []byte(command), 0644)
}

func resetLast() {
	os.WriteFile(cacheFile, []byte(""), 0644)
}

func getLast() string {
	data, _ := os.ReadFile(cacheFile)
	return string(data)
}

var envLastGo = "LAST_GO_ENV"

func runCommand(command string) {
	if s, has := samplesMap[command]; has {
		saveLast(command)

		fmt.Printf("\n--- Executing: %s ---\n", command)
		s.Run()
		fmt.Println("\n(r: repeat | b: menu | l: leave)")
	} else {
		fmt.Printf("Opção [%s] invalid. try again.\n", command)
	}
}

func gracefullFinish() {
	fmt.Println("bye")
	resetLast()
	os.Exit(2)
}

func main() {
	// 1 is the buffer size
	c := make(chan os.Signal, 1)
	// a special channel usage
	signal.Notify(c, os.Interrupt)

	// finish main when interrupted by os
	go func() {
		// stop execution of that specific go routine
		<-c

		gracefullFinish()
	}()

	lastCommand := getLast()

	fmt.Println("Running last command: ", lastCommand)
	if lastCommand != "" {
		runCommand(lastCommand)
	} else {
		showMenu()
	}

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		command := strings.TrimSpace(strings.ToLower(scanner.Text()))

		if command == "l" {
			gracefullFinish()
			break
		}

		if command == "b" {
			resetLast()
			showMenu()
			command = ""
			continue
		}

		if command == "r" {
			fmt.Println("🔄 Recompiling...")
			break
		}

		runCommand(command)
	}
}
