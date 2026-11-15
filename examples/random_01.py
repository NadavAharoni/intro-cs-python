import random

count_0 = 0
count_1 = 0
count_6 = 0

i = 0
while i < 10_000_000:
    r = random.random() * 6    # 0.00 .... 5.99
    cube = int(r) + 1          # 1 ... 6

    if cube == 0:
        count_0 = count_0 + 1
    if cube == 1:
        count_1 = count_1 + 1
    if cube == 6:
        count_6 = count_6 + 1
    i = i + 1

print("number of 0:", count_0)
print("number of 1:", count_1)
print("number of 6:", count_6)


