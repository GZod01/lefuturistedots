#!/usr/bin/python

import time
import os
import i3
import pprint
import sys
import itertools

def explore(obj):
    if not obj: return []
    res = []
    if 'name' in obj:
        res.append(obj['name'])
    if 'nodes' in obj:
        for n in obj['nodes']:
            res.extend(explore(n))
    return res

def getFocusedContainer(obj):
    if not obj: return None
    if 'focused' in obj and obj['focused']:
        return obj
    if 'nodes' in obj:
        for n in obj['nodes']:
            a = getFocusedContainer(n)
            if a != None:
                return a

    return None

def main():
  # if len(sys.argv) < 2:
  #   print('Usage: i3-focused-container')
  #   exit()

  tree = i3.get_tree()
  # pprint.pprint(explore(tree))
  pprint.pprint(
    getFocusedContainer(tree)
  )

main()

