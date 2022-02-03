

audio = randn(3000, 1);
sz = 20;
K = 1000;
X = extract_audio_patches(audio,sz,K);
size(X)