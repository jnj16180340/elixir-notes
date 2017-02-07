defmodule Pingpong do
  import Process, only: [send_after: 3]
  def ping() do
    receive do
      {status,pid,number} when is_number(number) and number<10 -> 
        # Use IO.inspect instead of IO.puts
        IO.inspect({status,pid,number})
        send(pid,{:ping, self(), number+1})
      {_,_,number} when is_number(number) -> 
        IO.puts("ping says: done")
      _ -> 
        IO.puts("pong says: GARBAGE!")
    end
    ping() # call self to keep process alive
  end
  
  def pong() do
    receive do
      {status,pid,number} when is_number(number) and number<10 -> 
        IO.inspect({status,pid,number})
        # note send vs send_after
        # Also note how the number of messages in flight increases!
        send_after(pid,{:pong, self(), number+1},500)
        send_after(pid,{:pong, self(), number+1},1000)
      {_,_,number} when is_number(number) -> 
        IO.puts("pong says: done")
      _ -> 
        IO.puts("pong says: GARBAGE!")
    end
    pong() # call self to keep process alive
  end
  
  def start() do
    pidping = spawn(__MODULE__, :ping, [])
    pidpong = spawn(__MODULE__, :pong, [])
    # the last line is the 'return' value
    # this is a 'map'
    %{:ping => pidping, :pong => pidpong}
  end
  
  defp theprivy() do
    IO.puts("this is a private function")
  end
end

#Then:
# `elixirc pingpong.ex`
# reload `iex` (or `elixir pingpong.ex`)

# Use `spawn/3`, not `spawn/1` (/1 is for anonymous functions)
# `pidping = spawn(&Pingpong.ping/0)`
# `pidping = spawn(Pingpong, :ping, [])`
# `pidpong = spawn(Pingpong, :pong, [])`
# `send(pidping,{:init,pidpong,0})`
# send() returns the message (you could branch messages like this?)

# You usually don't call `spawn` directly, instead use module `Task`

# `ourpids = Pingpong.start()`
# `ourpids |> Map.values |> Enum.map(&Process.alive?/1)`
# `Enum.map(Map.values(ourpids),&Process.alive?/1)`
# `ourpids |> Enum.map(fn {k,v} -> {k,Process.alive?(v)} end)`
# send(ourpids.ping,{:beginning,ourpids.pong,-2})

# `dialyzer --build_plt --apps erts kernel stdlib crypto public_key /usr/local/lib/elixir/lib/elixir/ebin/`
# `dialyzer -Wunderspecs -Wrace_conditions -Werror_handling -Wunmatched_returns Elixir.Pingpong.beam`
# 
