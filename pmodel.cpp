//
// P-model
//
#include <cmath>
#include <iostream>
#include <vector>
#include <algorithm> 
#include "smattpl.h"
#include "RWFile.h"
#include "ran.h"


using namespace std;

class Urand : public Ranf1 {
	int n;
	public:
	Urand(int nn){ n = nn;}
	int operator()(){return int64() % (n);} // entre 0 y n 
	};


// random generator function:
ptrdiff_t myrandom (ptrdiff_t i) { Urand ran(i); return ran();}

// pointer object to it:
ptrdiff_t (*p_myrandom)(ptrdiff_t) = myrandom;

int main(int argc, char * argv[])
{
	if( argc < 7)
	{
		cerr << "Multinomial Multiplicative Process" << endl;
		cerr << "p-model Martinez VJ et al. 1990 Astrophysical Journal 357: 50–610"<< endl;
		cerr << "Feder J. 1988 Fractals (Ney York: Plenun Press)" << endl << endl;

		cerr << "Usage: pmodel p0 p1 p2 p3 iter outputFile type=F|R|S" << endl;
		cerr << "type=F: Fixed order  R: random without reposition  S:random with reposition" << endl;		        
		exit(1);
	}

	int i,j,r,s,p,kk;
	long po,po1;
	RWFile file;

    Urand ran(2); // Entre 0 y 1

    // return (ran.int64() % (num+1)); // between 0 and num inclusive 
	
	int pMax=atoi(argv[5]);
	char rndEval = 'S';
	if( argc==8 )  rndEval=toupper(argv[7][0]);
	 
	simplmat <double> pOri;
	simplmat <double> pPre;
	simplmat <double> pAct;
	
	p=1;
    po=pow(2,p);
    po1=pow(2,p+1);
	pOri.resize(2,2,0.0);
	pPre.resize(po,po,0.0);
	pAct.resize(po1,po1,0.0);

	// Randomize initial positions
	int pos[4]={1,2,3,4};
	vector<int> posV(pos, pos+4);
	
	random_shuffle( posV.begin(),posV.end(),p_myrandom);
	for(int i=0; i<posV.size(); ++i)
        cout<<posV[i]<<' ';
	
	pOri(0)=atof(argv[posV[0]]);
	pOri(1)=atof(argv[posV[1]]);
	pOri(2)=atof(argv[posV[2]]);
	pOri(3)=atof(argv[posV[3]]);

	pPre(0,0)=pOri(0,0);
	pPre(0,1)=pOri(0,1);
	pPre(1,0)=pOri(1,0);
	pPre(1,1)=pOri(1,1);

    for(p=2;p<=pMax;p++)
    {
		for(i=0;i<po;i++)
	    {
			for(j=0;j<po;j++)
			{
				int inir=i*2;
				int finr=(i+1)*2;
				int inis=j*2;
				int fins=(j+1)*2;
				switch(rndEval)
				{
					case 'F':
						for(r=inir;r<finr;r++)
							for(s=inis;s<fins;s++)
							{
								pAct(r,s)=pPre(i,j)*pOri(r%2,s%2); 	// ** Modelo sin azar ***
							}
						break;

					case 'R':
						random_shuffle( posV.begin(),posV.end(),p_myrandom);
						kk=0;
						for(r=inir;r<finr;r++)
							for(s=inis;s<fins;s++)
							{
								pAct(r,s)=pPre(i,j)*pOri(posV[kk]-1);
								kk++;
							}
						break;
					default:
						for(r=inir;r<finr;r++)
							for(s=inis;s<fins;s++)
							{
								pAct(r,s)=pPre(i,j)*pOri(ran(),ran()); 	// ** Con reposición **
							}
						break;
				}
			}

		}

	    po=pow(2,p);
	    po1=pow(2,p+1);

		pPre.resize(po,po,0.0);
		for(i=0;i<po;i++)
			for(j=0;j<po;j++)
				pPre(i,j)=pAct(i,j);

        if(p<=pMax)
			pAct.resize(po1,po1,0.0);

	}
	file.WriteSeed(argv[6], pPre, "BI");
	
	return 0;
}
