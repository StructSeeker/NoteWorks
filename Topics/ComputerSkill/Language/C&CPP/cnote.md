

# Struct Literal
Note it work only in C

```c
int z = (struct {int x; int y;}){ .x = 1 , .y = 'b'}.x;
```