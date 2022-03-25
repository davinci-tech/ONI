#include <stdio.h>
#include <conio.h>
#include <iostream.h>
#include <fstream.h>
#include <stdlib.h>
#include <math.h>
unsigned huge a[251][251];
unsigned c1=0,c2=0,ct,i0,j0,n,i,j,k; float distf, distc=0, d;
float ok(void)
{if (i0==i && abs(j-j0)==1) return 1;
 if (j0==j && abs(i-i0)==1) return 1;
  if (abs(j0-j)==1 && abs(i-i0)==1)
     return sqrt(2);
 return 0;
}

int main(int argc, char *argv[], char **envp)
{ ifstream fi(argv[1]);
  ifstream fo(argv[2]);
  ofstream frez("result.txt");
  fi>>n;
//  fo>>distf;   ??
/*  if (fabs(distf-4*(n-1)-(n-2)*(n-2)*sqrt(2))/n>0.1)
   {cout<<"lungime incorecta"; return(1);}*/
  fo>>i0>>j0;
  for (k=1;k<=n*n;k++)
   {fo>>i>>j;
    if (a[i][j]!=0)
     {frez<<"prin patratul de coordonate "<<i<<' '<<j<<" se trece de 2 ori";
      return 2;}
    if (a[i0][j]!=0&& a[i][j0]!=0 && abs(a[i0][j]-a[i][j0])==1)
     {frez<<"drumul se autointersecteaza in pasul "<<k;
      return 2;}
    if (d=ok()) {d==1?c1++:c2++;
		 a[i][j]=k;
		 i0=i;j0=j;}
     else {frez<<"patratele din mutarile "<<k-1<<" si "<<k<<" nu sunt vecine";
	frez<<":"<<i0<<'-'<<j0<<" si "<<i<<'-'<<j;
	   return 3;}
   }
  i=j=1;
/*  if (d=ok()) {distc+=d; d==1?c1++:c2++;}
     else {cout<<"\npatratele din mutarile "<<k<<" si "<<k+1<<" nu sunt vecine";
	cout<<endl<<":"<<i0<<' '<<j0<<' '<<i<<' '<<j;
	   return 3;}*/
  //if (fabs(distf-distc)/n>0.1)
  if (c1==4*(n-1)&&c2==(n-2)*(n-2))
    {frez<<"ok: "<<atoi(argv[3])<<" puncte";return 0;}
   else {frez<<"lungime incorecta";
    return 4;}
}