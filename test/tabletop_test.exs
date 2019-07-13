defmodule TabletopTest do
  use ExUnit.Case
  doctest EdwardRobot.Tabletop
  alias EdwardRobot.{Robot, Tabletop}

  describe ".robot_on_tabletop?" do
    @describetag :function

    test "happy path" do
      robot = %Robot{x: 2, y: 2, direction: :north}

      assert(Tabletop.robot_on_tabletop?(robot))
    end

    test "sad path" do
      robot = %Robot{x: 0, y: 0, direction: nil}

      assert(Tabletop.robot_on_tabletop?(robot)) == {:error, "invalid command, robot should be placed first."}
    end
  end

  test ".valid_x?" do
    assert(Tabletop.valid_x?(5))
    assert(Tabletop.valid_x?(0))

    refute(Tabletop.valid_x?(6))
    refute(Tabletop.valid_x?(-1))
  end

  test ".valid_y?" do
    assert(Tabletop.valid_y?(5))
    assert(Tabletop.valid_y?(0))

    refute(Tabletop.valid_y?(6))
    refute(Tabletop.valid_y?(-1))
  end
end
