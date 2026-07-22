# -*- coding: utf-8 -*-
"""
Created on Tue Jul 21 21:08:51 2026

@author: MY PC
"""

#1. ATM PIN Verification

correct_pin = 9991
attempt = 0
max_attempt = 3
while attempt < max_attempt:
    enter_pin = int(input("Enter the PIN: "))

    if enter_pin == correct_pin:
        print("Access Granted")
        break
    else:
        tries_left = max_attempt - attempt - 1
        print("Wrong PIN,", tries_left, "tries left")
        attempt += 1

if attempt == max_attempt:
    print("Card Locked")
    

#2. Grocery Checkout Total

num_items = int(input("Enter the number of items: "))

total = 0
count = 0

while count < num_items:
    price = float(input("Enter item price: "))

    if total > 1000:
        price = price * 0.9   

    total += price
    count += 1

print("Final Total =", total)

#3. Number Guessing Game
secret_number = 49
attempt = 0

while True:
    guess = int(input("Guess the number: "))
    attempt += 1

    if guess > secret_number:
        print("Too High")

    elif guess < secret_number:
        print("Too Low")

    else:
        print("Correct")
        print("You took", attempt, "guesses")
        break

#4.Movie Ticket Booking
total_seats = int(input("Enter total number of seats: "))

number_of_bookings = int(input("Enter number of booking requests: "))

booking_requests = []

i = 0

while i < number_of_bookings:
    seats = int(input("Enter seats requested: "))
    booking_requests.append(seats)
    i += 1


index = 0

while index < len(booking_requests):

    requested_seats = booking_requests[index]

    if requested_seats > total_seats:
        print("Not enough seats")
        break

    else:
        total_seats -= requested_seats

    index += 1


print("Seats remaining:", total_seats)

#5.Study Streak Tracker
number_of_days = int(input("Enter number of days: "))

scores = []

i = 0

while i < number_of_days:
    score = int(input("Enter quiz score: "))
    scores.append(score)
    i += 1


streak = 0
index = 0

while index < len(scores):

    if scores[index] >= 60:
        streak += 1

    else:
        print("Streak broken")
        break

    index += 1


print("Final streak length:", streak)



#FOR LOOP

#1. ATM PIN Verification
correct_pin = 9991

attempts = 3

for i in range(attempts):

    entered_pin = int(input("Enter your PIN: "))

    if entered_pin == correct_pin:
        print("Access Granted")
        break

    else:
        tries_left = attempts - (i + 1)
        print("Wrong PIN,", tries_left, "tries left")

else:
    print("Card Locked")
    
#2. Grocery Checkout Total
number_of_items = int(input("Enter number of items: "))

total = 0

for i in range(number_of_items):

    price = float(input("Enter item price: "))

    if total > 1000:
        price = price * 0.90

    total += price

print("Final Total:", total)

#3. Guessing the number
secret_number = 49

guesses = []

guess_count = 0

for i in range(100):   # allows maximum 100 attempts

    guess = int(input("Enter your guess: "))

    guess_count += 1

    if guess > secret_number:
        print("Too High")

    elif guess < secret_number:
        print("Too Low")

    else:
        print("Correct")
        print("Guesses taken:", guess_count)
        break
    
 #4. Movie Ticket Booking
    
total_seats = int(input("Enter total seats: "))

number_of_bookings = int(input("Enter number of booking requests: "))

available_seats = total_seats

for i in range(number_of_bookings):

        request = int(input("Enter seats required: "))

        if request > available_seats:
            print("Not enough seats")
            break

        else:
            available_seats -= request
            print(request, "seats booked")
print("Seats remaining:", available_seats)

#5. Student quiz tracker
streak = 0

for i in range(100):

    score = int(input("Enter quiz score: "))

    if score >= 60:
        streak += 1

    else:
        print("Streak broken")
        break

print("Final streak length:", streak)