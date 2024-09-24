-module(grid_produce).
-export([max4mul/2]).
-compile([debug_info]).

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

% computing product of certain amount and direction of array from X(Row) and Y(Col) index
compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber) ->
    compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber - 1, 1).

compute_product(Array, Row, Col, _, _, 0, Acc) ->
    Acc * get_element_by_index(Array, Row, Col);
compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber, Acc) ->
    CellValue = get_element_by_index(
        Array, Row + StepRow * ProductNumber, Col + StepCol * ProductNumber
    ),
    compute_product(Array, Row, Col, StepRow, StepCol, ProductNumber - 1, Acc * CellValue).

compute_max_product(Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber) ->
    compute_max_product(
        Array, Max, MaxRow, MaxCol, MinRow, MinCol, StepRow, StepCol, ProductNumber, MinRow, MinCol
        % min row, min col
    ).

% computing max of all products with certain direction in array 
% (direction is defined by StepRow, StepCol, amount of element is ProductNumber)
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


% externed function that accepts array of numbers and count of elements, that product we search
max4mul(Array, ProductNumber) ->
    max4mul(Array, ProductNumber, 0).

max4mul(Array, ProductNumber, Max) ->
    Length = length(Array),
    RowMax = compute_max_product(Array, Max, Length, Length - ProductNumber, 1, 1, 0, 1, ProductNumber),
    ColMax = compute_max_product(Array, Max, Length - ProductNumber, Length, 1, 1, 1, 0, ProductNumber),
    DiagRMax = compute_max_product(Array, Max, Length - ProductNumber, Length - ProductNumber, 1, 1, 1, 1, ProductNumber),
    DiagLMax = compute_max_product(Array, Max, Length - ProductNumber, Length, 1, ProductNumber, 1, -1, ProductNumber),
    list_max([RowMax, ColMax, DiagRMax, DiagLMax]).
