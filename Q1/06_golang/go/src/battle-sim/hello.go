package main

import (
	// Call outer package, starting from $GOPATH
	"battle-sim/test"
	"fmt"
	"math/rand"
	"runtime"
	"strings"
	"time"
)

// FUNCTIONS

func add(x, y int) int {
	return x + y
}

func swap(x, y string) (string, string) {
	return y, x
}

func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

func delayedHi() {
	defer fmt.Println("Delayed World!")
	fmt.Println("Hello ")
}

func ticTacToe() {
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}
	// Player Turns
	board[0][0] = "X"
	board[2][2] = "O"
	board[1][2] = "X"
	board[1][0] = "O"
	board[0][2] = "X"
	// Print Board
	for i := 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " | "))
		if i != len(board)-1 {
			fmt.Println("--+---+--")
		}
	}
}

// This uses an "empty interface" which takes literally any type!
func describe(i interface{}) {
	// Print value and type of param
	fmt.Printf("(%v, %T)\n", i, i)
	// Type switch on i
	switch v := i.(type) {
	case int:
		fmt.Println("Found an integer for", v)
	case string:
		fmt.Println("Found a string for", v)
	default:
		fmt.Println("Found something weird!", v)
	}
}

// This throws an error for testing the MyError struct
func runError() error {
	return &MyError{
		time.Now(),
		"Didn't work!",
	}
}

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func multiParam(vals ...int) string {
	out := ""
	for _, val := range vals {
		out += fmt.Sprintf("%d ", val)
	}
	return out
}

// INTERFACES
type Printable interface {
	print() string
}

// STRUCTS and TYPES
type MyError struct {
	When time.Time
	What string
}

type Structure struct {
	X int
	Y int
}

type FakeClass struct {
	x, y string
}

// Assign the print() function to FakeClass
// This also makes FakeClass part of the Printable interface, because we implemented all method of the iface
func (fc FakeClass) print() string {
	return fmt.Sprintf("%s, %s", fc.x, fc.y)
}

// Let's also implement the "Stringer" interface found in fmt, which is just __str__ from Python!
func (fc FakeClass) String() string {
	return fmt.Sprintf("X = %s, Y = %s", fc.x, fc.y)
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s", e.When, e.What)
}

// Now to make a generic function that prints Printables
func printClass(p Printable) {
	fmt.Println(p.print())
}

// Pointer Receivers are _REQUIRED_ to persist changes to the object!!
func (fc *FakeClass) modifyX(n string) {
	fc.x = n
}

// VARIABLES

var c, python, java bool = true, false, true

const Pi = 3.14

func main() {
	// TEST OUT GOROUTINES
	fmt.Println("Starting routine")
	go say("=============================")
	// Everything else
	fmt.Printf("Hello, World!\n")
	fmt.Println("Random Number:", rand.Intn(10))
	fmt.Println("2 + 2 =", add(2, 2))
	a, b := swap("world", "hello")
	fmt.Println(a, b)
	d, e := split(23)
	fmt.Println("Split of 23:", d, e)
	fmt.Println("List of vars:", c, python, java)
	fmt.Println("PI =", Pi)
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	for sum < 1000 {
		sum += sum
	}
	if sum < 2000 {
		fmt.Println("Less than 2000!")
	}
	fmt.Println(sum)
	if thing := 10; thing <= 4 {
		// "thing" only exists within this context
		fmt.Println("10 < 4")
	} else {
		// "thing" exists here too!
		fmt.Println(thing)
	}
	// "thing" does not exist anymore!
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("Operating System is OSX")
	case "linux":
		fmt.Println("Operating System is Linux")
	default:
		fmt.Printf("Operating System is %s.\n", os)
	}
	// Switch w/o condition is a good way to write a long if/else ladder!
	switch test := 15; {
	case test < 0:
		fmt.Println("negative")
	case test == 0:
		fmt.Println("zero")
	case test > 50:
		fmt.Println("High")
	default:
		fmt.Println("Other")
	}
	delayedHi()
	// Pointers!  Yay....
	i := 42
	p := &i         // Point to i using p
	fmt.Println(*p) // Read i using the pointer
	*p = 21         // Set i through the pointer
	fmt.Println(i)  // See the new value of i
	// Structures
	fmt.Println(Structure{1, 2})
	s := Structure{1, 2}
	s.X = 4
	fmt.Println(s.X)
	// Arrays
	var msg [2]string
	msg[0] = "hello"
	msg[1] = "world"
	fmt.Println(msg)
	primes := [6]int{2, 3, 5, 7, 11, 13}
	fmt.Println(primes)
	// Slices are variable size - slicing is inclusive on min AND max
	var slice = primes[1:4]
	fmt.Println(slice)
	// Slices are pointers to arrays
	slice[1] = 4
	fmt.Println(primes)
	// Slices can be their own thing too:
	slice = []int{1, 2, 3, 4}
	fmt.Println(slice)
	sliceStruct := []struct {
		x int
		y string
	}{
		{1, "one"},
		{2, "two"},
		{3, "three"}, //_have_ to to trailing comma?
	}
	fmt.Println(sliceStruct)
	fmt.Printf("Length: %d, Capacity: %d\n", len(sliceStruct), cap(sliceStruct))
	ticTacToe()
	var nary []int
	for i := 10; i < 20; i++ {
		nary = append(nary, i)
	}
	fmt.Println(nary)
	// Looping over array with index
	for i, v := range nary {
		fmt.Printf("nary[%d] = %d\n", i, v)
	}
	var m map[string]int
	m = make(map[string]int)
	m["test"] = 10
	m["other"] = 20
	delete(m, "test")
	// Test if key exists with 2-part GET
	elem, ok := m["other"]
	fmt.Println("The value:", elem, " Present? ", ok)
	elem, ok = m["test"]
	fmt.Println("The value:", elem, " Present? ", ok)
	fmt.Println(m)
	// Class stuff:
	fc := FakeClass{"'ello", "guv'nah"}
	fmt.Println(fc.print())
	fc.modifyX("blah")
	fmt.Println(fc.print())
	fmt.Println(fc)
	// Now lets use the new interface printing!
	printClass(fc)
	// Notice that this describe utilizes the Stringer interface for fc!
	describe(fc)
	describe(m)
	if err := runError(); err != nil {
		fmt.Println(err)
	}
	fmt.Println(multiParam(1, 2, 3, 4, 5))
	fmt.Println(test.Foo())
	fmt.Println(Bar())
}
