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

### Algoritimos:

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
- Utilizamos o [log2 n](https://pt.khanacademy.org/computing/computer-science/algorithms/binary-search/a/running-time-of-binary-search) para descobrir o número de passos necessários e descobrir o tempo de execução
- fonts:
  - https://www.khanacademy.org/computing/computer-science/algorithms/binary-search/a/binary-search

#### Sliding window

- Possui dois for encadeado, um abrindo e outro fechando e fazendo checagens

<figure>
  <img src="images/slidewindow.png" width="50%"/>
  <figcaption>
    Ponteiros
  </figcaption>
</figure>

#### Exponential Search
- Utiliza a binary search para fazer a busca apos encontrar o range

#### Hashmap

- 

---

#### Linked Lists

- É importante para linguagens mais staticas que definem o tamanho do array na inicialização por exemplo com a linked list é possivel aumentar a lista dinamicamente
- Double linked lista é quando o no sabe o prev e o next
- A parte ruim é não ter acesso via index [n]

---

#### Queue

- usa FIFO first in first out
- Utiliza geralmente uma linkedlist

---

#### Hashmap

- tem a complexidade O(1)
- load factor 70%
- collisions

---

#### Stack

- Utiliza o LIFO last in last out

---

#### Binary tree

---

#### Trie

- Usada para autocomplete

---

#### B-tree

-

### Sorting

### Bubble sort

- Complexidade temporal O(N^2)
  - Melhor cenario O(n)
- Espacial O(1)
- Pouco eficiente para os dias de hoje porem pode ser usado para arrays menores com 100 itens por exemplo
- fonts:
  - https://cs50.harvard.edu/x/2025/shorts/bubble_sort/

### Insertion Sort

- https://www.w3schools.com/dsa/dsa_algo_insertionsort.php
- https://www.khanacademy.org/computing/computer-science/algorithms/insertion-sort/a/insertion-sort

<figure>
  <img src="images/insertion.png" width="50%"/>
  <figcaption>
    Quick sort
  </figcaption>
</figure>

### Selection Sort

- https://www.w3schools.com/dsa/dsa_algo_selectionsort.php
- https://www.khanacademy.org/computing/computer-science/algorithms/sorting-algorithms/a/sorting

<figure>
  <img src="images/insertion.png" width="50%"/>
  <figcaption>
    Quick sort
  </figcaption>
</figure>

### QuickSort

- Precisa escolher o pivot e ai dividir o array de um lado fica os menores e do outro os maiores que o pivot
  - A ideia é ir dividindo o array em dois recursivamente de acordo com o pivo
- Temporal: No melhor e medio caso N log n no pior n ** 2
- Espacial: No melhor log N no pior n
- fonts:
  - https://pt.khanacademy.org/computing/computer-science/algorithms/quick-sort/a/linear-time-partitioning

<figure>
  <img src="images/quick-sort.png" width="50%"/>
  <figcaption>
    Quick sort
  </figcaption>
</figure>

# MergeSort
- Temporal: O (n log n)
- Espacial: O(n)
- As etapas para solução são dividir, conquistar e combinar.
- fonts:
  - https://pt.khanacademy.org/computing/computer-science/algorithms/merge-sort/a/overview-of-merge-sort
  - https://www.youtube.com/watch?v=Ns7tGNbtvV4

<figure>
  <img src="images/dividir.png" width="50%"/>
  <figcaption>
    Dividir e conquistar
  </figcaption>
</figure>

<figure>
  <img src="images/diagram-merge.png" width="50%"/>
  <figcaption>
    Mais sobre dividir e conquistar
  </figcaption>
</figure>
