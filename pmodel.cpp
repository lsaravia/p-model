//
// P-model
//
#include <cmath>
#include <iostream>
#include <vector>
#include <algorithm> 
#include "smattpl.h"
#include "RWFile.h"
#include "randlib.h"
#include "ran.h"


using namespace std;

class Urand : public Ranf1 {
	int n;
	public:
	Urand(int nn){ n = nn;}
	int operator()(){return int64() % (n+1);} // entre 0 y n 
	};

int main(int argc, char * argv[])
{
	if( argc < 6)
	{
		cerr << "Multinomial Multiplicative Process" << endl;
		cerr << "p-model Martinez VJ et al. 1990 Astrophysical Journal 357: 50–610"<< endl;
		cerr << "Feder J. 1988 Fractals (Ney York: Plenun Press)" << endl << endl;

		cerr << "Usage: pmodel p0 p1 p2 p3 iter outputFile" << endl;
		        
		exit(1);
	}

	int i,j,r,s,p;
	long po,po1;
	RWFile file;

//	int rndSeed = time(NULL);
//	setall(rndSeed,rndSeed+1);
    Urand ran(1);

	// ranf(); 

//		return (ran.int64() % (num+1)); // between 0 and num inclusive 
	
	int pMax=atoi(argv[5]);

	simplmat <double> pOri;
	simplmat <double> pPre;
	simplmat <double> pAct;
	
	p=1;
    po=pow(2,p);
    po1=pow(2,p+1);
	pOri.resize(po,po,0.0);
	pPre.resize(po,po,0.0);
	pAct.resize(po1,po1,0.0);

	// Randomize initial positions
	int pos[4]={1,2,3,4};
	vector<int> posV(pos, pos+4);
	
	srand ( unsigned ( time (NULL) ) );
	
	random_shuffle( posV.begin(),posV.end());
	for(int i=0; i<posV.size(); ++i)
        cout<<posV[i]<<' ';
	
	pOri(0,0)=atof(argv[posV[0]]);
	pOri(0,1)=atof(argv[posV[1]]);
	pOri(1,0)=atof(argv[posV[2]]);
	pOri(1,1)=atof(argv[posV[3]]);

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
			
				for(r=inir;r<finr;r++)
					for(s=inis;s<fins;s++)
					{
					//kk=pPre(i,j);
					//kk1= pPre(r%2,s%2);
					
					// ** Modelo sin azar ***
					// pAct(r,s)=pPre(i,j)*pOri(r%2,s%2);
					pAct(r,s)=pPre(i,j)*pOri(ran(),ran());
					}
			}

		}

/*		for(i=0;i<po1;i++)
		{
			for(j=0;j<po1;j++)
				cout << pAct(i,j) << "\t";
			cout << endl;
		}
*/
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
	
	/*cout << po << "\t" << po << endl;
	cout << "BI" << endl;
	
	for(i=0;i<po;i++)
	{
		for(j=0;j<po;j++)
			cout << pPre(i,j) << "\t";
		cout << endl;
	}
	cout << endl << endl;
	*/
	return 0;
}
