%{
  import java.io.*;
%}

%start P
%token DEF IF THEN ELSE WHILE DO FOR
%token Punctuation_element
%token Operator
%token EQL_EQL GREATER_THAN_OR_EQUALS LESS_THAN_OR_EQUALS NOT_EQUALS 
%token Identifier
%token Literal

/* solving ambiguities */
%left '-' '+'
%left '*' '/' '%'
%left DEF IF THEN WHILE DO FOR 
%right ELSE 


%%

P : D ';' P 
|   D
;

D : DEF Identifier '(' ARGS ')' '=' E ';'
;

ARGS : Identifier ',' ARGS
|      Identifier
;


E:     Literal
|      Identifier
|      IF E OP E THEN E ELSE E
|      IF E '%' E THEN E ELSE E
|      FOR E DO E 
|      DO E WHILE E 
|      E '+' E
|      E '-' E
|      E '*' E
|      E '/' E
|      E '%' E
|      Identifier '(' C ')'
;

C:   E ',' C 
|    E
;

OP: EQL_EQL
|   '>'
|   '<'
|   GREATER_THAN_OR_EQUALS
|   LESS_THAN_OR_EQUALS
|   NOT_EQUALS
;

%%

private static boolean IS_ERROR = false;

/* a reference to the lexer object */
private Lexer lexer;

/* interface to the lexer */
private int yylex() {

    int yyl_return = -1;
    
try {
      
      yyl_return = lexer.yylex();
    }
 
   catch (IOException e) {
      System.err.println("IO error :"+e);

    }
    return yyl_return;
  }


 /* error reporting */
  public void yyerror (String error) {
    IS_ERROR = true;
    System.err.println("ERROR at line: " + lexer.GetLine() + " | with error name: " + error + " | at the word: \"" + lexer.GetWord() + "\"");
	
  }


 /* lexer is created in the constructor */
  public Parser(Reader r) {
    lexer = new Lexer(r , this);
  }



  public static void main(String args[]) throws IOException {

    Parser yyparser;

    if ( args.length > 0 ) {
      // parse a file
	
      yyparser = new Parser(new FileReader(args[0]));
      System.out.println("Start Parsing...");
	    yyparser.yyparse();

      if(IS_ERROR){
        System.out.println("Done with errors");
        }
      else{
        System.out.println("Done without errors");
        }
	
    }

    else {
      System.out.println("ERROR: Provide an input file as Parser argument");
    }
  }