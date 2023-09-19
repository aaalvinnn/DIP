function enlargeImage = enlarge_BI(inputImage, zoom)
   originalImage = imread(inputImage);
   [rows, cols, ~] = size(originalImage);
    newRows = rows * zoom;
    newCols = cols * zoom;
    % ����һ����ͼ��
    enlargedImage = uint8(zeros(newRows, newCols, 3));
    % ����˫���Բ�ֵ
    for newRow = 1:newRows
        for newCol = 1:newCols
            % ������ԭʼͼ���ϵ�����
            originalY = newRow / zoom;
            originalX = newCol / zoom;

            % ʹ��˫���Բ�ֵ��������ֵ
            x1 = floor(originalX);
            x2 = ceil(originalX);
            y1 = floor(originalY);
            y2 = ceil(originalY);

            % �߽���
            if x1 < 1 || x2 > cols || y1 < 1 || y2 > rows
                continue; % ����Խ������
            end
            

            % ��ֵ����
            dx = originalX - x1;
            dy = originalY - y1;

                        if x1 < 1
                x1 = x1 + ceil(disp_col);
            end
            
            if y1 < 1
                y1 = y1 + ceil(disp_row)+1;
            end
            
            A = double(originalImage(y1, x1, :));
            B = double(originalImage(y1, x2, :));
            C = double(originalImage(y2, x1, :));
            D = double(originalImage(y2, x2, :));

            pixelValue = (1 - dx) * (1 - dy) * A + dx * (1 - dy) * B + (1 - dx) * dy * C + dx * dy * D;

            % ������ת�������ֵ
            enlargedImage(newRow, newCol, :) = uint8(pixelValue);
        end
    end

    % ��ʾ�ͱ�����
    % imshow(enlargedImage);  % ��ʾ�Ŵ���ͼ��
    imwrite(enlargedImage, 'Output\enlarged_BI_image.jpg');  % ��ѡ������Ŵ���ͼ��
    % ���ú�������ֵ
    enlargeImage = enlargedImage;
end