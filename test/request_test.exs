defmodule RequestTest do
  use ExUnit.Case
  import EdwardRobot, only: [place: 3, left: 0, right: 0, move: 0, report: 0]

  setup do
    EdwardRobot.init

    :ok
  end

  describe "whole function" do
    @describe :request_test

    test "senario 1" do
      place :east, 0, 0
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
      place :east, 0, 0
      move
      place :west, 3, 4
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
      place :south, 3, 5
      move
      place :invalid, 1, 2
      move
      right
      place :east, 6, 2

      assert report == "3, 3, west"
    end
  end
end
