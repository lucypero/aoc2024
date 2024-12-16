// advent of code 2024 day 1

package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

day1 :: proc() -> (total_dist: int, similarity_score: int, ok: bool) {
	// Part 1
	inp, ok_f := os.read_entire_file("aoc1-input.txt")
	inp_str := string(inp)

	if !ok_f {
		fmt.eprintln("file error")
		return
	}

	list1, list2: [dynamic]int
	defer {
		delete(inp)
		delete(list1)
		delete(list2)
	}

	for line in strings.split_lines_iterator(&inp_str) {
		a := strconv.parse_int(line[:5]) or_return
		b := strconv.parse_int(line[8:][:5]) or_return
		append(&list1, a)
		append(&list2, b)
	}

	slice.sort(list1[:])
	slice.sort(list2[:])

	for i in 0 ..< len(list1) {
		total_dist += math.abs(list1[i] - list2[i])
	}

	// Part 2
	for i in list1 {
		appereances: int
		for j in list2 {
			if i == j {
				appereances += 1
			}
		}
		similarity_score += i * appereances
	}

	return total_dist, similarity_score, true
}

main :: proc() {
	if answ1, answ2, ok := day1(); ok {
		fmt.printfln(
			"day 1: part 1 (total distance): %v; part 2 (similarity score): %v",
			answ1,
			answ2,
		)
	} else {
		fmt.eprintln("error on day 1")
		os.exit(1)
    }
}
