defmodule ValidatorTest do
  use ExUnit.Case
  doctest EdwardRobot.Validator
  alias EdwardRobot.{Robot, Validator}

  describe ".robot_on_tabletop?" do
    @describetag :function

    test "happy path" do
      robot = %Robot{x: 2, y: 2, direction: :north}

      assert Validator.robot_on_tabletop?(robot)
    end

    test "sad path" do
      robot = %Robot{x: 0, y: 0, direction: nil}

      assert Validator.robot_on_tabletop?(robot) == {:error, "invalid command, robot should be placed first."}
    end
  end

  test ".valid_x?" do
    assert Validator.valid_x?(5)
    assert Validator.valid_x?(0)

    refute Validator.valid_x?(6)
    refute Validator.valid_x?(-1)
  end

  test ".valid_y?" do
    assert Validator.valid_y?(5)
    assert Validator.valid_y?(0)

    refute Validator.valid_y?(6)
    refute Validator.valid_y?(-1)
  end
end
