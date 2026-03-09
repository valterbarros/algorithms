## Arrays

[Study](../notes/STUDY.md) / Arrays

### Internals

> More deep details about array and slices can be found   
[Go Slices: usage and internals](https://go.dev/blog/slices-intro)

It is possible to create slice with make   
Capacity 15 and length 10

```go
slice0 := make([]float32, 10, 15)
fmt.Println("capacity slice0", cap(slice0), len(slice0))
```

Array fixed size

```go
array1 := [5]int{1, 2, 3}
```
Change array pos

```go
array1[1] = 4
fmt.Println("array1: ", array1)
```

Slice has a pointer to real array and the size is dynamic

```go
slice1 := []int{1, 2, 3, 4}
fmt.Println("slice1: ", slice1)
// when slice reach the cap, go basically duplicate the size of the intern array
fmt.Println("capacity slice1", cap(slice1), len(slice1))
slice1 = append(slice1, 2)
fmt.Println("capacity slice1", cap(slice1), len(slice1))
```

### Manipulation

Append to slice   
Append returns a new array

```go
slice2 := []int{1, 2, 3, 4, 5}
slice2 = append(slice2, 50)
```


```go
fmt.Println("slice1: ", slice1)
```
It is possible to swap slice positions

```go
slice3 := []int{1, 2, 3, 4, 5, 6}
// it basically put 0 in 1 and 1 in 0
slice3[0], slice3[1] = slice3[1], slice3[0]
fmt.Println("slice3: ", slice3)
```

It is possible to get a slice of array range

```go
array2 := [...]int{1, 2, 3, 4, 5} // ... is for "dynamic" array but not appendable
slice4 := array2[1:3]
fmt.Println("slice4: ", slice4)
```

### Using slices package

Unordered slice of array

```go
slice5 := []int{50, 10, 1, 9, 4}
// using slices package
slices.Sort(slice5)
fmt.Println("slice5: ", slice5)
```

### Curiosity

Is it possible to change original array?!   
> as slice has a pointer to original array if you change that it reflects on original array

```go
array3 := [...]int{1, 2, 3}
slice6 := array3[:] // get all range :
slice6[0] = 2
fmt.Println("array3: ", array3)