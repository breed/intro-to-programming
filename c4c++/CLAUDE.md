# Project Description

Write chapters to help beginning C++ programmers become beginning C programmers

## Textbook

- This chapter augments the book text found in ../s26/text/

## Examples

- For strings, use 80s references, lyrics from 80s songs, and Spanish occasionally. Keep it short.
- Validate examples to make sure syntax and result is correct
- Compile examples with `gcc -Wall -Wextra -pedantic` to verify correctness
- Create short example programs to illustrate the concepts covered
- Use `%zu` for `size_t` (e.g., `strlen` return) and `%td` for `ptrdiff_t` (e.g., pointer subtraction)

## Format and Style

- Use Pandoc markdown
- Use correct grammar and capitalizations
- Use tip callouts (`::: {.tip}` divs) to highlight idioms, best practices, or warn of bad practices
- Callouts are rendered as full-width `tcolorbox` boxes via `callout.lua` — do not use `wrapfigure`
- Keep the tone professional but light
- Refer to the reader as `you`

## Build

- Build with: `pandoc c4c++.md -o c4c++.pdf --lua-filter=callout.lua`
- Requires `header-includes` for `\usepackage[most]{tcolorbox}` (already in frontmatter)

## Content

1. Introduction:
    - in the begin know C++ automatically meant you know C, but modern C++ has dramatically different idioms and standard libraries than C, so the modern C++ programmer has some things to learn in order to program in C.
    - `The C Programming Language (Second Edition)` my go to textbook.
    - introduce this intro section quoted verbatim from the book and then quote the section for the first section `the-c-programming-language-intro.txt` 
2. Pointers
    - modern C++ programmers rarely see pointers and thus can get away with not fully understanding them, but C programmers must be very comfortable with pointers
    - a type that ends in * represents a pointer. the type information before the * represents the type of the memory that the pointer points to
    - all pointers are an address to a location in memory
    - you can get the address of a variable using & (including addresses of a pointer variable)
    - create a figure of a small program with a couple of variables and pointers to those variables and one pointer to one of the pointers and then show a memory diagram and label addresses of those variable
    - all function parameters are `pass by value` (no `pass by reference`) but we can pass pointers to memory we want to change by value
3. Allocating memory
    - global variables get started at the beginning of a program and stay around until the program finishes
    - local variables are declared inside of functions and go away when the function goes away
    - if we want to allocate memory, use it for a while and release it, we can use malloc() and free()
4. Strings
    - there is no std::string in C++. everything revolves around arrays of characters that end with a null '\0'
    - using strings, you always have to careful have the right amount of memory allocated. (remember to include space for the null!)
    - string manipulation routines: strlen(), strchr(), strrchr(), strstr(), strcat(), strdup() (include any additional ones that students should know)
    - review the problems that can arise using strcat()
    - point out that there are convenient ways to manipulate strings with sprintf() and sscanf that will be shown later in I/O
