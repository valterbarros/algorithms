package string

import (
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
	// Read the size of bytes passed on store
	// if the store is only 7 bytes it only read 7 bytes
	n, err := r13.r.Read(store)

	for i := range n {
		store[i] = replaces[string(store[i])]
	}

	return n, err
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
		{"Lbh penpxrq gur pbqr!", "You cracked the code!"},
	}

	for _, tt := range tests {
		t.Run("should return right decrypted string: "+tt.input, func(t *testing.T) {
			// Reading from reader
			// Can be splited in many peaces, the string has 21 bytes, can be read in 3 parts of 7
			decrypt := ""
			store := make([]byte, 7)
			for {
				n, err := r.Read(store)

				if n > 0 {
					decrypt += string(store)
				}

				if err == io.EOF {
					break
				}
			}

			assert.Equal(t, tt.expected, decrypt,
				"Rot13(%q) deve retornar a mensagem sem criptografia", tt.input)
		})
	}
}
