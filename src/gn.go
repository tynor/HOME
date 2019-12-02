// Cmd gn calculates and prints a diff summary like:
//
//   $ git diff 'master~10..master' | gn
//   293 lines of diff
//   185 lines (+200, -15)
//   650 words (+10, -660)
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"log"
	"os"
	"regexp"
)

var wordRE = regexp.MustCompile(`\b\w+`)

var (
	plus  = []byte("+++")
	minus = []byte("---")
)

func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		args = append(args, "-")
	}
	var lines int
	var addedLines, removedLines int
	var addedWords, removedWords int
	for _, fname := range args {
		var r io.ReadCloser
		if fname == "-" {
			r = os.Stdin
		} else {
			f, err := os.Open(fname)
			if err != nil {
				log.Printf("open: %v", err)
				continue
			}
			r = f
		}
		s := bufio.NewScanner(r)
		for s.Scan() {
			line := s.Bytes()
			lines++
			var changed int
			if diffLine(line, plus) {
				changed = 1
				addedLines++
			} else if diffLine(line, minus) {
				changed = -1
				removedLines++
			}
			switch changed {
			case 1:
				addedWords += len(wordRE.FindAll(line, -1))
			case -1:
				removedWords += len(wordRE.FindAll(line, -1))
			}
		}
		r.Close()
		if err := s.Err(); err != nil {
			log.Printf("scan: %v", err)
		}
	}
	fmt.Printf("%d lines of diff\n", lines)
	fmt.Printf(
		"%+d lines (+%d, -%d)\n",
		addedLines-removedLines,
		addedLines,
		removedLines,
	)
	fmt.Printf(
		"%+d words (+%d, -%d)\n",
		addedWords-removedWords,
		addedWords,
		removedWords,
	)
}

func diffLine(line, prefix []byte) bool {
	return bytes.HasPrefix(line, prefix[:1]) && !bytes.HasPrefix(line, prefix)
}
