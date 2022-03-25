#include <stdio.h>
#include <process.h>

FILE *out=NULL,*ok=NULL,*pct=NULL;
int test=0;

void end(char *msg,int punctaj)
{
	printf("Test: %d, Punctaj: %d puncte, %s !\n",test,punctaj,msg);
	if (out)
		fclose(out);
	if (ok)
		fclose(ok);
	if (pct)
	{
		fprintf(pct,"%d %d\n",test,punctaj);
		fclose(pct);
	}
	exit(0);
}

void main(int argc,char *argv[])
{
	int r1,n1,r2,n2;

	if (argc<5||sscanf(argv[3],"%d",&test)!=1)
		end("*** Parametrii necorespunzatori",0);
	pct=fopen(argv[4],test==1?"w":"a+");
	if (pct==NULL)
	   end("*** Nu pot deschide fisierul de punctaj",0);
	ok=fopen(argv[2],"r");
	if (ok==NULL)
	   end("*** Fisierul de iesire comisie nu exista",0);
	out=fopen(argv[1],"r");
	if (out==NULL)
	   end("Fisierul de iesire concurent nu exista",0);
    r1=fscanf(out,"%d",&n2);
    r2=fscanf(ok,"%d",&n1);
    if (r1!=1)
		end("Fisierul de iesire concurent este gol",0);
	if (r2!=1)
		end("*** Fisierul de iesire comisie este gol",0);
	printf(" Concurent: %d   Corect: %d\n",n2,n1);
	if (n1==n2)
		end("CORECT",10);
	else
		end("Raspuns gresit",0);
}
