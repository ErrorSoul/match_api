defmodule MatchApiTest do
  use ExUnit.Case
  doctest MatchApi

  test "greets the world" do
    assert MatchApi.hello() == :world
  end
end
