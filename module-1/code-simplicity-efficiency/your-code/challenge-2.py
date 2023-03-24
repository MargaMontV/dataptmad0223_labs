"""
The code below generates a given number of random strings that consists of numbers and 
lower case English letters. You can also define the range of the variable lengths of
the strings being generated.

The code is functional but has a lot of room for improvement. Use what you have learned
about simple and efficient code, refactor the code.
"""

import random
import string

def RandomStringGenerator(min_lenght, max_lenght, string_range):
    
    characters = string.ascii_lowercase + string.digits
    
    if (min_lenght > max_lenght) or (min_lenght <= 0) or (max_lenght <= 0):
        return "Incorrect min and max string lengths. Try again."
    elif min_lenght == max_lenght:
        string_random = ["".join(random.choices(characters, k= max_lenght)) for item in range(string_range)]
        return string_random
    else:
        string_random = ["".join(random.choices(characters, k = random.randint(min_lenght, 
                                            max_lenght))) for item in range(string_range)]
        return string_random
               

min_lenght = int(input("Enter minimum string length: "))
max_lenght = int(input("Enter maximum string length: "))
string_range = int(input("How many random strings to generate? "))

print(RandomStringGenerator(min_lenght, max_lenght, string_range))
