% This function computes the gabor with chirp on frequency which range linearly with constant k 
% http://en.wikipedia.org/wiki/Chirp_rate
% http://en.wikipedia.org/wiki/Chirp

% This function creates a matrix imSize x imSize with a gabor field with a chirp phase, the phase is linearly increasing 
% starting from baseFreq in the xBaseFreq (a real in [-0.5,0.5] which is the domain of gabor )

% Examples, make a 512x512 gabor, with 0 base frequency, increasing at rate 10 cycles/(width)^2, the 0 frequency band is in the middle of the image (xBaseFreq=0)
% The franges will be inclined at 30° degrees, with a gaussian filter standard deviation = 128 pixels and a trim of 0.05
 
function [ gabor, X0,phaseArray ] = makeChirpGabor( imSize, baseFreq, chirpRate, xBaseFreq, thetaRad, sigma, phase0Rad, trim )
    
    X = 1:imSize;                           % X is a vector from 1 to imageSize
    X0 = (X / imSize) - 0.5;                 % rescale X -> -.5 to .5
    
    % Phase array 
    phaseArray = 2*pi*( baseFreq.*(X0) + 0.5*chirpRate.*(X0).*(X0) + phase0Rad );
    %phaseArray = ( (phaseArray/abs( max(phaseArray(:)) - min(phaseArray(:)) ) ) ) *2*pi; # renormalize the frequencies in the range [-pi,pi]
    
    % Creates the grid for the gabor as the domain, it spans linearly separated numbers in the unity domain [-0.5,0.5] x [-0.5,0.5]
    [Xm Ym] = meshgrid(X0, X0);
    
    % Creates the phase vector, the very important thing in this kind of gabor fields
    % In a linear chirp, the instantaneous frequency f(t) varies linearly with time:
    % f(x) = f_0 + k x
    % where f_0 is the starting frequency (at x= 0), and k is the chirp rate or rate of frequency increase
    % The corresponding space-domain function for the phase of a linear chirp is the integral of the spatial frequency:
    %
    % phi(t) =  2 pi  (f_0*x + k/2*x^2 + phi_0 )
    % where phi0 is the initial phase (at time x = 0).

    % Compute the phases for the horizontal coordinate (which is chirped), the domain is shifted on X axis by adding 0.5, in order to make the 0 frequency start from the borders,
    % instead that from the center 
    phiX = 2*pi*( baseFreq.*(Xm+xBaseFreq) + 0.5*chirpRate.*(Xm+xBaseFreq).*(Xm+xBaseFreq) + phase0Rad );
    
    % For sake of clarity also compute the phases for the vertical coordinate, which is NOT chirped
    phiY = 2*pi*baseFreq*(Ym);
    
    % Rotates the phases in the 2D - plane with a given angle in radians thetaRad 
    phiX = phiX * cos(thetaRad);                % compute proportion of Xm for given orientation
    phiY = phiY * sin(thetaRad);                % compute proportion of Ym for given orientation
    
    % Sum X and Y components (can't use linear relation as in simple gabor, we have to rotate the image according to the input angle)
    phiXY =  phiX + phiY; 
    
    % The corresponding space-domain function for a sinusoidal linear chirp is the sine of the phase in radians:
    grating = sin(phiXY); % The function is computed on the square domain with the specified frequency, increasing along X, 0 along Y
    gabor = grating;
    
    s = sigma / imSize;                     % gaussian width as fraction of imageSize
    Xg = exp( -( ( (X0.^2) ) ./ (2* s^2) ));% formula for 1D gaussian
    Xg = normpdf(X0, 0, (20/imSize)); Xg = Xg/max(Xg);  % alternative using normalized probability function (stats toolbox)
    gauss = exp( -(((Xm.^2)+(Ym.^2)) ./ (2* s^2)) ); % formula for 2D gaussian
    gauss(gauss < trim) = 0;                % trim around edges (for 8-bit colour displays)
    gabor = grating .* gauss;               % use .* dot-product
    
end

