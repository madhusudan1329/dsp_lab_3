function keylock(fundamental_frequency)
    fs = 44100; % Sampling frequency (you can adjust this)
    recording = audiorecorder(fs, 16, 1); % Initialize audio recorder
    disp('Start whistling...');
    recordblocking(recording, 3); % Record for 3 seconds
    disp('Recording finished.');
    test_audio = getaudiodata(recording); % Get the recorded audio
   
    % Calculate the FFT of the test audio
    N = length(test_audio);
    fft_result = fft(test_audio);
    fft_magnitude = abs(fft_result(1:N/2+1));
    frequencies = linspace(0, fs/2, N/2+1);

    % Find the fundamental frequency using peak picking (you can customize this)
    threshold = max(fft_magnitude) * 0.1; % Adjust the threshold
    peaks = find(fft_magnitude > threshold);
    fundamental_frequency_test = frequencies(peaks(1)); % Assuming the first peak is the fundamental
   
    % Check if the fundamental frequency matches the reference within a 5% error
    error_threshold = 0.05 * fundamental_frequency; % 5% error
    if abs(fundamental_frequency_test - fundamental_frequency) <= error_threshold
        disp('ACCESS GRANTED');
    else
        disp('ACCESS DENIED');
    end
end
