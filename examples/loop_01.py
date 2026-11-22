import random

i = 0.0
print( type(i) )

count = 0
while i < 5:
    print(f"i= {i}")
    i = i + random.random()
    count = count + 1

print(f"loop ran {count} times")

print("=")
print(f"i= {i}")




