def factorial_rec(n):
    if (n == 0):
         return 1
    return n * factorial_rec(n - 1)

def factorial_cycle(n:int):
    acc = 1
    while (n != 0):
       acc *= n
       n -= 1
    return acc 

def sum_of_digits(n:int):
    acc = 0
    while (n != 0):
        acc += n % 10
        n //= 10
    return acc