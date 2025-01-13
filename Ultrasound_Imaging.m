%% Ultrasound Image Processing
% Author: Lauryn Peters
% Date: April 14, 2024

% Purpose: To take a raw liver ultrasound image and process it to make it
% more readable. 

close all; clear all; clc;

%% Image processing

liver = imread('liver_ultrasound.png'); % load raw image
med_filt = medfilt2(liver); % median filtering to remove "salt and pepper speckles"

% display pre- and post-median filtering
figure;
imshowpair(liver,med_filt,"montage","scaling","none")
title('Unfiltered Liver US                                                                       Median Filtered US');

[counts, binLoc] = imhist(med_filt); % explore intensity

% show histogram diplaying that image doesn't use full range of intensities
figure;
imhist(med_filt)
title('Pixel Intensity Histogram (Filtered)')
xlabel('Pixel Intensity Value')
ylabel('Frequency')

im_arr = med_filt ~= 0; % creates boolean array where any non-zero value = TRUE and zero values = FALSE
adjusted = med_filt; % generates copy of original image
adjusted(im_arr) = imadjust(med_filt(im_arr)); % adjusts image contrast by increasing range of intensities

% show histogram diplaying that image now uses full range of intensities
figure;
imhist(adjusted)
title('Pixel Intensity Histogram (Adjusted)')
xlabel('Pixel Intensity Value')
ylabel('Frequency')

% compare filtered and adjusted images
figure;
imshowpair(med_filt, adjusted, "montage","scaling","none")
title('Median Filtered US                                                                         Adjusted US');

sharp = imsharpen(adjusted); % sharpen image

% display pre- and post-sharpening 
figure;
imshowpair(adjusted, sharp, "montage","scaling","none")
title('Adjusted US                                                                               Sharpened US');

%% Before and after

figure;
imshowpair(liver, sharp, "montage","scaling","none")
title('       Original Image                                                                      Fully Processed Image');  