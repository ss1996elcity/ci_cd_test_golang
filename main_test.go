package main

import (
	"testing"
)

func TestPrintGreet(t *testing.T) {
	var name string = "Alex"
	testName := PrintGreet(name)
	if testName != "Hello, "+name {
		t.Errorf("Expected %s, received %v", name, testName)
	}
}
