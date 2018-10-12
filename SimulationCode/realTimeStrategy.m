buffer=load('data.mat');
%% 初始化参数
[len,m]=size(buffer);
TECmem=0;% 只记录TEC的总工作量
Pcritical=40;% W
minT=5; %触发chiller的TEC工作周期,实际周期时间不应太大，但是本数据集一个周期就有5分钟，所以只能让总时间达到25分种
chillerstat=0;
Etotal=zeros(len,1);
Twater=30;  
Twork=0;%chiller

for i=1:len;
    input=buffer(i,:);  %当前输入
    Tin=Tgenerate(input, Twater, 1, 1, 1, 0.5);
    % [ temperature ] = Tgenerate( data, Twater, k1, k2, b, threshold )
%% 策略生成与能耗计算
%1.判断TEC的工作状态是否足以触发chiller
% 可以通描绘单个系统运行纯chiller和纯TEC降温的降温能力与能耗的图线来找交点，交点处TEC总功率为Pcritical
if chillerstat==0
    if length(TECmem)>minT
        if sum([TECmem>Pcritical])/length(TECmem)>0.7
            chillerstat=1;
            TECmem=0;
            deltaT=(Tgenerate(, Twater, 1, 1, 1, 0.5)-Twater); %chiller应使水温下降的度数
            Twater=Twater-deltaT;  %假设一个周期内可以用chiller使水温下降并稳定
            Etotal(i)=Cwater**F*Terval*rou/cop_chiller;
            for j=1:m
                if Tin(j)>Tsafe+deltaT
                    Etotal=Etotal+k3*(Tin(j)-Tsafe-deltaT);
                end
            end
        end
    end
elseif chillerstat==1
    %判断chiller的功效是否刚刚好，过度或不足,即通过Twater与
    
end
end
