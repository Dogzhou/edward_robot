defmodule EdwardRobot.Robot do
  @moduledoc false
  import EdwardRobot.Validator
  alias EdwardRobot.{CustomError, Direction, Robot, Validator}
  @valid_directions Direction.directions()
  defstruct [:x, :y, :direction]
  @type direction :: Direction.direction()
  @type t() :: %__MODULE__{
          x: integer,
          y: integer,
          direction: direction
        }

  @doc """
  Initialize Edward Robot, create a robot pid to store state
  """
  def init do
    Agent.start_link(fn -> %Robot{} end, name: :edward_robot)
  end

  @doc """
  Place robot on the tabletop
  """
  @spec place(x :: integer, y :: integer, direction :: direction) :: atom | {:error, String.t()}
  def place(x, y, direction)
      when valid_x?(x) and valid_y?(y) and direction in @valid_directions do
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
  @spec move() :: atom | {:error, String.t()}
  def move do
    robot = get_robot()

    update_placement(robot.x, robot.y, robot.direction)
  end

  defp get_robot do
    Agent.get(:edward_robot, & &1)
  end

  defp update_placement(x, y, :east) when valid_x?(x + 1), do: update_robot(x + 1, y, :east)
  defp update_placement(x, y, :north) when valid_y?(y + 1), do: update_robot(x, y + 1, :north)
  defp update_placement(x, y, :west) when valid_x?(x - 1), do: update_robot(x - 1, y, :west)
  defp update_placement(x, y, :south) when valid_y?(y - 1), do: update_robot(x, y - 1, :south)
  defp update_placement(_, _, _), do: CustomError.invalid_movement()

  defp update_robot(x, y, direction) do
    Agent.update(:edward_robot, &(&1 = %Robot{x: x, y: y, direction: direction}))
  end

  @doc """
  Report robot placement on the tabletop

  Display error message if haven't place robot on a valid spot
  """
  @spec report :: String.t() | {:error, String.t()}
  def report do
    robot = get_robot()

    with true <- Validator.robot_on_tabletop?(robot) do
      "#{robot.x}, #{robot.y}, #{robot.direction}"
    end
  end
end
