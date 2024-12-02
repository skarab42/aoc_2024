import gleam/int
import gleam/list
import gleam/result

import input_2
import util

fn diff(values: List(Int), summary: List(Int)) -> List(Int) {
  case values {
    [] -> summary
    [a, b, ..tail] -> diff([b, ..tail], [a - b, ..summary])
    [_, ..] -> summary
  }
}

fn all_positive(values: List(Int)) -> Bool {
  list.all(values, fn(value) { value > 0 })
}

fn all_negative(values: List(Int)) -> Bool {
  list.all(values, fn(value) { value < 0 })
}

fn all_positive_or_all_negative(values: List(Int)) -> Bool {
  case all_positive(values) {
    False -> all_negative(values)
    True -> True
  }
}

fn validate_1(values: List(Int)) -> Bool {
  let max =
    result.unwrap(list.find(values, fn(x) { int.absolute_value(x) > 3 }), 0)

  case max {
    0 -> all_positive_or_all_negative(values)
    _ -> False
  }
}

fn parse(input: String) -> Result(List(List(Int)), Nil) {
  util.split_lines(input)
  |> list.map(fn(line) { util.str_to_int_list(line, " ") })
  |> result.all
}

fn compute_1(input: String) -> Int {
  result.unwrap(parse(input), [])
  |> list.map(fn(line) { validate_1(diff(line, [])) })
  |> list.count(fn(a) { a == True })
}

pub fn example_1() -> Int {
  compute_1(input_2.example)
}

pub fn part_1() -> Int {
  compute_1(input_2.input)
}

// Part 2 ---

fn remove_at_index(l: List(Int), i: Int) -> List(Int) {
  list.flatten([list.take(l, i), list.drop(l, i + 1)])
}

fn validate_2(values: List(Int)) -> Bool {
  values
  |> list.index_map(fn(_, i) {
    validate_1(diff(remove_at_index(values, i), []))
  })
  |> list.any(fn(v) { v == True })
}

fn compute_2(input: String) {
  result.unwrap(parse(input), [])
  |> list.map(fn(line) {
    case validate_1(diff(line, [])) {
      False -> validate_2(line)
      True -> True
    }
  })
  |> list.count(fn(a) { a == True })
}

pub fn example_2() -> Int {
  compute_2(input_2.example)
}

pub fn part_2() -> Int {
  compute_2(input_2.input)
}
