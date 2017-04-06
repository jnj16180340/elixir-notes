defmodule Streamer do
  def fibs(n) do
    Stream.unfold({0, 1}, fn {a,b} -> {b, {b, a+b}} end) 
    |> Enum.take(n) 
    |> Enum.to_list
  end
end
