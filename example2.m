function example2()
	disp('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
	disp('    This example shows the effect of chirp rate on a gabor.');
	disp('    This function shows how varying the chirp rate we increase the frequency along the x axis');
	disp('    thus shortening the franges distances');
	disp('    The gabor is build using makeChirpGabor');
	disp('    Press SPACEBAR to process the next image, there are totally 20 steps');
	disp('    The chirpRate also controls the number of franges in the image, nFranges=chirpRate if you set baseFreq=0');
	disp('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
	
	chirpRate=0;
	baseFreq=0.0;
	% xBaseFreq represents the x position where there is the baseFreq, it can be in [-0.5,0.5]
	% if you set xBaseFreq=-0.5, then the frequency of franges will increase from left to right
	% if you set xBaseFreq=0.5, then the frequency of franges will increase from right to left
	% if you set xBaseFreq= 0.0, then the frequency of franges will increase from symmetrically from left and right
	xBaseFreq=0.5;

	imSize=512;
	sigma=256;
	trim=0.05;

	phase0Rad=0.0;
	thetaRad=0.0;

	maxChirp=100;
	nsteps=50;
	for chirpRate=0:(maxChirp/nsteps):maxChirp
	   chirpRate
	   [I,x,phix]=makeChirpGabor( imSize, baseFreq, chirpRate, xBaseFreq, thetaRad, sigma, phase0Rad, trim );
	   imagesc(I);
	   pause
	end

