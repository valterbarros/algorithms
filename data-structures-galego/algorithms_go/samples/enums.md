#### Enums

**set direct value**

```go
const (
    Pending    = "pending"
    Ready      = "ready"
    InProgress = "in_progress"
)
```

**use a type to set enums**

```go
type ServerState int

const (
    StateIddle ServerState = iota
    StateConnected
)
```

**Methods on int type**

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

**usage**

```go
fmt.Println("untyped: ", Pending, Ready, InProgress)
fmt.Println("ServerState: ", StateIddle, StateConnected)
fmt.Println("ServerState String: ", StateIddle.String())
```
