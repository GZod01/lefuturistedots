package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"
)

func sendNotif(message string, urgency string) {
	_, err := exec.Command(
		"notify-send",
		"--urgency="+urgency,
		"--app-name=Monitor",
		"\""+message+"\"",
	).Output()
	fmt.Println(urgency, message)
	if err != nil {
		panic(err)
	}
}

// Event -
type Event struct {
	metric string // battery or memory
	limit  int
	unique bool
	notif  string
}

func main() {

	sleepPeriod := 2
	rowSleepPeriod := os.Getenv("LAPTOP_MONITOR_PERIOD_IN_MINUTES")
	if rowSleepPeriod != "" {
		i, _ := strconv.Atoi(rowSleepPeriod)
		sleepPeriod = i
	}

	fmt.Println("Using sleepPeriod (in minutes)", sleepPeriod)

	events := []Event{
		// BATTERY ALERTS
		Event{
			metric: "battery",
			limit:  98,
			unique: true,
			notif:  "Under 98%",
		},
		Event{
			metric: "battery",
			limit:  50,
			unique: true,
			notif:  "Under 50%",
		},
		Event{
			metric: "battery",
			limit:  40,
			unique: true,
			notif:  "Under 40%",
		},
		Event{
			metric: "battery",
			limit:  30,
			unique: true,
			notif:  "Under 30%",
		},
		Event{
			metric: "battery",
			limit:  20,
			unique: false,
			notif:  "Under 20%, please charge the laptop",
		},

		// MEMORY ALERTS
		Event{
			metric: "memory",
			limit:  2000,
			unique: true,
			notif:  "Under 2000M",
		},
		Event{
			metric: "memory",
			limit:  1000,
			unique: true,
			notif:  "Under 1000M",
		},
		Event{
			metric: "memory",
			limit:  500,
			unique: true,
			notif:  "Under 500M",
		},
		Event{
			metric: "memory",
			limit:  250,
			unique: false,
			notif:  "Under 250M, please kill some process",
		},
	}
	state := []int{}

	for range events {
		state = append(state, 0)
	}

	sendNotif("Starting laptop monitor", "normal")
	for {
		// notify for low free memory
		out, err := exec.Command("/bin/free", "-m").Output()
		if err != nil {
			fmt.Printf("%s", err)
		}
		output := string(out[:])
		row := strings.Split(output, "\n")
		row = strings.Split(row[1], " ")
		freeMemory, err := strconv.Atoi(row[len(row)-1])
		//fmt.Println("free", freeMemory)

		// check low capacity
		capacityFile := "/sys/class/power_supply/BAT1/capacity"
		statusFile := "/sys/class/power_supply/BAT1/status"
		out, err = ioutil.ReadFile(capacityFile)
		if err != nil {
			panic(err)
		}
		output = strings.Replace(string(out), "\n", "", 1)
		capacity, err := strconv.Atoi(output)

		out, err = ioutil.ReadFile(statusFile)
		if err != nil {
			panic(err)
		}
		status := strings.Replace(string(out), "\n", "", 1)
		//fmt.Println(status)

		// aggregate and sort events
		for i, event := range events {
			data := -1
			if event.metric == "memory" {
				data = freeMemory
			}
			if event.metric == "battery" {
				data = capacity
				if status == "Charging" {
					break
				}
			}
			//fmt.Println(data)
			if data <= event.limit {
				if event.unique && state[i] == 1 {
					break
				}
				state[i] = 1
				sendNotif(event.notif, "critical")
			} else {
				state[i] = 0
			}
		}

		time.Sleep(time.Duration(sleepPeriod) * time.Minute)
	}
}
