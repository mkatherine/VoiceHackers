% Parameters
fs = 80;           % Sampling frequency (Hz)





% Time and signal generation
t = (0:1/fs:2-1/fs);  % Time vector sampled  80Hz for 2 seconds



x = sin(2*pi*10*t)+ sin(2*pi*20*t) + sin(2*pi*40*t);  % Example sinusoidal signal
t = (0:1/fs:2-1/fs);  % Time vector sampled  80Hz for 2 seconds



x = sin(2*pi*10*t)+ sin(2*pi*20*t) + sin(2*pi*40*t);  % Example sinusoidal signal




subplot(2,1,1);
plot(x, t, 'b');

subplot(2,1,2);
plot(, t, 'b');




% Zero-padding and DFT
x_256 = [x, zeros(1, 256 - fs*2)];  % Zero-padding to 256
x_512 = [x, zeros(1, 512 - fs*2)];  % Zero-padding to 512

X_256 = fft(x_256, N_256);  % 256-point DFT

X_512 = fft(x_512, N_512);  % 512-point DFT

% Frequency vectors
f_256 = (0:N_256-1) * fs / N_256;  % Frequency axis for 256-point DFT
f_512 = (0:N_512-1) * fs / N_512;  % Frequency axis for 512-point DFT

% Plotting the magnitude spectrum
figure;

% 256-point DFT plot
subplot(2, 1, 1);
plot(f_256, abs(X_256), 'b');

title('256-Point DFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);  % Plot up to Nyquist frequency
grid on;

% 512-point DFT plot
subplot(2, 1, 2);
plot(f_512, abs(X_512), 'r');
title('512-Point DFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);  % Plot up to Nyquist frequency
grid on;

% Highlighting 20 Hz DFT coefficient
fprintf('20 Hz corresponds to index %d in the 256-point DFT.\n', round(20 / (fs / N_256)));
fprintf('20 Hz corresponds to index %d in the 512-point DFT.\n', round(20 / (fs / N_512)));
