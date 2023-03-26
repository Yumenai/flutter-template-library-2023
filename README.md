# template_library

An application that provide a code repository needed to accelerate flutter application development.

# Configuration

Version: Flutter 3

# Project Structure (Under Development)

A hybrid of feature first and layer first approach.

- component
  - The most basic widget without any reference to other component or widget except for third-party component
- controller
  - The handling of all the data and functionality of an app
- data
  - Store all the constant value
- dialog
  - Store all the possible dialog format that allows quick implementation
- item (Pending)
  - Provide a reusable widget display in a list
- model
  - Provide a data format
- route
  - Handle all the screen navigation in the app
- service
  - Handle all the feature initialisation and function
- utility
  - An independent class that provide a simple solution that could be reused in various part of the application

TODO
- module
  - A list of independent function that can be added or removed without much hassle