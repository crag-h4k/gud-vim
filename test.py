#!/usr/bin/env python3
from sys import argv
from os import getenv


def do_something(x=5, y=10, z=20) -> int:
    """
    add all the inputs together and square it.
    """
    p = x + y + z
    return p ** p


if __name__ == '__main__':

    if argv[1] is not None:
        result = do_something(argv[1], argv[1], argv[1])
    else:
        result = do_something(1, 2, 3)
    print(f'result: {result}')

    test = {}

