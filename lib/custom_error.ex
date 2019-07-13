defmodule EdwardRobot.CustomError do
  @moduledoc false

  @invalid_placement "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid."
  @invalid_movement "invalid command, robot will fall down the tabletop."
  @invalid_report "invalid command, robot should be placed first."

  def invalid_placement, do: {:error, @invalid_placement}
  def invalid_movement, do: {:error, @invalid_movement}
  def invalid_report, do: {:error, @invalid_report}
end
