## In this repo
- `random`: My random crap
    - `pingpong`: message passing between processes

- `pragprog`: Exercises from Dave Thomas _Programming Elixir 1.3_; annotated with answers found at https://forums.pragprog.com/forums/322

## Dialyzer
Setup: `dialyzer --build_plt --apps erts kernel stdlib crypto public_key /usr/local/lib/elixir/lib/elixir/ebin/`
`Wall` equivalent: `dialyzer -Wunderspecs -Wrace_conditions -Werror_handling -Wunmatched_returns Elixir.Pingpong.beam`
Normal use: `dialyzer $BYTECODE`

### To do
- [ ] build tooling, package manager etc demos
- [ ] Message passing over a network
    - Raspberry Pi "cluster" example, maybe blink lights or sth
- [ ] MQTT broker example
- [ ] Some comparisons to nodeJS and other crappy stuff

### Standard tooling
Build tool: `mix`
Package manager: `hex.pm`
Static checker: `dialyzer` (for BEAM bytecode, generated Erlang code)
REPL: `iex`

### Features
- Robustness: 
    - 30 years of Erlang (BEAM VM) and OTP (standard library for "telephony")
    - Used in cell networks, Whatsapp, big companies
    - "Erlang philosophy":
        - Failures will always happen
        - The system must never go down
- The BEAM VM scheduler is really good
- Hot code loading
- "Invisible" distributed-ness: Processes are 'location agnostic' apart from bare-metal differences and network latency
- "Pipeline" syntax
        - `f |> g(y) |> h(y,z)` == `h(g(f(),y),y,z)`
- Dealing with binary streams and regex-like stuff is really easy
        - EXAMPLES
- Soft realtime
    - Explain what this means
- More...

### Differences and caveats
- Types+syntax can be a little bit weird
    - **But at least they're not schizophrenic!** 
    - Pick a style and stick to it
    - Use module attributes `@attrib` as constants
- Some case sensitivity
    - `Piff` == :"Elixir.Piff" (`Piff` != `"Elixir.Piff"`, `:Piff`, `"Piff"` etc)
    - `:lowercaseatom` *may be* an Erlang module
    - `:io` -> Erlang `io` module; `IO` -> `Elixir.IO`
    - `:erlang.FUNC` is "built-in functions"
    - Don't worry if you follow naming conventions
- Pattern matching: blah blah
    - This often replaces guards, cases, etc.
    - e.g. `def match(target, target), do` instead of `def match(target, guess) when target==guess do...`
- No `for`, `while` loops
    - Use tail call recursion instead
    - Actually there are, but let's just use them for traversing enumerables
- "Opinionated" types (?)
    - lists are linked lists, bad for arbitrary lookup
    - Fast for prepending at head
- **One** concurrency model
    - no `Event` vs `callback` vs `Promise` vs ...
    - Just processes and messages
    - They may be wrapped higher level stuff (`Task` etc)
- Error handling...
- Processes are *cheap*
- No `return` statement
    - *deal with it*
- "" != ''
    - "": String
    - '': Character list
- No custom guard clauses
    - it's technically possible
- Import module functions in the smallest possible scope
    - Even in function defs!
    

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
