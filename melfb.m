function m = melfb(p, n, fs)
% MELFB         Determine matrix for a mel-spaced filterbank
%
% Inputs:       p   number of filters in filterbank
%               n   length of fft
%               fs  sample rate in Hz
%
% Outputs:      x   a (sparse) matrix containing the filterbank amplitudes
%                   size(x) = [p, 1+floor(n/2)]
%
% Usage:        For example, to compute the mel-scale spectrum of a
%               colum-vector signal s, with length n and sample rate fs:
%
%               f = fft(s);
%               m = melfb(p, n, fs);
%               n2 = 1 + floor(n/2);
%               z = m * abs(f(1:n2)).^2;
%
%               z would contain p samples of the desired mel-scale spectrum
%
%               To plot filterbanks e.g.:
%
%               plot(linspace(0, (12500/2), 129), melfb(20, 256, 12500)'),
%               title('Mel-spaced filterbank'), xlabel('Frequency (Hz)');


f0 = 700 / fs; %define scaling factor 
fn2 = floor(n/2); %half the fft size, which is the nyquists freq

lr = log(1 + 0.5/f0) / (p+1); %determines logarithmic spacing of the mel filterbank

% convert to fft bin numbers with 0 for DC term
bl = n * (f0 * (exp([0 1 p p+1] * lr) - 1)); %this defines the FFT bin locations of filter edges, using mel frequency scale


%defining boundaries
b1 = floor(bl(1)) + 1;
b2 = ceil(bl(2));
b3 = floor(bl(3));
b4 = min(fn2, ceil(bl(4))) - 1;

%generate each bin filter weight
pf = log(1 + (b1:b4)/n/f0) / lr;
fp = floor(pf);
pm = pf - fp;

%generate sparce matrix 
r = [fp(b2:b4) 1+fp(1:b3)]; %row
c = [b2:b4 1:b3] + 1; %column
v = 2 * [1-pm(b2:b4) pm(1:b3)]; %filter weights

%generate a sparce filterbank matrix 
m = sparse(r, c, v, p, 1+fn2);
end


