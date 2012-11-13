% This function show the simple gabor rotation. The gabor is build using makeChirpGabor 
% but with chirpRate=0, so that the behaviour is the same of a usual gabor.
% The angle theta is varying and the franges are rotated accordingly
% Press SPACEBAR to process the next image, there are totally 20 steps

function example1()
	
	disp('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
	disp('    This example shows the simple gabor rotation.');
	disp('    The gabor is build using makeChirpGabor');
	disp('    but with chirpRate=0, so that the behaviour is the same of a usual gabor.');
	disp('    The angle theta is varying and the franges are rotated accordingly');
	disp('    Press SPACEBAR to process the next image, there are totally 20 steps');
	disp('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
	chirpRate=0;
	baseFreq=1.0;
	xBaseFreq=0.5; #should be 0.5

	imSize=64;
	% If sigma is set=imSize then no gaussian filter is applied because the filter gaussian is approx large as the image
	sigma=64;
	trim=0.05;

	phase0Rad=0.0;

	for thetaRad=0:pi/20:2*pi
	   disp(['Angle= ' num2str(thetaRad/pi*180) ' deg' ] );
	   [I,x,phix]=makeChirpGabor( imSize, baseFreq, chirpRate, xBaseFreq, thetaRad, sigma, phase0Rad, trim );
	   imagesc(I);
	   pause
	end
