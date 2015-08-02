# haskell-bf
Brainfuck interpreter written in Haskell

Brainfuck is a minimalistic esoteric programming language (https://en.wikipedia.org/wiki/Brainfuck).

Instruction set:

Instruction  | In C
---- | -------------
`>`  | `++ptr`
`<`  | `--ptr`
`+`  |  `++*ptr`
`-`  |  `--*ptr`
`.`  |  `putchar(*ptr`
`,`  |  `*ptr = getchar()`
`[`  |  `while (*ptr) {`
`]`  |  `}`

# Build and run
```
cabal run -- "<brainfuck program>"
```

Example:

```
cabal run -- "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
```

Outputs "Hello World!"

# Test
To launch test suite run `cabal test`

