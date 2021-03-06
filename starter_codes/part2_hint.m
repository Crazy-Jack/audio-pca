
delta = clf;
clear;


limit = 2e-04; 
num_components = 6;

%Load audio
[y, fs] = audioread('audio1.wav');
sz = num_components;
data = [];
data = [data extract_audio_patches(y,sz,5000)];
%0 mean the data
%verify that we take mean of all patches and subtract and not
%individual patches and subtract

[xdim, ydim] = size(data);


data_mean = mean(data')';
scattermean = data_mean * ones(1, ydim);
data = data - scattermean;


%hebbian learning using sanger's rule
w = randn(xdim, num_components);

%iterate until delta is smaller then limit
delta = 1;
numadjust = 0;
iteration = 0;
w_delta = zeros(xdim, num_components);
eta = 2 * 10^-10; % learning rate
% slow version, ok for learning a few components  
% maybe there is a way to speed up the learning of all 64 components
% you can also use the while loop: while abs(delta) > limit
% here, we will just learn six neurons (j), printing out the weights every 30 iterations 
% of the data set, you may want to modify that. 

for outerloop = 1:50
  for innerloop = 1:30
    for idy = 1:ydim
        xcur = data(:,idy);
        ycur = w'*xcur;
        % suppose to comment out
        for j = 1:num_components
            sum_term = sum(bsxfun(@times, w(:, 1:j), ycur(1:j).'), 2);
            w_delta(:, j) = eta * (ycur(j) * xcur(:) - ycur(j)* sum_term);
        end
        w = w + w_delta;
    end
    delta = sum(sum(abs(w_delta)))

  end
   
end


 %display results (all)
figure
colormap('gray');

for idx = 1:num_components
    subplot(1,num_components, idx);
    z = w(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    plot(reshape(z,1,sz));
end




