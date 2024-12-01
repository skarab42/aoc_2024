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

pub fn example_2_test() {
  day_1.example_2()
  |> should.equal(31)
}

pub fn part_2_test() {
  day_1.part_2()
  |> should.equal(17_191_599)
}
