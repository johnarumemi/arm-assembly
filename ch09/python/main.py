"""
Run this script to call the shared library function mytoupper

The cytpes module provides a way to call functions in DLLs or shared libraries.

The functions in the shared library must follow the Linux
function calling convention.

# Example Usage

```bash
$ python -m main

# or

$ python main.py
```

"""

from ctypes import CDLL, c_char_p, c_char, c_int, create_string_buffer, Array


# Load the shared library into memory
# Linux should have the shared library in the LD_LIBRARY_PATH
# CDLL represents a shared libraries
# Calling the functions releases the Python GIL during the call and
# reacquires it afterwards.
libupper = CDLL("libup.so")

# These steps are optional but recommended. They allow python to define
# argument and return types for the function, so Python can do extra error
# checking.
libupper.mytoupper.argtypes = [c_char_p, c_char_p]
libupper.mytoupper.restype = c_int

# Python uses unicode strings, hence each character takes up more than 1 byte.
# We need the characters in ascii. This is done via using b"unicode-string"
# `create_string_buffer` creates a mutable character buffer that is compatible
# with C (and hence assembly).
in_str: Array[c_char] = create_string_buffer(b"Hello, World!")
out_str: Array[c_char] = create_string_buffer(250)  # 250 is the buffer size

len = libupper.mytoupper(in_str, out_str)

# decode from ascii to unicode and print values
print("Original  = {}".format(in_str.value.decode()))
print("Uppercase = {}".format(out_str.value.decode()))
print("Length = {}".format(len))
