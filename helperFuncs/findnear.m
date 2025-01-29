function [ind] = findnear(X,Xtgt)

% function [ind] = findnear(X,Xtgt)
%
%   example call: X = randn(100,1); [ind] = findnear(X,0); X(ind)
%
% find index in vector nearest to a specified target value
%
% X:    vector of values
% Xtgt: target value
%%%%%%%%%%%%%%%%%%%%%%%%%%
% ind:  index of vector where value is nearest target value

ind = find(abs(X - Xtgt) == min(abs(X - Xtgt)),1);
