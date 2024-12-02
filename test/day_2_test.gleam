import gleeunit
import gleeunit/should

import day_2

pub fn main() {
  gleeunit.main()
}

pub fn example_1_test() {
  day_2.example_1()
  |> should.equal(2)
}

pub fn part_1_test() {
  day_2.part_1()
  |> should.equal(663)
}

pub fn example_2_test() {
  day_2.example_2()
  |> should.equal(42)
}

pub fn part_2_test() {
  day_2.part_2()
  |> should.equal(42)
}
