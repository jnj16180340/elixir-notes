defmodule SAB do
  @exercise "StringsAndBinaries-1"
  # The (? ) to get char code syntax is really bad,
  # is there another way to get char code?
  # Sigils example: Note that
  # SAB.printable?(~c'123\n') => false
  # SAB.printable?(~C'123\n') => true
  def printable?(lin) do
    List.foldl(lin, true, fn(val, acc) -> acc and val<=(?~) and val>=(? ) end )
  end
  
  @exercise "StringsAndBinaries-2"
  # - What's the difference between string and binary? (there's no Binary mnodule!)
  # - Cleaner way of implementing polymorphism besides guards for each param?
  def anagram?(lin, lintoo) when is_binary(lin), do: anagram?(String.to_charlist(lin), lintoo)
  def anagram?(lin, lintoo) when is_binary(lintoo), do: anagram?(lin, String.to_charlist(lintoo))
  def anagram?(lin, lintoo) do
  # should also catch string case and convert to char list
  # string doesn't implement enumerable
    Enum.sort(lin) == Enum.sort(lintoo)
  end

end
