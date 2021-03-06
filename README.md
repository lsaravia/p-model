## p-model

Generation of a 2D Multinomial Multiplicative Process 

Described in  Martinez VJ et al. 1990 Astrophysical Journal 357: 50–610
and also in Feder J. 1988 Fractals (Ney York: Plenun Press).

Used in an ecological framework by Laurie H, Perrier E (2010) A multifractal model for spatial variation in species richness. Ecological Complexity 7: 32–35.

The parameter are four probabilities p1 p2 p3 p4, the number of iterations (iter) and the output file name. The size of the image is given by 2^iter.

The *.sed files are output examples.

The pmodel.r file is an R script to plot the sed files using lattice package. For multifractal spectra estimation it uses mfSBA software <https://github.com/lsaravia/mfsba>. The files t* s* f* a* are mfSBA output files with the multifractal spectra.


License
=======

  Copyright 2012 Leonardo A. Saravia
 
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 