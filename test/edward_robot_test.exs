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

  defp place_robot_on_valid_spot(context), do: EdwardRobot.place(:east, 0, 0)
end
