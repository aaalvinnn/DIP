function grayImage = rgbToGray(colorImage)
    % ��ȡͼ��ĳߴ�
    [rows, cols, ~] = size(colorImage);

    % ��ʼ���Ҷ�ͼ�����
    grayImage = zeros(rows, cols);

    % ʹ�ü�Ȩƽ������ÿ�����صĻҶ�ֵ
    for row = 1:rows
        for col = 1:cols
            % ��ȡ���ص�R��G��Bͨ��ֵ
            pixel = colorImage(row, col, :);
            R = double(pixel(1));
            G = double(pixel(2));
            B = double(pixel(3));

            % ����Ҷ�ֵ
            grayValue = 0.2989 * R + 0.5870 * G + 0.1140 * B;
            
            %imshow����ʾ�������ͣ���ͼ��Ϊunit8����ʱ��֧�ַ�Χ0~255��ͼ��Ϊdouble����ʱ��֧�ַ�Χ0~1
            grayValue = grayValue./255;
            % ���Ҷ�ֵд��Ҷ�ͼ�����
            grayImage(row, col) = grayValue;
        end
    end
    imwrite(grayImage,'Output\gray1.jpg');
end

