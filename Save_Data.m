clearvars -except mean
fid = fopen('Querylevelnorm.txt');

c=textscan(fid,'%d8%*s1:%f642:%f643:%f644:%f645:%f646:%f647:%f648:%f649:%f6410:%f6411:%f6412:%f6413:%f6414:%f6415:%f6416:%f6417:%f6418:%f6419:%f6420:%f6421:%f6422:%f6423:%f6424:%f6425:%f6426:%f6427:%f6428:%f6429:%f6430:%f6431:%f6432:%f6433:%f6434:%f6435:%f6436:%f6437:%f6438:%f6439:%f6440:%f6441:%f6442:%f6443:%f6444:%f6445:%f6446:%f64%*s%*s%*s%*s%*s%*s%*s%*s%*s');

fclose(fid);

data_len=length(c{1});
data_width=size(c , 2)-1;

Out=double(c{1});
In=zeros(data_len , data_width);
In(:,1) = double(c{2});

for n=3:47
    In(:,n-1) = c{n};
end;

clearvars c fid n

save InputOutPut.mat Out In data_len data_width;