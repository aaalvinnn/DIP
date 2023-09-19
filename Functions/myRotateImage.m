function rotatedImage = myRotateImage(inputImage, angleDegrees)
    % 读取输入图像
    originalImage = imread(inputImage);
    % 将角度转换为弧度
    angleRadians = deg2rad(angleDegrees);

    % 计算旋转矩阵
    rotationMatrix = [cos(angleRadians) -sin(angleRadians); sin(angleRadians) cos(angleRadians)];

    % 计算输出图像的大小
    [rows, cols, ~] = size(originalImage);
    newRows = ceil(rows * abs(cos(angleRadians)) + cols * abs(sin(angleRadians)));
    newCols = ceil(rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians)));

    % 创建一个新图像，用于存储旋转后的图像
    rotatedImage = uint8(zeros(newRows, newCols, 3));
    % 扩充原始图像，防止旋转后超出boundary
    disp_col = 0;
    disp_row = 0;
    if angleRadians > 0 % 向下
        disp_col = rows * abs(sin(angleRadians));
        disp_row = 0;

    elseif angleRadians < 0 % 向上
        disp_col = 0;
        disp_row = cols * abs(sin(angleRadians));
    end
    % 计算旋转后的图像
    for row = 1:rows
        for col = 1:cols
            % 计算原始图像中的对应像素位置
            newRow = round(row * cos(angleRadians) + col * sin(angleRadians));
            newCol = round(-row * sin(angleRadians) + col * cos(angleRadians));

            % 检查像素是否在原始图像范围内
            % 复制像素值到旋转后的图像
            if angleDegrees == 90 || angleDegrees == -90
                 rotatedImage(newRow, newCol, :) = originalImage(row, col, :);
            else
                rotatedImage(newRow+ceil(disp_row), newCol+ceil(disp_col), :) = originalImage(row, col, :);
        
            end
        end
    end
    
%         for newRow = 1:newRows
%         for newCol = 1:newCols
%             % 计算原始图像中的对应像素位置
%             originalRow = round(newRow * cos(angleRadians) + newCol * sin(angleRadians));
%             originalCol = round(-newRow * sin(angleRadians) + newCol * cos(angleRadians));
% 
%             % 检查像素是否在原始图像范围内
%             if originalRow >= 1 && originalRow <= rows && originalCol >= 1 && originalCol <= cols
%                 % 复制像素值到旋转后的图像
%                 rotatedImage(newRow, newCol, :) = originalImage(originalRow, originalCol, :);
%             end
%         end
%     end

    % 显示旋转后的图像
    imshow(rotatedImage);

    % 可选：保存旋转后的图像
    imwrite(rotatedImage, 'rotated_image.jpg');
end
