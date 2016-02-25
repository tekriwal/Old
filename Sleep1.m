% REMEMBER; Syntax is (ROW, COLUMN)

% Figure out how to save something in Matlab...
% accomplished, next step is figuring out whether I need the editor window
% *don't forget semicolons
% *don't forget to save
% do I need to keep re-importing the data file? Doesn't seem right...

%data2 = uint16(data.data);
%plot(data.data(1:10000000,24))

%this changes the data into 16 bit form and plots something out in the
%second line


%questions for Dr. Thompson - how do I sync up with github, do I really
%need to import the data file every time that I close down Matlab?

%Goal 1 - identify a fingerprint of sleep, will try for N2 signs of sleep
%spindles (12-14 Hz for ~0.5 second) and K wave (sharp negative deflection
%shortly after spindle) 

%Which data sets to pull from? For EEG need two central channels and two
%occipital channels, sampled from in 30-seconds. Occipital channels O1 and
%O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set


% Figure out how to save something in Matlab...
% accomplished, next step is figuring out whether I need the editor window
% *don't forget semicolons
% *don't forget to save
% do I need to keep re-importing the data file? Doesn't seem right...

%data2 = uint16(data.data);
%plot(data.data(1:10000000,24))

%this changes the data into 16 bit form and plots something out in the
%second line


%questions for Dr. Thompson - how do I sync up with github, do I really
%need to import the data file every time that I close down Matlab?

%Goal 1 - identify a fingerprint of sleep, will try for N2 signs of sleep
%spindles (12-14 Hz for ~0.5 second) and K wave (sharp negative deflection
%shortly after spindle) 

%Which data sets to pull from? For EEG need two central channels and two
%occipital channels, sampled from in 30-seconds. Occipital channels O1 and
%O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set

z=2


%%
%alldata=data.data;
%%
%allLFP=alldata(:,23:26);

% 2/7/16
%reached directory through Users > AndyTekriwal > Documents > MATLAB >
%Abosch > Git in order to get here, hopefully this will push to repos Dr.
%Thompson has access to through GitHub

%Occipital channels O1 and O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set

EEG1 = data.data(:,5);
EEG2 = data.data(:,16);
EEG3 = data.data(:,7);
EEG4 = data.data(:,18);

%deleting data2 variable, just going to deal with running the big file unti

% unsure if ^ did anything

% Rules for scoring - https://sleepdata.org/datasets/chat/pages/manuals/polysomnography
% -reading-center/6-08-01-scoring-sleep-stages-and-arousals.md

%upgraded to the bundle package, so now have access to signal processing
%commands, intend on using EEG1-4 to try and isolate spindles using 
%p = bandpower(x,fs,freqrange)
%x is time series input...?
%fs is sampling frequency which I think should be 1024
%for freq range: [0, (N-1)fs/(2N)] if x is real-valued and N is odd

%bandpower(EEG1,1024,[12,14])
%12-14 represents Hz range of interest (I think)

%fvtool - good function, I think..

%questions for John - 
%1) Do I need to do pre-processing analogous to Rachel's LFP_PreProcess1.m?
% answer - maybe
%2) Create/apply band
% answer - see below, what we want to do is have a moving window which will
% evaluate the power spectral density for 12-14 Hz in periods that are a
% bit larger than what we're interested in, so like 2 secs if sleep
% spindles are usually about 0.5 sec

%nyquist tells you that you need to sample at twice the frequency of
%interest

% From meeting with Dr. Thompson at 8:30AM 2/8/16 starting variables


% For EEG1:

Fs = data.Fs;
numSecs = 1; %edit from 2

windowLength = Fs * numSecs;

totalVals = length(EEG1);
totalNumWins = floor(totalVals/windowLength);

start = 1;
stop = windowLength;

avePowerAllEEG1 = zeros(totalNumWins,1);
for wi = 1:totalNumWins
    
    %Step1
    tempWindow = EEG1(start:stop);
    
    windoW = 500 %edit from 200
    noverlap = 20 %edit from 50
    
    [power,freqS,~] = pwelch(tempWindow,windoW,noverlap,[],Fs,'power');
    
    %Step2
    freqIndex = freqS >= 12 & freqS <= 14;
    %this is logical indexing
    %function "find"
    
    %Step3
    powerOfInterest = power(freqIndex);
    
    %average power
    avePow = mean(powerOfInterest);
    
    %Contain data
    avePowerAllEEG1(wi,1) = avePow;
    
    %need to move window
    start = stop + 1;
    stop = stop + windowLength;
    
    fprintf('Window Number %d is done! \n', wi)
    
    
    
end

%%
% For EEG2

Fs = data.Fs;
numSecs = 2;

windowLength = Fs * numSecs;

totalVals = length(EEG2);
totalNumWins = floor(totalVals/windowLength);

start = 1;
stop = windowLength;

avePowerAllEEG2 = zeros(totalNumWins,1);
for wi = 1:totalNumWins
    
    %Step1
    tempWindow = EEG2(start:stop);
    
    windoW = 200
    noverlap = 50
    
    [power,freqS,~] = pwelch(tempWindow,windoW,noverlap,[],Fs,'power');
    
    %Step2
    freqIndex = freqS >= 12 & freqS <= 14;
    %this is logical indexing
    %function "find"
    
    %Step3
    powerOfInterest = power(freqIndex);
    
    %average power
    avePow = mean(powerOfInterest);
    
    %Contain data
    avePowerAllEEG2(wi,1) = avePow;
    
    %need to move window
    start = stop + 1;
    stop = stop + windowLength;
    
    fprintf('Window Number %d is done! \n', wi)
    
    
    
end

% For EEG3


Fs = data.Fs;
numSecs = 2;

windowLength = Fs * numSecs;

totalVals = length(EEG3);
totalNumWins = floor(totalVals/windowLength);

start = 1;
stop = windowLength;

avePowerAllEEG3 = zeros(totalNumWins,1);
for wi = 1:totalNumWins
    
    %Step1
    tempWindow = EEG3(start:stop);
    
    windoW = 200
    noverlap = 50
    
    [power,freqS,~] = pwelch(tempWindow,windoW,noverlap,[],Fs,'power');
    
    %Step2
    freqIndex = freqS >= 12 & freqS <= 14;
    %this is logical indexing
    %function "find"
    
    %Step3
    powerOfInterest = power(freqIndex);
    
    %average power
    avePow = mean(powerOfInterest);
    
    %Contain data
    avePowerAllEEG3(wi,1) = avePow;
    
    %need to move window
    start = stop + 1;
    stop = stop + windowLength;
    
    fprintf('Window Number %d is done! \n', wi)
    
    
    
end


% for EEG4


Fs = data.Fs;
numSecs = 2;

windowLength = Fs * numSecs;

totalVals = length(EEG4);
totalNumWins = floor(totalVals/windowLength);

start = 1;
stop = windowLength;

avePowerAllEEG4 = zeros(totalNumWins,1);
for wi = 1:totalNumWins
    
    %Step1
    tempWindow = EEG4(start:stop);
    
    windoW = 200
    noverlap = 50
    
    [power,freqS,~] = pwelch(tempWindow,windoW,noverlap,[],Fs,'power');
    
    %Step2
    freqIndex = freqS >= 12 & freqS <= 14;
    %this is logical indexing
    %function "find"
    
    %Step3
    powerOfInterest = power(freqIndex);
    
    %average power
    avePow = mean(powerOfInterest);
    
    %Contain data
    avePowerAllEEG4(wi,1) = avePow;
    
    %need to move window
    start = stop + 1;
    stop = stop + windowLength;
    
    fprintf('Window Number %d is done! \n', wi)
    
    
    
end

%% so now we need to do some "sigma" analysis
%1)      Find baseline interval (e.g., first 614400 samples; or 10 mins).
%2)      Compute mean and sd of baseline interval. std(baseline) and mean(baseline)
%3)      Compute criteria: baseCrit = mean(baseline)  + (std(baseline)*3)
%4)      Find index for mean power values for your range of interest that exceed the baseCrit.
%      a.       find( avePowerAll > baseCrit )

% This is not a pre-processing step. Essentially you are exploring the EEG 
% space using the power spectrum for a narrow frequency range 
% (e.g., 11-12), looking for events of interest.


% Baselength = 1024*60*10 = ten minutes worth of sampling

%1)
BaselineEEG1 = EEG1(1:614400,1);

%2)
meanBaselineEEG1 = mean(BaselineEEG1)
stdBaselineEEG1 = std(BaselineEEG1)

%3)

posbaseCrit = meanBaselineEEG1 + (stdBaselineEEG1*3)
negbaseCrit = meanBaselineEEG1 - (stdBaselineEEG1*3)

%4)
find(avePowerAllEEG1>posbaseCrit)
find(avePowerAllEEG1<negbaseCrit)


% Questions for John 
% 1) If I want to run all/any of the ten patients do I set script up with X
% variable in beginning and then state what X equals before running script?

% 2) Are my scripts being uploaded to Git appropriately?

% 3) So when I run the above code, there are no points that are above/below the
% three sigma benchmark - appropriate move seems to be to try 2.5? NO DICE

% 4)Clarify the function of: windoW = 500; noverlap = 20 

%% Retrying the sigma analysis using 2.5 instead of 3 deviations...
 

%1)
BaselineEEG1 = EEG1(1:614400,1);

%2)
meanBaselineEEG1 = mean(BaselineEEG1)
stdBaselineEEG1 = std(BaselineEEG1)

%3)

posbaseCrit = meanBaselineEEG1 + (stdBaselineEEG1*2.5)
negbaseCrit = meanBaselineEEG1 - (stdBaselineEEG1*2.5)

%4)
find(avePowerAllEEG1>posbaseCrit)
find(avePowerAllEEG1<negbaseCrit)

%...still nothing useful?

%% Retrying the sigma analysis using longer baseline period



%1)
BaselineEEG1 = avePowerAllEEG1; %increased time period

%2)
meanBaselineEEG1 = mean(BaselineEEG1)
stdBaselineEEG1 = std(BaselineEEG1)

%3)

posbaseCrit = meanBaselineEEG1 + (stdBaselineEEG1)
negbaseCrit = meanBaselineEEG1 - (stdBaselineEEG1)

%4)
find(avePowerAllEEG1>posbaseCrit)
find(avePowerAllEEG1<negbaseCrit)

%no dice
%%
% need to take some time and do some pre-processing
% need to take to Ilknur about pre-processing
% quick and dirty way to do it would be to
% CONVERT THE avePOWERALL TO A LINEAR SCALE!!!!!!!
% look at the physiology - how sleep spindles cluster

%% 2/22/16 - the following is after Dr. Thompson pulled the individual LFP and EEG data

load (Pat1_vars_mat)
load (Pat1_lfp.mat)

Pat1_LFP0 = lfpData_pt1.LFP0;
Pat1_LFP1 = lfpData_pt1.LFP1;
Pat1_LFP2 = lfpData_pt1.LFP2;
Pat1_LFP3 = lfpData_pt1.LFP3;


% Questions for John - go over the specifics of filtering, Butterworth or
% not, infinite signals or not, what is the "magnitude specifications" part

% Dr. Thompson provided "high_pass.m" and "low_pass.m" - currently in
% f/Abosch but should be found in email from 2/24/16 as well; in order to
% call the function use "filteredData = high_pass(Pat1_LFP1,1024,101);


% Questions for John - how do I overlay plots? How do I highlight regions
% between plots that are different?

%Tasks - 1) De-trend 2) Filter (bandpass) 3) ????? 4) Profit [avoid fvtool
%and do the full code instead]


% Detrend

DT_Pat1_LFP0 = detrend(lfpData_pt1.LFP0);
DT_Pat1_LFP1 = detrend(lfpData_pt1.LFP1);
DT_Pat1_LFP2 = detrend(lfpData_pt1.LFP2);
DT_Pat1_LFP3 = detrend(lfpData_pt1.LFP3);

% Bandpass filter

LowFilt_Pat1_LFP0 = low_pass(Pat1_LFP0, 1024, 105);
HighFilt_Pat1_LFP0 = high_pass(Pat1_LFP0,1024,1);


% fourier based plot


x = whatever data 

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;

plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')







