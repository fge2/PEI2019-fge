function varargout=ascreadin(year,number)
% output=ascreadin(year,number)
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
% output 
%
% last modified by fge@princeton.edu on 7/2/2019

filename=char(strcat('/home/fge/PTONcGPS/WeatherData/',year,'/pton',...
    sprintf('%03d',number),'0','.',extractBetween(year,3,4),...
    '__SBF_ASCIIIn.asc'));
output=cell2mat(textscan(fopen(filename),'%f %f %f %f %f %f %f %f'));

% Optional output
varns={output};
varargout=varns(1:nargout);
