/*
					   A R B O R E
				  Verificator problema
	ONI 2000   Clasele XI-XII   Ziua I   Problema 2
*/
#include <stdio.h>
#include <process.h>

#define NODS  100UL
#define NIL   255

FILE *fin,*fout,*fres,*ferr;
unsigned char tata[NODS];
unsigned char rtata[NODS];
unsigned char selected[NODS];
int val[NODS];
int n,k;

void end(char *err)
{
	printf("%s\n",err);
	fprintf(ferr,"%s\n",err);
	fclose(fin);
	fclose(fout);
	fclose(fres);
	fclose(ferr);
	exit(0);
}

int main(int argc, char *argv[])
{
	int i,j,rad,rn,sum,first_res;

	if (argc<5)
	{
		printf("Parametrii: in out res err !\n");
		return -1;
	}
	fin=fopen(argv[1],"r");
	fout=fopen(argv[2],"r");
	fres=fopen(argv[3],"r");
	ferr=fopen(argv[4],"w");
	fscanf(fin,"%d %d",&n,&k);
	tata[0]=NIL;
	fscanf(fin,"%d",&val[0]);
	for (i=1;i<n;i++)
	{
		fscanf(fin,"%d %d",&tata[i],&val[i]);
		tata[i]--;
	}
	for (i=0;i<n;i++)
		selected[i]=0;
	rn=0;
	sum=0;
	fscanf(fres,"%d",&first_res);
	while (fscanf(fout,"%d",&j)==1)
	{
		if (rn==0)
		{
			if (first_res==-1&&j==-1)
			{
				if (fscanf(fout,"%d",&j)==1||!feof(fout))
					end("Caractere dupa \"-1\"!");
				end("Rezultat corect!");
			}
			if (first_res==-1&&j!=-1)
				end("Rezultat gresit. Nu exista solutie!");
			if (first_res!=-1&&j==-1)
				end("Rezultat gresit. Exista solutie!");
		}
		if (j<1||j>n)
			end("Numarul de nod invalid!");
		if (selected[j-1])
			end("Numar de nod duplicat!");
		selected[j-1]=1;
		sum+=val[j-1];
		rn++;
//		printf("%d\n",j);
	}
	if (sum!=k)
		end("Suma valorilor nodurilor nu este egala cu k!");
	for (i=0;i<n;i++)
		rtata[i]=NIL;
	for (i=0;i<n;i++)
		if (selected[i]&&selected[tata[i]])
			rtata[i]=tata[i];
	rad=NIL;
	for (i=0;i<n;i++)
		if (selected[i]&&tata[i]==NIL)
			if (rad==NIL)
				rad=i;
			else
				end("Rezultatul nu este un arbore!");
	end("Rezultat corect!");
	return 0;
}
