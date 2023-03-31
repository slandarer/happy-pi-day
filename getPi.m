function Pi=getPi(n)
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
if nargin<1,n=3;end
Pi=char(vpa(sym(pi),n+10));
Pi=abs(Pi)-48;
Pi=Pi(3:n+2);
end 