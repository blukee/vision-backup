%% 3d face data source http://give-lab.cs.uu.nl/SHREC/shrec2007/
%% depend on - toolbox_graph

files = dir('*.off');

sumv = [];
countv = 0;
face = [];
for file = files'
    
    [v,f] = read_off(file.name);
    
    if ~size(sumv,1)==0
        sumv = sumv + v;
    else
        sumv = v;
    end
    
    countv = countv + 1;
    
end

averagev = sumv/countv;
plot_mesh(averagev,f);
write_off('average.off',averagev,f)