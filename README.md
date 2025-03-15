# Instructions to run the code:
download all code in this repository and put them in one project folder. Then, add all subfolders as path in MATLAB.
1. SpeechExtraction.mlx will generate results for tests 1-4. It loads the audio files, trims the audio to remove silence, does the STFT, plots the mel-spaced filter bank, applies the filterbank to the STFT and plots the cepstrum. The output is the mfcc.
2. VectorQuantization.mlx does test 5- 6
3. Main_updated does test 7-10.

##Functions
1. melfb: creates the melspaced filter bank
2. our_mfcc: not to confuse with MATLAB internal mfcc.m function, our_mfcc solves for the mfcc coefficients
3. loadwav: loads all the .wav file in a folder to extract the signal and fs
4. LBG
5. getrr_id: gets the recognition rate of input test and train data 



# Background
Machine learning models are very popular today to perform speech identification. However, we can achieve comparable if not better results with a less complex method using simple signal processing methods. In this paper, we implemented signal processing tools to identify speaker ID for an unknown speaker audio file. Our approach is divided into four major parts: speech preprocessing, feature extraction, vector quantization and full test and demonstration. 

# Test Method

**Data Sets**
Three data sets are utilized. The main dataset to test system functionality is dataset #1. Dataset #2 and #3 is further used to test the robustness of the model. 
1. Zero: 11 training data, 8 test data 
2. 2024 Zero and Twelve: 
3. 2025 Five and Eleven:


## Test Approach
<img width="715" alt="Screenshot 2025-03-14 at 10 44 25 PM" src="https://github.com/user-attachments/assets/52390aef-cdc8-42b8-9e02-7d12453a7672" />



**Speech Preprocessing**
In this stage each speaker audio file is loaded and stored into a cell array. To improve the sensitivity of our model, we removed the silence parts in the beginning and end of each audio file.

**Feature Extraction**
The goal of this stage is to obtain mel frequency cepstral coefficients (MFCC), which are distinct features that characterize each speaker. Each speaker will have their own set of MFCC ie. if we have 10 speakers, there will be 10 sets of MFCC. The size of the MFCC depends on the length of the audio file, the size of the framing, windowing, etc, so it differs for each speaker audio file. The MFCC of all the speakers will be stored in a cell array. The MFCC is obtained by referring to the, method in the figure below. 
<img width="635" alt="Screenshot 2025-03-14 at 10 44 35 PM" src="https://github.com/user-attachments/assets/88c3e968-edcb-4cb6-9016-95138c44278e" />

**Mel Frequency Bank**
A mel frequency bank is a series of bandpass filters that will impose a signal into human auditory perception capabilities. It reduces spectral detail on the input audio and preserves only the relevant features. It also warps the frequency so that lower frequencies are more dominant than higher frequencies, as the human ear is more sensitive to audio signals with lower frequencies. It does this by having a linear frequency spacing below 1000Hz and a logarithmic spacing above 1000Hz to about 6400Hz.. Each triangular bandpass filter is a spectral histogram bin. The number of mel spectrum coefficients K is chosen by the designer.
<img width="379" alt="Screenshot 2025-03-14 at 10 44 50 PM" src="https://github.com/user-attachments/assets/581c7a65-0e3a-47ea-8594-dffd4afd4bbb" />

**Vector Quantization**
In this stage  the codebook is obtained, which is a collection of centroids for each MFCC set. The number of centroids is a parameter that the designer decides. The following flowchart is utilized to obtain the centroid. 
<img width="396" alt="Screenshot 2025-03-14 at 10 45 03 PM" src="https://github.com/user-attachments/assets/bd9762b7-a682-4e7d-b9b6-fd0a9364455a" />
<img width="580" alt="Screenshot 2025-03-14 at 10 45 12 PM" src="https://github.com/user-attachments/assets/f5d5e8da-71c7-4844-a12b-cb471026926c" />


# Test Results 

## Human Recognition Rate (Test 1) 
To compare the recognition rate of this system with a baseline, human recognition rate is obtained from two subjects. The subjects listened to the 11 train audio files from dataset#1, and tried to match the 8 test data to the corresponding ID. Subject one obtained a recognition rate of 75% while subject two obtained 62.5%, with both averaging to a 68.75% recognition rate. 

## Speech Preprocessing (Test 1 - 2) 
Using MATLAB function called loadwav() is generated to load the signal and sampling frequency of all the .wav audio files in the train data folder into cell arrays. The sampling frequency of all audio files in dataset #1 is found to be 12500Hz which means 256 samples corresponds to 0.02 seconds (Test 1)
256 samples * (1/12500) seconds =0.02 seconds  



**The signals of each 11 train data from dataset #1  is then plotted in the time domain (Test 2)**
![image](https://github.com/user-attachments/assets/74d3cb23-5fe4-42de-80d8-408750a25447)
It is observed that the signal strength varies and will need to be normalized to maintain consistency. 



**Silence Removal**
To further improve the sensitivity of our model, the silence from the beginning and the end of the audio files are removed. This is done by trimming the signal to the start and end of the speech. The energy of a discrete time signal is defined as the square of the signal amplitude (Figure #) . An energy threshold is set to 0.0005. 

<img width="226" alt="Screenshot 2025-03-14 at 10 46 52 PM" src="https://github.com/user-attachments/assets/51975c94-d50e-4033-8694-e7ded34a5bc3" />

The start audio index is determined by the first time the signal transitions to an energy above 0.0005 while the end is the last index that transitions to a sample with energy lower than 0.0005. The 0.0005 threshold is determined by iterating between different values and visually seeing how much of the signal is removed. The signal is also normalized to obtain the waveform below:

![image](https://github.com/user-attachments/assets/66ad82f2-8c22-4b36-acf2-8042817248f0)



## Speech Recognition (Test 2-4) 
Matlab function STFT is used to obtain the periodogram of the signal. This function performs frame blocking, windowing and takes the FFT of the signal. Different frame blocking sizes are tested N = 128, 256, and 512 while the frame increment M is kept constant at N/3. Since the signal is symmetric around zero, only the positive frequencies are plotted. 

![image](https://github.com/user-attachments/assets/13246bba-a570-4de1-a4e1-98e3bb9730ce)

Varying frame sizes presents a trade-off between variance and resolution. A smaller frame size reduces frequency resolution but increases variance. At N=128, the signals appear strongest because fewer frames result in higher variance, making each frame more concentrated. Conversely, with more frames, the signal energy is more evenly distributed, making individual components appear weaker as seen in N = 512. As a middle ground, a frame size of 256 is selected for this project. 

![image](https://github.com/user-attachments/assets/08b9beb1-f883-4bfe-baa2-006d20a26904)

## Applying Mel Frequency Bank (Test 3)
The mel-spaced filterbank is generated using the provided function melfb.m on the project. The function outputs a sparse matrix containing filterbank amplitudes with its different bandwidths. The filters below 1000 Hz are linear, and after are logarithmic.  K is set to 20 and the result of the function is 20 triangular shape bandpass filters spaced out as expected. 
![image](https://github.com/user-attachments/assets/275d7fef-d893-4e4c-8734-2e873b8ac2ea)

After applying the mel-spaced filterbank by multiplication, the mel-frequency coefficients are  obtained. The periodogram of the signal appears stronger after  irrelevant parts are removed, and lower frequency signals are amplified. 
![image](https://github.com/user-attachments/assets/2ac3e30a-9579-45a5-8ae6-87aaf18953b0)

## Completing the Cepstrum
The final MFCC coefficients are obtained by taking the log of the mel-frequency coefficients and taking the DCT to convert the log back to time. 
To obtain the MFCC we utilized the following equation:
<img width="683" alt="Screenshot 2025-03-13 at 1 59 22 PM" src="https://github.com/user-attachments/assets/7cfbf9d3-9540-46cc-ab12-870523edd22d" />

The result is a cell array of MFCCs unique to each speaker. We then remove the K = 0 coefficient from the cell array as it is the coefficient that is affected by the change in speaker volume. 

## Vector Quantization Test 5-6
In this stage the centroid of each MFCC for every speaker is obtained and collated into a codebook. The function LBG.m generates the codebook. The design parameters here are e () and K or M (number of clusters) 

**Initial plotting of MFCC (Test 5)** 
It is observed that the MFCCs are spread out and can be classified into clusters.

<img width="1071" alt="Screenshot 2025-03-14 at 10 53 29 PM" src="https://github.com/user-attachments/assets/c993ca35-662a-4e0b-941c-860d00930afa" />

**Finding the codebook and plotting with the centroids k  = 4 (Test 6)** 
Using LBG.m we were able to find k number of centroids for each MFCC group. Below is a plot of the MFCCs and each centroid in a 2D plane. 
<img width="1135" alt="Screenshot 2025-03-14 at 10 53 54 PM" src="https://github.com/user-attachments/assets/bc5441a9-fe97-4984-9cc5-c48de14f62b1" />
<img width="1142" alt="Screenshot 2025-03-14 at 10 54 05 PM" src="https://github.com/user-attachments/assets/a327bf4d-fcd4-4ded-aab3-b5847f87c1cf" />



## Full Test and Demonstration (Test 7-10)

Speaker Identification Using Codebook (Test 7)
The speaker ID with the centroid that has the least sum of distances to all of the MFCCs is set to be the predicted speaker of the audio. Getrr_id.m function is generated to get the recognition rate. 
<img width="387" alt="Screenshot 2025-03-14 at 10 54 38 PM" src="https://github.com/user-attachments/assets/1ff5edfe-9c38-49c5-9ab8-bbf90de59e30" />

Test 7 part (a) With the original dataset #1 containing 11 train data and 8 test data, e = 0.01 and M = 6, we obtained a test data speaker recognition rate of 75%. The train data speaker recognition rate is 100%
Test 7 part (b) then, we added 5 more recording voices of our team mates. With additional test and train data pairs totalling in 16 training data and 13 test data, e=0.01 and M = 6, it obtained a speaker recognition rate of 84.6%.

**Full Test with Notch Filter (Test 8)** 

Created a notch filter operating at the following freuencies: [20,50,60,200]. **This increaseed our speaker recognition rate "Speaker Recognition Rate: 87.50%"**,creating a more refined system. Any other combination caused efficiency to stay at or drop below 75% which was our original test recognition rate.
<img width="455" alt="image" src="https://github.com/user-attachments/assets/ba6642fe-889c-4b0d-92c2-c2da63029203" />


**Full Test with data set #2 (Test 9)** 
With additional 10 test and train pairs from dataset #2, totaling 22 train data and 19 test data, using e = 0.01 and M = 6, we obtained a speaker recognition rate of 78.95%. It is observed that adding more training and testing data pairs lower the accuracy of the system. Tuning the parameters below e<0.01 and M>6 does not improve the system. 

**Full Test with Dataset #2 and #3 (Test 10)**
Matlab function getrr_id used to train the and test the speaker recognition on the datasets.
10a- speaker is classified by last 2 numbers of the ID and the word (zero or twelve) is classified by the number in the hundreds place of the ID 
105- speaker 5 says 12
003- speaker 3 saying zero
<img width="447" alt="Screenshot 2025-03-14 at 10 58 08 PM" src="https://github.com/user-attachments/assets/e76df9c8-be54-4146-9b7f-a4e871c73bac" />




Test 10a:

Question 1: If we use "twelve" to identify speakers, what is the accuracy versus "zero"? 
**Accuracy for Zero: 88.89**
**Accuracy for Twelve: 77.78**

Question 2: If we train a whole system how accurate is your system?
**Combined Accuracy: 83.33**

<img width="211" alt="image" src="https://github.com/user-attachments/assets/76c84b32-ea10-4999-9a9a-c8819046ddfe" />
![image](https://github.com/user-attachments/assets/45837b24-068f-4807-9264-77177b55f9b2)

Test 10b: 
Question 3:
**11 Accuracy: 100%** most likely because it takes the longest to say
**5 Accuracy: 78.26**

Question 4:**Much better** accuracy compared against test in 10a using zero/twelve

![image](https://github.com/user-attachments/assets/79be85ca-1541-4140-bb36-b8ceb191b74c)
![image](https://github.com/user-attachments/assets/18202fa1-5bd4-4c56-804d-07f93b38bad3)

Analysis -
Original data testing 75%
2024 12/0: 77.78/88.89
2025 11/5: 100/78.26
The 2025 had the best accuracy and 11 and the most syllables meaning that each individual recording got more samples. 2024 had less tests in it and a worse accuracy and the original data set had the least tests and least accuracy. 


# Conclusion
Adding additional train and dataset pairs can improve or reduce the accuracy of the system. If we add audio files with more distinct features and pronunciation, it is likely that the accuracy of the system will be improved ie. when we used an “eleven” data set that has 3 syllables. 

We utilize the cepstrum for speaker recognition instead of direct FFT as the logarithm function to solve for the cepstrum will amplify weaker signal components that are otherwise dominated by stronger features. Taking the log will us to focus on less dominant features. Utilizing DCT in the cepstrum will also provide better energy concentration and ease clustering. 

We remove the first component K = 0 because it contains the difference in volume between the two speakers. 




# References
[1] L.R. Rabiner and B.H. Juang, Fundamentals of Speech Recognition, Prentice-Hall, Englewood Cliffs, N.J., 1993.
[2] L.R Rabiner and R.W. Schafer, Digital Processing of Speech Signals, Prentice-Hall, Englewood Cliffs, N.J., 1978.
[3] S.B. Davis and P. Mermelstein, “Comparison of parametric representations for monosyllabic word recognition in
continuously spoken sentences”, IEEE Transactions on Acoustics, Speech, Signal Processing, Vol. ASSP-28, No. 4, August 1980.
[4] Y. Linde, A. Buzo & R. Gray, “An algorithm for vector quantizer design”, IEEE Transactions on Communications, Vol.
28, pp.84-95, 1980.
[5] S. Furui, “Speaker independent isolated word recognition using dynamic features of speech spectrum”, IEEE Transactions
on Acoustic, Speech, Signal Processing, Vol. ASSP-34, No. 1, pp. 52-59, February 1986.
[6] S. Furui, “An overview of speaker recognition technology”, ESCA Workshop on Automatic Speaker Recognition,
Identification and Verification, pp. 1-9, 1994.
[7] F.K. Song, A.E. Rosenberg and B.H. Juang, “A vector quantisation approach to speaker recognition”, AT&T Technical
Journal, Vol. 66-2, pp. 14-26, March 1987.
[8] Frequently Asked Questions WWW site, http://svr-www.eng.cam.ac.uk/comp.speech/


