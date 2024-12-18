import gleam/int
import gleam/list
import gleam/option
import gleam/regexp
import gleam/result

import input_3
import util

pub fn compute_1(input: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul\\(([0-9]+),([0-9]+)\\)")

  regexp.scan(with: re, content: input)
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
  compute_1(input_3.example_1)
}

pub fn part_1() -> Int {
  compute_1(input_3.input)
}

// Part 2 ---

fn walk(matches: List(regexp.Match), on: Bool, results: List(Int)) -> List(Int) {
  case matches {
    [] -> results
    [match, ..rest] ->
      case on, match {
        _, regexp.Match("do()", _) -> walk(rest, True, results)
        _, regexp.Match("don't()", _) -> walk(rest, False, results)
        True, regexp.Match(_, [option.Some(a), option.Some(b)]) ->
          walk(rest, on, [
            result.unwrap(int.parse(a), 0) * result.unwrap(int.parse(b), 0),
            ..results
          ])
        _, _ -> walk(rest, on, results)
      }
  }
}

pub fn compute_2(input: String) -> Int {
  let assert Ok(re) =
    regexp.from_string("don't\\(\\)|do\\(\\)|mul\\(([0-9]+),([0-9]+)\\)")

  regexp.scan(with: re, content: input)
  |> walk(True, [])
  |> util.list_sum
}

pub fn example_2() -> Int {
  compute_2(input_3.example_2)
}

pub fn part_2() -> Int {
  compute_2(input_3.input)
}
