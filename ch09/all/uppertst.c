//
// C program to call our Assembly
// toupper routine.
//

#include <stdio.h>

// Prototype for our Assembly function
extern int mytoupper( char *, char * );

#define MAX_BUFFSIZE 255

int main()
{
	char *str = "This is a test.";
	char outBuf[MAX_BUFFSIZE];
	int len;

	len = mytoupper( str, outBuf );
	printf("Before str: %s\n", str);
	printf("After str: %s\n", outBuf);
	printf("Str len = %d\n", len);
	return(0);	
}
