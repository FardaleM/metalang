Object subclass: countchar [
  |buffer|
  read_int [|o|
    ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
     o := 0.
    (buffer isNil) ifFalse:[
    (buffer =~ '^(-?\d+)' asRegex) ifMatched: [:match |
    o := match at: 1.
    buffer := buffer allButFirst:(o size).
    ].
    ^o asInteger. ]
  ]
  skip [
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    (buffer =~ '^(\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].
    ]
  ]
  read_char [|o|
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    o := buffer at: 1.
    buffer := buffer allButFirst:1.
    ^o.
    ]
  ]
   nth: tab tofind: tofind len: len [|out0|
    out0 := 0.
    (0 to: (len - 1)) do: [:i| ((tab at: (i + 1)) = tofind)
      ifTrue:[out0 := out0 + 1.].].
    ^ out0
  ]
  main [
    |tofind tmp tab result len|len := 0.
    len := self read_int.
    self skip.
    tofind := $ .
    tofind := self read_char.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := $ .
      tmp := self read_char.
      tab at: (i + 1) put: tmp.
    ].
    result := (self nth: tab tofind: tofind len: len).
    result display.
    ]
]
Eval [ (countchar new) main. ]

