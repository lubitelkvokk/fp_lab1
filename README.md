lab1
=====

## Task 11

![alt text](resources/image.png)

```
Array = [
    [8, 2, 22, 97, 38, 15, 0, 40, 0, 75, 4, 5, 7, 78, 52, 12, 50, 77, 91, 8],
    [49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 4, 56, 62, 0, 81],
    [81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 3, 49, 13, 36, 65],
    [52, 70, 95, 23, 4, 60, 11, 42, 69, 24, 68, 56, 1, 32, 56, 71, 37, 2, 36, 91],
    [22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80],
    [24, 47, 32, 60, 99, 3, 45, 2, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50],
    [32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70],
    [67, 26, 20, 68, 2, 62, 12, 20, 95, 63, 94, 39, 63, 8, 40, 91, 66, 49, 94, 21],
    [24, 55, 58, 5, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72],
    [21, 36, 23, 9, 75, 0, 76, 44, 20, 45, 35, 14, 0, 61, 33, 97, 34, 31, 33, 95],
    [78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 3, 80, 4, 62, 16, 14, 9, 53, 56, 92],
    [16, 39, 5, 42, 96, 35, 31, 47, 55, 58, 88, 24, 0, 17, 54, 24, 36, 29, 85, 57],
    [86, 56, 0, 48, 35, 71, 89, 7, 5, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58],
    [19, 80, 81, 68, 5, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 4, 89, 55, 40],
    [4, 52, 8, 83, 97, 35, 99, 16, 7, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66],
    [88, 36, 68, 87, 57, 62, 20, 72, 3, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69],
    [4, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 8, 46, 29, 32, 40, 62, 76, 36],
    [20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 4, 36, 16],
    [20, 73, 35, 29, 78, 31, 90, 1, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 5, 54],
    [1, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 1, 89, 19, 67, 48]
].
```
``` erl
list_max(List) -> list_max(List, -1).

list_max([], Max) ->
    Max;
list_max([H | T], Max) ->
    list_max(T, mmax(H, Max)).

mmax(X, Y) ->
    if
        X > Y -> X;
        X =< Y -> Y
    end.

get_element_by_index(List, I, J) -> lists:nth(J, lists:nth(I, List)).

% Вычисление результата умножения определенного количества числе (ProductNumber) по определенному направлению в матрице с текущего индекса X(Row), Y(Col)
compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber) ->
    compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber - 1, 1).

compute_product(Array, Row, Col, _, _, 0, Acc) ->
    Acc * get_element_by_index(Array, Row, Col);
compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber, Acc) ->
    CellValue = get_element_by_index(
        Array, Row + StepRow * ProductNumber, Col + StepCol * ProductNumber
    ),
    compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber - 1, Acc * CellValue).

% вызов хвостовой рекурсии с указанными ограничениями на индексы и начальными значениями для умножения (можно реализовать передачу функции с указанными оператором, напр. +)
compute_max_product(Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber) ->
    compute_max_product(
        Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, MinRow, MinCol
    ).

% Вычисляется результат умножения указанного количества элементов, по указанному направлению и по всем доступным по ограничениям индексам.
compute_max_product(_, Max, MaxRow, _, _, _, _, _, _, MaxRow, _) ->
    Max;
compute_max_product(
    Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, Row, Col
) when
    Row >= MinRow, Row =< MaxRow, Col >= MinCol, Col =< MaxCol
->
    Product = compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber),
    NewMax = mmax(Max, Product),
    compute_max_product(
        Array, NewMax, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, Row, Col + 1
    );
compute_max_product(
    Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, Row, _
) ->
    compute_max_product(
        Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, Row + 1, MinCol 
        % next row, min col
    ).

% Функция принимает двумерный массив и количество элементов, произведение которых будет искаться
max4mul(Array, ProductNumber) ->
    max4mul(Array, ProductNumber, 0).

max4mul(Array, ProductNumber, Max) ->
    Length = length(Array),
    RowMax = compute_max_product(Array, Max, Length, Length - ProductNumber, 1, 1, 0, 1, ProductNumber),
    ColMax = compute_max_product(Array, Max, Length - ProductNumber, Length, 1, 1, 1, 0, ProductNumber),
    DiagRMax = compute_max_product(Array, Max, Length - ProductNumber, Length - ProductNumber, 1, 1, 1, 1, ProductNumber),
    DiagLMax = compute_max_product(Array, Max, Length - ProductNumber, Length, 1, ProductNumber, 1, -1, ProductNumber),
    list_max([RowMax, ColMax, DiagRMax, DiagLMax]).
```

## Task 20

![alt text](resources/image1.png)

``` erl
% Вызов функции с общим для большинства случаев нейтральным по умножению элементом (1)
fac(X) -> fac(X, 1).

% Хвостовая рекурсия, с передачей аккумулятора. Для нахождения факториала необходимо каждый раз умножать его на текущее значение.
fac(0, Acc) -> Acc;
fac(X, Acc) -> fac(X - 1, X * Acc).

% Реализация суммы цифр числа рекурсивным методом 
sum_digit(0) -> 0;
sum_digit(X) -> sum_digit(X div 10) + X rem 10.

% Реализация суммы цифр числа хвостовой рекурсией
sum_digit_tailrec(X) -> sum_digit_tailrec(X, 0).

sum_digit_tailrec(0, Acc) -> Acc;
sum_digit_tailrec(X, Acc) -> sum_digit_tailrec(X div 10, Acc + X rem 10).

% Реализация суммы цифр числа с использованием сверточной функции fold
sum_digit_fold(X) ->
    Digits = integer_to_list(X),
    lists:foldl(fun(Digit, Acc) -> Acc + (Digit - $0) end, 0, Digits).
```
