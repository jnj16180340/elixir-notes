# Module namespace should reflect directory structure,
# but I think directory naming isn't important (e.g. case etc.)
defmodule Issues.CLI do
    # basically a module-level constant
    @default_count 4
    
    @moduledoc """
     Handle the command line parsing and the dispatch to
     the various functions that end up generating a
     table of the last _n_ issues in a github project
     """
    @doc """
    runs it?
    """ 
    def run(argv), do: parse_args(argv)
    
    @doc """
    `argv` can be -h or --help, which returns :help.
    Otherwise it is a github user name, project name, and (optionally)
    the number of entries to format.

    Return a tuple of `{ user, project, count }`, or `:help` if help was given.
    """
    def parse_args(argv) do
        # OptionParser does some coercing into atoms, --an-arg becomes :an_arg etc.
        parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
        
        # parser returns {parsed, args, invalid}
        # args are anything that's not a --switch
        # invalid are switches with the wrong type, or strict mode undefined switches
        case parse do
            # does this match [help: true, nothelp: blah] or just the 1-item list
            {[help: true], _, _} -> :help
            {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
            {_, [user, project], _} -> {user, project, @default_count}
            _ -> :help
        end
        
    end
    
end