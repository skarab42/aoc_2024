import gleam/int
import gleam/list
import gleam/result

import input_2
import util

pub fn diff(values: List(Int), summary: List(Int)) -> List(Int) {
fn diff(values: List(Int), summary: List(Int)) -> List(Int) {
  case values {
    [] -> summary
    [a, b, ..tail] -> diff([b, ..tail], [a - b, ..summary])
    [_, ..] -> summary
  }
}

pub fn all_positive(values: List(Int)) -> Bool {
fn all_positive(values: List(Int)) -> Bool {
  list.all(values, fn(value) { value > 0 })
}

pub fn all_negative(values: List(Int)) -> Bool {
fn all_negative(values: List(Int)) -> Bool {
  list.all(values, fn(value) { value < 0 })
}

pub fn all_positive_or_all_negative(values: List(Int)) -> Bool {
fn all_positive_or_all_negative(values: List(Int)) -> Bool {
  case all_positive(values) {
    False -> all_negative(values)
    True -> True
  }
}

pub fn validate_1(values: List(Int)) -> Bool {
fn validate_1(values: List(Int)) -> Bool {
  let max =
    result.unwrap(list.find(values, fn(x) { int.absolute_value(x) > 3 }), 0)

  case max {
    0 -> all_positive_or_all_negative(values)
    _ -> False
  }
}

pub fn parse(input: String) -> Result(List(List(Int)), Nil) {
fn parse(input: String) -> Result(List(List(Int)), Nil) {
  util.split_lines(input)
  |> list.map(fn(line) { util.str_to_int_list(line, " ") })
  |> result.all
}

pub fn compute_1(input: String) -> Int {
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

pub fn example_2() -> Int {
  42
}

pub fn part_2() -> Int {
  42
}
