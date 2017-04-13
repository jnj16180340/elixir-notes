# Is module name important?
defmodule CLITest do
  # I do not understand `use`
  use ExUnit.Case
  doctest Issues
  
  # [:function, arity]
  import Issues.CLI, only: [parse_args: 1]
  
  test "--help and -h return :help" do
    assert parse_args(["-h", "piff"]) == :help
    assert parse_args(["--help","poof"]) == :help
  end
  
  test "3 values given -> 3 values returned" do
    assert parse_args(["user","project","420"]) == {"user", "project", 420}
  end
  
  test "use default value for count if only 2 values given" do
    # HOW do we import the @default_count from Issues.CLI?
    # Do we need to explicitly define a getter?
    # Or is it best practice to put all that in
    # a config file, and pull configs into everything?
    IO.puts(@default_count)
    assert parse_args(["user","project"]) == {"user", "project", 4}
  end
  
end
