#!/bin/python3

# /usr/lib/python3.10/site-packages/picker/data
# list every files that are presents in picker/data plus a name or description
import os
import yaml
import subprocess
from subprocess import Popen, PIPE, STDOUT
from itertools import chain

ROFIMOJI_CHARS_TMP_PATH = '/tmp/rofimoji_chars'
ROFIMOJI_DATA_PATH = '/usr/lib/python3.10/site-packages/picker/data/'

os.chdir('/home/mbess/dots/charpicker')

if os.path.exists(ROFIMOJI_CHARS_TMP_PATH):
    os.remove(ROFIMOJI_CHARS_TMP_PATH)

config_f = open('./config.yaml')
config = yaml.safe_load(config_f.read())
config_f.close()

all_data_paths = os.listdir('/usr/lib/python3.10/site-packages/picker/data')

choices_res = ''
reached = []
for path in all_data_paths:
    if path in reached: continue
    res = list(filter(lambda x: path in x['files'], config['choices']))
    msg = f"{path}"
    if len(res) > 0:
        choice = res[0]
        msg = ' '.join(choice['files'])
        if 'additions' in choice:
            msg += ' + additions'
        if 'keywords' in choice:
            msg += ' :: ' + ','.join(choice['keywords'])
        reached.extend(choice['files'])
    choices_res += msg + '\n'

choices_res += '@ all, whole, tout, unicode\n'

p = Popen(['rofi', '-dmenu', '-i', '-window-title', 'Character category'],
          stdout=PIPE,
          stdin=PIPE,
          stderr=PIPE)
stdout_data = p.communicate(input=choices_res.encode())[0]
print('wait', stdout_data.decode())

raw_res = stdout_data.decode()
if raw_res.strip() == '':
    exit()

raw_res: str = raw_res.split(' :: ')[0].split(' + ')


def load_with_path(paths):
    ofile = open(ROFIMOJI_CHARS_TMP_PATH, 'a')
    for path in paths:
        ifile = open(ROFIMOJI_DATA_PATH + path.strip(), 'r')
        ofile.write(ifile.read())
        ifile.close()

    ofile.close()

    subprocess.call(['rofimoji', '-f', ROFIMOJI_CHARS_TMP_PATH])
    os.remove(ROFIMOJI_CHARS_TMP_PATH)


if raw_res[0].startswith('@ all'):
    # load all the files
    load_with_path(all_data_paths + list(
        chain.from_iterable(
            list(
                map(lambda c: c['additions']
                    if 'additions' in c else [], config['choices'])))))
    exit()

paths = raw_res[0].split(' ')
if len(raw_res) == 1:
    # call directly
    subprocess.call(['rofimoji', '-f', ROFIMOJI_DATA_PATH + paths[0].strip()])
else:
    # the used selected a custom choice group
    res = list(
        filter(lambda custom_choice: set(paths) == set(custom_choice['files']),
               config['choices']))
    assert len(res) > 0
    choice = res[0]
    if 'additions' in choice:
        for addition_path in choice['additions']:
            paths.append('./additions/' + addition_path.strip())
    load_with_path(paths)
