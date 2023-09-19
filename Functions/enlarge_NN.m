function enlargeImage = enlarge_NN(inputImage, zoom)
   originalImage = imread(inputImage);
   [rows, cols, ~] = size(originalImage);
    newRows = rows * zoom;
    newCols = cols * zoom;
    % 创建一个新图像
    enlargedImage = uint8(zeros(newRows, newCols, 3));
    % 进行最近邻插值
    for newRow = 1:newRows
        for newCol = 1:newCols
            % 计算在原始图像上的坐标
            originalRow = round(newRow / zoom);
            originalCol = round(newCol / zoom);

            % 确保坐标在有效范围内
            originalRow = max(1, min(originalRow, rows));
            originalCol = max(1, min(originalCol, cols));

            % 设置放大后的像素值
            enlargedImage(newRow, newCol, :) = originalImage(originalRow, originalCol, :);
        end
    end
    % 显示和保存结果
    % imshow(enlargedImage);  % 显示放大后的图像
    imwrite(enlargedImage, 'Output\enlarged_NN_image.jpg');  % 可选：保存放大后的图像
    % 设置函数返回值
    enlargeImage = enlargedImage;
end