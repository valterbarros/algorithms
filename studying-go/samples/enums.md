## Enums

[Readme](../README.md) / Enums   
### Set direct value
```go
const (
	Pending    = "pending"
	Ready      = "ready"
	InProgress = "in_progress"
)
```

use a type to set enums
```go
type ServerState int
```

Methods on int type \o/
```go
func (ss ServerState) String() string {
	if ss == 0 {
		return "idle"
	}
	if ss == 1 {
		return "connected"
	}
	return "other"
}
```

```go
const (
	StateIddle ServerState = iota
	StateConnected
)
```

usage
```go
fmt.Println("untyped: ", Pending, Ready, InProgress)
fmt.Println("ServerState: ", StateIddle, StateConnected)
```

```go
fmt.Println("ServerState String: ", StateIddle.String())
```
