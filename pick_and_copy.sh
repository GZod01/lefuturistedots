stint | python3 -c "import fileinput; print('#' + ''.join(['{0:02x}'.format(int(x)) for x in list(fileinput.input())[0].replace('\n', '').split(' ')]))" | awk '{printf $0}' | xclip -selection c
notify-send "exit"
