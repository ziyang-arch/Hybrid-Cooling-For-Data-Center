function [ E , E_chiller, E_tec] = Ehybrid( oc, Tin ,F,  Terval, cop_chiller, Tsafe)
%EHYBRID 此处显示有关此函数的摘要
%   oc是用chiller降的温度值， Tin是该时刻输入的cpu本征温度值

Cwater=4200;

rou=1000;%水的密度

E_chiller=Cwater*(oc)*F*Terval*rou/cop_chiller;
E_tec=0;
for i=1:length(Tin)
    if Tin(i)-oc>Tsafe
        E_tec=E_tec+Etec(Tin(i)-Tsafe-oc);
    end
end
E_tec=E_tec*300;
E=E_chiller+E_tec;

end

