# FLOAT DATATYPE ASSIGNMENT
# =========================

# SOLVED EXAMPLE
# --------------
# Question: Calculate the area of a circle with radius 5.5
print("SOLVED EXAMPLE:")
print("Calculate the area of a circle with radius 5.5")
import math
radius = 5.5
area = math.pi * radius ** 2
print(f"Radius: {radius}")
print(f"Area: {area:.2f}")
print("-" * 50)

# ASSIGNMENT QUESTIONS
# ===================

# Question 1: Calculate the average of 3.14, 2.718, 1.618, 0.577
print("Question 1: Calculate the average of 3.14, 2.718, 1.618, 0.577")
>>>
num=[3.14,2.718,1.618,0.577]
avg=sum(num) / len(num)
print("average:", avg)

# Question 2: Convert 98.6 Fahrenheit to Celsius (F = C * 9/5 + 32)
print("\nQuestion 2: Convert 98.6 Fahrenheit to Celsius")
F=98.6
C=(F-32) *5/9
print("celsius:", C)

# Question 3: Calculate the compound interest on $1000 at 5.5% for 3 years
print("\nQuestion 3: Calculate compound interest on $1000 at 5.5% for 3 years")
P = 1000
r = 5.5 / 100
t = 3

A = P * (1 + r) ** t
compound_interest = A - P

print("Compound Interest:", compound_interest)
print("Total Amount:", A)

# Question 4: Find the hypotenuse of a right triangle with sides 3.5 and 4.2
print("\nQuestion 4: Find the hypotenuse of a right triangle with sides 3.5 and 4.2")
import math

a = 3.5
b = 4.2

hypotenuse = math.sqrt(a**2 + b**2)
print("Hypotenuse:", hypotenuse)


# Question 5: Calculate the volume of a sphere with radius 7.8
print("\nQuestion 5: Calculate the volume of a sphere with radius 7.8")
import math

r = 7.8
volume = (4/3) * math.pi * r**3
print("Volume of sphere:", volume)


# Question 6: Round 3.14159 to 3 decimal places
print("\nQuestion 6: Round 3.14159 to 3 decimal places")
num = 3.14159
rounded_value = round(num, 3)
print(rounded_value)


# Question 7: Calculate the percentage: 45 out of 67
print("\nQuestion 7: Calculate the percentage: 45 out of 67")
part = 45
total = 67
percentage = (part / total) * 100
print("Percentage:", percentage)


# Question 8: Find the square root of 23.456
print("\nQuestion 8: Find the square root of 23.456")
import math

num = 23.456
square_root = math.sqrt(num)
print("Square root:", square_root)


# Question 9: Calculate the simple interest: Principal=2500, Rate=6.5%, Time=2.5 years
print("\nQuestion 9: Calculate simple interest: Principal=2500, Rate=6.5%, Time=2.5 years")
P = 2500
R = 6.5
T = 2.5

SI = (P * R * T) / 100
print("Simple Interest:", SI)


# Question 10: Convert 45.7 degrees to radians
print("\nQuestion 10: Convert 45.7 degrees to radians")

import math

degrees = 45.7
radians = math.radians(degrees)
print("Radians:", radians)
