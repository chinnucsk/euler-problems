%% Project Euler, problem 19
%% 
%% How many Sundays fell on the first of the month during the twentieth century?

-module(euler19).

-export([solve/0]).

-include_lib("eunit/include/eunit.hrl").

is_leap_year(Year) ->
    if
        Year rem 400 == 0 ->
            true;
        Year rem 100 == 0 ->
            false;
        Year rem 4 == 0 ->
            true;
        true ->
            false
    end.

days_in_month(Month, Year) ->
    case Month of
        1 -> 31;
        2 ->
            case is_leap_year(Year) of 
                true -> 29;
                false -> 28
            end;
        3 -> 31;
        4 -> 30;
        5 -> 31;
        6 -> 30;
        7 -> 31;
        8 -> 31;
        9 -> 30;
        10 -> 31;
        11 -> 30;
        12 -> 31
    end.

next_date({Day, Month, Year, Dow}) ->
    NewDow = (Dow + 1) rem 7,
    case Day == days_in_month(Month, Year) of
        false ->
            NewDay = Day + 1,
            NewMonth = Month,
            NewYear = Year;
        true ->
            case Month == 12 of
                false ->
                    NewDay = 1,
                    NewMonth = Month + 1,
                    NewYear = Year;
                true ->
                    NewDay = 1,
                    NewMonth = 1,
                    NewYear = Year + 1
            end
    end,
    {NewDay, NewMonth, NewYear, NewDow}.

is_first_of_month_sunday({Day, _Month, _Year, Dow}) ->
    (Day == 1) and (Dow == 0).

solve() ->
    solve({1, 1, 1900, 1}, 0).

solve(Date = {_Day, _Month, Year, _Dow}, Count) ->
    NextDate = next_date(Date),
    if
        Year < 1901 ->                         % Not in 20th century yet
            solve(NextDate, Count);
        Year =< 2000 ->
            case is_first_of_month_sunday(Date) of
                false -> NewCount = Count;
                true -> NewCount = Count + 1
            end,
            solve(NextDate, NewCount);
        true ->
            Count
    end.

solve_test() ->
    ?assertEqual(171, solve()).
