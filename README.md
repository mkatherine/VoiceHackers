Instructions to run the code:
download all code in this repository and put them in one project folder. Then, add all subfolders as path in MATLAB.
1. SpeechExtraction.mlx will generate results for tests 1-4. It loads the audio files, trims the audio to remove silence, does the STFT, plots the mel-spaced filter bank, applies the filterbank to the STFT and plots the cepstrum. The output is the mfcc.
2. VectorQuantization.mlx does test 5- 6
3. Main does test 7-10.

Functions
1. melfb: creates the melspaced filter bank
2. our_mfcc: not to confuse with MATLAB internal mfcc.m function, our_mfcc solves for the mfcc coefficients
3. loadwav: loads all the .wav file in a folder to extract the signal and fs
4. LBG
5. getrr_id: gets the recognition rate of input test and train data 



Human Recognition Rate
Maria Katherine - 75% - might redo

![image](https://github.com/user-attachments/assets/74d3cb23-5fe4-42de-80d8-408750a25447)

Voice Detection: Plot of audio signals after applying filter to remove anything with energy 0.0005 
![image](https://github.com/user-attachments/assets/66ad82f2-8c22-4b36-acf2-8042817248f0)

![image](https://github.com/user-attachments/assets/08b9beb1-f883-4bfe-baa2-006d20a26904)

![image](https://github.com/user-attachments/assets/275d7fef-d893-4e4c-8734-2e873b8ac2ea)

![image](https://github.com/user-attachments/assets/2ac3e30a-9579-45a5-8ae6-87aaf18953b0)

![image](https://github.com/user-attachments/assets/70087792-eeb9-46f0-9470-30d0fb06da81)

VQ
<img width="1239" alt="image" src="https://github.com/user-attachments/assets/59c71cc6-68a5-4540-affd-8008a6d5a575" />

<img width="1230" alt="Screenshot 2025-03-05 at 1 00 47 PM" src="https://github.com/user-attachments/assets/8a85532f-c35b-4e40-aab6-4eef4fd14437" />
<img width="1205" alt="image" src="https://github.com/user-attachments/assets/f184cb74-309c-4cbf-942b-568dae0e14f3" />
<img width="1220" alt="Screenshot 2025-03-05 at 1 01 21 PM" src="https://github.com/user-attachments/assets/198244b4-303d-483c-9e74-2e9d67cb8cac" />


Test 7 - Part I

with the original 11 train data and 8 test data, e = 0.01 and M = 6, we obtained a **test data speaker recognition rate of 75%**
the **train data speaker recognition rate is always 100%** 

![Screenshot 2025-03-06 at 2 28 11 PM](https://github.com/user-attachments/assets/4820d139-7da3-4085-b49b-8d8fccc5f705)


Test 7 - Part II 
we added more train and test data pairs from our team mates. With 5 additional test and train pairs, totalling in 16 train data and 13 test data. We obtained a **speaker recognition rate of 84.6%**

![Screenshot 2025-03-06 at 2 29 07 PM](https://github.com/user-attachments/assets/b61e1abb-ff4f-4a57-96db-9b8b1ed6de23)


Test 9
with additional 10 test and train pairs from the 2024 data, totalling in 22 train data and 19 test data, we obtained a **speaker recognition rate of 78.95%** It seems to perform more poorly compared to adding only 5 additional test and train pairs in test7 partII. 

![image](https://github.com/user-attachments/assets/3f59ab59-7fee-491d-b02b-a9f77b5b4979)


Analysis: 
- compare the test and train accuracy between the original data, 2024data, and 2025data
