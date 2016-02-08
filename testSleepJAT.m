% starting Variables

% data variable in WS

Fs = 1024;
numSecs = 2;

windowLength = Fs * numSecs;

totalVals = length(data);
totalNumWins = floor(totalVals/windowLength);

start = 1; 
stop = windowLength;

avePowerAll = zeros(totalNumWins,1);
for wi = 1:totalNumWins

    % Step 1
    tempWindow = data(start:stop);
    
    windoW = 650;
    noverlap = 50;
    
    [power,freqS,~] = pwelch(tempWindow,windoW,noverlap,[],Fs,'power');
    
    % Step 2 
    freqIndex = freqS >= 10 & freqS <= 12; %
    
    % Step 3
    powerOfInterest = power(freqIndex);
    
    % ave power
    avePow = mean(powerOfInterest);
    
    % Contain data
    avePowerAll(wi,1) = avePow;
    
    %
    start = stop + 1;
    stop = stop + windowLength;
    
    fprintf('Window Number %d is Done! \n', wi)
    
    
end

stopp = 1;
    

