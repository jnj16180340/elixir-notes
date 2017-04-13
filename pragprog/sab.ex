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
  
  @exercise "StringsAndBinaries-5"
  # in: list of "stuff"
  # out: print centered column width=longest string
  # it should work with multibyte unicode
  # total padding is maxlength - length
  # pad left + r half of it
  defp padit(s, total_length) do
    # how do you make a closure?
    # just return an anonymous function i think
    sl = String.length(s)
    s 
    |> String.pad_leading(sl+div(total_length-sl,2))
    |> String.pad_trailing(total_length)
  end
  
  def centerr(lodqs) do
    ml = maxlen(lodqs)
    Enum.map(lodqs, fn s -> padit(s, ml) end)
  end
  
  def center(lodqs), do: centerr(lodqs) |> Enum.map(&IO.puts/1)
  # This should be guarded or patternmatched for [string] only...
  # this syntax fucks up Kate's Elixir highlighting. It's the /1 that does it, jesus wept
  defp maxlen(l), do: l |> Enum.map(&String.length/1) |> Enum.max  # / the slash undoes the fucked highlighting
  
  @exercise "StringsAndBinaries-6"
  # There's probably a way to do it with binary pattern matching
  # but I can't figure it out yet
  def capitalize_sentences(sentence) do
    sentence 
    |> String.split(". ", trim: true) # trim doesn't matter; left in as example of keyword option
    |> Enum.map(&String.capitalize/1) #/
    |> Enum.reduce("", fn(x, acc) -> "#{acc}#{x}. " end)
  end
  
  @exercise "StringsAndBinaries-7"
  # Look up the answer, this will be a better description of binary pattern matching
  # than the actual book chapter.
  

end
