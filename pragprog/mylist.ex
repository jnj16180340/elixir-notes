defmodule MyList do
  @exercise "ListsAndRecursion-0"
  @purpose "it sums a list"
  def sum([head | []]), do: head
  def sum([head | [th | tt]]), do: sum([head + th | tt])
  
  @exercise "ListsAndRecursion-1"
  @purpose "it applies a function to each list element and sums the xformed elements"
  def mapsum([], _func), do: 0 # don't do [head|[]]
  def mapsum([head | tail], func), do: func.(head)+mapsum(tail, func)
  
  @exercise "ListsAndRecursion-2"
  @purpose "finds the maximum value in a list"
  # when there's one element, there's one possible max value!
  def max([head | []]), do: head
  def max([head | [th | tt]]) when head>th, do: max([head | tt])
  def max([head | [th | tt]]) when head<th, do: max([th | tt])
  
  @exercise "ListsAndRecursion-3"
  @purpose "it takes a '', adds n to each element, wraps if new value > z"
  # Typically charlists are deprecated, modern libs use binaries
  # ?z == 122 (prepending '?' is an operator!)
  # This isn't quite correct, _convert is wrong
  # Don't use a second list, because pop->prepend reverses the order!
  def caesar([],_), do: []
  def caesar([head|tail], n), do: [_convert(head,n) | caesar(tail,n)]
  defp _convert(c,n), do: rem(c+n,?z)
  
  @exercise "ListsAndRecursion-4"
  @purpose "span(from,to) returns list of numbers from from to to. Let's not make a range and convert it to a list."
  # it's the tail element, so it must be a list
  # assumes 0>from>to
  def span(to,to), do: [to]
  def span(from,to), do: [from | span(from+1,to)]
  
  @exercise "ListAndRecursion-5"
  @purpose "Implement Enum functions (no libraries nor comprehensions==loops): *all?, *each, filter, split, *take"
  # all(enum, fun): true if fun(e) for all e in enum
  # 0 is considered "true"
  # need a header for default args
  def all?(_, func \\ &(&1))
  def all?([head | []], func), do: func.(head) && true
  # remember to include func in recursive call or it will be the default!!!
  def all?([head | tail], func), do: func.(head) && all?(tail, func)
  #each(enum, fun) invokes fun for each item
  def each(_, func \\ &IO.puts/1) # the / makes kate syntax file glitch out
  def each([head|[]], func) do
    func.(head) # we can't join lines with ;
    :ok
  end
  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end
  # take/2: [1,2,3],2 -> [1,2]; [1,2,3].-1 -> 3
  def take([head | _], 0), do: head
  def take([head | tail], index) when index<0, do: take([head|tail], count([head|tail])+index)
  def take([_ | tail], index), do: take(tail, index-1)
  # it's easier to implement take using a count helper fn instead of 4 param _take
  def count([head|tail]), do: _count([head|tail],0)
  defp _count([head|[]], acc), do: acc+1
  defp _count([head|tail],acc), do: _count(tail, acc+1)
  # filter(enum, fun) -> returns only those elements for which fun returns
  def filter([head | []], func) do
    if func.(head) do
      [head]
    end
  end
  def filter([head|tail], func) do
    #piff
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  
  # split(enumerable, count) -> Splits the enumerable into two enumerables, leaving count elements in the first one.
  # If count is a negative number, it starts counting from the back to the beginning of the enumerable (2x memory)
end
