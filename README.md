Gabor field with a chirped phase
=============

Octave/Matlab code to generate gabors with chirp

In this simple files I provide a rather flexible method to generate nonlinear Gabor fields, where the frequency 
is varying. I implemented a linearly varying frequency using the formula 

f(x)=f_0 + k*x where f_0 is base frequency (i.e. the frequency at x=0) and k is the so-called chirp rate, (i.e. the second
time derivative of phase phi(x) ).


What is this? Why do I need it?
====
I implemented the chirp as in the wikipedia article http://en.wikipedia.org/wiki/Chirp and 
http://en.wikipedia.org/wiki/Chirp_rate

I also provide some examples. Please run:

testChirpGabor.m

to check the functionalities of the simple chirpGabor function.

The code is not optimized. The only optimization here is the exploitation of full-vectorization in matrix computations.

This code can be made faster
1) By explicitly writing it in C++
2) By exploiting GPU libraries, like Jacket for Matlab

Currently the code works on Octave and Matlab