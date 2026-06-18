%% initialize matlab
clear all;
close all;
clc;

%% read file
%pre-allocate spaces
file_name = strings(1,6);
data = cell(1,6);

%input information
Field = ["Bx","By","Dz","Ez","Hx","Hy"];
C = string(input('what is the time step?\n'));

for i = 1:6

    %file name
    B = "_t";
    D = ".soft_OPC_field";
    file_name(i) = Field(i)+B+C+D;

    %read datas
    data{i} = dlmread(file_name(i));
end

%size of data
sz = size(data{1});
sz = sz(1);

%% amplitude change
for i = 1:6
    
    %compute rms
    rms = sqrt(mean(data{i}(:,4).^2));

    %amplitude change
    data{i}(:,4) = rms;
end

%% save to new file
for i = 1:3
    datfile = fopen("New_"+Field(i)+B+C+D,'w');
    for j = 1:sz
        fprintf(datfile,'%d, %d, %d, %.24e, %.24f\n',data{i}(j,1),data{i}(j,2),data{i}(j,3),data{i}(j,4),data{i}(j,5));
    end
    fclose(datfile);
end

for i = 4:6
    datfile = fopen("New_"+Field(i)+B+C+D,'w');
    for j = 1:sz
        fprintf(datfile,'%d, %d, %d, %.24f, %.24f\n',data{i}(j,1),data{i}(j,2),data{i}(j,3),data{i}(j,4),data{i}(j,5));
    end
    fclose(datfile);
end
