function getLogo
% getLogo - Generate letter images and adjust them for a "Happy Pi Day" logo
%           (生成字母图像并调整尺寸，用于"Happy Pi Day"徽标)
%
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Create image folder if not exists (若图像文件夹不存在则创建)
if ~exist('image', 'dir')
    mkdir('image\')
end

% Character set: '.' and 'A' to 'Z' (字符集：点和字母A到Z)
logoSet=['.', char(65:Z)];

for i=1:27
    % Create a figure with invisible axes (创建带隐藏坐标轴的图窗)
    figure();
    ax = gca;
    ax.XLim = [-1, 1];
    ax.YLim = [-1, 1];
    ax.XColor = 'none';
    ax.YColor = 'none';
    ax.DataAspectRatio = [1, 1, 1];
    
    % Display the current character (显示当前字符)
    logo = logoSet(i);
    hold on
    text(0, 0, logo, 'HorizontalAlignment','center', ...
         'FontSize',320, 'FontName','Segoe UI Black')
    
    % Save as PNG (保存为PNG)
    exportgraphics(ax, ['image\', logo, '.png'])
    close
end

% Process the dot image (处理点图像)
dotPic = imread('image\..png');
newDotPic = uint8(ones([400, size(dotPic, 2), 3]).*255);
newDotPic(end-size(dotPic,1)+1:end, :, 1) = dotPic(:, :, 1);
newDotPic(end-size(dotPic,1)+1:end, :, 2) = dotPic(:, :, 2);
newDotPic(end-size(dotPic,1)+1:end, :, 3) = dotPic(:, :, 3);
imwrite(newDotPic, 'image\..png')

% Resize and pad each letter image (调整每个字母图像大小并添加边距)
S = 20;
for i = 1:27
    logo = logoSet(i);
    tPic = imread(['image\', logo, '.png']);
    sz = size(tPic, [1, 2]);
    sz = round(sz ./ sz(1) .* 400);
    tPic = imresize(tPic, sz);
    
    % Add padding (添加白色边距)
    tBox = uint8(255.*ones(size(tPic, [1, 2]) + S));
    tBox(S+1:S+size(tPic,1), S+1:S+size(tPic,2)) = tPic(:, :, 1);
    imwrite(cat(3, tBox, tBox, tBox), ['image\', logo, '.png'])
end
end