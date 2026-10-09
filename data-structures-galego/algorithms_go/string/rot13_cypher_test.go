package string

import (
	"fmt"
	"io"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

type rot13Reader struct {
	r io.Reader
}

// Root13 https://en.wikipedia.org/wiki/ROT13
var replaces = map[string]byte{
	" ": ' ',
	"!": '!',
	"a": 'n',
	"b": 'o',
	"c": 'p',
	"d": 'q',
	"e": 'r',
	"f": 's',
	"g": 't',
	"h": 'u',
	"i": 'v',
	"j": 'w',
	"k": 'x',
	"l": 'y',
	"m": 'z',
	"n": 'a',
	"o": 'b',
	"p": 'c',
	"q": 'd',
	"r": 'e',
	"s": 'f',
	"t": 'g',
	"u": 'h',
	"v": 'i',
	"w": 'j',
	"x": 'k',
	"y": 'l',
	"z": 'm',
	"A": 'N',
	"B": 'O',
	"C": 'P',
	"D": 'Q',
	"E": 'R',
	"F": 'S',
	"G": 'T',
	"H": 'U',
	"I": 'V',
	"J": 'W',
	"K": 'X',
	"L": 'Y',
	"M": 'Z',
}

// It implements a Reader and read from a Reader
func (r13 rot13Reader) Read(store []byte) (int, error) {
	// Create a copy to temp read data
	// the size 7 is because the string has 21 chars and is multiple of 21
	aux := make([]byte, 7)
	// offset to read after offset read
	var offset int

	fmt.Println("store: ", len(store))

	for {
		n, err := r13.r.Read(aux)

		if err == io.EOF {
			break
		}

		// Copy characters and decrypt rot13
		for i := range n {
			// Mapper from replaces and return in byte type
			char := replaces[string(aux[i])]

			store[offset+i] = char
		}

		offset += n
	}

	fmt.Printf("bytes: %s \n", string(store))

	return offset, io.EOF
}

func TestRot13(t *testing.T) {
	// You cracked the code
	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	// Read here
	// Commented for tests
	// io.Copy(os.Stdout, &r)

	tests := []struct {
		input    string
		expected string
	}{
		{"Lbh penpxrq gur pbqr!", "You cracked the code"},
	}

	for _, tt := range tests {
		t.Run("should return right decrypted string: "+tt.input, func(t *testing.T) {
			store := make([]byte, 21)
			r.Read(store)

			assert.Equal(t, tt.expected, string(store),
				"Rot13(%q) deve retornar a mensagem sem criptografia", tt.input)
		})
	}
}
