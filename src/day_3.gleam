import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regex
import gleam/result
import util

import input_3

pub fn compute_1(input: String) -> Int {
  let assert Ok(re) = regex.from_string("mul\\(([0-9]+),([0-9]+)\\)")

  regex.scan(with: re, content: input)
  |> list.map(fn(match) {
    case match.submatches {
      [option.Some(a), option.Some(b)] ->
        result.unwrap(int.parse(a), 0) * result.unwrap(int.parse(b), 0)
      _ -> 0
    }
  })
  |> util.list_sum
}

pub fn example_1() -> Int {
  compute_1(input_3.example)
}

pub fn part_1() -> Int {
  compute_1(input_3.input)
}

// Part 2 ---

pub fn example_2() -> Int {
  // io.debug(input_3.example)

  42
}

pub fn part_2() -> Int {
  // io.debug(input_3.input)

  42
}
