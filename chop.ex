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
