function [ power ] = Etec(deltaT )
%E_TEC 此处显示有关此函数的摘要
%   此处显示详细说明
if deltaT<8
    power=0.0918*deltaT^2+0.034*deltaT;
else
    power=0.8941*deltaT^2-14.16*deltaT+65.43;
end
    


end

