### Bio O notation

Fala sobre escalabilidade e não sobre desempenho

![bigO](images/bigO.png)

- Escala logaritimica
- Complexidade temporal: tem a ver com tempo de acordo com o input
- Complexidade espacial: Tem a ver com quanto de memoria o algoritimo usa.
- O(1) tempo constante ou memoria constante examplo pegar o primeiro elemento de um array
- O(n log n) geralmente merge sorte e divide conquer
- O(n) escala exatamente na proporção que o input aumenta
- O(n^2) for encadeado

### Arrays

No javascript arrays são na verdade objetos complexos e não arrays

No rust ele precisa saber exatamente qual o tamanho devem ter os arrays, para fazer o gerenciamento de memoria com mais desempenho

<figure>
  <img src="images/array-memory.png" width="50%"/>
  <figcaption>
    Alocação de memoria
  </figcaption>
</figure>

Algoritimos:

#### Two points
- São dois ponteiros que apontam cada um para a extremidade esquerda e direita do array
- Pode ser usado para reverter um array de palavras

<figure>
  <img src="images/two-points.png" width="50%"/>
  <figcaption>
    Alocação de memoria
  </figcaption>
</figure>

#### Binary Search
- Divide a coleção pela metade e vai dividindo até encontrar o item
- Precisa que o array esteja ordenado
- Temporal: O(log n)
- Espacial: O(1)

### Sliding window

- Possui dois for encadeado, um abrindo e outro fechando e fazendo checagens

<figure>
  <img src="images/slidewindow.png" width="50%"/>
  <figcaption>
    Ponteiros
  </figcaption>
</figure>

### Exponential Search
- Utiliza a binary search para fazer a busca apos encontrar o range

### Hashmap
- 

---

### Linked Lists

---

### Queue

- usa FIFO first in first out
- Utiliza geralmente uma linkedlist

---

### Hashmap

- tem a complexidade O(1)
- load factor 70%
- collisions

---

### Stack

- Utiliza o LIFO last in last out

---

### Binary tree

---

### Trie

- Usada para autocomplete

---

### B-tree

- 