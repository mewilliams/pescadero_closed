clear
close all

usgs_fn = '../external_data/usgs_pescadero_2009_2013_inst.txt';

disp('reading data...')
fid = fopen(usgs_fn);
for i = 1:33
    header = fgetl(fid);
end

data = textscan(fid, '%s%s%s%s%f%s%f%s','Delimiter','\t','EmptyValue',NaN);
fclose(fid)

%%
data{3}(1:10)

ispst = strcmp(data{4},'PST');
ispdt = strcmp(data{4},'PDT');

t_usgs_local = NaN(length(length(data{3})),1);

disp('making timestamp...')

for i = 1:length(data{3})
t_usgs_local(i) = datenum(data{3}(i),'yyyy-mm-dd HH:MM');
end
%%
    
disp('converting timestamp to GMT...')

t_usgs_gmt = t_usgs_local;
t_usgs_gmt(ispst) = t_usgs_gmt(ispst) + 8/24;
t_usgs_gmt(ispdt) = t_usgs_gmt(ispdt) + 7/24;
        
figure
plot(t_usgs_local,(t_usgs_gmt-t_usgs_local)*24)

Q_cfs = data{5};
H_ft = data{7};

figure
plot(t_usgs_gmt,Q_cfs)

herename = pwd;
readme = ['data made in ',herename,'new_plot_usgs_streamflow.m on ', datestr(now)];
station_number = char(data{2}(1));

save('../external_data/usgs_pescadero_2009_2013_inst.mat','t_usgs_*','Q_cfs','H_ft','station_number','readme')
