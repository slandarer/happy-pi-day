% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
% 构建连接矩阵
dataMat=zeros(10,10);
Pi=getPi(1001);
for i=1:1000
    dataMat(Pi(i)+1,Pi(i+1)+1)=dataMat(Pi(i)+1,Pi(i+1)+1)+1;
end

BCC=biChordChart(dataMat,'Arrow','on','Label',num2cell('0123456789'));
BCC=BCC.draw(); 

% 添加刻度
BCC.tickState('on') 

% 修改字体，字号及颜色
BCC.setFont('FontName','Cambria','FontSize',17)

set(gcf,'Position',[200,100,820,820]);

