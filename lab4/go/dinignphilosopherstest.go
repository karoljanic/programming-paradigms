package main

import (
	"os"
	"strconv"
)

func main() {
	if len(os.Args) == 3 {
		philosophersNumber, _ := strconv.Atoi(os.Args[1])
		mealsNumber, _ := strconv.Atoi(os.Args[2])
		simulation(philosophersNumber, mealsNumber)
	}
}
