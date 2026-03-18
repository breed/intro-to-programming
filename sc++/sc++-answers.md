---
title: "Starting C++ — Answer Key"
toc: true
toc-depth: 2
colorlinks: true
header-includes:
  - \usepackage[most]{tcolorbox}
---

# Chapter 3: Strings — Answers

1. `std::cin >> str` reads a single word, stopping at the first whitespace character.
   `std::getline(std::cin, str)` reads an entire line, including spaces, stopping only at the newline.
   Use `std::cin >>` when you want a single token (like a username with no spaces).
   Use `std::getline()` when you want a full line of input (like a person's full name or a sentence).

2. The code prints:

    ```
    Ice Ice Baby
    12
    ```

    The string `b` is formed by concatenating `"Ice"`, `" "`, `"Ice"`, and `" Baby"`, producing `"Ice Ice Baby"` which is 12 characters long.

3. `std::string("Hola").at(4)` throws a `std::out_of_range` exception because valid indices are 0 through 3.
   `std::string("Hola")[4]` accesses the null terminator character `'\0'`, which is technically valid for `std::string::operator[]` (it returns the null character at the position equal to `size()`), but accessing any index beyond that is undefined behavior.

4. `pos` is `15`.
   The substring `"dop"` first appears at index 15 in `"MMMBop ba duba dop"`.

5. The bug is that `"Hello, " + "world!"` tries to add two string literals (character arrays) together using `+`.
   This does not compile because neither operand is a `std::string`.
   Fix: make at least one side a `std::string`, for example `std::string("Hello, ") + "world!"`.

6. The bug is the missing `std::cin.ignore()` between the `std::cin >> count` and the `std::getline(std::cin, name)`.
   After `std::cin >> count` reads the integer, the newline from pressing Enter remains in the input buffer.
   `std::getline()` immediately reads that leftover newline and returns an empty string, so the user never gets a chance to type their name.
   Fix: add `std::cin.ignore();` after `std::cin >> count;`.

7. The code prints:

    ```
    B@il@mos
    ```

    It iterates through `"Bailamos"` and replaces every `'a'` with `'@'`.

8. `std::stoi("42abc")` returns `42` because it parses as many leading characters as form a valid integer and stops.
   `std::stoi("abc42")` throws a `std::invalid_argument` exception because the string does not start with a valid integer.

9. Example solution:

    ```cpp
    #include <iostream>
    #include <string>

    int main()
    {
        std::string name;
        std::cout << "enter your full name: ";
        std::getline(std::cin, name);

        std::cout << "length: " << name.size() << std::endl;

        std::cout << "reversed: ";
        for (int i = name.size() - 1; i >= 0; --i) {
            std::cout << name[i];
        }
        std::cout << std::endl;

        return 0;
    }
    ```

\newpage

# Chapter 4: Expressions — Answers

1. `7 / 2` performs integer division and produces `3` (the fractional part is discarded).
   `7.0 / 2` performs floating-point division and produces `3.5`.
   It matters because integer division silently loses precision.
   If you need an exact result, ensure at least one operand is a floating-point type.

2. The code prints:

    ```
    12 10 12
    ```

    `b = a++`: `b` gets the current value of `a` (10), then `a` becomes 11.
    `c = ++a`: `a` is incremented to 12 first, then `c` gets that value (12).
    So `a` is 12, `b` is 10, `c` is 12.

3. The values are:
    - `17 % 5` = `2` (17 = 3×5 + 2)
    - `20 % 4` = `0` (20 = 5×4 + 0)
    - `3 % 7` = `3` (3 = 0×7 + 3; when the dividend is smaller than the divisor, the remainder is the dividend itself)

4. `result` is `false`.
   It does not crash because of short-circuit evaluation: `x != 0` evaluates to `false`, and since `&&` requires both sides to be `true`, C++ immediately returns `false` without evaluating the right side (`100 / x > 5`).
   The division by zero never happens.

5. The bug is `if (x = 10)` — this uses `=` (assignment) instead of `==` (comparison).
   It assigns 10 to `x`, and the expression evaluates to 10, which is non-zero and therefore `true`.
   The `if` body always executes, and `x` is changed to 10 regardless of its original value.
   Fix: change to `if (x == 10)`.

6. The bug is operator precedence.
   `==` has higher precedence than `&`, so the expression is parsed as `flags & (0b0010 == 0b0010)`, which simplifies to `flags & 1` (since the comparison is `true`, which is `1`).
   This checks bit 0 instead of bit 1.
   Fix: add parentheses: `if ((flags & 0b0010) == 0b0010)`.

7. The code prints:

    ```
    B
    ```

    The chained ternary evaluates the conditions top to bottom.
    `score >= 90` is `false` (85 < 90), so it moves to the next condition.
    `score >= 80` is `true` (85 >= 80), so `grade` is assigned `"B"`.

8. The answers in binary:
    - `0b1100 & 0b1010` = `0b1000` (AND: bits set in both)
    - `0b1100 | 0b1010` = `0b1110` (OR: bits set in either)
    - `0b1100 ^ 0b1010` = `0b0110` (XOR: bits set in one but not both)

9. Example solution:

    ```cpp
    #include <iostream>

    int main()
    {
        int n;
        std::cout << "enter an integer: ";
        std::cin >> n;

        if (n % 2 == 0) {
            std::cout << n << " is even" << std::endl;
        } else {
            std::cout << n << " is odd" << std::endl;
        }

        if (n > 0) {
            std::cout << n << " is positive" << std::endl;
        } else if (n < 0) {
            std::cout << n << " is negative" << std::endl;
        } else {
            std::cout << n << " is zero" << std::endl;
        }

        return 0;
    }
    ```
