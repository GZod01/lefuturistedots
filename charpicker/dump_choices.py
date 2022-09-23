#!/bin/python3

# /usr/lib/python3.10/site-packages/picker/data
# list every files that are presents in picker/data plus a name or description
import os
import yaml

config_f = open('./config.yaml')
config = yaml.safe_load(config_f.read())
config_f.close()

d = os.listdir('/usr/lib/python3.10/site-packages/picker/data')

reached = []
for path in d:
    if path in reached: continue
    res = list(filter(lambda x: path in x['files'], config['choices']))
    msg = f"{path}"
    if len(res) > 0:
        choice = res[0]
        msg = ' '.join(choice['files'])
        if 'additions' in choice:
            msg += ' + additions'
        if 'keywords' in choice:
            msg += ' :: '  + ','.join(choice['keywords'])
        reached.extend(choice['files'])
    print(msg)

