-module(generate_module).
-export([generate_random_line/2, generate_array/3]).

% Генерация одной строки длиной N с целыми числами от 1 до Max
generate_random_line(N, Max) -> generate_random_line(N, Max, []).

generate_random_line(0, _, Acc) -> Acc;
generate_random_line(N, Max, Acc) -> 
    generate_random_line(N - 1, Max, [rand:uniform(Max) | Acc]).

% Генерация двумерного массива размером N x M с целыми числами от 1 до Max
generate_array(N, M, Max) -> generate_array(N, M, Max, []).

generate_array(0, _, _, Acc) -> 
    Acc;
generate_array(N, M, Max, Acc) ->
    List = generate_random_line(M, Max),  % Генерация строки длиной M
    fold
    generate_array(N - 1, M, Max, [List | Acc]).
