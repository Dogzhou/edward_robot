defmodule EdwardRobot.Validator do
  alias EdwardRobot.{CustomError, Robot}
  @moduledoc false
  @max_x 5
  @max_y 5

  defmacro valid_x?(x) do
    quote do
      unquote(x) in 0..unquote(@max_x)
    end
  end

  defmacro valid_y?(y) do
    quote do
      unquote(y) in 0..unquote(@max_y)
    end
  end

  @doc """
  check if robot is on the tabletop

  robot's direction is nil if it's never been placed correctly
  """
  @spec robot_on_tabletop?(robot :: Robot.t()) :: String.t() | true
  def robot_on_tabletop?(robot) do
    case robot.direction do
      nil -> CustomError.invalid_report()
      _ -> true
    end
  end
end
