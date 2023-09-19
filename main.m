clc
% ��Ӻ���·��
addpath('Functions\')

% ��ȡ��ɫͼ��
colorImage = imread('Input\hust.bmp');

%ʹ�����б�д����
grayImage = rgbToGray(colorImage) ;

 % ��ͼ��˳ʱ����ת...��
rotatedImage = myRotateImageBilinear('Output\gray1.jpg', 150 + 999);

% ��ͼ��Ŵ�zoom��
input = 'Input\hust.bmp';
enlargeImage_NN = enlarge_NN(input, 2);      % ������㷨 NN:Nearest Neighbor, 2 Ϊ �Ŵ�����Ŀǰֻ��ȡ����
enlargeImage_BI = enlarge_BI(input, 2);      % ˫���Բ�ֵ BI:Bilinear Interpolation

% �ϲ�ͼ��չʾ
% combinedImage = [enlargeImage_NN, enlargeImage_BI]; % ˮƽ����
combinedImage = [enlargeImage_NN; enlargeImage_BI]; % ��ֱ����
imwrite(combinedImage, 'Output\combined_image.jpg');
imshow(combinedImage);

