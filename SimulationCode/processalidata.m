u=39600;
j=1;
for i=1:length(alidata)
    if alidata(i,1)==u
        ali(j,alidata(i,2))=alidata(i,3);
    else
        u=alidata(i,1);
        j=j+1;
        ali(j,alidata(i,2))=alidata(i,3);
    end
end
        