#### Maps

create a map without initialization

```go
map1 := make(map[string]int)
fmt.Println("map1: ", map1)
```

it is possible to use any to accept any type but is more recommended to use struct

```go
map2 := make(map[string]any)
map2["first"] = 1
fmt.Println("map2: ", map2)
```

As that map is using any type go don't permit the usage of that without a type assertition
> That garantes less errors at runtime

```go
// error:
c := int64(map2["first"]) * 2
```

It is possible to create map inner map

```go
map3 := make(map[string]map[string]int)
map3["inner"] = map[string]int{
    "name": 1,
}
fmt.Println("map3: ", map3)
```

remove a key

```go
delete(map3, "inner")
```

clear map

```go
clear(map3)
```

maps package has so many fns like maps.Equal()

```go
map4 := map[string]string{
    "maps":    "maps",
    "structs": "structs",
}
fmt.Println("map4: ", map4)
```

it returns a seq and is necessary to use `slice.Collect` to get slice of that
> More about [Range Over Function Types](https://go.dev/blog/slices-intro)

```go
fmt.Println("keys4: ", maps.Keys(map4))
```
