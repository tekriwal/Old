
% This script is for WY 2/29/16

load('Patient_4_Sleep_LFP.mat')

% Assign variables using standardized Pat#_LFP#_part

Pat4_LFP0 = data(1).data(:,23);
Pat4_LFP1 = data(1).data(:,24);
Pat4_LFP2 = data(1).data(:,25);
Pat4_LFP3 = data(1).data(:,26);

%Pat4_LFP0_2 = data(2).data(:,23);
%Pat4_LFP1_2 = data(2).data(:,24);
%Pat4_LFP2_2 = data(2).data(:,25);
%Pat4_LFP3_2 = data(2).data(:,26);

% Let's create a plot to visualize what the data looks like

plot(Pat4_LFP0);
legend('Pat4_LFP0','Location','northeast');
xlabel('Samples');
ylabel('Units (???)');


%De-trend 

%DT_Pat4_LFP0 = detrend(Pat4_LFP0);
%DT_Pat4_LFP1 = detrend(Pat4_LFP1);
%DT_Pat4_LFP2 = detrend(Pat4_LFP2);
%DT_Pat4_LFP3 = detrend(Pat4_LFP3);

% Detrend; using mean

m_Pat4_LFP0 = mean(Pat4_LFP0);
m_Pat4_LFP1 = mean(Pat4_LFP1);
m_Pat4_LFP2 = mean(Pat4_LFP2);
m_Pat4_LFP3 = mean(Pat4_LFP3);

% unsure which of the following  is the right way to format?

DTm_Pat4_LFP0 = detrend(Pat4_LFP0,'m_Pat4_LFP0');
DTm_Pat4_LFP1 = detrend(Pat4_LFP1,'m_Pat4_LFP1');
DTm_Pat4_LFP2 = detrend(Pat4_LFP2,'m_Pat4_LFP2');
DTm_Pat4_LFP3 = detrend(Pat4_LFP3,'m_Pat4_LFP3');

DTm2_Pat4_LFP0 = detrend(Pat4_LFP0,'constant');
DTm2_Pat4_LFP1 = detrend(Pat4_LFP1,'constant');
DTm2_Pat4_LFP2 = detrend(Pat4_LFP2,'constant');
DTm2_Pat4_LFP3 = detrend(Pat4_LFP3,'constant');

% as a check, mean of the de-trended line should be close to zero


meanDTm0 = mean(DTm_Pat4_LFP0);
meanDTm1 = mean(DTm_Pat4_LFP1);
meanDTm2 = mean(DTm_Pat4_LFP2);
meanDTm3 = mean(DTm_Pat4_LFP3);


meanDTm2_0 = mean(DTm2_Pat4_LFP0);
meanDTm2_1 = mean(DTm2_Pat4_LFP1);
meanDTm2_2 = mean(DTm2_Pat4_LFP2);
meanDTm2_3 = mean(DTm2_Pat4_LFP3);

% Seems like the DTm# produces mean values that are slightly greater than
% DTm, so going with the first of the two options which is as follows


DTm_Pat4_LFP0 = detrend(Pat4_LFP0,'m_Pat4_LFP0');
DTm_Pat4_LFP1 = detrend(Pat4_LFP1,'m_Pat4_LFP1');
DTm_Pat4_LFP2 = detrend(Pat4_LFP2,'m_Pat4_LFP2');
DTm_Pat4_LFP3 = detrend(Pat4_LFP3,'m_Pat4_LFP3');

% It would be nice to visualize the difference between the raw vs
% de-trended data

trend_Pat4_LFP0 = Pat4_LFP0 - DTm_Pat4_LFP0;
trend_Pat4_LFP1 = Pat4_LFP1 - DTm_Pat4_LFP1;
trend_Pat4_LFP2 = Pat4_LFP2 - DTm_Pat4_LFP2;
trend_Pat4_LFP3 = Pat4_LFP3 - DTm_Pat4_LFP3;

%% this needs work, and everything beyond it

% this isn't right, but its something
hold on
plot(trend_Pat4_LFP0,':r')
plot(DTm_Pat4_LFP0,'b')
plot(t,zeros(size(t)),':k')
legend('Raw','Trend','Detrended Data',...
       'Mean of Detrended Data','Location','northeast')
xlabel('Samples');
ylabel('Units (???)');





%%

% Bandpass filter

LowFilt_DTm_Pat4_LFP0 = low_pass(DTm_Pat4_LFP0, 1024, 105);
HighFilt_DTm_Pat4_LFP0 = high_pass(DTm_Pat4_LFP0,1024,1);

% fourier based plot to generate power spectrum density

x = DTm_Pat4_LFP0;
Fs = 1024;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;

plot(freq,10*log10(psdx))
grid on
title('DTm_Pat4_LFP0 Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%this should break things up into thirty-second segments

Fs = 1024;
Total_seconds = 29115797/Fs;
n = Total_seconds/30;
Rn = round(n);
p = n/2;
Rp = round(p);

% y = buffer(x,n,p) overlaps or underlaps successive frames in the output matrix by p samples

Thirty_second_epochs_DTm_Pat4_LFP0 = buffer(DTm_Pat4_LFP0,Rn,Rp);
mean_Thirty_second_epochs_Pat4_LFP0 = mean(Thirty_second_epochs_DTm_Pat4_LFP0);

% following test code should be able to be altered to fit our data, should
% be able to generate 30 second windows we can cycle through - I think
%test = randn(10,10);
 
for ti = 1:size(test,2)
   
    plot(test(:,ti),'r')
   
    pause
    % the 'pause' function will pause Matlab until you press any key
    close all
end

% for each thirty second window we want to be able to compute the power
% spectrum density, and then compare specific frequencies of interest
% within every thirty second against all others in order to see when psd
% <</>> 4 SD



