function rotatedImage = myRotateImageBilinear(inputImage, angleDegrees)
    % 读取输入图像
    originalImage = imread(inputImage);
    
    % 将角度转换为弧度
    angleDegrees = mod(angleDegrees, 360)   % 当输入一个大于360的度数时，取模
    angleRadians = deg2rad(angleDegrees);

    % 计算旋转矩阵
    rotationMatrix = [cos(angleRadians) -sin(angleRadians); sin(angleRadians) cos(angleRadians)];

    % 获取原始图像的大小
    [rows, cols, ~] = size(originalImage);

    % 计算旋转后的图像的大小
    newRows = ceil(rows * abs(cos(angleRadians)) + cols * abs(sin(angleRadians)));
    newCols = ceil(rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians)));

    % 创建一个新图像，用于存储旋转后的图像
    rotatedImage = uint8(zeros(newRows, newCols, 3));
    
    % 扩充原始图像，给予图像一个偏置，使出现在生成图片的正中央，生成图片的边界就是原始图像的边界，防止旋转后超出boundary
    disp_col = 0;
    disp_row = 0;
    if angleDegrees > 0 && angleDegrees < 90    % 第四象限
        disp_col = rows * abs(sin(angleRadians));
        disp_row = 0;
    
    elseif angleDegrees >= 90 && angleDegrees < 180    % 第三象限 
        disp_col = rows * abs(sin(angleRadians)) + cols * abs(cos(angleRadians));
        disp_row = rows * abs(cos(angleRadians));
        
    elseif angleDegrees >= 180 && angleDegrees < 270   % 第二象限
        disp_col = cols * abs(cos(angleRadians));
        disp_row = cols * abs(sin(angleRadians)) + rows * abs(cos(angleRadians));
        
    elseif angleDegrees >= 270                   % 第一象限
        disp_col = 0;
        disp_row = cols * abs(sin(angleRadians));
    end

    % 计算旋转后的图像
    for newRow = 1:newRows
        for newCol = 1:newCols
            % 计算原始图像中的对应坐标
            originalCoord = rotationMatrix \ [newCol-ceil(disp_col); newRow-ceil(disp_row)];
            originalX = originalCoord(1);
            originalY = originalCoord(2);

            % 使用双线性插值计算像素值
            x1 = floor(originalX);
            x2 = ceil(originalX);
            y1 = floor(originalY);
            y2 = ceil(originalY);

            % 边界检查
            if x1 < 1 || x2 > cols || y1 < 1 || y2 > rows
                continue; % 跳过越界像素
            end
            

            % 插值计算
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

            % 设置旋转后的像素值
            rotatedImage(newRow, newCol, :) = uint8(pixelValue);
        end
    end
    
    
   

    % 显示旋转后的图像
    imshow(rotatedImage);

    % 可选：保存旋转后的图像
    imwrite(rotatedImage, 'Output\rotated_image.jpg');
end