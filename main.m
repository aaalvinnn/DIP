clc
% 添加函数路径
addpath('Functions\')

% 读取彩色图像
colorImage = imread('Input\hust.bmp');

%使用自行编写函数
grayImage = rgbToGray(colorImage) ;

 % 将图像顺时针旋转...度
rotatedImage = myRotateImageBilinear('Output\gray1.jpg', 150 + 999);

% 将图像放大zoom倍
input = 'Input\hust.bmp';
enlargeImage_NN = enlarge_NN(input, 2);      % 最近邻算法 NN:Nearest Neighbor, 2 为 放大倍数，目前只能取整数
enlargeImage_BI = enlarge_BI(input, 2);      % 双线性插值 BI:Bilinear Interpolation

% 合并图像展示
% combinedImage = [enlargeImage_NN, enlargeImage_BI]; % 水平排列
combinedImage = [enlargeImage_NN; enlargeImage_BI]; % 垂直排列
imwrite(combinedImage, 'Output\combined_image.jpg');
imshow(combinedImage);

