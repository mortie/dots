#!/usr/bin/env python3

import time
import sys
import math

device = "/sys/class/backlight/intel_backlight"

with open(device + "/brightness") as f:
    curr_bri = int(f.readline())
with open(device + "/max_brightness") as f:
    max_bri = int(f.readline())

def change_between(curr, new, t = 0.2, steps = 10):
    if new > max_bri:
        new = max_bri
    elif new < 0.005 * max_bri:
        new = 0.005 * max_bri

    if new < curr:
        new = math.floor(new)
    else:
        new = math.ceil(new)

    for i in range(steps):
        frac = (i + 1) / steps
        val = int(curr * (1 - frac) + new * frac)

        with open(device + "/brightness", "w") as f:
            f.write(str(val))
            time.sleep(t / steps)

if len(sys.argv) != 2:
    print("Usage: " + sys.argv[0] + " <factor>")
    exit(1)

factor = float(sys.argv[1])
change_between(curr_bri, curr_bri + curr_bri * factor)
