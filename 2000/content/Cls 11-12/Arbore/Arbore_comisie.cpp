/*
					   A R B O R E
	ONI 2000   Clasele XI-XII   Ziua I   Problema 2
*/
#include <stdio.h>
#include <alloc.h>
#include <process.h>

#define NODS  100UL
#define KMAX  1001UL
#define NIL   255

typedef struct info_struct
{
	int left;
	unsigned char down;
} info_t;

FILE *fin,*fout;
int n,k;

info_t *fx[NODS];
int tata[NODS];
int val[NODS];

void end()
{
	fclose(fin);
	fclose(fout);
	for (int i=0;i<NODS;i++)
		free(fx[i]);
	exit(0);
}

info_t *x(int nod,int valoare)
{
	if (nod>=NODS)
		printf("EROARE!\n");
	return &fx[nod][valoare];
}

void solution(int nod,int valoare)
{
	int v=valoare;
	fprintf(fout,"%d\n",nod+1);
	while (x(nod,v)->down!=NIL)
	{
		solution(x(nod,v)->down,v-x(nod,v)->left);
		v=x(nod,v)->left;
	}
}

void postord(int q)
{
	int i,j1,j2;

	for (i=0;i<=k;i++)
	{
		x(q,i)->left=-1;
		x(q,i)->down=NIL;
	}
	x(q,val[q])->left=0;
	x(q,val[q])->down=NIL;
	if (val[q]==k)
	{
		solution(q,k);
		end();
	}
	for (i=0;i<n;i++)
		if (tata[i]==q)
		{
			postord(i);
			for (j1=0;j1<=k;j1++)
				if (x(q,j1)->left>=0)
					for (j2=0;j1+j2<=k;j2++)
						if (x(i,j2)->left>=0&&
							x(q,j1)->down!=i&&
							x(q,j1+j2)->left<=0)
						{
							x(q,j1+j2)->left=j1;
							x(q,j1+j2)->down=i;
							if (j1+j2==k)
							{
								solution(q,k);
								end();
							}
						}
		}
}

int main()
{
	unsigned long i,j;

	for (i=0;i<NODS;i++)
		if ((fx[i]=(info_t *)malloc(KMAX*sizeof(info_t)))==NULL)
		{
			for (j=0;j<i;j++)
				free(fx[j]);
			printf("Memorie insuficienta! Rulati din DOS!\n");
			return -1;
		}
	fin=fopen("arbore.in","r");
	fout=fopen("arbore.out","w");
	fscanf(fin,"%d %d",&n,&k);
	tata[0]=NIL;
	fscanf(fin,"%d",&val[0]);
	for (i=1;i<n;i++)
	{
		fscanf(fin,"%d %d",&tata[i],&val[i]);
		tata[i]--;
	}
	postord(0);
	fprintf(fout,"-1\n");
	end();
	return 0;
}
