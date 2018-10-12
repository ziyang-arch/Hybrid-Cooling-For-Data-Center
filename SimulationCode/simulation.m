function  [ E_kwh , E_kwhmono, E_kwhtec, E_min] = simulation( data, argument )
%SIMULATION 此处显示有关此函数的摘要
%   此处显示详细说明

Tsafe=argument.Tsafe;
Tstandard=argument.Tstandard;
k1=argument.k1;
b1=argument.b1;
k2=argument.k2;
b2=argument.b2;
threshold=argument.threshold;
cop_chiller=argument.cop_chiller;
F=argument.F;
nTerval=argument.nTerval;
Terval=argument.Terval;
activ=argument.activ;
cpuJudge=argument.cpuJudge;
Cwater=4200;
rou=1000;

%% Tgenerate( data, Twater, k1, k2, b1, b2,threshold )
temperature=Tgenerate(data,Tstandard, k1,k2,b1,b2,threshold);
[l,m]=size(data);
E=zeros(l,3);
Emono=zeros(l,1);
E_tec=zeros(l,1);
E_kwh=zeros(l,3);
E_kwhmono=zeros(l,1);
E_kwhtec=zeros(l,1);
E_min=zeros(l,1);
cstat=0;% chiller的工作状态
Tchiller=0; %chiller工作可以降下的温度'
tempmem=[];
for i=1:l
    tempmem=updatemem(tempmem, temperature(i,:), nTerval);
    
    if cstat==0
        [cstat, Tchiller]=act(tempmem,Tsafe, activ, cpuJudge,nTerval );
       
    else
       [ cstat,Tchiller]=shut(tempmem,Tsafe, activ, cpuJudge, cstat ,Tchiller);
        
    end
    %%
   peak=max(temperature(i,:));
    if peak<=Tsafe
        Emono(i)=0;
    else    
        Emono(i)=Cwater*(peak-Tsafe)*F*Terval*rou/cop_chiller;
    end
    %%
    for j=1:m
        if temperature(i,j)>Tsafe
            E_tec(i)=E_tec(i)+Etec(temperature(i,j)-Tsafe);
        end
    end
    E_tec(i)=E_tec(i)*300;
    %%
    Etemp=0;
    Em=0;
    for T=0:0.5:peak-Tsafe
        [Etemp,~,~]=Ehybrid( T, temperature(i,:) ,F, Terval, cop_chiller, Tsafe);
        if T~=0
            if Etemp<Em
                Em=Etemp;
            end
        else
            Em=Etemp;
        end
    end
    %%
    [E(i,1),E(i,2),E(i,3)]=Ehybrid( Tchiller, temperature(i,:) ,F, Terval, cop_chiller, Tsafe);
    E_kwh(i,:)=E(i,:)/12000;
    E_kwhmono(i)=Emono(i)/12000;
    E_kwhtec(i)=E_tec(i)/12000;
    E_min(i)=Em/12000;
end

 














