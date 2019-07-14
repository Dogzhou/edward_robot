defmodule DirectionTest do
  use ExUnit.Case
  alias EdwardRobot.Direction

  test ".directions" do
    assert Direction.directions() == [:east, :north, :south, :west]
  end

  test ".left_from" do
    assert Direction.left_from(:east) == :north
    assert Direction.left_from(:north) == :west
    assert Direction.left_from(:west) == :south
    assert Direction.left_from(:south) == :east
  end

  describe ".right_from" do
    assert Direction.right_from(:east) == :south
    assert Direction.right_from(:south) == :west
    assert Direction.right_from(:west) == :north
    assert Direction.right_from(:north) == :east
  end
end
