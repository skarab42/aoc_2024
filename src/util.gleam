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
