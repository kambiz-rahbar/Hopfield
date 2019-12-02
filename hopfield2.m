clc
clear
close all

numbers = {'0.tif','1.tif','2.tif','3.tif','4.tif','5.tif','6.tif','7.tif','8.tif','9.tif'};

X = zeros(770,10);
for k = 1:10
    im = imread(strcat('dataset//',numbers{k}));
    im = imresize(im,0.25);
    im = im2bw(im);
    
    figure(1);
    subplot(2,5,k); imshow(im); title('train sample');
    
    X(:,k) = reshape(im,[],1);
end
X = 2*X-1;

net = newhop(X);

view(net);

my_noise = randn(size(X));
test_data = X;% + my_noise;
for k = 1:10
    test = test_data(:,k);
    %test(1:11*35)=-1;
    test = circshift(test,5);
    
    test_img = reshape(test,size(im));
    test_img = (test_img+1)/2;
    
    y_hat = net({1 100},[],test);
    
    y_hat_final = y_hat{100};
    y_hat_final = reshape(y_hat_final,size(im));
    y_hat_final = (y_hat_final+1)/2;
    
    figure(2);
    subplot(2,10,k); imshow(test_img,[]); title(sprintf('test input (%d)',k-1));
    subplot(2,10,k+10); imshow(y_hat_final,[]); title('net output');
end

