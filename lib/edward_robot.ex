defmodule EdwardRobot do
  @moduledoc false
  import Tabletop
  defstruct x: 0, y: 0, direction: nil
  @type word() :: String.t()

  @valid_directions Direction.directions()

  @doc """
  Initialize Edward Robot, create a robot pid to store state
  """
  def init do
    Agent.start_link(fn -> %EdwardRobot{} end, name: :edward_robot)
  end

  @doc """
  Place robot on the tabletop
  """
  @spec place(direction :: atom, x :: integer, y :: integer) :: atom | {:error, word()}
  def place(direction, x, y) when valid_x?(x) and valid_y?(y) and direction in @valid_directions  do
    update_robot(x, y, direction)
  end

  def place(_, _, _), do: CustomError.invalid_placement()

  @doc """
  Turn robot direction to the left
  """
  @spec left() :: atom
  def left do
    robot = get_robot()

    update_robot(robot.x, robot.y, Direction.left_from(robot.direction))
  end

  @doc """
  Turn robot direction to the right
  """
  @spec right() :: atom
  def right do
    robot = get_robot()

    update_robot(robot.x, robot.y, Direction.right_from(robot.direction))
  end

  @doc """
  Move robot 1 unit forward
  """
  @spec move() :: atom
  def move do
    robot = get_robot()

    update_placement(robot.x, robot.y, robot.direction)
  end

  defp get_robot do
    Agent.get(:edward_robot, & &1)
  end

  defp update_placement(x, y, direction) when direction == :east and x < 5, do: update_robot(x + 1, y, direction)
  defp update_placement(x, y, direction) when direction == :north and y < 5, do: update_robot(x, y + 1, direction)
  defp update_placement(x, y, direction) when direction == :west and x > 0, do: update_robot(x - 1, y, direction)
  defp update_placement(x, y, direction) when direction == :south and y > 0, do: update_robot(x, y - 1, direction)
  defp update_placement(_, _, _),  do: CustomError.invalid_movement()

  defp update_robot(x, y, direction) do
    Agent.update(:edward_robot, & &1 = %EdwardRobot{x: x, y: y, direction: direction})
  end

  @doc """
  Report robot placement on the tabletop

  Display error message if haven't place robot on a valid spot
  """
  @spec report :: word() | {:error, word()}
  def report do
    robot = Agent.get(:edward_robot, & &1)

    if robot.direction == nil do
      CustomError.invalid_report()
    else
      "#{robot.x}, #{robot.y}, #{robot.direction}"
    end
  end
end
