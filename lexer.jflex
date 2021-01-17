import java.io.*;

%%

%class Lexer
%line
%byaccj

%{
 /* store a reference to the parser object */
  private Parser yyparser;

/* constructor taking an additional parser object */
  public Lexer(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
}
	/* Get the line, Starting from 1 */
    public int GetLine() { 
        return yyline + 1; 
        }
		
	public String GetWord() { 
        return yytext(); 
        }

%}

DEF = "def"
IF = "if"
THEN = "then"
ELSE = "else"
WHILE = "while"
DO = "do"
FOR = "for"
Punctuation_element = [():,;]
Operator = ("="|"+"|"-"|"*"|"%"|"/"|">"|"<")
Identifier = [a-zA-Z]([a-zA-Z\d_])*
Literal = \d+

%% 
/* Keywords */
{DEF}						{ return Parser.DEF; }
{IF}						{ return Parser.IF; }
{THEN}						{ return Parser.THEN; }
{ELSE}						{ return Parser.ELSE; }
{WHILE}						{ return Parser.WHILE; }
{DO}						{ return Parser.DO; }
{FOR}						{ return Parser.FOR; }


{Punctuation_element} { return (int) yycharat(0); }

/* Some operators */
{Operator}   { return (int) yycharat(0); }

/* Other Operators */
"=="            { return Parser.EQL_EQL; }
">="    	{ return Parser.GREATER_THAN_OR_EQUALS; }
"<="        	{ return Parser.LESS_THAN_OR_EQUALS; }
"!="            { return Parser.NOT_EQUALS; }



{Identifier}       { return Parser.Identifier; }

{Literal}          { return Parser.Literal; }

            
/* Whitespaces */
[\s]+ 	           { /* do nothing */ }

/* Tokens other than the regular expressions above (Not included in the language) */
.     {
        System.err.println( "Lexical Error at line: " + yyline+1 + ", at the word: \"" + yytext() + "\"");
        return -1;
        }