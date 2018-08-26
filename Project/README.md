Simple Lex example in ```*.l``` file.
```C++
a?(b|c)a* return TOKEN1;
b?(a|c)b* return TOKEN2;
c?(b|a)*c*  return TOKEN3;
\"[^"\n]*["\n]  return FORMAT;
```
