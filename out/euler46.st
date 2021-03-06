Object subclass: euler46 [
   eratostene: t max0: max0 [|n j|
    n := 0.
    (2 to: (max0 - 1)) do: [:i| ((t at: (i + 1)) = i)
      ifTrue:[
        n := n + 1.
        ((max0 quo: i) > i)
        ifTrue:[
          j := i * i.
          [(j < max0) and: [j > 0]] whileTrue:[
            t at: (j + 1) put: 0.
            j := j + i.
          ].
        ].
      ].].
    ^ n
  ]
  main [
    |primes nprimes n maximumprimes m2 l era canbe|maximumprimes := 6000.
    era := Array new: maximumprimes.
    (0 to: (maximumprimes - 1)) do: [:j_| era at: (j_ + 1) put: j_.].
    nprimes := (self eratostene: era max0: maximumprimes).
    primes := Array new: nprimes.
    (0 to: (nprimes - 1)) do: [:o| primes at: (o + 1) put: 0.].
    l := 0.
    (2 to: (maximumprimes - 1)) do: [:k| ((era at: (k + 1)) = k)
      ifTrue:[
        primes at: (l + 1) put: k.
        l := l + 1.
      ].].
    l display.
    ' == ' display.
    nprimes display.
    '
' display.
    canbe := Array new: maximumprimes.
    (0 to: (maximumprimes - 1)) do: [:i_| canbe at: (i_ + 1) put: false.].
    (0 to: (nprimes - 1)) do: [:i| (0 to: (maximumprimes - 1)) do: [:j|
                                     n := (primes at: (i + 1)) + (2 * j * j).
                                     (n < maximumprimes)
                                     ifTrue:[canbe at: (n + 1) put: true.].
      ].].
    (1 to: maximumprimes) do: [:m|
      m2 := m * 2 + 1.
      ((m2 < maximumprimes) and: [(canbe at: (m2 + 1)) not])
      ifTrue:[m2 display.
        '
' display.].
    ].
    ]
]
Eval [ (euler46 new) main. ]

