function [ outDATA ] = evalGoodEpochsLFP( lfpDAT , sampFreq , epchLeng )
%evalGoodEpochsLFP : Assess epochs of 'epchLeng' for aberrant amplitude
%oscillations.
%   INPUTS:
%       i).   lfpDAT = [n x 1] vector of raw LFP data: format double
%       ii).  sampFreq = sampling frequency in Hz: format integer double
%       iii). epchLeng = length of epoch in seconds: format integer double
%
%   OUTPUTS:
%       i).   outDATA: struct
%           a). events = boolean vector of length equal to number epochs
%           where 1 = epoch to keep and 0 = epoch to discard
%           b). keepEps.meanEp = vector of length of Fs * epoch length
%           representing the mean amplitude of keep epochs
%           c). keepEps.CI95per = matrix [2 x Fs * epoch length]
%           representing the +/- 95% confidence interval for keep epochs
%           d). nKeepEps.meanEp = vector of length of Fs * epoch length
%           representing the mean amplitude of bad epochs
%           e). nkeepEps.CI95per = matrix [2 x Fs * epoch length]
%           representing the +/- 95% confidence interval for bad epochs

totTimeinSecs = floor((length(lfpDAT)/sampFreq));
totNumSegs = round(totTimeinSecs/epchLeng) - 1;
lengSeg = epchLeng*sampFreq;

% Vars to grab
lfpSegs = zeros(totNumSegs, lengSeg);
% Detect beyond mean sd
eventDet = true(totNumSegs,1);

% Compute absolute value of entire trace (all positive)
absSegAll = abs(lfpDAT);
% Compute mean and SD of absolutized trace
mSeg = mean(absSegAll);
sdSeg = std(absSegAll);
% Compute threshold mean + 7*SD
thrseg = mSeg + (sdSeg * 7);
% Set variable as Global Threshold
globalThresh = thrseg;

start = 1;
stop = lengSeg;

for ti = 1:totNumSegs
   
    tSeg = lfp0pat4(start:stop, 1);
    
    absSeg = abs(tSeg);
    
    if any(absSeg > globalThresh)
        eventDet(ti) = false;
    end

    lfpSegs(ti,:) = tSeg;

    start = stop + 1;
    stop = stop + lengSeg;

end

%%

keepDat = lfpSegs(eventDet,:);
datLen = size(keepDat,1);
mKeep = mean(keepDat);

SEM_dat = std(keepDat)/sqrt(datLen);                                  % Standard Error
ts_dat = flipud(transpose(tinv([0.025  0.975],datLen-1)));            % T-Score
CI = bsxfun(@plus, mKeep ,(bsxfun(@times, ts_dat, SEM_dat)));         % Confidence Intervals

%%

dKeepDat = lfpSegs(~eventDet,:);
datLen2 = size(dKeepDat,1);
mdKeep = mean(dKeepDat);

SEM_dat2 = std(dKeepDat)/sqrt(datLen2);                                % Standard Error
ts_dat2 = flipud(transpose(tinv([0.025  0.975],datLen2-1)));           % T-Score
CI2 = bsxfun(@plus, mdKeep ,(bsxfun(@times, ts_dat2, SEM_dat2)));      % Confidence Intervals

outDATA.events = eventDet;
outDATA.keepEps.meanEp = mKeep;
outDATA.keepEps.CI95per = CI;
outDATA.nKeepEps.meanEp = mdKeep;
outDATA.nKeepIps.CI95per = CI2;


end

