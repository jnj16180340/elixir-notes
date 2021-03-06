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
  defp _count([_head|[]], acc), do: acc+1
  defp _count([_head|tail],acc), do: _count(tail, acc+1)
  # filter(enum, fun) -> returns only those elements for which fun returns
  def filter([head | []], func) do
    if func.(head) do
      [head]
    end
  end
  def filter([head|tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  # split(enumerable, count) -> Splits the enumerable into two enumerables, leaving count elements in the first one.
  # is it possible to do without reversing the list?
  def reverse([head|tail]), do: _reverse([head|tail],[])
  defp _reverse([oh|[]], nl), do: [oh|nl] 
  defp _reverse([oh|ot], nl), do: _reverse(ot, [oh|nl]) 
  
  def split([head|tail], c) when c<0, do: _split([head|tail],{[],[]},count([head|tail])+c)
  def split([head|tail], c), do: _split([head|tail],{[],[]},c)
  defp _split([head|[]],{l1,l2}, c) when c>0, do: {reverse([head|l1]),reverse(l2)}
  defp _split([head|[]],{l1,l2}, c) when c==0, do: {reverse(l1), reverse([head|l2])}
  defp _split([head|tail],{l1,l2}, c) when c>0, do: _split(tail,{[head|l1],l2},c-1)
  defp _split([head|tail],{l1,l2}, c) when c==0, do: _split(tail,{l1, [head|l2]}, c)
  
  @exercise "ListsAndRecursion-6"
  @purpose "flatten: flattens an arbitrarily nested list :("
  # There aren't easy ways to do this without building an intermediate list,
  # SEE https://forums.pragprog.com/forums/322/topics/11936
  # If we are allowed to use `++` (ineffficient!!)
  #def flatten([head|[]]) when is_list(head), do: flatten(head) # empiricallyunnecessary
  def flatten([head|[]]), do: flatten(head)
  def flatten([head|tail]), do: flatten(head) ++ flatten(tail)
  def flatten(h), do: [h]  
  
  @exercise "ListsAndRecursion-7"
  @purpose "Use span() + list comprehensions to return prime numbers"
  defp snap(a,b), do: a..b |> Enum.to_list
  # tHIS IS I THINK IMPOSSIBBLE TO DO AS PURE generator+filter
  # unless we use `--` and find nonprimes
  
  @exercise "ListsAndRecursion-8"
  @purpose "insertinf fields n stuff"
  # We can't export variables from modules directly, although we could define as
  # @module_attribute and def getter, do: @module_attribute
  # But, the idiomatic way is to think in functions not variables
  def tax_rates, do: [ NC: 0.075, TX: 0.08 ]
  def orders, do: [
      [ id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ id: 124, ship_to: :OK, net_amount: 35.50 ],
      [ id: 125, ship_to: :TX, net_amount: 24.00 ],
      [ id: 126, ship_to: :TX, net_amount: 44.80 ],
      [ id: 127, ship_to: :NC, net_amount: 25.00 ],
      [ id: 128, ship_to: :MA, net_amount: 10.00 ],
      [ id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ id: 130, ship_to: :NC, net_amount: 50.00 ]
    ]
  # Keyword.update: updates keywords with f(value) OR initial
  # f = nil is okay when key never exists; but identity is safer == &(&1))
  # i guess nil is good for catching problems early
  # Or, use Keyword.put/3 which is better (or put_new which doesn't overwrite)
  # Interestingly, update adds to tail, put adds to head
  def nil2zero(nil), do: 0
  def nil2zero(v), do: v
  #for li <- MyList.orders, do: Keyword.update(li, :piff, 420, nil)
  def calctaxes do
    for li <- MyList.orders do 
      Keyword.put(li, :total, li[:net_amount]*(1+nil2zero(tax_rates[li[:ship_to]])))
    end
  end
end
