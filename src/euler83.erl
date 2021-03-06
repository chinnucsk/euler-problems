-module(euler83).

-export([solve/0]).

-include_lib("eunit/include/eunit.hrl").

solve() ->
    Square = euler81common:read_square("../input/euler81.txt", 80),
    solve(Square, 80).

solve(Square, Size) ->
    Right = [{{X-1,Y}, {X,Y}, euler81common:get(Square, X, Y)} || X <- lists:seq(2, Size),
                                                                  Y <- lists:seq(1, Size)],
    Left = [{{X,Y}, {X-1,Y}, euler81common:get(Square, X-1, Y)} || X <- lists:seq(2, Size),
                                                                   Y <- lists:seq(1, Size)],
    Down = [{{X,Y-1}, {X,Y}, euler81common:get(Square, X, Y)} || X <- lists:seq(1, Size),
                                                                 Y <- lists:seq(2, Size)],
    Up = [{{X,Y}, {X,Y-1}, euler81common:get(Square, X, Y-1)} || X <- lists:seq(1, Size),
                                                                 Y <- lists:seq(2, Size)],
    Root = [{root, {1,1}, euler81common:get(Square, 1, 1)}],
    All = Right ++ Left ++ Down ++ Up ++ Root,
    Topology = spf:solve(spf:new_topology(All), root),
    spf:cost_root_to_point(Topology, {Size, Size}).
    
solve_test() ->
    {Square, Size} = euler81common:get_test_square(),
    ?assertEqual(2297, solve(Square, Size)).

