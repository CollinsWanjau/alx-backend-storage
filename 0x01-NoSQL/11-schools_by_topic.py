#!/usr/bin/python3
'''Return the list of school by specific topic
'''


def schools_by_topic(mongo_collection, topic):
    '''
    Return the list of school by specific topic
    '''
    topic_filter = {
        'topics': {
            '$elemMatch': {
                '$eq': topic
            },
        },
    }

    matching_schools = []
    for school in mongo_collection.find(topic_filter):
        matching_schools.append(school)

    return matching_schools
