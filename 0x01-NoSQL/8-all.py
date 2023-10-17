#!/usr/bin/env python3
'''
    Lists all documents
'''


def list_all(mongo_collection):
    '''Lists all documents in python'''
    if mongo_collection is None:
        return []
    return list(mongo_collection.find())
