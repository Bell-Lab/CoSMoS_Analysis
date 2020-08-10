function pc=three_gaussian_linear_mxl(inarg,xvec)
%
% function three_gaussian_linear_mxl(inarg,xvec)
%
% Maximum likelihood function for fitting a linear distribution with three gaussians
%
%   a1/sqrt(2*pi*Sigma1^2)*exp(-(xvec-X1)).^2/(2*Sigma1^2) ) +   a2/sqrt(2*pi*Sigma2^2)*exp(-(xvec-X2)).^2/(2*Sigma2^2) ) + ...  
%               a3/sqrt(2*pi*Sigma3^2)*exp(-(xvec-X3)).^2/(2*Sigma3^2) )
%
% a1 == fraction between 0 and 1 
% a2 == fraction between 0 and 1 
% a3 == fraction between 0 and 1
%      NOTE:   a1=Ap1^2/(1+ Ap1^2 + Ap2^2)  
%              a2=Ap2^2/(1+ Ap1^2 + Ap2^2)
%              a3= 1 - a1 - a2
%   Inverting above:  Ap1^2=(1+a1-a2-a3)/(2*a3);  Ap2^2=(1+a2-a1-a3/(2*a3);
% inarg =[ Ap1 Ap2 X1 Sigma1  X2 Sigma2  X3  Sigma3]
% xvec = vector list of x values measured that will be characterized by the
%          gaussian distribution
% 
% call via argout = fminsearch('three_gaussian_linear_mxl',inarg,[],xvec)

Ap1=inarg(1);  Ap2=inarg(2);  
a1=Ap1^2/(1+Ap1^2+Ap2^2); a2=Ap2^2/(1+Ap1^2+Ap2^2);a3=1-a1-a2;
X1=inarg(3);
Sigma1=inarg(4);
X2=inarg(5);
Sigma2=inarg(6);
X3=inarg(7);
Sigma3=inarg(8);


                    % Form the vector indicating the probabilities that
                    % the intervals are part of the
                    % trial distribution.                 
%probvector= 1/sqrt(2*pi*sigma^2)*exp(-(xvec-Xo).^2/(2*sigma^2) )  +inarg(3) ;     
%probvector= 1/sqrt(2*pi*sigma^2)*exp(-(xvec-Xo).^2/(2*sigma^2) )   ;
probvector= a1/sqrt(2*pi*Sigma1^2)*exp(-(xvec-X1).^2/(2*Sigma1^2) ) + a2/sqrt(2*pi*Sigma2^2)*exp(-(xvec-X2).^2/(2*Sigma2^2) ) +...
    a3/sqrt(2*pi*Sigma3^2)*exp(-(xvec-X3).^2/(2*Sigma3^2) );

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
