#!/usr/bin/env

import math

f = open('file.csv', 'w')
for val in range(100):
    t = 0.1*val
    y = math.sin(2*t)
    f.write('{}, {}\n'.format(t, y))
f.close()