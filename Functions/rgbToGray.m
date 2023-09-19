function grayImage = rgbToGray(colorImage)
    % 获取图像的尺寸
    [rows, cols, ~] = size(colorImage);

    % 初始化灰度图像矩阵
    grayImage = zeros(rows, cols);

    % 使用加权平均计算每个像素的灰度值
    for row = 1:rows
        for col = 1:cols
            % 获取像素的R、G、B通道值
            pixel = colorImage(row, col, :);
            R = double(pixel(1));
            G = double(pixel(2));
            B = double(pixel(3));

            % 计算灰度值
            grayValue = 0.2989 * R + 0.5870 * G + 0.1140 * B;
            
            %imshow能显示两大类型：当图像为unit8类型时，支持范围0~255，图像为double类型时，支持范围0~1
            grayValue = grayValue./255;
            % 将灰度值写入灰度图像矩阵
            grayImage(row, col) = grayValue;
        end
    end
    imwrite(grayImage,'Output\gray1.jpg');
end

