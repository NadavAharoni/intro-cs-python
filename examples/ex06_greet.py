first_name = input("What is your first name? ")
print("Hello,", first_name, "!")
last_name = input("What is your last name? ")
print("Hello", first_name, last_name)

full_name = first_name + " " + last_name
print(full_name)

full_name = f"{first_name} {last_name} length={len(first_name+" "+last_name)}"
print(full_name)

