import gleeunit
import gleeunit/should

import day_1

pub fn main() {
  gleeunit.main()
}

pub fn example_1_test() {
  day_1.example_1()
  |> should.equal(11)
}

pub fn part_1_test() {
  day_1.part_1()
  |> should.equal(1_970_720)
}
