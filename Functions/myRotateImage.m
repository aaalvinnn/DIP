function rotatedImage = myRotateImage(inputImage, angleDegrees)
    % ��ȡ����ͼ��
    originalImage = imread(inputImage);
    % ���Ƕ�ת��Ϊ����
    angleRadians = deg2rad(angleDegrees);

    % ������ת����
    rotationMatrix = [cos(angleRadians) -sin(angleRadians); sin(angleRadians) cos(angleRadians)];

    % �������ͼ��Ĵ�С
    [rows, cols, ~] = size(originalImage);
    newRows = ceil(rows * abs(cos(angleRadians)) + cols * abs(sin(angleRadians)));
    newCols = ceil(rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians)));

    % ����һ����ͼ�����ڴ洢��ת���ͼ��
    rotatedImage = uint8(zeros(newRows, newCols, 3));
    % ����ԭʼͼ�񣬷�ֹ��ת�󳬳�boundary
    disp_col = 0;
    disp_row = 0;
    if angleRadians > 0 % ����
        disp_col = rows * abs(sin(angleRadians));
        disp_row = 0;

    elseif angleRadians < 0 % ����
        disp_col = 0;
        disp_row = cols * abs(sin(angleRadians));
    end
    % ������ת���ͼ��
    for row = 1:rows
        for col = 1:cols
            % ����ԭʼͼ���еĶ�Ӧ����λ��
            newRow = round(row * cos(angleRadians) + col * sin(angleRadians));
            newCol = round(-row * sin(angleRadians) + col * cos(angleRadians));

            % ��������Ƿ���ԭʼͼ��Χ��
            % ��������ֵ����ת���ͼ��
            if angleDegrees == 90 || angleDegrees == -90
                 rotatedImage(newRow, newCol, :) = originalImage(row, col, :);
            else
                rotatedImage(newRow+ceil(disp_row), newCol+ceil(disp_col), :) = originalImage(row, col, :);
        
            end
        end
    end
    
%         for newRow = 1:newRows
%         for newCol = 1:newCols
%             % ����ԭʼͼ���еĶ�Ӧ����λ��
%             originalRow = round(newRow * cos(angleRadians) + newCol * sin(angleRadians));
%             originalCol = round(-newRow * sin(angleRadians) + newCol * cos(angleRadians));
% 
%             % ��������Ƿ���ԭʼͼ��Χ��
%             if originalRow >= 1 && originalRow <= rows && originalCol >= 1 && originalCol <= cols
%                 % ��������ֵ����ת���ͼ��
%                 rotatedImage(newRow, newCol, :) = originalImage(originalRow, originalCol, :);
%             end
%         end
%     end

    % ��ʾ��ת���ͼ��
    imshow(rotatedImage);

    % ��ѡ��������ת���ͼ��
    imwrite(rotatedImage, 'rotated_image.jpg');
end
