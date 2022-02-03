%Load images

x = [];
x = [x extract_patches(imread('im.1.tif'),8,500)];
x = [x extract_patches(imread('im.2.tif'),8,500)];
x = [x extract_patches(imread('im.3.tif'),8,500)];
x = [x extract_patches(imread('im.4.tif'),8,500)];
x = [x extract_patches(imread('im.5.tif'),8,500)];
x = [x extract_patches(imread('im.6.tif'),8,500)];
x = [x extract_patches(imread('im.7.tif'),8,500)];
x = [x extract_patches(imread('im.8.tif'),8,500)];
x = [x extract_patches(imread('im.9.tif'),8,500)];
x = [x extract_patches(imread('im.10.tif'),8,500)];
% Look at first 10 images for the first part
% x = [x extract_patches(imread('im.11.tif'),8,500)];

%get covariance matrix (transpose matrix such that cov produces correct result)
%singular value decomposition on covariance matrix
[U,S,V] = %% FILL IN the computation of covariance matrix and svd here 

%display results (top 10)
figure
colormap('gray');
for idx = 1:10
    subplot(1,10,idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    imagesc(reshape(z,8,8));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));

    %set(gca, 'visible', 'off'); 
end

%display all eigenvectors as images 
figure
colormap('gray');

for idx = 1:64
    subplot(8,8, idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    imagesc(reshape(z,8,8));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));
    %set(gca, 'visible', 'off'); 
end


% TASK: you have to deal with eigenvalues to answer the questions. 


% codes for taking Image 11 and uses 10 principal components to reconstruct it.
% one line of code commented out.

im = imread('im11.tif');
[x y] = size(im);
results = zeros(x,y);
step = 8;
numeig = 10;
for idx = 0:(x/step)-1
    for idy = 0:(y/step)-1
        patch = im(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8));
        
        patch =double( reshape(patch, 1,64));
        
        n_patch = zeros(64,1);
        %dot product and recreate patch
        for idcoeff = 1:numeig
             n_patch = %%   TASK: synthesized a new patch based on 10 PCs 
        end  
        
        %write back results
        n_patch = reshape(n_patch,8,8);
        results(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8)) = n_patch;
    end
end

results10 = results;

figure
colormap('gray');
%contrast normalization
results = results - min(min(results));
results = results / max(max(results));
imshow(results);
title('Recreated with PCA (10)');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%code for showing original image.

figure
colormap('gray');
imshow(im);
title('Original image');


