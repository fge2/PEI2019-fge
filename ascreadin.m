function varargout=ascreadin(year,number)
% datastr=ascreadin(year,number)
% 
% This function reads in weather data from a .asc file
%
% INPUT:
%
% year
% number
% 
% OUTPUT:
%
% datastr 
%
% last modified by fge@princeton.edu on 7/2/2019

yearstr=num2str(year);
filename=char(strcat('/home/fge/PTONcGPS/WeatherData/',yearstr,'/pton',...
    sprintf('%03d',number),'0','.',extractBetween(yearstr,3,4),...
    '__SBF_ASCIIIn.asc'));
a=fileread(filename);
datastr=extractAfter(a,'--------------------------------------- ');

% Optional output
varns={datastr};
varargout=varns(1:nargout);
