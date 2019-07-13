defmodule EdwardRobot do
  @type word() :: String.t()
  defstruct x: 0, y: 0, direction: nil

  @valid_directions ~w(east north south west)a
  @valid_x 0..5
  @valid_y 0..5
  @left_direction_map %{
    :east => :north,
    :north => :west,
    :west => :south,
    :south => :east
  }
  @right_direction_map %{
    :east => :south,
    :south => :west,
    :west => :north,
    :north => :east
  }

  @doc """
  Initialize Edward Robot, create a robot pid to store state
  """
  def init do
    Agent.start_link(fn -> %EdwardRobot{} end, name: :edward_robot)
  end

  @doc """
  Place robot on the tabletop

  valid x value is within 0 -> 5
  valid y value is within 0 -> 5
  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec place(direction :: atom, x :: integer, y :: integer) :: pid() | {:error, word()}
  def place(direction, x, y) when x in @valid_x and y in @valid_y and direction in @valid_directions  do
    Agent.update(:edward_robot, & &1 = %EdwardRobot{x: x, y: y, direction: direction})
  end

  def place(_, _, _), do: {:error, "Invalid command, please make sure the robot placement is within 5 * 5 tabletop and direction is valid"}

  @doc """
  Turn robot direction to the left
  """
  @spec left() :: :atom
  def left do
    update_robot(robot.x, robot.y, @left_direction_map[robot.direction])
  end

  @doc """
  Turn robot direction to the right
  """
  @spec right() :: :atom
  def right do
    update_robot(robot.x, robot.y, @right_direction_map[robot.direction])
  end

  @doc """
  Move robot 1 unit forward
  """
  @spec move() :: :atom
  def move do
    update_placement(robot.x, robot.y, robot.direction)
  end

  defp robot do
    Agent.get(:edward_robot, & &1)
  end

  defp update_placement(x, y, direction) when direction == :east and x < 5, do: update_robot(x + 1, y, direction)
  defp update_placement(x, y, direction) when direction == :north and y < 5, do: update_robot(x, y + 1, direction)
  defp update_placement(x, y, direction) when direction == :west and x > 0, do: update_robot(x - 1, y, direction)
  defp update_placement(x, y, direction) when direction == :south and y > 0, do: update_robot(x, y - 1, direction)
  defp update_placement(_, _, _),  do: {:error, "invalid command, robot will fall down the tabletop"}

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
      {:error, "Robot hasn't been placed correctly yet."}
    else
      "#{robot.x}, #{robot.y}, #{robot.direction}"
    end
  end
end
