## Arrays

[Readme](../README.md) / Arrays

### Internals

> More deep details about array and slices can be found   
[Go Slices: usage and internals](https://go.dev/blog/slices-intro)

it is possible to create slice with make   
capacity 15 and length 10
```go
slice0 := make([]float32, 10, 15)
```

```go
fmt.Println("capacity slice0", cap(slice0), len(slice0))
```

array fixed size
```go
array1 := [5]int{1, 2, 3}
// change array pos
array1[1] = 4
fmt.Println("array1: ", array1)
```
