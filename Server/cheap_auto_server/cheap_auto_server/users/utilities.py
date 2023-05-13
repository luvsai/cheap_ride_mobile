import math
import random

import string
import random


def generateToken(N=32):
    # using random.choices()
    # generating random strings
    res = ''.join(random.choices(string.ascii_uppercase +
                                 string.digits + "&*%!_-+", k=N))
    return res




def generateOTP():
    # Declare a digits variable
    # which stores all digits
    digits = "0123456789"
    OTP = ""

   # length of password can be changed
   # by changing value in range
    for i in range(6):
        OTP += digits[math.floor(random.random() * 10)]

    return OTP
