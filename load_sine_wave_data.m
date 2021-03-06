%LOAD_SIN_WAVE_DATA Load data generated by a sine wave
%
%       [DATA, CP] = LOAD_SINE_WAVE_DATA( LENGTH, AMPLITUDES, FREQUENCIES,
%   SNRS)
%
%   This function generates data of length DATA_LENGTH (default 10), 
%   as generated by sine wave(s).
%
%   The segments are defined by AMPLITUDES, FREQUENCIES and SNRS.
%   The first is a vector is amplitudes.
%   The second argument is vector of frequencies for each segment
%   The last argument is a vector which indicates the signal-to-noise ratio
%   (modellen by gaussian-white-noise).

function [ datapoints, change_points ] = load_sine_wave_data( data_length, amplitudes, frequencies, snrs )

    if nargin < 1; data_length  = 10; end
    if nargin < 2; amplitudes   = [1 3 1 5 2]; end
    if nargin < 3; frequencies  = ones(length(amplitudes), 1) * 10; end
    if nargin < 4; snrs         = zeros(length(amplitudes), 1 ); end
    
    if ~isequal(length(amplitudes), length(frequencies), length(snrs) )
        error ('All input arguments must be of the same length');
    end
    
    datapoints = zeros(data_length, 1);
    change_points = zeros(length(amplitudes), 1);
    
    per_segment = ceil(data_length/ length(amplitudes));
    i = 1;
    for segment = 1 : length(amplitudes)
        t = 1:0.001:per_segment;
        a = amplitudes(segment);
        
        f = frequencies(segment);
        snr = snrs(segment);
        
        y = a * sin(2 * pi * f * t);
        
        if snr > 0
            y = awgn(y, snrs(segment));
        end
        
        
        datapoints(i:i+length(y)-1) = y;
        change_points(segment) = i;
        i = i + length(y);
    end
    
    change_points(1) = [];

end

