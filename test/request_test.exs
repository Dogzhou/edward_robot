defmodule RequestTest do
  use ExUnit.Case
  import EdwardRobot.Robot

  setup do
    init()

    :ok
  end

  describe "whole function" do
    @describetag :request_test

    test "senario 1" do
      place 0, 0, :east
      move
      move
      move
      move
      move
      left
      right
      left

      assert report == "5, 0, north"
    end

    test "senario 2" do
      place 0, 0, :east
      move
      place 3, 4, :west
      move
      move
      move
      move
      move
      left
      right
      left

      assert report == "0, 4, south"
    end

    test "senario 3" do
      place 3, 5, :south
      move
      place 1, 2, :invalid
      move
      right
      place 6, 2, :east

      assert report == "3, 3, west"
    end
  end
end
