# 0x01. NoSQL

## Learning Objectives

### General

*   What NoSQL means
*   What is difference between SQL and NoSQL
*   What is ACID
*   What is a document storage
*   What are NoSQL types
*   What are benefits of a NoSQL database
*   How to query information from a NoSQL database
*   How to insert/update/delete information from a NoSQL database
*   How to use MongoDB

## Requirements

### MongoDB Command File

*   All your files will be interpreted/compiled on Ubuntu 18.04 LTS using `MongoDB` (version 4.2)
*   All your files should end with a new line
*   The first line of all your files should be a comment: `// my comment`
*   A `README.md` file, at the root of the folder of the project, is mandatory
*   The length of your files will be tested using `wc`

### Python Scripts

*   All your files will be interpreted/compiled on Ubuntu 18.04 LTS using `python3` (version 3.7) and `PyMongo` (version 3.10)
*   All your files should end with a new line
*   The first line of all your files should be a comment: `#!/usr/bin/env python3`
*   A `README.md` file, at the root of the folder of the project, is mandatory
*   The length of your files will be tested using `wc`
*   Your code should use the pycodestyle style (version 2.5.*)
*   All your modules should have documentation (`python3 -c 'print(__import__("my_module").__doc__)'`)
*   All your functions should have documentation (`python3 -c 'print(__import__("my_module").my_function.__doc__)'`)
*   Your code should not be executed when imported (by using `if __name__ == "__main__":`)

## Tasks

### 0. List all databases

Write a script that lists all databases in MongoDB.

[0-list_databases.py](0-list_databases.py "0-list_databases.py")

### 1. Create a database

Write a script that creates or uses the database `my_db`:

*   If `my_db` exists, display `Already exists: <mongo client instance>`