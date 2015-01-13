function chromavec = chroma(file)
% finds the chroma vector of a .wav file

[x, fs] = wavread(file);
N = length(x);
f = -fs/2:fs/(N-1):fs/2;    %frequency(x) axis of spectrum
z = fftshift(fft(x));
z1 = abs(z);                %converts to power measurement

c0 = [15.893 16.835];       %frequency (hz) range of C in the first octave

notes = [15.893 16.835 17.835 18.9 20.025 21.215 22.475 23.81 25.23 26.73 28.32 30.005 31.785];

chromavec = [];

for pc = 0:11
    zoctave = [notes(pc+1) notes(pc+2)];
    ranges = [zoctave];
    for i = 1:7
        ranges = [ranges zoctave*(2^i)];   %finds ranges for remaining octaves by multiplying by powers of 2
    end

    averages = [];
    for j = 1:2:16
        temp = find(f>=ranges(j) & f<ranges(j+1));    %takes all frequencies within the ranges found above
        for k = 1:length(temp)
            temp(k) = z1(temp(k));        %replaces frequencies with their corresponding power measurements
            end
        averages = [averages mean(temp)];   %averages for each octave
    end
    chromavec = [chromavec mean(averages)];       %averages the values for each octave into a single value
end

total = sum(chromavec);
chromavec = chromavec/total;        %reduces range of values to between 0 and 1