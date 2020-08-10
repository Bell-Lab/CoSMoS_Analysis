function pc=two_gaussian_linear_mxl(inarg,xvec)
%
% function two_gaussian_linear_mxl(inarg,xvec)
%
% Maximum likelihood function for fitting a linear distribution with two gaussians
%
%   a/sqrt(2*pi*Sigma1^2)*exp(-(xvec-X1)).^2/(2*Sigma1^2) ) +  (1-a)/sqrt(2*pi*Sigma2^2)*exp(-(xvec-X2)).^2/(2*Sigma2^2) )
%
%  with a = Ap^2/(1+Ap^2)  (or Ap = sqrt( a/(1-a) )
% inarg =[ Ap X1 Sigma1  X2 Sigma2]
% xvec = vector list of x values measured that will be characterized by the
%          gaussian distribution
% 
% call via argout = fminsearch('two_gaussian_linear_mxl',inarg,[],xvec)

 
a=inarg(1)^2/(1+inarg(1)^2);
X1=inarg(2);
Sigma1=inarg(3);
X2=inarg(4);
Sigma2=inarg(5);


                    % Form the vector indicating the probabilities that
                    % the intervals are part of the
                    % trial distribution.                 
%probvector= 1/sqrt(2*pi*sigma^2)*exp(-(xvec-Xo).^2/(2*sigma^2) )  +inarg(3) ;     
%probvector= 1/sqrt(2*pi*sigma^2)*exp(-(xvec-Xo).^2/(2*sigma^2) )   ;
probvector= a/sqrt(2*pi*Sigma1^2)*exp(-(xvec-X1).^2/(2*Sigma1^2) ) + (1-a)/sqrt(2*pi*Sigma2^2)*exp(-(xvec-X2).^2/(2*Sigma2^2) )   ;


prodprob=sum(log(probvector));           % Take product of all probabilities;
pc=-prodprob;                         % The fminsearch will then minimize the
                                      % -prodprob (i.e. maximize prodprob)
                                      % so we will maximize the likelihood
                                      % that the intervals vector
                                      % represents the said distribution
                                      % (The sum of the log of the vector entries
                                      % is the same as the log of the
                                      % product of the vector entries.  We
                                      % use the sum( log() ) because taking
                                      % the product of the entries yields a
                                      % number too small for the computer
                                      % to handle.
%   1/sqrt(2*pi*arg(2)^2) * exp(-(xvec-inarg(1)).^2/(2*inarg(2)^2) )  +inarg(3)
%
% inarg =[ (Xo center)     sigma     offset]




