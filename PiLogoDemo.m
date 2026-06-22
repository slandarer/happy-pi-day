%% PiLogoDemo : Pi digits as colored text —— first 150 decimals
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Prepare digit sequence: integer part (3), decimal point marker (-1), and 150 decimals
% (准备数字序列：整数部分3，小数点标记-1，以及150位小数)
Pi = [3, -1, getPi(150)];

% Color palette for: '.' (index 1), then digits 0-9 (indices 2-11)
% (配色：第1位为小数点，后续为数字0-9)
CM = [109,110,113; 224, 25, 33; 244,126, 26; 253,207,  2; 154,203,57; 111,150,124;
      121,192,235;   6,109,183; 190,168,209; 151,118,181; 233, 93,163] ./ 255;

% String representations: '.' and digit names (字符串表示：小数点及数字英文名)
ST = {'.', 'ZERO', 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE'};

n = 1;
hold on

% Loop to generate 20 lines of text (循环生成20行文字)
for i = 1:20
    STList = '';
    NMList = [];
    PicListR = uint8(zeros(400, 0));
    PicListG = uint8(zeros(400, 0));
    PicListB = uint8(zeros(400, 0));
    
    % Build one line of text using consecutive digits (用连续数字构建一行文字)
    for j = 1:6
        STList = [STList, ST{Pi(n)+2}];
        NMList = [NMList, ones(size(ST{Pi(n)+2})) .* (Pi(n)+2)];
        n = n + 1;
        % Stop if line would exceed ~20 characters (避免单行过长)
        if length(STList) > 15 && length(STList) + length(ST{Pi(n)+2}) > 20
            break;
        end
    end
    
    % Render each character with its corresponding color (用对应颜色渲染每个字符)
    for k = 1:length(STList)
        tPic = imread(['image\', STList(k), '.png']);
        PicListR = [PicListR, (255 - tPic(:,:,1)) .* CM(NMList(k), 1)];
        PicListG = [PicListG, (255 - tPic(:,:,2)) .* CM(NMList(k), 2)];
        PicListB = [PicListB, (255 - tPic(:,:,3)) .* CM(NMList(k), 3)];
    end
    PicList = cat(3, PicListR, PicListG, PicListB);
    image([-1200, 1200], [0, 150] - (i-1)*150, flipud(PicList))
end

% Figure and axes decoration (图窗及坐标区域修饰)
set(gcf, 'Position', [200, 100, 600, 820]);
ax = gca;
ax.DataAspectRatio = [1, 1, 1];
ax.XLim = [-1300, 1300];
ax.Position = [0, 0, 1, 1];
ax.XTick = [];
ax.YTick = [];
ax.Color = [0, 0, 0];
ax.YLim = [-19*150 - 80, 230];