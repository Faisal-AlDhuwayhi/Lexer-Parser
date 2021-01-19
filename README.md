# Lexer & Parser
The project focuses on building a parser that recognizes a language, which is described as:

P -> D ; P | D

D -> def id(ARGS) = E;

ARGS -> id , ARGS | id

E -> int | id | if E1 OP E2 then E3 else E4 | for E1 do E2 | do E1 while E2
 | E1+E2 | E1-E2 | E1*E2 | E1/E2 | E1%E2 
 | id(E1, …, En)

OP -> == | > | < | >= | <= | != | % 

## Steps
1. **Build a lexical analyzer** (Lexer) to capture the tokens of the language, using Jflex. To do this, you need to define a constant value
associated with each token, so that you can return this value every time your parser needs a new token. 
   - *Keywords*: def, if, then, else, while, do, for.
   - *Punctuation elements*: ( ) : , ;
    - *Operators*: = , +, - , *, %, /, == , > , < , <= , >= , !=
   - *Identifiers*: String of alphanumeric (and _) starting with an alphabetic character.
   - *Literals*: integer only.

2. **Rewrite the grammar** to eliminate any ambiguity and make sure that the associativity of the operations +, –, *, and / are left to right. 
3. **Write a parser** of the rewritten grammar using BYACC/J. Once you have built your parser, you should be able to process programs written in the language described above. When BYACC finds input that doesn't match the grammar, it automatically terminates with the message 'Syntax error'. You will need to write an error routine (yyerror) that also prints out the line number before this termination, and a main function that reads a program from a file. 

## Requirements
1. [JFLex](https://jflex.de/)
2. [BYACC/J](http://byaccj.sourceforge.net/)

## Run
To run the following program, open the terminal or the command line window. Then, navigate to the project directory and run the following commands:

1. Compile the Jflex file. This would automatically create the java code file "[jflex class name].java", which is here "Lexer.java".

```
jflex lexer.jflex 
```
1. Compile the yacc file. This would directly create the java code file "Parser.java" and "ParserVal.java".
   
```
yacc -J parser.y 
```
3. Compile the "Lexer.java" file.

```
javac Lexer.java
```
4. Compile the "Parser.java" file.

```
javac Parser.java
```

*Note*: You can run all the previous commands as one line of commands, by embedding '&&' between them:
```
jflex lexer.jflex && yacc -J parser.y && javac Lexer.java && javac Parser.java
```
5. Run the parser with the input text file.
```
 java Parser input.txt
```

There are some **sample runs** with their results that could be found [**here**](https://github.com/Faisal-AlDhuwayhi/Lexer-Parser/tree/master/Sample-Runs).

## Resources
- [Getting started with JFlex](https://www.youtube.com/watch?v=IV1Rwq7ERR4&ab_channel=MiftaSintaha)
- [Linking JFlex with BYacc/J (Lexer with Parser)](https://jflex.de/manual.html#BYaccJ)