function [fwhm,x1,x2,halfmax] = gamfwhm(a,b,bPlot)

% function [fwhm,x1,x2,halfmax] = gamfwhm(a,b,bPlot)
%
%   example call: [fwhm,x1,x2,halfmax] = gamfwhm(2,3,1)
%
% returns full width at half maximum (fwhm) of gampdf for a > 1
% NOTE: requires symbolic math toolbox for lambertw.m
% NOTE: values of a closer to one require more precision when plotting the
% FWHM alongside the PDF
%
% a:   shape parameter, must be a > 1
% b:   scale parameter, must be b > 0
% bPlot: unitless plotting parameter
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%
% fwhm:    full-width at half maximum
% x1:      left FWHM endpoint
% x2:      right FWHM endpoint
% halfmax: height of the half max

%argument checks
if ~exist('bPlot','var') bPlot = 0; end
if (a <= 1) error('WARNING! a must be greater than 1!'); end
if (b <= 0) error('WARNING! b must be greater than 0!'); end

%gamma dist mode
gmode = gammode(a,b);

%lambert w function argument (hence 'larg')
larg = -1/(2^(1/(a-1))*exp(1));

%compute individual half-arguments
x1 = real(-gmode*lambertw(0,larg));
x2 = real(-gmode*lambertw(-1,larg));

%compute full-width at half max
fwhm = x2 - x1;

%compute halfmax
halfmax = gampdf(x2,a,b);

%equivalent (unused) computation
%fwhm = gmode*(lambertw(0,larg)-lambertw(-1,larg));

if bPlot == 1
    npoints = 10e5;
    hold on;
    plot(linspace(0,2*x2,npoints),gampdf(linspace(0,2*x2,npoints),a,b),'LineWidth',2)
    plot(linspace(x1,x2,npoints),halfmax*ones(npoints,1),'LineWidth',5)
    legend('Gamma Distribution','FWHM')
    formatFigure('x','p(x)','Gamma Full Width at Half Max');
end