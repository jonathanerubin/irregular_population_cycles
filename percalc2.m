% assumes dt=0.01, dat is column of x values, y values
az=-26.3
el=44.4

%figure
%hist3(dat,[20,20])
%set(gca,'FontSize',16)
%view(az,el)
%xlabel('x','FontSize',16),ylabel('y','FontSize',16)

clear per
dt=0.01;
%dt=0.001;
t=[0.01:dt:2000];
%t=[0.001:dt:10000];

%yt=0.12; xt=0.15;
yt=0.3;xt=0.3; % for ah2 version

s=size(dat);
c1=min(find(dat(:,2)>yt));
dat=dat(c1:s(1),:);

%s=size(dat);
%c2=min(find(dat(:,1)<0.2));
%dat=dat(c2:s(1),:);

s=size(dat);
s1=s(1);
j=1;

while s1>0,
   yc1=min(find(dat(:,2)<yt));
   xc1=min(find(dat(yc1:s1,1)>xt));
   yc2=min(find(dat(yc1+xc1:s1,2)>yt));
   yc3=min(find(dat(yc1+xc1+yc2:s1,2)<yt));
   if yc3,
       per(j)=(yc3+yc2+xc1)*dt; %0.01; 
       j=j+1;
       dat=dat(yc1+xc1+yc2+yc3:s1,:);
       s=size(dat);
       s1=s(1);
   else s1=0;
   end
end

fprintf('mean period = %5.2f\n', mean(per))
fprintf('median period = %5.2f\n', median(per))
fprintf('st dev = %5.2f\n', std(per))
fprintf('CV = %5.2f\n', std(per)/mean(per))
%figure
%hist(per)
%set(gca,'FontSize',16)
%xlabel('period','FontSize',16)
%ylabel('number of cycles','FontSize',16)



   
