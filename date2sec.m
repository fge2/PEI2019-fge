function ellapsed_time=date2sec(t)
% ellapsed_time=date2sec(t)
% 
% Converts datetime array into ellapsed_time column array in seconds
%
% INPUT:
%  
% t                 The datetime vector
%
% OUTPUT:
%
% ellapsed_time     The ellapsed time in seconds vector
%
% Last modified by fge@princeton.edu on 6/24/19

n=length(t);
sec=datevec(t);
ellapsed_time(2:n)=etime(sec(2:end,:),sec(1:end-1,:));

