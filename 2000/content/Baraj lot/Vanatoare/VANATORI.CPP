#include <stdio.h>
#include <alloc.h>
#include <values.h>
/*
a[t1,t2,o]=numarul maxim de animale din intervalul 1..o care
		   pot fi vanate a.i cristi sa ocupe t1 timp
		   si marius sa ocupe t2 timp
		  =max(a[t1,t2,o-1],a[t1-timp[o],t2,o-1],a[t1,t2-timp[o],o-1]);

Complexitatea este TMAX*TMAX*OBIECTE.
Solutia e simpla dar ocupa destul de multa memorie (TMAX*TMAX*OBIECTE).
Daca nu tinem minte si drumul "inapoi" si vrei numai maximul, atunci problema
reduce dimensiunea memoriei la TMAX*TMAX*2
In aceasta varianta nu tinem minte drumul "inapoi", ci doar maximul.
*/
#define OBIECTE 600
#define TMAX    300

#define LUP     0
#define MISTRET 1

int *ma[TMAX+1];
int timp[OBIECTE+1],fel[OBIECTE+1];
int n;
int tmax;

int max(int a,int b)
{
	return a<b?b:a;
}

int *a(int t1,int t2,int i)
{
	return ma[t1]+(t2*2+i);
}

void main()
{
	int i,n1,n2,t,t1,t2;
	int maxt1,maxt2,maxi;
	FILE *in,*out;
	in=fopen("vanatori.in","r");
	if (in==NULL)
	{
	   printf("Fisier de intrare nu exista !\n");
	   return;
	}
	out=fopen("vanatori.out","w");
	fscanf(in,"%d",&tmax);
	fscanf(in,"%d %d",&n1,&n2);
	for (i=0;i<=tmax;i++)
		if ((ma[i]=(int *)malloc((tmax+1)*2*sizeof(int)))==NULL)
		{
			for (int j=0;j<i;j++)
				free(ma[j]);
			printf("Memorie insuficienta !\n");
			return;
		}
	for (n=1;n<=n1;n++)
	{
		fscanf(in,"%d",&timp[n]);
		fel[n]=LUP;
	}
	for (;n<=n1+n2;n++)
	{
		fscanf(in,"%d",&timp[n]);
		fel[n]=MISTRET;
	}
	n--;
	int k=0;
	for (t1=0;t1<=tmax;t1++)
		for (t2=0;t2<=tmax;t2++)
			*a(t1,t2,0)=0;
	int *at1t2i,*at1t2im1,*at1moit2im1,*at1t2moiim1;
	for (i=1;i<=n;i++)
		for (t1=0;t1<=tmax;t1++)
			for (t2=0;t2<=tmax;t2++)
			{
/*
				*a(t1,t2,i%2)=*a(t1,t2,(i-1)%2);
				if (fel[i]==LUP&&t1>=timp[i]&&*a(t1,t2,i%2)<*a(t1-timp[i],t2,(i-1)%2)+1)
					*a(t1,t2,i%2)=*a((t1-timp[i]),t2,(i-1)%2)+1;
				if (t2>=timp[i]&&*a(t1,t2,i%2)<*a(t1,(t2-timp[i]),(i-1)%2)+1)
					*a(t1,t2,i%2)=*a(t1,(t2-timp[i]),(i-1)%2)+1;
				if (k<*a(t1,t2,i%2))
					k=*a(t1,t2,i%2);
*/
				at1t2i=a(t1,t2,i%2);
				at1t2im1=a(t1,t2,(i-1)%2);
				at1moit2im1=a(t1-timp[i],t2,(i-1)%2);
				at1t2moiim1=a(t1,t2-timp[i],(i-1)%2);

				*at1t2i=*at1t2im1;
				if (fel[i]==LUP&&t1>=timp[i]&&*at1t2i<*at1moit2im1+1)
					*at1t2i=*at1moit2im1+1;
				if (t2>=timp[i]&&*at1t2i<*at1t2moiim1+1)
					*at1t2i=*at1t2moiim1+1;
				if (k<*at1t2i)
					k=*at1t2i;
			}
	fprintf(out,"%d\n",k);
	for (i=0;i<=tmax;i++)
		free(ma[i]);
	fclose(in);
	fclose(out);
}
