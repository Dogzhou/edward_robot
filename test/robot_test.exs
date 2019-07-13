defmodule RobotTest do
  use ExUnit.Case
  alias EdwardRobot.Robot

  setup do
    Robot.init

    :ok
  end

  describe ".place & .report" do
    @describetag :function

    test "place robot on a valid spot" do
      Robot.place(0, 1, :east)

      assert Robot.report() == "0, 1, east"
    end

    test "place robot on the farmost corner" do
      Robot.place(5, 5, :east)

      assert Robot.report() == "5, 5, east"
    end

    test "ignore invalid placement" do
      Robot.place(0, 0, :east)
      Robot.place(6, 5, :east)

      assert Robot.report() == "0, 0, east"
    end

    test "return error if wrong placement" do
      assert Robot.place(:invalid_direction, 0, 0) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."}
      assert Robot.place(6, 5, :east) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."}
      assert Robot.place(5, 6, :west) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."}
      assert Robot.place(0, -1, :north) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."}
      assert Robot.place(-1, 0, :north) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."}
    end

    test "return error if hasn't correctly placed robot when report" do
      Robot.place(0, 0, :invalid_direction)

      assert Robot.report == {:error, "invalid command, robot should be placed first."}
    end
  end

  test ".left" do
    Robot.place(0, 0, :east)

    Robot.left()
    assert Robot.report() == "0, 0, north"

    Robot.left()
    assert Robot.report() == "0, 0, west"

    Robot.left()
    assert Robot.report() == "0, 0, south"

    Robot.left()
    assert Robot.report() == "0, 0, east"
  end

  test "right from east" do
    Robot.place(0, 0, :east)

    Robot.right()
    assert Robot.report() == "0, 0, south"

    Robot.right()
    assert Robot.report() == "0, 0, west"

    Robot.right()
    assert Robot.report() == "0, 0, north"

    Robot.right()
    assert Robot.report() == "0, 0, east"
  end

  describe ".move & .report" do
    @describetag :function

    test "move east on tabletop" do
      Robot.place(4, 5, :east)
      Robot.move()

      assert Robot.report() == "5, 5, east"
    end

    test "move east fall off the tabletop" do
      Robot.place(5, 5, :east)

      assert Robot.move() == {:error, "invalid command, robot will fall down the tabletop."}
      assert Robot.report() == "5, 5, east"
    end

    # Test for move other directions
  end
end
