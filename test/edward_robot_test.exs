defmodule EdwardRobotTest do
  use ExUnit.Case
  doctest EdwardRobot

  setup do
    EdwardRobot.init

    :ok
  end

  describe ".place & .report" do
    @describetag :function

    test "place robot on a valid spot" do
      EdwardRobot.place(:east, 0, 1)

      assert EdwardRobot.report() == "0, 1, east"
    end

    test "place robot on the farmost corner" do
      EdwardRobot.place(:east, 5, 5)

      assert EdwardRobot.report() == "5, 5, east"
    end

    test "ignore invalid placement" do
      EdwardRobot.place(:east, 0, 0)
      EdwardRobot.place(:east, 6, 5)

      assert EdwardRobot.report() == "0, 0, east"
    end

    test "return error if wrong placement" do
      assert EdwardRobot.place(:invalid_direction, 0, 0) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}
      assert EdwardRobot.place(:east, 6, 5) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}
      assert EdwardRobot.place(:west, 5, 6) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}
      assert EdwardRobot.place(:north, 0, -1) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}
      assert EdwardRobot.place(:north, -1, 0) == {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}
    end

    test "return error if hasn't correctly placed robot when report" do
      EdwardRobot.place(:invalid_direction, 0, 0)

      assert EdwardRobot.report == {:error, "Robot hasn't been placed correctly yet."}
    end
  end

  test ".left" do
    EdwardRobot.place(:east, 0, 0)

    EdwardRobot.left()
    assert EdwardRobot.report() == "0, 0, north"

    EdwardRobot.left()
    assert EdwardRobot.report() == "0, 0, west"

    EdwardRobot.left()
    assert EdwardRobot.report() == "0, 0, south"

    EdwardRobot.left()
    assert EdwardRobot.report() == "0, 0, east"
  end

  test "right from east" do
    EdwardRobot.place(:east, 0, 0)

    EdwardRobot.right()
    assert EdwardRobot.report() == "0, 0, south"

    EdwardRobot.right()
    assert EdwardRobot.report() == "0, 0, west"

    EdwardRobot.right()
    assert EdwardRobot.report() == "0, 0, north"

    EdwardRobot.right()
    assert EdwardRobot.report() == "0, 0, east"
  end

  describe ".move & .report" do
    @describetag :function

    test "move east on tabletop" do
      EdwardRobot.place(:east, 4, 5)
      EdwardRobot.move()

      assert EdwardRobot.report() == "5, 5, east"
    end

    test "move east fall off the tabletop" do
      EdwardRobot.place(:east, 5, 5)

      assert EdwardRobot.move() == {:error, "invalid command, robot will fall down the tabletop"}
      assert EdwardRobot.report() == "5, 5, east"
    end

    # Test for move other directions
  end
end
