Quiz title: CMPE 30 Numbers Quiz
Quiz description: This is a graded quiz that must be done on your own. You are allowed to use the book from class, but no online resources, no notes from others, and no answers from others.

shuffle answers: true

1. What does the "base" (radix) of a number system refer to?
a) The largest digit you can use
*b) The number of distinct digits used in the system
c) The number of bits in a byte
d) The maximum value you can represent

2. What is the decimal value of the binary number `101010`?
a) 52
*b) 42
c) 32
d) 84

3. How can you tell if a binary number is divisible by 2?
*a) Its last bit is 0
b) Its first bit is 0
c) It has an even number of 1s
d) It ends in `10`

4. What does each hexadecimal digit represent in terms of bits?
a) 2 bits
b) 3 bits
*c) 4 bits
d) 8 bits

5. What is the decimal value of `0xFF`?
a) 15
b) 16
*c) 255
d) 256

6. What is the decimal value of the octal number `052`?
a) 52
*b) 42
c) 40
d) 82

9. Why is `052` a potential source of confusion in C++?
a) It is not a valid literal
b) It is the same as decimal 52
*c) The leading zero makes it an octal literal, which equals decimal 42
d) The compiler ignores the leading zero

10. What is the purpose of the digit separator `'` in C++?
a) It separates the integer and decimal parts of a number
*b) It improves readability without changing the value
c) It marks the end of a literal
d) It specifies the base of the number

13. To convert the hex string `"2A"` to an integer using `std::stoi`, what do you pass as the base?
a) 2
b) 8
c) 10
*d) 16

14. What is the correct call to convert the binary string `"101010"` to an integer?
a) `std::stoi("101010")`
*b) `std::stoi("101010", nullptr, 2)`
c) `std::stoi("101010", nullptr, 10)`
d) `std::stoi("0b101010")`

16. To find the two's complement of a number, you:
a) Flip all the bits
b) Add 1 to the original number
*c) Flip all the bits and add 1
d) Subtract the number from the maximum value

17. In 8-bit two's complement, what does the bit pattern `1111 1111` represent?
a) 255
b) -0
*c) -1
d) -128

18. In two's complement, what does the highest bit indicate?
a) Whether the number is even or odd
b) Whether overflow occurred
*c) Whether the number is negative
d) The base of the number

19. How many bits are in a byte?
a) 4
*b) 8
c) 16
d) 32

20. What is the typical size of an `int` on modern systems?
a) 1 byte
b) 2 bytes
*c) 4 bytes
d) 8 bytes

21. With `n` bits, what is the range of an unsigned integer type?
a) -2^(n-1) to 2^(n-1) - 1
*b) 0 to 2^n - 1
c) 0 to 2^n
d) 1 to 2^n

22. What is the range of a signed 8-bit integer in two's complement?
a) -127 to 127
*b) -128 to 127
c) -128 to 128
d) 0 to 255

23. What happens when an unsigned integer overflows in C++?
*a) It wraps around to 0
b) It is undefined behavior
c) The program crashes
d) The value is clamped to the maximum

24. What happens when a signed integer overflows in C++?
a) It wraps around predictably
*b) It is undefined behavior
c) The program throws an exception
d) The value is clamped to the maximum

25. What is the result of `1 << 3`?
a) 3
b) 1
*c) 8
d) 6

26. What does a left shift by 1 position do to a value?
a) Divides by 2
*b) Multiplies by 2
c) Adds 2
d) Subtracts 2

27. What is the result of right-shifting an odd number like `7 >> 1`?
a) 4
*b) 3
c) 3.5
d) 0

28. What fills in from the left when you right-shift a negative signed value?
a) 0s
*b) 1s (the sign bit is copied)
c) Alternating 0s and 1s
d) The result is undefined

