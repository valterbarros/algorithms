## Maps

[Study](../notes/STUDY.md) / Maps

### Working with map

Create a map without initialization

```go
map1 := make(map[string]int)
fmt.Println("map1: ", map1)
```

It is possible to use any to accept any type but is more recommended to use struct

```go
map2 := make(map[string]any)
map2["first"] = 1
fmt.Println("map2: ", map2)
```

Here is necessary to run a type assertition   
C := int64(map2["first"]) * 2

It is possible to create map inner map

```go
map3 := make(map[string]map[string]int)
map3["inner"] = map[string]int{
	"name": 1,
}
fmt.Println("map3: ", map3)
```

### Go safe map attributes manipulation

As that map is using **any** type go don't permit the usage of that without a type assertition   
> That garantes less errors at runtime

```go   
Error:   
C := int64(map2["first"]) * 2   
```

### Editing map

Remove a key

```go
delete(map3, "inner")
// clear map
clear(map3)
```

Maps package has so many fns like maps.Equal()   
Map keys

```go
map4 := map[string]string{
	"maps":    "maps",
	"structs": "structs",
}
fmt.Println("map4: ", map4)
```

It returns a seq and is necessary to use slice.Collect to get slice of that   
> More about [Range Over Function Types](https://go.dev/blog/slices-intro)

```go
fmt.Println("keys4: ", maps.Keys(map4))