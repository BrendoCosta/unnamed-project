defmodule IzumiTest do
  use ExUnit.Case
  doctest Izumi

  test "greets the world" do
    assert Izumi.hello() == :world
  end
end
