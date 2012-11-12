% This function computes the gabor with chirp on frequency which range linearly with constant k 
function [ gabor,Xf ] = makeGaborModulatedFreqVar( imSize, nFranges, theta, sigma, phase, trim )
    lambda=imSize/(nFranges);
    X = 1:imSize;                           % X is a vector from 1 to imageSize
    X0 = (X / imSize) - .5;                 % rescale X -> -.5 to .5
    phaseRad = (phase * 2* pi);             % convert to radians: 0 -> 2*pi
    
    freq = imSize/lambda;                    % compute frequency from wavelength
    freq=freq/norm(freq);
    Xf = 2*pi*(freq*X0 + lambda*X0.*X0 + phaseRad);
    [Xm Ym] = meshgrid(Xf, Xf);             % 2D matrices
    
    %Xf = Xm * freq * 2*pi;
    grating = sin( Xf + phaseRad);          % make 2D sinewave
    thetaRad = (theta / 360) * 2*pi;        % convert theta (orientation) to radians
    Xt = Xm * cos(thetaRad);                % compute proportion of Xm for given orientation
    Yt = Ym * sin(thetaRad);                % compute proportion of Ym for given orientation
    XYt =  Xt + Yt;                         % sum X and Y components
    XYf = XYt * freq * 2*pi;                % convert to radians and scale by frequency
    grating = sin( XYf + phaseRad);         % make 2D sinewave
    s = sigma / imSize;                     % gaussian width as fraction of imageSize
    %Xg = exp( -( ( (X0.^2) ) ./ (2* s^2) ));% formula for 1D gaussian
    Xg = normpdf(X0, 0, (20/imSize)); Xg = Xg/max(Xg);  % alternative using normalized probability function (stats toolbox)
    gauss = exp( -(((Xm.^2)+(Ym.^2)) ./ (2* s^2)) ); % formula for 2D gaussian
    gauss(gauss < trim) = 0;                % trim around edges (for 8-bit colour displays)
    gabor = grating;# .* gauss;               % use .* dot-product
end

