# Thomas "Programming Elixir 1.3" ModulesAndFunctions-6
# Exercise answers can be found at https://forums.pragprog.com/forums/322
defmodule Chop do
    # Another option: Split list into [head | middle (1 or 2 elem) | tail]
    def guess(target, low..high) do
        tg = midpoint(low..high)
        fout(tg)
        guess(target, low..high, tg)
    end
    def guess(target, low..high, theguess) when theguess==target do
        # the anchor case/ terminating condition
        IO.puts("#1")
        theguess
    end
    def guess(target, low..high, theguess) when low==high do
        # another anchor case/ terminating condition
        IO.puts("#2")
        low
    end
    def guess(target, low..high, theguess) when theguess>target do
        # lower half
        tg = midpoint(low..high)
        fout(tg)
        guess(target, splist(low..high, :lower), tg)
    end
    def guess(target, low..high, theguess) when theguess<target do
        # upper half
        tg = midpoint(low..high)
        fout(tg)
        guess(target, splist(low..high, :upper), tg)
    end
    
    # I really don't wanna handle even/odd length cases!
    def splist(low..high, :lower) do
        low..low+div(high-low,2)
    end
    def splist(low..high, :upper) when high-low==1 do
        # fuuuuuck me
        high..high
    end
    def splist(low..high, :upper) do
        (low+div(high-low,2))..high
    end
    
    # find middle element of list
    def midpoint(low..high) do
        # general case, ignore lower ones
        low+div(high-low,2)
    end
    
    def fout(g) when is_integer(g) do
        IO.puts("Is it "<>Integer.to_string(g))
    end
end

# Dave Thomas's answer
defmodule ChopAnswer do
  # another way of pattern matching
  # Use string interpolation instead of concatenation!
  # that avoids Integer.to_string/1 etc
  # re: midpoint finding, I'm just stupid
  def guess(actual, range = low..high) do 
    guess = div(low+high, 2)
    IO.puts "Is it #{guess}?"
    _guess(actual, guess, range)
  end

  # use pattern matching instead of guard!
  # style: use _ in private functions
  defp _guess(actual, actual, _),
    do: IO.puts "Yes, it's #{actual}"
  
  # this is so much simpler
  # we already know the list midpoint so we don't need to split it
  # in a separate function!
  defp _guess(actual, guess,  _low..high)
    when guess < actual,
    do: guess(actual, guess+1..high)

  defp _guess(actual, guess,  low.._high) 
    when guess > actual, 
    do: guess(actual, low..guess-1)
end
