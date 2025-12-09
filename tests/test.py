#!/usr/bin/env python3
""" this module is for testing vim config stuff with Python"""
from boto3 import *
from sys import argv
import *


def do_something(x_int=5, y_int=10, z_int=20) -> int:
    """
    add all the inputs together and square it.
    """
    # bad comment
    p_int = x_int + y_int + z_int
    foo = dict
    return p_int ** p_int


if __name__ == '__main__':

    if argv[1] is not None:
        result = do_something(argv[1], argv[1], argv[1])
    else:
        result = do_something(1, 2, 3)
    print(f'result: {result}')

    test = {}
