defmodule EdwardRobot.Direction do
  @moduledoc """
  provide direction functions
  """

  @doc """
  return an array of all directions
  """
  @spec directions() :: list(atom)
  def directions, do: ~w(east north south west)a

  @doc """
  return the direction after turning left from a direction
  """
  @spec left_from(direction :: atom) :: atom
  def left_from(:east), do: :north
  def left_from(:north), do: :west
  def left_from(:west), do: :south
  def left_from(:south), do: :east

  @doc """
  return the direction after turning right from a direction
  """
  @spec right_from(direction :: atom) :: atom
  def right_from(:east), do: :south
  def right_from(:south), do: :west
  def right_from(:west), do: :north
  def right_from(:north), do: :east
end
