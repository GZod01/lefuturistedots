#!/usr/bin/python
# Created by @lefuturiste on 2021-10-25
import time
import os
import i3
import pprint
import sys

def main():
  if len(sys.argv) < 2:
    print('Usage: i3_migrate_output <target_OUTPUT> <source_OUTPUT> OR i3_migrate_output <target_OUTPUT>')
    exit()

  outputs = i3.get_outputs()
  print(outputs)

  def getOutput(name):
    res = list(filter(lambda o: o['name'] == name and o['active'], outputs))
    if len(res) == 0: return None
    return res[0]

  target = getOutput(sys.argv[1])
  if target == None:
    print('Invalid target output')
    exit()

  if len(sys.argv) < 3:
    source = list(filter(lambda o: o['active'] and o['name'] != target['name'], outputs))[0]
  else:
    source = getOutput(sys.argv[2])
    if source == None:
      print('Invalid source output')
      exit()

  workspaces = i3.get_workspaces()

  print(f'{source=}')
  print(f'{target=}')

  toMove = list(filter(lambda w: w['output'] == source['name'], workspaces))
  pprint.pprint(toMove)

  if len(toMove) == 0:
    print('Nothing to move!')
    exit()

  for workspace in toMove:
    print(f"Moved workspace {workspace['name']} to output {target['name']}")
    cmd1 = f"i3-msg \"workspace {str(workspace['num'])}\""
    cmd2 = f"i3-msg \"move workspace to output {target['name']}\""
    print(cmd1)
    print(cmd2)
    os.system(cmd1)
    time.sleep(0.01)
    os.system(cmd2)
    time.sleep(0.01)

main()
main()
