function [y,b,a] = low_pass(x, Fs, Fcut,n,figflag)
%y = low_pass(x, Fs, Fcut)
% INPUT
%   x :[time x chn] or [time x epoch]
%   Fs : Sampling freq. (Hz)
%   Fcut: Cutoff freq. (Hz)
%   n :Filter Order

%Order size
if ~exist('n','var') || isempty(n); 
    n = 3; 
end

if ~exist('figflag','var') || isempty(figflag);
    figflag = 0;
end

%Design for Butterworth Filter
Wn = Fcut/(Fs/2);

%Coefficients for filter algo.
[b, a] = butter(n, Wn,'low');	

[h,f]=freqz(b,a,512,Fs);
if figflag == 1
figure;plot(f,abs(h));grid;title('Frequency Response');
%fvtool(b,a);
end

%Filter 
y = filtfilt(b, a, x);

%y = y';
