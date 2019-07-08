defmodule EdwardRobotTest do
  use ExUnit.Case
  doctest EdwardRobot

  test "greets the world" do
    assert EdwardRobot.hello() == :world
  end
end
