Build tool: `mix`
Package manager: `hex.pm`
Static checker: `dialyzer` (for BEAM bytecode, generated Erlang code)
REPL: `iex`
Robustness: 
    - 30 years of Erlang (BEAM VM) and OTP (standard library for "telephony")
    - Used in cell networks, Whatsapp, big 
Nice features:
    - The BEAM VM scheduler is really good
    - Hot code loading
    - "Invisible" distributed-ness: Processes are 'location agnostic' apart from bare-metal differences and network latency
    - More...
    - "Pipeline" syntax
        - `f |> g(y) |> h(y,z)` == `h(g(f(),y),y,z)`
    - Dealing with binary streams and regex-like stuff is really easy
        - EXAMPLES

Differences and caveats:
- Pattern matching: blah blah
- No `for` loops
    - use tail call recursion instead:
- "Opinionated" types (?)
    - lists are linked lists, bad for arbitrary lookup
- **One** concurrency model
    - no `Event` vs `callback` vs `Promise` vs ...
    - Just processes and messages
- Error handling...
- Processes are *cheap*
- No `return` statement
    - *deal with it*
- "" != ''
    - "": String
    - '': Character list
- No custom guard clauses
    - it's technically possible
    

Syntax for definition/lookup of Enumerable types can be a bit weird. Pick a style and stick to it

````elixir
iex(9)> x = %{:piff => 42}
%{piff: 42}
iex(10)> y = %{"piff" => 42}
%{"piff" => 42}
iex(11)> z = [piff: 42] 
[piff: 42]

iex(28)> x.piff
42
iex(29)> x["piff"]
42
iex(30)> x['piff'] # remember strings aren't character lists
nil
iex(31)> y.piff
** (KeyError) key :piff not found in: %{"piff" => 42}
iex(31)> y["piff"]
42
iex(32)> z.piff
** (ArgumentError) argument error
    :erlang.apply([piff: 42], :piff, [])
iex(32)> z[:piff]
42
````

Examples:
- MQTT broker in N lines
- Compare to JS, Python
