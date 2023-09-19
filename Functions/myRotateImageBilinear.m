function rotatedImage = myRotateImageBilinear(inputImage, angleDegrees)
    % ��ȡ����ͼ��
    originalImage = imread(inputImage);
    
    % ���Ƕ�ת��Ϊ����
    angleDegrees = mod(angleDegrees, 360)   % ������һ������360�Ķ���ʱ��ȡģ
    angleRadians = deg2rad(angleDegrees);

    % ������ת����
    rotationMatrix = [cos(angleRadians) -sin(angleRadians); sin(angleRadians) cos(angleRadians)];

    % ��ȡԭʼͼ��Ĵ�С
    [rows, cols, ~] = size(originalImage);

    % ������ת���ͼ��Ĵ�С
    newRows = ceil(rows * abs(cos(angleRadians)) + cols * abs(sin(angleRadians)));
    newCols = ceil(rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians)));

    % ����һ����ͼ�����ڴ洢��ת���ͼ��
    rotatedImage = uint8(zeros(newRows, newCols, 3));
    
    % ����ԭʼͼ�񣬸���ͼ��һ��ƫ�ã�ʹ����������ͼƬ�������룬����ͼƬ�ı߽����ԭʼͼ��ı߽磬��ֹ��ת�󳬳�boundary
    disp_col = 0;
    disp_row = 0;
    if angleDegrees > 0 && angleDegrees < 90    % ��������
        disp_col = rows * abs(sin(angleRadians));
        disp_row = 0;
    
    elseif angleDegrees >= 90 && angleDegrees < 180    % �������� 
        disp_col = rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians));
        disp_row = rows * abs(cos(angleRadians));
        
    elseif angleDegrees >= 180 && angleDegrees < 270   % �ڶ�����
        disp_col = cols * abs(cos(angleRadians));
        disp_row = cols * abs(sin(angleRadians)) + rows * abs(cos(angleRadians));
        
    elseif angleDegrees >= 270                   % ��һ����
        disp_col = 0;
        disp_row = cols * abs(sin(angleRadians));
    end

    % ������ת���ͼ��
    for newRow = 1:newRows
        for newCol = 1:newCols
            % ����ԭʼͼ���еĶ�Ӧ����
            originalCoord = rotationMatrix \ [newCol-ceil(disp_col); newRow-ceil(disp_row)];
            originalX = originalCoord(1);
            originalY = originalCoord(2);

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
            rotatedImage(newRow, newCol, :) = uint8(pixelValue);
        end
    end
    
    
   

    % ��ʾ��ת���ͼ��
    imshow(rotatedImage);

    % ��ѡ��������ת���ͼ��
    imwrite(rotatedImage, 'Output\rotated_image.jpg');
end