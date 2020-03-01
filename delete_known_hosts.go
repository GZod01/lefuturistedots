/**
* This code can be useful when you need to delete a specific line in the file ~/.ssh/known_hosts
* Usage: 
*    $ ./delete_known_hosts [line number]
* Note: line numbers are counted from 1 to inf 
**/
package main

import (
	"fmt"
	"os/user"
	"os"
	"io/ioutil"
	"strings"
	"strconv"
)

func main() {
	user, err := user.Current()
	if err != nil {
		panic(err)
	}

	lineNumber, _ := strconv.ParseInt(os.Args[1], 10, 0)

	filePath := user.HomeDir + "/.ssh/known_hosts"

	// read file
	data, err := ioutil.ReadFile(filePath)
	// put all the lines as a single string in a variable
	content := string(data)

	if err != nil {
		return
	}

	// split these lines 
	fileLines := strings.Split(content, "\n")
	// put the content of the line to delete in another variable
	lineToDelete := fileLines[lineNumber - 1]

	fmt.Print("Deleting line: ")
	fmt.Println("\"" + lineToDelete + "\"")

	// create a new string with the new content without this specific line
	newContent := ""
	for _, element := range fileLines {
		if element != lineToDelete {
			newContent += element + "\n"
		}
	}

	// write the new content in the file
	err = ioutil.WriteFile(filePath,  []byte(newContent), 0644)
	if err != nil {
		panic(err)
	}
}
