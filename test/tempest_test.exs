defmodule TempestTest do
  use ExUnit.Case
  doctest Tempest

  test "greets the world" do
    assert Tempest.hello() == :world
  end
end
