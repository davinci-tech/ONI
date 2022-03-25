#pragma hdrstop
//#include <condefs.h>
#include<stdio.h>
#include<conio.h>
//#include<windows.h>
#include<malloc.h>
#include<string.h>

#define NMax 10000
#define AllocMax 10000


//---------------------------------------------------------------------------
#pragma argsused
int main(int argc, char* argv[])
{
    long int N;
    unsigned int uu;
    int m,i,j,nrn/*numarul de resturi noi */
             ,nrv/*numarul de resturi vechi */;
    char x[10],rest[NMax];
    long int rest_nou[NMax],rest_vechi[NMax];
    char **rn_numar,**rv_numar; /* rv <=> restul vechi, rn <=> restul nou*/
    rn_numar=(char**)calloc(AllocMax,sizeof(char*));
    rv_numar=(char**)calloc(AllocMax,sizeof(char*));
    for(i=0;i<AllocMax;i++)
      rn_numar[i]=rv_numar[i]=NULL;

 //   clrscr();
    printf("Dati N:");
    scanf("%d",&uu);
    N=uu;
    printf("Dati m:");scanf("%d",&m);
    for(i=0;i<m;i++){
       printf("x%d=",i+1);scanf("%d",&nrn);x[i]=(char)nrn;
    }
    j=1;
    while(j){
       j=0;
       for(i=0;i<m-1;i++)
         if(x[i]>x[i+1]){
             j=x[i];x[i]=x[i+1];x[i+1]=(char)j;j=1;
         }
    }
    for(i=0;i<N;i++) rest[i]=0;
    nrn=0;nrv=0;
    for(i=0;i<m;i++){
        unsigned long int u;
        if(x[i]==0) continue;
        u=((long)x[i])%((long int)N);
        if(rest[(unsigned int)u]==0){
            rest[(unsigned int)u]=1;
            rest_nou[nrn]=u;
            rn_numar[nrn]=(char*)malloc(2);
            rn_numar[nrn][0]=(char)('0'+x[i]);rn_numar[nrn][1]=0;
            nrn++;
        }
        if(u==0){ printf("\n\nNumarul cautat este: %s.\n",rn_numar[nrn-1]);return 0;}
    }
    while(nrn>0) {
      for(i=0;i<nrv;i++) free(rv_numar[i]);
      nrv=nrn;
      for(i=0;i<nrv;i++) {
          rv_numar[i]=rn_numar[i];
          rn_numar[i]=NULL;
          rest_vechi[i]=rest_nou[i];
      }
      nrn=0;
      ////////////////////////////////////////////////////////////////////////
      for(i=0;i<nrv;i++)
        for(j=0;j<m;j++){
            unsigned long int u;
            u=(rest_vechi[i]*10+x[j])%N;
            if(rest[(unsigned int)u]==0){
                rest[(unsigned int)u]=1;
                rest_nou[nrn]=u;
                u=strlen(rv_numar[i]);
                rn_numar[nrn]=(char*)malloc( (size_t)(u+2) ) ;
                strcpy(rn_numar[nrn],rv_numar[i]);
                rn_numar[nrn][(unsigned int)u]=(char)('0'+x[j]);
                rn_numar[nrn][(unsigned int)(u+1)]=0;
                if(rest_nou[nrn]==0){ printf("\n\nNumarul cautat este: %s.\n",rn_numar[nrn]);return 0;}
                nrn++;
            }
        }
      ////////////////////////////////////////////////////////////////////////
    }
    printf("\n\nNu se poate obtine un multiplu de %ld folosind doar cifrele date.\n",N);
    return 0;
}
 