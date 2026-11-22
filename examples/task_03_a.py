import random

count = [0,0,0,0,0,0,0]

i = 0
while i < 10_000_000:
    r = random.random() * 6    # 0.00 .... 5.99
    cube = int(r) + 1          # 1 ... 6

    count[cube] = count[cube] + 1

    i = i + 1

print(count)
