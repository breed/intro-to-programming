Quiz title: CMPE 30 Operators Quiz
Quiz description: This is a graded quiz that must be done on your own. You are allowed to use the book from class, but no online resources, no notes from others, and no answers from others.

shuffle answers: true

GROUP
points per question: 10
pick: 10

1. What is the result of `10 / 3` when both operands are integers?
a) 3.333
*b) 3
c) 4
d) 0

2. What does the modulus operator `%` return?
*a) The remainder after integer division
b) The quotient of the division
c) The percentage of one value to another
d) The decimal portion of the division

3. What is the value of `1985 % 10`?
a) 198
b) 1985
*c) 5
d) 85

4. Given `int x = 5; int y = x++;`, what are the values of `x` and `y`?
a) x is 5, y is 5
*b) x is 6, y is 5
c) x is 6, y is 6
d) x is 5, y is 6

5. Given `int x = 5; int y = ++x;`, what are the values of `x` and `y`?
a) x is 5, y is 5
b) x is 6, y is 5
*c) x is 6, y is 6
d) x is 5, y is 6

6. Which statement is equivalent to `score += 10;`?
a) score = 10;
b) score = 10 + 10;
*c) score = score + 10;
d) score == score + 10;

7. What is the result of `2 + 3 * 4`?
a) 20
*b) 14
c) 24
d) 9

8. What happens when you write `if (x = 5)` instead of `if (x == 5)`?
a) The program will not compile
b) It checks whether x equals 5
*c) It assigns 5 to x and the condition is always true
d) It causes a runtime error

9. What does the `&&` operator require for the overall expression to be true?
a) At least one operand must be true
*b) Both operands must be true
c) Both operands must be false
d) Exactly one operand must be true

10. What is short-circuit evaluation?
a) The compiler optimizes logical expressions at compile time
*b) C++ stops evaluating a logical expression as soon as the result is determined
c) The program skips the entire if-block when the condition is false
d) A technique for reducing the number of comparison operators

11. With `&&`, if the left side is `false`, what happens to the right side?
a) It is evaluated and the result is combined with the left side
*b) It is never evaluated
c) It is evaluated but the result is ignored
d) It always returns true

12. With `||`, if the left side is `true`, what happens to the right side?
a) It is evaluated and the result is combined with the left side
*b) It is never evaluated
c) It is evaluated but the result is ignored
d) It always returns false

13. Among the logical operators, which has the highest precedence?
*a) `!`
b) `&&`
c) `||`
d) They all have the same precedence

14. What does the ternary operator `?:` do?
a) Compares three values and returns the largest
*b) Returns one of two values based on a condition
c) Performs three operations in sequence
d) Checks three conditions at once

15. What is the result of `(score >= 60) ? "Passed" : "Failed"` when score is 85?
*a) "Passed"
b) "Failed"
c) true
d) 85

16. What does the bitwise AND operator `&` do?
a) Returns 1 for each bit where either operand is 1
*b) Returns 1 for each bit where both operands are 1
c) Returns 1 for each bit where the operands differ
d) Inverts every bit

17. What is `42 & 0x0F`?
a) 42
b) 15
*c) 10
d) 0

18. How do you check whether bit 2 is set in a variable `flags`?
a) `flags == 0b00000100`
*b) `flags & 0b00000100`
c) `flags | 0b00000100`
d) `flags ^ 0b00000100`

19. How do you clear bit 2 in a variable `flags`?
a) `flags &= 0b00000100;`
*b) `flags &= ~0b00000100;`
c) `flags |= ~0b00000100;`
d) `flags ^= 0b00000100;`

20. Which bitwise operator is commonly used to toggle (flip) specific bits?
a) `&`
b) `|`
*c) `^`
d) `~`

21. What is the result of `1 << 3`?
a) 3
b) 1
*c) 8
d) 6

22. What happens when the `~` operator is applied to an `unsigned char` value?
a) It flips the bits of the 8-bit value directly
*b) The value is promoted to `int` before the bits are flipped
c) It returns 0
d) It only flips the sign bit

23. Why is the expression `x & 0xFF == 0` likely a bug?
a) `&` and `==` cannot be used in the same expression
b) `0xFF` is not a valid literal
*c) `==` has higher precedence than `&`, so it is parsed as `x & (0xFF == 0)`
d) Bitwise AND always returns 0

24. What is operator overloading?
a) Using too many operators in a single expression
b) Defining new operators that do not exist in C++
*c) The same operator symbol performing different actions depending on the types involved
d) Assigning multiple values with a single operator

25. What does the `+` operator do when applied to `std::string` values?
a) Adds the lengths of the strings
*b) Concatenates (joins) the strings together
c) Compares the strings alphabetically
d) Returns the first string

26. What does associativity determine?
a) Which operator has the highest precedence
b) Whether an operator works with one or two operands
*c) The direction of evaluation when operators of the same precedence appear together
d) Whether the operator can be overloaded

27. Why is prefix `++i` generally preferred over postfix `i++` in loops?
a) Prefix is required by the C++ standard for loops
b) Postfix does not work with all integer types
*c) Prefix can be more efficient because it avoids creating a temporary copy
d) Postfix increments by 2 instead of 1

28. What is the result of `a = b = 3;`?
a) Only `a` gets the value 3
*b) Both `a` and `b` get the value 3
c) It causes a compilation error
d) Only `b` gets the value 3

END_GROUP
