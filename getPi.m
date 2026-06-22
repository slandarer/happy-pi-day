function Pi = getPi(n)
% getPi - Extract the first n decimal digits of pi (提取圆周率π的前n位小数)
%   Pi = getPi(n) returns a numeric array containing the first n digits
%   after the decimal point of pi.
%   (返回包含π小数点后前n位数字的数值数组)
%
%   If n is not specified, defaults to 3. (若未指定n，默认取3位)
%
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

    if nargin < 1
        n = 3;
    end

    piStr = char(vpa(sym(pi), n + 10));
    digitVec = abs(piStr) - 48;
    Pi = digitVec(3 : n + 2);
end