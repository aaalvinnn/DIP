function enlargeImage = enlarge_BI(inputImage, zoom)
   originalImage = imread(inputImage);
   [rows, cols, ~] = size(originalImage);
    newRows = rows * zoom;
    newCols = cols * zoom;
    % 创建一个新图像
    enlargedImage = uint8(zeros(newRows, newCols, 3));
    % 进行双线性插值
    for newRow = 1:newRows
        for newCol = 1:newCols
            % 计算在原始图像上的坐标
            originalY = newRow / zoom;
            originalX = newCol / zoom;

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
            enlargedImage(newRow, newCol, :) = uint8(pixelValue);
        end
    end

    % 显示和保存结果
    % imshow(enlargedImage);  % 显示放大后的图像
    imwrite(enlargedImage, 'Output\enlarged_BI_image.jpg');  % 可选：保存放大后的图像
    % 设置函数返回值
    enlargeImage = enlargedImage;
end