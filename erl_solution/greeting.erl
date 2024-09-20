-module(greeting).
-export([
    fac/1, fac/2,
    sum_digit/1,
    mmax/2,
    list_max/1, list_max/2,
    aboba/4,
    diagonal_r_max/1,
    diagonal_l_max/1,
    row_max/1,
    col_max/1,
    max4mul/1
]).
-compile([debug_info]).




fac(X) -> fac(X, 1).

fac(0, Acc) -> Acc;
fac(X, Acc) -> fac(X - 1, X * Acc).

sum_digit(0) -> 0;
sum_digit(X) -> sum_digit(X div 10) + X rem 10.

% largest_product_grid_20x20(List) -> largest_product_grid_20x20(List, 20, 0, 0, -1).

% largest_product_grid_20x20(List, NumbersCount, N, I, J, Max)
%   when I > N - NumbersCount
%     -> largest_product_grid_20x20(List, NumbersCount, N, I, J, Max);
% largest_product_grid_20x20(List,NumbersCount, N, I, J, Max) ->
%     if Max < List[largest_product_grid_20x20()

mmax(X, Y) ->
    if
        X > Y -> X;
        X =< Y -> Y
    end.

list_max(List) -> list_max(List, -1).

list_max([], Max) ->
    Max;
list_max([H | T], Max) ->
    if
        H > Max -> list_max(T, H);
        H =< Max -> list_max(T, Max)
    end.

% Нахождение максимального право диагонального произведения начинающегося с элемента с первой строки двумерного массива
diagonal_r_max(List) -> diagonal_r_max(List, 1, 0).

diagonal_r_max(List, Col, Max) when length(List) >= 4, Col =< 17 ->
    Product =
        get_element_by_index(List, 1, Col) *
            get_element_by_index(List, 2, Col + 1) *
            get_element_by_index(List, 3, Col + 2) *
            get_element_by_index(List, 4, Col + 3),
    NewMax = mmax(Max, Product),
    diagonal_r_max(List, Col + 1, NewMax);
diagonal_r_max(_, _, Max) ->
    Max.

% Нахождение максимального лево диагонального произведения начинающегося с элемента с первой строки двумерного массива
diagonal_l_max(List) -> diagonal_l_max(List, 4, 0).

diagonal_l_max(List, Col, Max) when length(List) >= 4, Col =< 20 ->
    Product =
        get_element_by_index(List, 1, Col) *
            get_element_by_index(List, 2, Col - 1) *
            get_element_by_index(List, 3, Col - 2) *
            get_element_by_index(List, 4, Col - 3),
    NewMax = mmax(Max, Product),
    diagonal_l_max(List, Col + 1, NewMax);
diagonal_l_max(_, _, Max) ->
    Max.

% Нахождение максимального горизонтального произведения начинающегося с элемента с первой строки двумерного массива
row_max(List) -> row_max(List, 1, 0).

row_max(List, Col, Max) when Col =< 17 ->
    Product =
        get_element_by_index(List, 1, Col) *
            get_element_by_index(List, 1, Col + 1) *
            get_element_by_index(List, 1, Col + 2) *
            get_element_by_index(List, 1, Col + 3),
    NewMax = mmax(Max, Product),
    row_max(List, Col + 1, NewMax);
row_max(_, _, Max) ->
    Max.

% Нахождение максимального вертикального произведения начинающегося с элемента с первой строки двумерного массива
col_max(List) -> col_max(List, 1, 0).

col_max(List, Col, Max) when length(List) >= 4, Col =< 20 ->
    Product =
        get_element_by_index(List, 1, Col) *
            get_element_by_index(List, 2, Col) *
            get_element_by_index(List, 3, Col) *
            get_element_by_index(List, 4, Col),
    NewMax = mmax(Max, Product),
    col_max(List, Col + 1, NewMax);
col_max(_, _, Max) ->
    Max.

get_element_by_index(List, I, J) -> lists:nth(J, lists:nth(I, List)).

max4mul(Array) -> max4mul(Array, 0).

max4mul([], Max) ->
    Max;
max4mul(Array, Max) ->
    DiagRMax = diagonal_r_max(Array),
    DiagLMax = diagonal_l_max(Array),
    RowMax = row_max(Array),
    ColMax = col_max(Array),
    NewMax = list_max([DiagLMax, DiagRMax, RowMax, ColMax, Max]),
    [_ | T] = Array,
    max4mul(T, NewMax).

aboba(_, I, J, Max) when I > 16, J > 16 -> Max;
aboba(List, I, J, Max) when I > 16, J =< 16 ->
    Product =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I, J + 1) *
            get_element_by_index(List, I, J + 2) *
            get_element_by_index(List, I, J + 3),
    aboba(List, I, J + 1, list_max([Product, Max]));
aboba(List, I, J, Max) when I =< 16, J > 16 ->
    Product =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I + 1, J) *
            get_element_by_index(List, I + 2, J) *
            get_element_by_index(List, I + 3, J),
    ProductDiagL =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I - 1, J + 1) *
            get_element_by_index(List, I - 2, J + 2) *
            get_element_by_index(List, I - 3, J + 3),
    aboba(List, I + 1, J, list_max([Product, ProductDiagL, Max]));
aboba(List, I, J, Max) when I =< 16, J =< 16 ->
    ProductRow =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I, J + 1) *
            get_element_by_index(List, I, J + 2) *
            get_element_by_index(List, I, J + 3),
    ProductCol =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I + 1, J) *
            get_element_by_index(List, I + 2, J) *
            get_element_by_index(List, I + 3, J),

    ProductDiagR =
        get_element_by_index(List, I, J) *
            get_element_by_index(List, I + 1, J + 1) *
            get_element_by_index(List, I + 2, J + 2) *
            get_element_by_index(List, I + 3, J + 3),
    if
        J > 4 ->
            ProductDiagL =
                get_element_by_index(List, I, J) *
                    get_element_by_index(List, I - 1, J + 1) *
                    get_element_by_index(List, I - 2, J + 2) *
                    get_element_by_index(List, I - 3, J + 3),
            NewMax = list_max([ProductRow, ProductCol, ProductDiagL, ProductDiagR, Max]),
            list_max([
                aboba(List, I + 1, J + 1, NewMax),
                aboba(List, I + 1, J, NewMax),
                aboba(List, I, J + 1, NewMax)
            ]);
        J =< 4 ->
            NewMax = list_max([ProductRow, ProductCol, ProductDiagR, Max]),
            list_max([
                aboba(List, I + 1, J + 1, NewMax),
                aboba(List, I + 1, J, NewMax),
                aboba(List, I, J + 1, NewMax)
            ])
    end.
