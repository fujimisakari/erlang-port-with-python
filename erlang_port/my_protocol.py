#! /usr/bin/env python
# -*- coding:utf-8 -*-

from protocol import Protocol


class MyProtocol(Protocol):

    def handler_twice(self, x):
        return 2 * int(x)

    def handler_sum(self, x, y):
        return int(x) + int(y)

    def handler_hello(self, name):
        return 'Hello, {}'.format(name)

if __name__ == '__main__':
    MyProtocol().run()
