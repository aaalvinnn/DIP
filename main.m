clc
% 添加函数路径
addpath('Functions\')

% 读取彩色图像
colorImage = imread('Input\hust.bmp');

%使用自行编写函数
grayImage = rgbToGray(colorImage) ;

 % 将图像顺时针旋转...度
myRotateImageBilinear('Output\gray1.jpg', 150 + 999);




