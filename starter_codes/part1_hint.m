%Load audio
[y, fs] = audioread('audio1.wav');
sz = 100;
x = [];
x = [x extract_audio_patches(y,sz,5000)];
% Look at first 10 images for the first part
% x = [x extract_patches(imread('im.11.tif'),8,500)];

%get covariance matrix (transpose matrix such that cov produces correct result)
%singular value decomposition on covariance matrix
[U,S,V] = svd(cov(transpose(x), 1)); %% FILL IN the computation of covariance matrix and svd here 


%display all eigenvectors as images 
figure
colormap('gray');


h = input("Would you like to hear the eigenvectors? (y/n)", 's');
for idx = 1:64
    subplot(8,8, idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    % plot the signal
    plot(reshape(z,1,sz));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));
    
    if strcmp(h, "y")
        input("Press any button to hear next eigenvector")
        sound(z, fs);
    end
end


% Plot Eigenvalues
figure 
eigenvalues = diag(S);
plot(eigenvalues(1:64));
title("top 64 eigenvalues");
xlabel("Eigenvalue Ranking (1 to 64)");
ylabel("Eigenvalue");

% codes for taking the audio and uses 10 principal components to reconstruct it.
% one line of code commented out.
% 

szy = size(y, 1);
results = zeros(szy,1);
step = sz;
numPC = 40;
n_patch = zeros(step,1);
for idx = 0:(szy/step)-1
    
    patch = y(((idx*step)+1):((idx+1)*step),1);

    patch =double( reshape(patch, 1,step));

    
    %dot product and recreate patch
    coeffs = patch * U(:, 1:numPC);
    n_patch = coeffs * U(:, 1:numPC).';
    %write back results
    n_patch = reshape(n_patch,step, 1);
    results(((idx*step)+1):((idx+1)*step),1) = n_patch;

end

% sound the reconstructed
sound(results, fs);

% compare the reconstructed with the original
figure
subplot(2, 1, 1)
plot(y);
title("original")
subplot(2, 1, 2)
plot(results);
title("reconstructed with " + numPC + " PCs"); 

