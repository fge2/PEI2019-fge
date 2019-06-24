function varargout = indexsplit(t)
% [dive,surface] = indexsplit(t)
% 
% Splits location indices into surface and subsurface vectors
%
% INPUT:
%  
% t         The datetime vector
%
% OUTPUT:
%
% surface   The array of indices where mermaid reports surface data
% dive      The array of indices where mermaid reports subusrface data
%
% Last modified by fge@princeton.edu on 6/24/19


% calculate diving indices
n=length(t);
index=ones(1,n);
count=1;
for i=2:n
    if ~(t.Day(i)==t.Day(i-1))
        count=count+1;
        index(count)=i;
    end
end
dive=index(1:count);

% calculate surface indices
a=1:n;
surface=setdiff(a,index);

% Optional output
varns={dive,surface};
varargout=varns(1:nargout);
