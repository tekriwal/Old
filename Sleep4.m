%% Psuedocodia

% This script is for WY 

load('Patient_4_Sleep_LFP.mat')

% Assign variables using standardized Pat#_LFP#_part

Pat4_LFP0 = data(1).data(:,23);
Pat4_LFP1 = data(1).data(:,24);
Pat4_LFP2 = data(1).data(:,25);
Pat4_LFP3 = data(1).data(:,26);
Pat4_LFPm = (Pat4_LFP0 + Pat4_LFP1 + Pat4_LFP2 + Pat4_LFP3)/4;

% For shorter, second section of recording

%Pat4_LFP0_2 = data(2).data(:,23);
%Pat4_LFP1_2 = data(2).data(:,24);
%Pat4_LFP2_2 = data(2).data(:,25);
%Pat4_LFP3_2 = data(2).data(:,26);

% Plot mean of the data

plot(Pat4_LFPm);
legend('Pat4_LFP0','Location','northeast');
xlabel('Samples');
ylabel('Units (???)');

% Compute global mean, SD and threshold (mean + (SD * 7)) on absolute value
% of recording

% Substitute values > +/- 7 SD's with NAN's

% Recompute global mean, SD and threshold (mean + (SD * 7)) on absolute
% value of recording

% Re-generate plot of mean but have NAN's highlighted as vertical red lines

% Dr. Wu's analysis of the sleep was1 analyzed as accurately as possible by
% eye and ruler, that data was compiled and imported as three arrays, saved
% as "Pat4_WorkspaceItems.mat".

% Details of "Pat4_WorkspaceItems.mat":
% Row 1:78, Column A is start of discretely scored sleep cycle and B is its
% end - units for both are sample numbers with fs = 1024. Column C is the
% sleep score with 1,2, and 3 representing N1, N2, and N3; 4 represents
% Wake; 5 represents REM

% Load matfile, perform function to generate discrete segments of data based
% on Column A and Column B, using Column C for identification

% matstruct = load('Pat4_LFPm.mat'); Pat4_LFPm_vals =
% matstruct.NameOfYourInputVariable;

Pat4_LFPm_sample_num = length(Pat4_LFPm);
num = xlsread('Pat4_Matlab_Events.xlsx');
start_pos = num(:,1);
end_pos = num(:,2);
sleep_scores = num(:,3);
last_scored_pos = max(end_pos);
group_num = zeros(last_scored_pos, 1);
for K = 1 : size(start_pos,1)
  group_num(start_pos(K) : end_pos(K)) = sleep_scores(K);
end


if last_scored_pos > Pat4_LFPm_sample_num
  group_num(Pat4_LFPm_sample_num+1 : end) = [];
end

% Detrend data to remove any float on the traces: we may want to
% detrend within 30 second epochs, as that is how Dr. Wu scored the EEG's.
% Regardless, need to split the segments into uniform time periods of X
% number of seconds and compare to global threshhold. Run segments through
% function that will return boolean output for whether to keep or junk that
% section

% Plot with NAN's and junk'ed segments in red - see if there's a
% correlation between thw two

% Bandpass filter each segment using Dr. Thompson's "high_pass.m" and
% "low_pass.m" - currently in f/Abosch but should be found in email from
% 2/24/16 as well

% Perform spectral power density analysis on segments and the overall
% mean (weighted by segment length)

% Create GUI that allows for cycling through of segments

% T-test between segments (ok if different size segments used in
% comparisons?), generating a p value for each comparison

% Import Dr. Wu's plot and overlay with color code scheme so that
% statistically similar segments appear in a given color - assumption is
% that changes in sleep cycle cause a sustained change in power spectrum
% that should match Dr. Wu's transitions










%%

% Break up into 30 second segments and identify which segments we may want
% to consider as "noise" using Dr. T's evalGoodEpochsLFP.m script

lfpDAT = Pat4_LFPm;
sampFreq = 1024;
epchLeng = 30;

evalGoodEpochsLFP( lfpDAT , sampFreq , epchLeng )



% Interval Number - indicates where in the sequence of the data that window
% came from (is this extranenous? Can't we just use the row # from the
% other arrays to figure out this same information?)
% Length - how long the sequence is in units of 30 seconds. This
% measurement was chosen to match with Dr. Wu's analysis as closely as
% possible
% Sleep Stage - this contains the score that each interval was given by Dr.
% Wu, the numbers 1-3 correspond to stages 1-3 as well, with 4 = W
% and 5 = R

% Need to assign each 30 second piece to a designation - how do we handle
% segments where there is a switch from one to the other? We did estimate
% where these transitions happen so chopping them out doesn't really seem
% to matter

% Ask Dr. T if the excel file seems match up with what we



%%


% Bandpass filter using low_pass and high_pass
% Just for LFP0 though, must be a way to easily subsitute in other value

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

% y = buffer(x,n,p) overlaps or underlaps successive frames in the output
% matrix by p samples

Thirty_second_epochs_DTm_Pat4_LFP0 = buffer(DTm_Pat4_LFP0,Rn,Rp);
mean_Thirty_second_epochs_Pat4_LFP0 = mean(Thirty_second_epochs_DTm_Pat4_LFP0);

% Need to plot these and be able to cycle through segments/zoom in and out
% this isn't right, but its something

hold on
plot(trend_Pat4_LFP0,':r')
plot(DTm_Pat4_LFP0,'b')
plot(t,zeros(size(t)),':k')
legend('Raw','Trend','Detrended Data',...
       'Mean of Detrended Data','Location','northeast')
xlabel('Samples');
ylabel('Units (???)');

% Will want ability to visualize the moving average as well as standard
% deviation at varying sigmas if desired.

%% Power spectrum

% We want to compute the power spectrum for 30 second windows in line with
% Dr. Wu's EEG analysis, and then compare those power spectrums across time
% using a spectrogram or some other wavelet feature

% We then want to compare our LFP's spectral analysis to Dr. Wu's and see
% if there are certain ephys signatures that align well with the
% transitions he suggests. One way to plot this is to import the time
% stamps Dr. Wu's suggested transitions as events in a histogram and see
% what local changes are occurring a bit before/during/after transition on
% spectral density plots, heatmaps, etc

% Compare to our own suggested sleep stage switches (if we have any
% generated)

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


% generate a line graph displaying LFPs'0-3' along the one LFP's DTm counterpart


% Generate a line graph displaying LFPs'0:3' along with DTm counterparts,
% use colors that make it easy to differentiate pairs, include legend,
% include Pat4_LFPm and DTm_Pat4_LFPm with a thickened line.


% How do we search for drop offs or increases in the power spectrum around
% the time when patients transition between sleep periods? I could see how
% defining some parameter like >2SD from the 30 second period before it
% gets flagged, but also seems like there may be a better way.



%% Coherence

% It is necessary to find a way to detect low level environmental noise,
% large artifacts detected across multiple recording contact sites, and
% have some statistical measure that justifies the signal we are recording
% is indeed physiologic. To do this, we want to get the coherence for
% certain frequencies/waveforms:

% We want to take a number of samples that we can then compare against one
% another intra contact recording. If we are assuming stoichastic activity,
% we'd want the windows to be the length we think populations could be
% modulating in, say 100 ms.

% Within those windows, we'd want to transform the data into discrete
% waveforms/equations

% We'd want to compare each window against one another per
% frequency/waveforms by taking the correlation constant for each window
% against every other window

% Make comparison from LFP to LFP in the hopes of identifying either A)
% identical artifacts that can be excluded or B) unique but complementary
% electronic signatures that we can use to characterize network level
% oscillations




%% ALL Raw LFPs Analysis

% Plot as the untransformed data and include error bars, numerically
% Measure coherence for each grouping of LFP's and all LFP's

% See how the coherence compares between patients, make note of any
% outliers and possible patterns in response to 


%% Misc

% Measure spectral density for ratio of beta/gamma as well as looking at
% body contact EEGs for evidence of tremor. I suspect there may be times in
% certain patients during their sleep cycle where tremor is apparent, and I
% would not be surprised to find this time closely with a significant change in
% beta/gamma

% Should we look for things like sleep spindles in the EEG recordings
% ourselves to validate our findings - may not be in places we expect in PD
% patients

%% Devise algorithm 
% To pick up on ephys signatures that we may find occurring at known
% intervals relative to sleep cycle

% See if we use our algorithm on data from Dr. O'Niel's pediatric
% population to make feasible inferences into their sleep architecture if
% applicable

% Create code that would be capabale of communicating between DBS hardware
% and implanted computer/BCI to enable for turn on/off in response to
% algorithm (machine learning?)

%% Sending scripts/results to collaborators for input


