#shell #linux #ubuntu #operating-system #file-system 

- Stands for stream editor.
- Used to transform and filter texts.
# Examples
## Replace a group of charaters
- Only change on console.
```bash
sed 's/John/Micheal/g' names.txt
```
- `s` stands for substitute.
- Add `-i` to make the replacement occur on the file.
```bash
sed -i 's/John/Micheal/g' names.txt
```
## Delete a group of characters
```bash
sed 's/Micheal//g' names.txt
```
## Delete all of the lines containing a group of characters
```bash
sed '/Micheal/d' names.txt
```

## Delete the first one, two, three lines
```bash
sed '1d' names.txt # 1 line only
sed '1,3d' names.txt # first 3 lines
sed '2,5d' names.txt # line 2 to line 5
```
