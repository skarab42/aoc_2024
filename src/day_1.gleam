import gleam/int
import gleam/list
import gleam/result
import gleam/string

import input_1

fn split_lines(input: String) -> List(String) {
  input
  |> string.trim
  |> string.split(on: "\n")
}

fn split_values(input: String) -> List(String) {
  input
  |> string.trim
  |> string.split(on: "   ")
}

fn split_list(
  lines: List(String),
  left: List(Int),
  right: List(Int),
) -> Result(#(List(Int), List(Int)), Nil) {
  case lines {
    [] -> Ok(#(left, right))
    [first, ..lines] -> {
      let values = split_values(first)

      case values {
        [left_val, right_val] -> {
          use lv <- result.then(int.parse(left_val))
          use rv <- result.then(int.parse(right_val))

          split_list(lines, [lv, ..left], [rv, ..right])
        }
        _ -> panic as "should have two values"
      }
    }
  }
}

fn parse_list(input: String) {
  split_lines(input) |> split_list([], [])
}

fn pop_both(left: List(Int), right: List(Int)) {
  use #(left_val, left) <- result.then(list.pop(left, fn(_) { True }))
  use #(right_val, right) <- result.then(list.pop(right, fn(_) { True }))

  Ok(#(#(left_val, left), #(right_val, right)))
}

fn diff_1(
  left: List(Int),
  right: List(Int),
  total: List(Int),
) -> Result(List(Int), Nil) {
  case pop_both(left, right) {
    Error(_) -> Ok(total)
    Ok(#(#(left_val, left), #(right_val, right))) ->
      diff_1(left, right, [int.absolute_value(left_val - right_val), ..total])
  }
}

pub fn sum(values: List(Int)) -> Int {
  case values {
    [] -> 0
    [head, ..tail] -> head + sum(tail)
  }
}

fn compute_1(input: String) -> Result(Int, Nil) {
  let assert Ok(#(left, right)) = parse_list(input)
  let left = list.sort(left, by: int.compare)
  let right = list.sort(right, by: int.compare)

  use total <- result.then(diff_1(left, right, [0]))

  Ok(sum(total))
}

pub fn example_1() -> Int {
  result.unwrap(compute_1(input_1.example), 0)
}

pub fn part_1() -> Int {
  result.unwrap(compute_1(input_1.input), 0)
}

// Part 2 ---

fn diff_2(
  original_right: List(Int),
  left: List(Int),
  right: List(Int),
  total: List(Int),
) -> Result(List(Int), Nil) {
  case pop_both(left, right) {
    Error(_) -> Ok(total)
    Ok(#(#(left_val, left), #(_right_val, right))) -> {
      let count = list.count(original_right, fn(a) { a == left_val })
      diff_2(original_right, left, right, [left_val * count, ..total])
    }
  }
}

fn compute_2(input: String) -> Result(Int, Nil) {
  let assert Ok(#(left, right)) = parse_list(input)
  use total <- result.then(diff_2(right, left, right, [0]))

  Ok(sum(total))
}

pub fn example_2() -> Int {
  result.unwrap(compute_2(input_1.example), 0)
}

pub fn part_2() -> Int {
  result.unwrap(compute_2(input_1.input), 0)
}
