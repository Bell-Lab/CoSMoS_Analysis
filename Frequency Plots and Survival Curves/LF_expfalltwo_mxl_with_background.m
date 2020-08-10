function pc=expfalltwo_mxl_with_background(inarg,intervals,tm,tx,NsTs,NbTb,bkarg)
%
% function expfalltwo_mxl_with_background(inarg,intervals,tm,tx,NsTs,NbTb,bkarg)
%
% Will use a MAXIMUM LIKELIHOOD algorithm for fitting a distribution
% function.  In this instance we will fit a biexponential with 
% three parameters a, tau1 and tau2  We must also input the minimum
% resolution time for the distribution, tm and the maximum time interval tx.
%  (see B18p36)
%(  1/( a*A + (1-a)*B )*...
%          ( a*r1 *exp(-intervals*r1)+(1-a)*r2 *exp(-intervals*r2) );
%
%  where A = ( exp(-tm*r1) - exp(-tx*r1) ) 
%    and B = ( exp(-tm*r2) - exp(-tx*r2) )
%  (see B18p36)
%        
% inarg = [ ap r1 r2],  starting fit parameters in the distribution, 
%                defined in the above equation for the distribution
%               note that a = 1/(1+ap^2)
% intervals == vector list of intervals measured (e.g. residence times) that
%            should be part of the distribution 
% tm == minimum interval length that can be resolved in the experiment
% tx== maximum interval length that can be resolved in the experiment
% NsTs == (# data events OBSERVED)/(total wait (low) time for data)
% NbTb == (# background events OBSERVED)/(total wait (low) time for background)
% bkarg == [ apb rb1 rb2],  same as inarg but here for the background 
%               as previously determined by fitting the background with
%               'expfalltwo_mxl.m'
%
% call via fminsearch('expfalltwo_mxl_with_background',inargzero,[],intervals,tm,tx,NsTs,NbTb,bkarg)


% Copyright 2016 Larry Friedman, Brandeis University.

% This is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.

% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
% A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this software. If not, see <http://www.gnu.org/licenses/>.



%N=length(intervals);                    % Number of events measured in the experiment
                                % Calculate the probability of each
                                % measured interval being part of the
                                % hypothesized distribution
ab=1/(1+bkarg(1)^2);            % 'a' value for the background distribution
rb1=abs(bkarg(2));
rb2=abs(bkarg(3));
Ab=( exp(-tm*rb1) - exp(-tx*rb1) );     % 'A' value for the background distribution
Bb = ( exp(-tm*rb2) - exp(-tx*rb2) );   % 'B' value for the background distribution

a=1/(1+inarg(1)^2);
r1=abs(inarg(2));
r2=abs(inarg(3));
                                       % Expression in terms of time constants
%A=( exp(-tm/tau1) - exp(-tx/tau1) );
%B = ( exp(-tm/tau2) - exp(-tx/tau2) );
%probability_vector=(  1/( a*A + (1-a)*B  )*...
%                                 ( a/tau1*exp(-intervals/tau1)+(1-a)/tau2*exp(-intervals/tau2) )+...
%                                   0);
                                        % Expression in terms of rates
A=( exp(-tm*r1) - exp(-tx*r1) );
B = ( exp(-tm*r2) - exp(-tx*r2) );
%probability_vector=(  1/( a*A + (1-a)*B  ) )*...
%                                 ( a*r1*exp(-intervals*r1)+(1-a)*r2*exp(-intervals*r2) )+...
%                                 0;
    %  Note the background term, and the relative values of the event frequencies
    % 'NsTs' for the (data+background) signal and 'NbTb' for the background multiplying
    % the (signal-background) and background terms respecitvley
probability_vector=(NsTs-NbTb)*(  1/( a*A + (1-a)*B  ) )*...
                                 ( a*r1*exp(-intervals*r1)+(1-a)*r2*exp(-intervals*r2) )+...
                     NbTb*(  1/( ab*Ab + (1-ab)*Bb  ) )*...
                                 ( ab*rb1*exp(-intervals*rb1)+(1-ab)*rb2*exp(-intervals*rb2) );
                  %               86.4617*exp(-intervals/1.3642) + 14.1050*exp(-intervals/5.9616);
               % Corrects for (reanalysis) nonspecific binding b18p54 top of page
              % 82.94*exp(-intervals/1.45) + 12.22*exp(-intervals/6.13);  
              % Corrects for nonspecific binding b18p42 top of page         

prodprob=sum(log(probability_vector));           % Take product of all probabilities;
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
                                      % to handle

% Build up the probability expression using just the Number of observed events:
% coefficient of background term should be:  (Nb/Tb)*Ts = Nb', the number
% of background events we should observe for dwell times btwn tm and tx  (integrating
% the background term Nb'*(1/( ab*Ab + (1-ab)*Bb)* ( ab*rb1*exp(-intervals*rb1)+(1-ab)*rb2*exp(-intervals*rb2) );
% between tm and tx yields Nb'
% In taking the data on the e.g. DNA with a promoter we observe Ns dwell events
% comprised of both signal and background.  Thus, the coefficient of the 
% 'signal only' term should be:  Ns-Nb', yielding a first term of
% (Ns - Nb')*(1/( a*A + (1-a)*B)* ( a*r1*exp(-intervals*r1)+(1-a)*r2*exp(-intervals*r2) )  ;
% which yield a number of events equal to (Ns - Nb') with dwell times
% between tm and tx.  Dividing by the wait time Ts, we obtain the
% expression in the above program.
% Ns
