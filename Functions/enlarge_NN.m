function enlargeImage = enlarge_NN(inputImage, zoom)
   originalImage = imread(inputImage);
   [rows, cols, ~] = size(originalImage);
    newRows = rows * zoom;
    newCols = cols * zoom;
    % ����һ����ͼ��
    enlargedImage = uint8(zeros(newRows, newCols, 3));
    % ��������ڲ�ֵ
    for newRow = 1:newRows
        for newCol = 1:newCols
            % ������ԭʼͼ���ϵ�����
            originalRow = round(newRow / zoom);
            originalCol = round(newCol / zoom);

            % ȷ����������Ч��Χ��
            originalRow = max(1, min(originalRow, rows));
            originalCol = max(1, min(originalCol, cols));

            % ���÷Ŵ�������ֵ
            enlargedImage(newRow, newCol, :) = originalImage(originalRow, originalCol, :);
        end
    end
    % ��ʾ�ͱ�����
    % imshow(enlargedImage);  % ��ʾ�Ŵ���ͼ��
    imwrite(enlargedImage, 'Output\enlarged_NN_image.jpg');  % ��ѡ������Ŵ���ͼ��
    % ���ú�������ֵ
    enlargeImage = enlargedImage;
end