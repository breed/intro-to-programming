---
title: "C for C++ Programmers"
header-includes:
  - \usepackage[most]{tcolorbox}
---

# Introduction

In the beginning, knowing C++ automatically meant you knew C. The original C++
compiler, `cfront`, literally translated C++ code into C before compiling it.
But modern C++ has diverged dramatically from C. You have `std::string`,
`std::vector`, smart pointers, RAII, templates, `iostream`, and exceptions — none
of which exist in C. If someone hands you a C codebase today, your modern C++
instincts will not get you very far.

So why learn C? Because C is everywhere. Operating systems, embedded firmware,
database engines, language runtimes — the foundational software that the world
runs on is written in C. Even if you spend most of your career in C++, you will
encounter C code, C libraries, and C APIs. Understanding C makes you a better
programmer, period.

My go-to C textbook is *The C Programming Language (Second Edition)* by Brian
Kernighan and Dennis Ritchie — often called "K&R." It is one of the most
influential programming books ever written, and it opens like this:

> The only way to learn a new programming language is by writing programs in it.
> The first program to write is the same for all languages: Print the words
> hello, world. This is the big hurdle; to leap over it you have to be able to
> create the program text somewhere, compile it successfully, load it, run it,
> and find out where your output went. With these mechanical details mastered,
> everything else is comparatively easy.
>
> In C, the program to print "hello, world" is
>
> ```c
> #include <stdio.h>
> main()
> {
>     printf("hello, world\n");
> }
> ```
>
> Just how to run this program depends on the system you are using. As a
> specific example, on the UNIX operating system you must create the program in
> a file whose name ends in ".c", such as hello.c, then compile it with the
> command `cc hello.c`. If you haven't botched anything, such as omitting a
> character or misspelling something, the compilation will proceed silently, and
> make an executable file called a.out. If you run a.out by typing the command
> `a.out`, it will print `hello, world`. On other systems, the rules will be
> different; check with a local expert.

That quote is from 1988, and the advice still holds. Let's look at a slightly
more modern version of hello world:

```c
#include <stdio.h>

int main(void) {
    printf("hello, world\n");
    return 0;
}
```

Save this as `hello.c` and compile it:

```
gcc hello.c -o hello
./hello
```

Notice the differences from C++. There is no `#include <iostream>`, no
`std::println`, no `std::cout`. In C, you use `printf` from `<stdio.h>` for
output. The file ends in `.c`, not `.cpp`. You compile with `gcc` (the GNU C
compiler) rather than `g++`.

Here is a quick summary of the biggest differences you will encounter:

| C++ | C |
|:---|:---|
| `std::string` | `char` arrays with `'\0'` |
| `std::vector` | raw arrays or `malloc` |
| `std::cout` / `std::println` | `printf` |
| `std::cin` | `scanf` |
| `new` / `delete` | `malloc` / `free` |
| Smart pointers | Raw pointers (only option) |
| Classes and objects | Structs and functions |
| References (`&`) | Pointers (`*`) |
| `bool` (built-in) | `_Bool` or `#include <stdbool.h>` |
| `// comments` | `/* comments */` (C89); `//` allowed since C99 |

::: {.tip}
**Tip:** C source files use the `.c` extension and are compiled with `cc` or
`gcc`. If you accidentally compile a `.c` file with `g++`, it will be treated as
C++ and may accept syntax that real C compilers reject. Always use `gcc` when
writing C.
:::

## 2. Pointers

If you have been writing modern C++, you may have rarely (or never) used raw
pointers. Smart pointers like `std::unique_ptr` and `std::shared_ptr` manage
memory for you. References let you pass objects without copying them. The
standard library hides pointer details behind iterators and containers.

In C, none of that exists. Pointers are everywhere, and you must be comfortable
with them. Every dynamic data structure, every function that needs to modify its
arguments, every interaction with the operating system — all involve pointers.

### What Is a Pointer?

A pointer is a variable that holds a memory address. That's it. Instead of
holding a value like `42`, a pointer holds the *location* where `42` is stored.

### Declaring Pointers

A pointer type is declared by placing a `*` after the base type. The type before
the `*` tells you what kind of data lives at the address the pointer holds:

```c
int *p;         // p is a pointer to an int
char *s;        // s is a pointer to a char
double *d;      // d is a pointer to a double
```

::: {.tip}
**Tip:** The `*` belongs to the variable, not the type. This declaration creates
one pointer and one regular int:

```c
int *p, q;    // p is a pointer to int; q is just an int
```

To declare two pointers, you need two stars: `int *p, *q;`
:::

### The Address-Of Operator: `&`

The `&` operator returns the address of a variable. You have seen `&` in C++ for
references — in C, it is strictly the address-of operator:

```c
int score = 100;
int *p = &score;   // p now holds the address of score

printf("score = %d\n", score);    // 100
printf("address of score = %p\n", (void *)p);  // something like 0x7ffd5e8a3b2c
```

### Dereferencing: `*`

The `*` operator on a pointer gives you the value at the address the pointer
holds. This is called **dereferencing**:

```c
int score = 100;
int *p = &score;

printf("Value at p: %d\n", *p);   // 100

*p = 200;                          // modify score through the pointer
printf("score is now: %d\n", score);  // 200
```

Notice the dual use of `*`: in a declaration, it means "this is a pointer." In
an expression, it means "follow the pointer to the value."

### Pointers to Pointers

Since a pointer is just a variable, it has an address too. You can create a
pointer to a pointer:

```c
int val = 42;
int *p = &val;       // p points to val
int **pp = &p;       // pp points to p

printf("val = %d\n", val);       // 42
printf("*p = %d\n", *p);        // 42
printf("**pp = %d\n", **pp);    // 42
```

You dereference `pp` twice: once to get `p`, and again to get `val`. Pointers to
pointers show up frequently in C — for example, `main` can be declared as
`int main(int argc, char **argv)`, where `argv` is a pointer to an array of
string pointers.

### Visualizing Pointers in Memory

Consider this small program:

```c
int x = 1985;
int y = 80;
int *p = &x;
int **pp = &p;
```

Every variable lives at some address in memory. Here is what the layout looks
like (using made-up but realistic addresses):

```
  Variable    Address      Value
  --------    ----------   ----------
  x           0x1000       1985
  y           0x1004       80
  p           0x1008       0x1000  -------> x
  pp          0x1010       0x1008  -------> p -------> x
```

The variable `x` lives at address `0x1000` and holds the value `1985`. The
pointer `p` lives at address `0x1008` and holds the value `0x1000` — the address
of `x`. The pointer-to-pointer `pp` lives at `0x1010` and holds `0x1008` — the
address of `p`. Following the chain: `*pp` gives you `p` (which is `0x1000`),
and `**pp` gives you `x` (which is `1985`).

Notice that `p` and `pp` are just variables that hold numbers. Those numbers
happen to be memory addresses. There is nothing magical about a pointer — it is
just a variable whose value is an address.

::: {.tip}
**Tip:** You can take the address of any variable with `&`, including the
address of a pointer variable. The expression `&p` gives you the address where
`p` itself is stored, not the address `p` points to.
:::

### NULL Pointers

A pointer that does not point to anything should be set to `NULL`:

```c
int *p = NULL;   // p points to nothing

if (p != NULL) {
    printf("Value: %d\n", *p);
} else {
    printf("Pointer is NULL\n");
}
```

Dereferencing a `NULL` pointer is undefined behavior and usually crashes your
program with a segmentation fault. Always check before dereferencing a pointer
you did not initialize yourself.

::: {.tip}
**Tip:** In C, `NULL` is typically defined as `((void *)0)`. You may also see
`0` used directly. C++11 introduced `nullptr` as a type-safe null pointer — C
does not have `nullptr`, so use `NULL`.
:::

### Pointers and Arrays

A pointer might point to a single value in memory, or it might point to the
first element of an array of values. There is nothing in the type system that
tells you which — an `int *` looks the same either way:

```c
int score = 100;
int *p = &score;              // points to one int

int nums[] = {10, 20, 30};
int *q = nums;                // points to the first of three ints
```

Both `p` and `q` are `int *`. The compiler does not know whether there are more
`int` values after the one being pointed to. It is up to you, the programmer, to
keep track of how many elements a pointer refers to and to stay within bounds.

In C, arrays and pointers are intimately connected. When you use an array name
in most expressions, it **decays** to a pointer to the first element:

```c
int nums[] = {10, 20, 30, 40, 50};
int *p = nums;       // p points to nums[0]; no & needed

printf("%d\n", *p);       // 10 (same as nums[0])
printf("%d\n", *(p + 1)); // 20 (same as nums[1])
printf("%d\n", p[2]);     // 30 — yes, you can use [] on pointers!
```

**Pointer arithmetic** works in units of the pointed-to type. If `p` is an
`int *` and `int` is 4 bytes, then `p + 1` advances the address by 4 bytes to
the next `int`. You never have to think about byte sizes — the compiler handles
it.

```c
int nums[] = {10, 20, 30};
int *p = nums;

for (int i = 0; i < 3; i++) {
    printf("nums[%d] = %d\n", i, *(p + i));
}
```

::: {.tip}
**Tip:** Array indexing `nums[i]` is actually syntactic sugar for `*(nums + i)`.
This is why `2[nums]` technically works — it is `*(2 + nums)`, which is the same
thing. Don't write code like that, but knowing this helps you understand how
arrays and pointers relate.
:::

### Pass by Value (and Pointers as a Workaround)

In C++, you can pass arguments by reference using `&`:

```cpp
void increment(int &x) { x++; }   // C++ — modifies the original
```

C does not have references. **All function parameters in C are pass by value** —
the function receives a copy of the argument, not the original. If you want a
function to modify a variable in the caller, you pass a *pointer* to it:

```c
void increment(int *x) {
    (*x)++;   // dereference the pointer, then increment
}

int main(void) {
    int score = 99;
    increment(&score);      // pass the ADDRESS of score
    printf("%d\n", score);  // 100
    return 0;
}
```

The function `increment` receives a *copy* of the pointer (the address), but
since both the original and the copy point to the same memory, dereferencing
either one reaches the same variable. This is how C simulates pass by reference.

::: {.tip}
**Tip:** Every time you see a function parameter with `*` in C, ask yourself:
"Is this pointer here so the function can modify the caller's variable, or
because it needs to access a block of memory (like an array)?" Often it is
both.
:::

### Try It: Pointer Playground

This program demonstrates the core pointer operations:

```c
#include <stdio.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main(void) {
    // Basic pointer usage
    int val = 1985;
    int *p = &val;
    printf("val = %d, *p = %d\n", val, *p);
    printf("Address of val: %p\n", (void *)&val);

    // Modify through pointer
    *p = 1989;
    printf("After *p = 1989: val = %d\n", val);

    // Pointer to pointer
    int **pp = &p;
    printf("**pp = %d\n", **pp);

    // Pass by value with pointers
    int x = 10, y = 20;
    printf("Before swap: x=%d, y=%d\n", x, y);
    swap(&x, &y);
    printf("After swap:  x=%d, y=%d\n", x, y);

    // Arrays and pointers
    char *words[] = {"Totally", "Radical", "Tubular"};
    for (int i = 0; i < 3; i++) {
        printf("words[%d] = %s\n", i, words[i]);
    }

    return 0;
}
```

## 3. Allocating Memory

Every variable in your program lives somewhere in memory, but not all memory is
created equal. Understanding where variables live — and how long they last — is
essential for writing correct C programs.

### Global Variables

A **global variable** is declared outside of any function. It is created when the
program starts and exists until the program exits:

```c
#include <stdio.h>

int high_score = 0;   // global — lives for the entire program

void update_score(int points) {
    if (points > high_score) {
        high_score = points;
    }
}

int main(void) {
    update_score(1000);
    update_score(500);
    printf("High score: %d\n", high_score);  // 1000
    return 0;
}
```

Global variables are visible to every function in the file. They are convenient
but can make programs harder to reason about, since any function can change them.

::: {.tip}
**Tip:** Use global variables sparingly. When every function can read and write
the same variable, bugs become harder to track down. Prefer passing data through
function parameters.
:::

### Local Variables

A **local variable** is declared inside a function (or block). It is created when
the function is called and destroyed when the function returns:

```c
void greet(void) {
    char message[] = "Hola, amigo";  // local — exists only during greet()
    printf("%s\n", message);
}
// message is gone once greet() returns
```

Local variables live on the **stack** — a region of memory that grows and shrinks
automatically as functions are called and return. You do not need to free stack
memory; it is reclaimed automatically.

::: {.tip}
**Tip:** Never return a pointer to a local variable. The memory is freed when the
function returns, and the pointer becomes a **dangling pointer** — it points to
memory that no longer belongs to you:

```c
int *bad(void) {
    int x = 42;
    return &x;   // BUG: x is destroyed when bad() returns
}
```
:::

### Dynamic Allocation: `malloc` and `free`

Sometimes you need memory that outlives the function that created it, or memory
whose size you do not know at compile time. For this, C provides `malloc` and
`free` from `<stdlib.h>`.

`malloc` allocates a block of memory on the **heap** and returns a pointer to it.
The heap is a region of memory that persists until you explicitly release it:

```c
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int *nums = malloc(5 * sizeof(int));
    if (nums == NULL) {
        printf("Allocation failed!\n");
        return 1;
    }

    for (int i = 0; i < 5; i++) {
        nums[i] = (i + 1) * 10;
    }

    for (int i = 0; i < 5; i++) {
        printf("nums[%d] = %d\n", i, nums[i]);
    }

    free(nums);   // release the memory back to the system
    return 0;
}
```

`malloc` returns a `void *` — a generic pointer that can be assigned to any
pointer type without a cast in C. It returns `NULL` if the allocation fails.
Always check for `NULL` after calling `malloc`.

::: {.tip}
**Tip:** There are no smart pointers in C. There is no RAII. There is no garbage
collector. If you call `malloc`, you *must* call `free` when you are done. If
you forget, you leak memory. If you call `free` twice on the same pointer, you
get undefined behavior. If you use a pointer after freeing it, you get undefined
behavior. Memory management in C is entirely your responsibility.
:::

`calloc` is a variant that allocates memory and initializes it to zero:

```c
int *nums = calloc(5, sizeof(int));  // 5 ints, all initialized to 0
```

And `realloc` lets you resize a previously allocated block:

```c
nums = realloc(nums, 10 * sizeof(int));  // grow to 10 ints
```

### Where Variables Live: A Summary

| Kind | Where | Lifetime | Example |
|:---|:---|:---|:---|
| Global | Data segment | Entire program | `int count = 0;` (outside functions) |
| Local | Stack | Until function returns | `int x = 5;` (inside a function) |
| Dynamic | Heap | Until you call `free` | `int *p = malloc(...)` |

### Try It: Memory Lifetimes

```c
#include <stdio.h>
#include <stdlib.h>

int total = 0;   // global — lives for the whole program

void add_to_total(int n) {
    int local = n;       // local — gone when add_to_total returns
    total += local;
}

int main(void) {
    add_to_total(10);
    add_to_total(20);
    printf("Total: %d\n", total);    // 30

    // dynamic — lives until we free it
    int *data = malloc(3 * sizeof(int));
    if (data == NULL) return 1;

    data[0] = 1985;
    data[1] = 1986;
    data[2] = 1987;

    for (int i = 0; i < 3; i++) {
        printf("data[%d] = %d\n", i, data[i]);
    }

    free(data);
    return 0;
}
```

## 4. Strings

In C++, you use `std::string` and barely think about what is happening under the
hood. In C, there is no string type at all. A "string" in C is just an array of
`char` that ends with a null character `'\0'`. Every string function in C depends
on finding that null terminator to know where the string ends.

### Declaring C Strings

There are several ways to create a string in C:

```c
char greeting[] = "Hola, mundo";        // compiler sizes it: 12 bytes (11 + '\0')
char band[20] = "Depeche Mode";         // 20-byte buffer, only 13 used
char empty[10] = "";                     // 10 bytes, first byte is '\0'
```

When you write `"Hola, mundo"`, the compiler automatically adds a `'\0'` at the
end. The array `greeting` is 12 bytes: 11 visible characters plus the null
terminator.

::: {.tip}
**Tip:** Always remember the null terminator when sizing your buffers. The
string `"hello"` needs 6 bytes, not 5. Off-by-one errors with null terminators
are one of the most common bugs in C.
:::

### String Functions

C provides a library of string manipulation functions in `<string.h>`. These are
the ones you will use most:

**`strlen` — Get the Length**

Returns the number of characters before the null terminator:

```c
#include <stdio.h>
#include <string.h>

int main(void) {
    char song[] = "Take On Me";
    printf("'%s' has %zu characters\n", song, strlen(song));  // 10
    return 0;
}
```

Note that `strlen` does not count the `'\0'`. The array holding `"Take On Me"`
is 11 bytes, but `strlen` returns 10.

**`strcpy` / `strncpy` — Copy a String**

`strcpy` copies the source string (including the null terminator) into the
destination buffer. You must make sure the destination is large enough:

```c
char dest[20];
strcpy(dest, "Tainted Love");  // copies 13 bytes (12 chars + '\0')
```

`strncpy` is the safer variant — it copies at most `n` characters:

```c
char dest[10];
strncpy(dest, "Enjoy the Silence", 9);
dest[9] = '\0';  // strncpy does NOT guarantee null termination!
```

::: {.tip}
**Tip:** `strncpy` does not null-terminate the destination if the source is
longer than `n`. Always set the last byte yourself:
`dest[sizeof(dest) - 1] = '\0';`
:::

**`strcmp` — Compare Strings**

In C++, you can compare strings with `==`. In C, you cannot — using `==` on
two `char` arrays compares the *addresses*, not the contents. Use `strcmp`
instead:

```c
char a[] = "Rush";
char b[] = "Rush";

if (a == b) {
    // This compares ADDRESSES, not content — almost always false
}

if (strcmp(a, b) == 0) {
    // This compares the actual characters — correct!
    printf("Same band!\n");
}
```

`strcmp` returns 0 if the strings are equal, a negative value if the first is
lexicographically less, and a positive value if it is greater.

::: {.tip}
**Tip:** Yes, `strcmp` returns 0 for equal strings. It is a common source of
confusion. Think of it as returning the "difference" between the strings — zero
means no difference.
:::

**`strchr` / `strrchr` — Find a Character**

`strchr` finds the first occurrence of a character. `strrchr` finds the last:

```c
char lyric[] = "Don't You Forget About Me";
char *first_o = strchr(lyric, 'o');    // points to 'o' in "Don't"
char *last_o = strrchr(lyric, 'o');    // points to 'o' in "About"

if (first_o != NULL) {
    printf("First 'o' at position %td\n", first_o - lyric);
}
```

Both functions return a pointer to the found character, or `NULL` if the
character is not in the string.

**`strstr` — Find a Substring**

Finds the first occurrence of a substring within a string:

```c
char title[] = "Blade Runner 1982";
char *found = strstr(title, "Runner");
if (found != NULL) {
    printf("Found: %s\n", found);  // "Runner 1982"
}
```

Like `strchr`, it returns a pointer to the start of the match, or `NULL` if not
found.

**`strcat` / `strncat` — Concatenate Strings**

`strcat` appends one string to the end of another:

```c
char message[50] = "Hasta la ";
strcat(message, "vista");
strcat(message, ", baby");
printf("%s\n", message);  // "Hasta la vista, baby"
```

This works fine as long as the destination buffer is large enough. But `strcat`
does not check bounds — if you run out of space, it writes past the end of the
array.

::: {.tip}
**Tip:** `strcat` is one of the most dangerous functions in C. It has no way to
know how large the destination buffer is, so it blindly appends bytes. If the
combined strings exceed the buffer size, you get a **buffer overflow** — one of
the most common security vulnerabilities in the history of software. Use
`strncat` instead, which takes a maximum number of characters to append:

```c
char buf[20] = "Hello";
strncat(buf, ", World!", sizeof(buf) - strlen(buf) - 1);
```
:::

**`strdup` — Duplicate a String**

`strdup` allocates new memory on the heap, copies the string into it, and
returns a pointer to the copy. You are responsible for freeing the memory when
you are done:

```c
char *copy = strdup("Video Killed the Radio Star");
printf("%s\n", copy);
free(copy);  // you must free memory allocated by strdup
```

::: {.tip}
**Tip:** `strdup` calls `malloc` internally. Every call to `strdup` must
eventually be paired with a call to `free`. If you forget, you have a memory
leak.
:::

### The Dangers of `strcat`

Let's look at a concrete example of why `strcat` is dangerous:

```c
#include <stdio.h>
#include <string.h>

int main(void) {
    char buf[12] = "Buenas ";    // 7 chars + '\0', 4 bytes remaining

    // "noches" is 6 chars — doesn't fit in 4 remaining bytes!
    strcat(buf, "noches");       // BUFFER OVERFLOW — undefined behavior

    printf("%s\n", buf);         // might print garbage, might crash
    return 0;
}
```

The buffer is 12 bytes, `"Buenas "` uses 8 (including the `'\0'`), and
`"noches"` needs 7 more bytes (including its `'\0'`). That is 14 bytes total in
a 12-byte buffer. The extra bytes overwrite whatever happens to be next to the
buffer in memory, which can corrupt other variables, crash the program, or —
worst of all — create a security exploit.

### A Preview: `sprintf` and `sscanf`

C has two powerful functions for building and parsing strings that we will cover
in detail in the I/O section: `sprintf` writes formatted output into a string
buffer (like `printf` but to a string), and `sscanf` reads formatted input from
a string (like `scanf` but from a string). They are the C programmer's Swiss
Army knife for string manipulation:

```c
char result[50];
int year = 1985;
sprintf(result, "The year is %d. Que bueno!", year);
// result is now "The year is 1985. Que bueno!"
```

### Try It: String Playground

This program exercises several string functions so you can see them in action:

```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(void) {
    // strlen
    char song[] = "Sweet Dreams";
    printf("Song: '%s' (%zu chars)\n", song, strlen(song));

    // strcpy
    char copy[20];
    strcpy(copy, song);
    printf("Copy: '%s'\n", copy);

    // strcmp
    printf("Compare '%s' to '%s': %d\n", song, copy, strcmp(song, copy));
    printf("Compare 'A' to 'B': %d\n", strcmp("A", "B"));

    // strcat
    char greeting[30] = "Buenos ";
    strcat(greeting, "dias");
    printf("Greeting: '%s'\n", greeting);

    // strchr and strstr
    char *ch = strchr(song, 'D');
    if (ch) printf("Found 'D' at position %td\n", ch - song);

    char *sub = strstr(song, "Dreams");
    if (sub) printf("Found substring: '%s'\n", sub);

    // strdup
    char *dup = strdup("Never Gonna Give You Up");
    printf("Duplicate: '%s'\n", dup);
    free(dup);

    return 0;
}
```

## Conclusion

You have covered a lot of ground. Here are the key takeaways:

- **C and C++ are different languages.** Modern C++ has evolved far from C.
  Knowing one does not mean you automatically know the other.
- **Pointers hold memory addresses.** Use `&` to get an address, `*` to follow
  one. Arrays decay to pointers, and pointer arithmetic moves in units of the
  pointed-to type.
- **All function arguments are pass by value.** To modify a caller's variable,
  pass a pointer to it.
- **Know where your memory lives.** Global variables last the whole program,
  local variables live on the stack, and dynamic memory from `malloc` lives on
  the heap until you `free` it.
- **Strings in C are `char` arrays** terminated by `'\0'`. You must manage
  buffer sizes manually and use functions like `strlen`, `strcpy`, `strcmp`, and
  `strcat` instead of the `std::string` methods you are used to.
- **`strcat` and `strcpy` do not check bounds.** Buffer overflows are real and
  dangerous. Prefer the bounded versions (`strncat`, `strncpy`) and always
  ensure your buffers are large enough.

Es un mundo nuevo, but you have the C++ foundation to build on. The syntax will
feel familiar even when the idioms are different. Write small programs, compile
them with `gcc`, and get comfortable with the compiler's warnings — they are
your best amigo.

Buena suerte — you have got this.

---

*Content outline and editorial support from Ben. Words by Claude, the Opus.*
