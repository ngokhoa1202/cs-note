#cli #operating-system #ubuntu #file-system #regular-expression  #scripting  #scripting 

- Employed by [Filesystem commands](Filesystem%20commands.md)
# Star wildcard ($\star$)
- Stands for any character, any string of arbitary size (even empty string).
# Question mark wildcard (?)
- Stands for any single character.
# Square bracket wildcard ([...])
- Stands for any of the characters specified in the enclosing pair of bracket.
```bash
ls scripts.[xyz]* # either x or y or z
```
- Can specific a range in the pair of square of bracket
```bash
ls [a-cx-z]* # a to c or x to z
```

```bash
ls [0-9][0-9][1-8] # 0 to 9 followed by 0 to 9 followed by 1-8
```

# Backflash wildcard (\\)
- Stands for escape sequence, used to mark an endline for scripting.
# Caret wildcard (^)
- Stands for the beginning of the line.
# Dollar sign wildcard ($)
- Stands for the end of the line.



