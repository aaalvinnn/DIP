clc
% ��Ӻ���·��
addpath('Functions\')

% ��ȡ��ɫͼ��
colorImage = imread('Input\hust.bmp');

%ʹ�����б�д����
grayImage = rgbToGray(colorImage) ;

 % ��ͼ��˳ʱ����ת...��
myRotateImageBilinear('Output\gray1.jpg', 150 + 999);




