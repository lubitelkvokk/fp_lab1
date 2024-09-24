-module(factorial).
-export([fac/1, sum_digit/1, sum_digit_fold/1, sum_digit_tailrec/1]).

fac(X) -> fac(X, 1).

fac(0, Acc) -> Acc;
fac(X, Acc) -> fac(X - 1, X * Acc).

sum_digit(0) -> 0;
sum_digit(X) -> sum_digit(X div 10) + X rem 10.

sum_digit_tailrec(X) -> sum_digit_tailrec(X, 0).

sum_digit_tailrec(0, Acc) -> Acc;
sum_digit_tailrec(X, Acc) -> sum_digit_tailrec(X div 10, Acc + X rem 10).

sum_digit_fold(X) ->
    Digits = integer_to_list(X),
    lists:foldl(fun(Digit, Acc) -> Acc + (Digit - $0) end, 0, Digits).
