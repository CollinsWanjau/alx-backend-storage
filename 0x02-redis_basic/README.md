# Redis as a Python Dictionary

- Yes. Broadly speaking, there are many parallels you can draw between a Python dictionary (or generic hash table) and what Redis is and does:
    - A redis db holds key:value pairs and supports commands such as GET, SET and DEL etc.
    - Redis keys are always strings.
    - Redis values may be a number of different data types.i.e string, list, hashes and sets.
    - Many Redis commands operate in constant 0(1) time, just like retrieving a value from a
    python dict or any hash table.

## More Data Types in Python vs Redis

- To be clear, all Redis keys are strings.It's the value thaty can take on data types in addition
to the string values

- A hash is a mapping of string:string, called field-value pairs that sits under one top-level key.

```redis
127.0.0.1:6379> HSET realpython url "https://realpython.com/"
(integer) 1
127.0.0.1:6379> HSET realpython github realpython
(integer) 1
127.0.0.1:6379> HSET realpython fullname "Real Python"
(integer) 1
```

- This sets three field-value pairs for one key, "realpython". If you’re used to Python’s terminology and objects, this can be confusing. A Redis hash is roughly analogous to a Python dict that is nested one level deep:

```python
data = {
    "realpython": {
        "url": "https://realpython.com/",
        "github": "realpython",
        "fullname": "Real Python",
    }
}
```

- Just like there’s MSET for basic string:string key-value pairs, there is also HMSET for hashes to set multiple pairs within the hash value object:

```redis
127.0.0.1:6379> HMSET pypa url "https://www.pypa.io/" github pypa fullname "Python Packaging Authority"
OK
127.0.0.1:6379> HGETALL pypa
1) "url"
2) "https://www.pypa.io/"
3) "github"
4) "pypa"
5) "fullname"
6) "Python Packaging Authority"
```

- Using HMSET is probably a closer parallel for the way that we assigned data to  a nested
dictionary above, rather than setting each nested pair as is done with HSET.

- Redis hashes are useful for storing objects, but they are not the only data type that Redis supports. Redis also supports lists, sets, and sorted sets.

- A Redis list is a collection of string values that are sorted according to the order in which they were inserted. You can add elements to a Redis list in the head or tail position. This is similar to a Python list, which is a collection of objects that are ordered according to the order in which they were inserted.

- Commands to operate in lists begin with an L or R to indicate whether the operation is on the left or right side of the list. For example, LPUSH and RPUSH add elements to the left and right sides of the list, respectively. LPOP and RPOP remove elements from the left and right sides of the list, respectively.

- Redis sets are collections of unique string values. This is similar to a Python set, which is a collection of unique objects. Redis sets are unordered, which means that the order in which the strings are added to the set is irrelevant. This is also true of Python sets.

- Commands to operate on sets begin with an S, such as SCARD, which gets the number of elements in the set, and SADD, which adds elements to the set.

- Hashes: Commands to operate on hashes begin with an H, such as HGET, which gets the value of a field in the hash, and HSET, which sets the value of a field in the hash.

# Using redis_py: Redis in Python

- redis-py is a Python interface to Redis that allows you to interact with Redis using Python data structures. You can use redis-py to execute Redis commands, such as SET and GET, and to get the values from Redis keys as Python objects, such as Python dictionaries.

- We built the Redis instance r with no arguments, but it comes bundled with a number of parameters if you need them:

```python
# From redis/client.py
class Redis(object):
    def __init__(self, host='localhost', port=6379,
                 db=0, password=None, socket_timeout=None,
                 # ...
```

## Allowed Key Types

- Redis keys are always strings. Using redis-py, you can set keys as Python strings, integers, or floating-point values. If you set a key using a Python data structure, such as a dictionary, then redis-py will convert the data structure to a string using str() before sending it to Redis.
