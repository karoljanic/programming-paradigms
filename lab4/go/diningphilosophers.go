package main

import (
	"fmt"
	"sync"
)

type diner struct {
	philosophersNumber int
	mealsNumber        int
	pickUpFork         []chan bool
	pickDownFork       []chan bool
	eatenLunches       []int
	waitGroup          sync.WaitGroup
}

func makeDinner(philosophersNumber, mealsNumber int) *diner {
	d := &diner{
		philosophersNumber: philosophersNumber,
		mealsNumber:        mealsNumber,
		pickUpFork:         make([]chan bool, philosophersNumber),
		pickDownFork:       make([]chan bool, philosophersNumber),
		eatenLunches:       make([]int, philosophersNumber),
		waitGroup:          sync.WaitGroup{},
	}

	for i := 0; i < philosophersNumber; i++ {
		d.pickUpFork[i] = make(chan bool)
		d.pickDownFork[i] = make(chan bool)

		d.eatenLunches[i] = 0
	}

	d.waitGroup.Add(philosophersNumber * mealsNumber)

	return d
}

func (d *diner) start() {
	for i := 0; i < d.philosophersNumber; i++ {
		go d.initializeFork(i)
		go d.initializePhilosopher(i)
	}

	d.waitGroup.Wait()
}

func (d *diner) initializeFork(id int) {
	for {
		d.pickUpFork[id] <- true

		<-d.pickDownFork[id]
	}

}

func (d *diner) initializePhilosopher(id int) {
	for d.eatenLunches[id] < d.mealsNumber {
		think(d, id)

		left := false
		right := false

		select {
		case left = <-d.pickUpFork[id]:
			leftForkUp(d, id)
		default:
			left = false
		}

		if !left {
			continue
		}

		select {
		case right = <-d.pickUpFork[((id + 1) % d.philosophersNumber)]:
			rightForkUp(d, id)
		default:
			right = false
		}

		if !right {
			d.pickDownFork[id] <- true
			leftForkDown(d, id)
			continue
		}

		if left && right {
			eat(d, id)

			d.pickDownFork[id] <- true
			d.pickDownFork[((id + 1) % d.philosophersNumber)] <- true
			d.eatenLunches[id]++

			leftForkDown(d, id)
			rightForkDown(d, id)

			d.waitGroup.Done()
		}

	}

}

func think(d *diner, id int) {
	fmt.Printf("Philosopher %d is thinking\n", id)
}

func leftForkUp(d *diner, id int) {
	fmt.Printf("Philosopher %d pick up left fork\n", id)
}

func rightForkUp(d *diner, id int) {
	fmt.Printf("Philosopher %d pick up right fork\n", id)
}

func leftForkDown(d *diner, id int) {
	fmt.Printf("Philosopher %d put down left fork\n", id)
}

func rightForkDown(d *diner, id int) {
	fmt.Printf("Philosopher %d put down right fork\n", id)
}

func eat(d *diner, id int) {
	fmt.Printf("Philosopher %d is eating %d lunch\n", id, d.eatenLunches[id]+1)
}

func simulation(philosophersNumber, mealsNumber int) {
	d := makeDinner(philosophersNumber, mealsNumber)
	d.start()
}
