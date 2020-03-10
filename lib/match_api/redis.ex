defmodule MatchApi.Redis do
  def get(user_id) do
    Redix.command!(:redix, ["GET", user_id])
  end

  def increment(user_id) do
    Redix.command!(:redix, ["INCR", user_id])
  end
end