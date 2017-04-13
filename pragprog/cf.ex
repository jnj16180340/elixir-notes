defmodule ControlFlow do
    @testint 69
    @teststr "four twenty"
    @exercise "ControlFlow-1"
    # FizzBuzz using case
    
    @exercise "ControlFlow-2"
    # Some touchy feely shit
    
    @exercise "ControlFLow-3"
    # ControlFlow.ok! {:error, <<2342345>>} kills the process, lol. why?
    # more primitive "data" types work fine
    def ok!({:ok, data}), do: data
    def ok!({notok, data}), do: raise("#{notok}: #{data}")
end