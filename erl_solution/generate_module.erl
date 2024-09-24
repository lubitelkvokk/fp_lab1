-module(generate_module).
-export([generate_random_line/2, generate_array/3]).

% Генерация одной строки длиной N с целыми числами от 1 до Max
generate_random_line(N, Max) ->
    lists:map(fun(_) -> rand:uniform(Max) end, lists:seq(1, N)).

% Генерация двумерного массива размером N x M с целыми числами от 1 до Max
generate_array(N, M, Max) ->
    lists:map(fun(_) -> generate_random_line(M, Max) end, lists:seq(1, N)).
