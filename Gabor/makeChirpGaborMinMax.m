function [I,x,phix] = makeChirpGaborMinMax( imSize, thetaRad, nCyclesMinLeft, nCyclesMaxRight, sigma, trim )
% see the solution of equ. system
chirpRate=	2*(nCyclesMaxRight-nCyclesMinLeft);
baseFreq=	nCyclesMaxRight-nCyclesMinLeft;
phase0Rad = 	nCyclesMinLeft+(nCyclesMaxRight-nCyclesMinLeft)/4;

chirpRate
baseFreq
phase0Rad

xBaseFreq=-0.5;

[ I,x,phix ] = makeChirpGabor( imSize, baseFreq, chirpRate, xBaseFreq, thetaRad, sigma, phase0Rad, trim );
