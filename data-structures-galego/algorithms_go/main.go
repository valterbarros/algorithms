package main

import (
	"bufio"
	"data-structures/algorithms_go/samples"
	"fmt"
	"maps"
	"os"
	"os/signal"
	"slices"
	"sort"
	"strconv"
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
	"arrays":    samples.ArrayType{},
	"maps":      samples.MapsType{},
	"controls":  samples.ControlsType{},
}

func showMenu() {
	fmt.Println("\n--- MENU SAMPLES ---")

	// Para o menu ficar sempre em ordem alfabética (opcional)
	keys := make([]string, 0, len(samplesMap))
	for k := range samplesMap {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for index, k := range keys {
		fmt.Printf("%d -> %s\n", index, k)
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
	// maps.Keys return seq and is necessary to put that on a slice with slices.Collect
	keys := slices.Collect(maps.Keys(samplesMap))
	slices.Sort(keys)
	// convert number
	commandInt, err := strconv.ParseInt(command, 10, 64)
	// TODO: fix out of range error in case of wrong input
	mappedCommand := keys[commandInt]

	if err != nil {
		fmt.Printf("Opção [%s] invalid. try again.\n", mappedCommand)
		return
	}

	if s, has := samplesMap[mappedCommand]; has {
		saveLast(command)

		fmt.Printf("\n--- Executing: %s ---\n", mappedCommand)
		s.Run()
		fmt.Println("\n(r: repeat | b: menu | l: leave)")
	} else {
		fmt.Printf("Opção [%s] invalid. try again.\n", mappedCommand)
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
