import gleeunit
import gleeunit/should

import day_3

pub fn main() {
  gleeunit.main()
}

pub fn example_1_test() {
  day_3.example_1()
  |> should.equal(161)
}

pub fn part_1_test() {
  day_3.part_1()
  |> should.equal(181_345_830)
}

pub fn example_2_test() {
  day_3.example_2()
  |> should.equal(48)
}

pub fn part_2_test() {
  day_3.part_2()
  |> should.equal(98_729_041)
}
