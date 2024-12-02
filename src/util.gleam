import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn split_lines(input: String) -> List(String) {
  input
  |> string.trim
  |> string.split(on: "\n")
}

pub fn trim_split(input: String, on: String) -> List(String) {
  input
  |> string.trim
  |> string.split(on)
}

pub fn str_to_int_list(input: String, on: String) -> Result(List(Int), Nil) {
  trim_split(input, on)
  |> list.map(int.parse)
  |> result.all
}
