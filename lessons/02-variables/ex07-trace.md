# תרגיל 7: מה יודפס?

בכל אחד מהקטעים הבאים, כתבו על דף **בדיוק** מה יודפס, לפני שמריצים.
אם לדעתכם תהיה שגיאה, כתבו באיזו שורה ומה סוג השגיאה.
אחר כך הריצו ובדקו. על כל טעות, הבינו למה טעיתם.

---

## קטע 1

```python
x = 10
y = x
x = x + 5
print(x, y)
```

## קטע 2

```python
a = "5"
b = 2
print(a * b)
print(int(a) * b)
```

## קטע 3

```python
n = 17
print(n // 5, n % 5, n / 5)
```

## קטע 4

```python
price = 19.9
qty = 3
print(f"Total: {price * qty:.2f}")
```

## קטע 5

```python
s = "abc"
s = s + s
print(len(s), s)
```

## קטע 6

```python
a = 3
b = 4
a = a + b
b = a - b
a = a - b
print(a, b)
```

## קטע 7

```python
x = 7
print(x > 5, x == 7.0, x != "7")
```

## קטע 8

```python
value = "12"
value = value + "3"
value = int(value) + 3
print(value)
```

## קטע 9

```python
t = True
f = False
print(t + t + f, type(t + f))
```

## קטע 10

```python
total = 0
total += 4
total *= 3
total -= 2
total //= 3
print(total)
```

## קטע 11

```python
name = "Dana"
print(f"{name:>6}|{name:<6}|")
```

## קטע 12

```python
x = 5
print("x" + "=" + x)
```

---

## שאלות

1. כמה תשובות היו נכונות בניסיון הראשון?
2. מה הקטע שהפתיע אתכם הכי הרבה? למה?
3. בקטע 6 יש טריק. מה הוא עושה? האם הוא עובד לכל שני מספרים?
