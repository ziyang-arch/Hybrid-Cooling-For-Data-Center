function [ tempmem ] = updatemem( tempmem, new , nTerval)
%UPDATEMEM 此处显示有关此函数的摘要
%   此处显示详细说明
[l,m]=size(tempmem);
if l<nTerval
    tempmem=[tempmem; new];
else
    for i=1:nTerval-1
        tempmem(i,:)=tempmem(i+1,:);
    end
    tempmem(nTerval,:)=new;
end

end

