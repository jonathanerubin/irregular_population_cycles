% assumes dt=0.001, dat is column of x values, y values
az=-26.3;
el=44.4;

%figure
%hist3(dat,[20,20])
%set(gca,'FontSize',16)
%view(az,el)
%xlabel('x','FontSize',16),ylabel('y','FontSize',16)

clear per xval approach crawl;
%dt=0.01;
dt=0.001;
t=[dt:dt:2500];
%t=[0.001:dt:10000];
thresh=0.004;

s=size(dat);
c1=min(find(dat(:,2)>0.1)); % for h: 0.12)); % for r: 0.07));
dat=dat(c1:s(1),:);

%s=size(dat);
%c2=min(find(dat(:,1)<0.2));
%dat=dat(c2:s(1),:);

s=size(dat);
s1=s(1);
j=1;

while s1>0
   yc1=min(find(dat(:,2)<0.1)); % for h: 0.12));  %for r: 0.07));  
   xc1=min(find(dat(yc1:s1,1)>0.15)); % for h: 0.2));  % for r: 0.12)); 
   yc2=min(find(dat(yc1+xc1:s1,2)>0.1)); % for h: 0.12));  % for r: 0.07)); 
   yc3=min(find(dat(yc1+xc1+yc2:s1,2)<0.1)); % for h: 0.12)); % for r: 0.07)); 
   if yc3
       per(j)=(yc3+yc2+xc1)*dt; 
       datchunk=dat(yc1:yc1+xc1+yc2+yc3,:);
       dis=datchunk(:,1).^2+datchunk(:,2).^2;
       crawl(j)=(xc1-yc1)*dt; % changed to time spent within bin with origin
       %length(find(dis<thresh));       % time spent within thresh of origin
       approach(j)=min(dis);   %closest approach to origin
       xval(j)=dat(yc1,1);  
       xvalnext(j)=dat(yc1+xc1+yc2+yc3,1);
       
       j=j+1;
       dat=dat(yc1+xc1+yc2+yc3:s1,:);
       s=size(dat);
       s1=s(1);
   else s1=0;
   end
end

%fprintf('mean crawl time = %5.2f\n', mean(crawl))
%fprintf('mean closest approach = %5.2f\n', mean(approach))
%fprintf('closest approach = %5.2f\n', min(approach))
fprintf('mean x value at section = %10.8f\n', mean(xval));
fprintf('std in x value at section = %10.8f\n', std(xval));
fprintf('min x value at section = %10.8f\n', min(xval));
fprintf('max x value at section = %10.8f\n', max(xval));
%fprintf('mean period = %5.2f\n', mean(per))
%fprintf('median period = %5.2f\n', median(per))
%fprintf('st dev = %5.2f\n', std(per))
%figure
%hist(per)
%set(gca,'FontSize',16)
%xlabel('period','FontSize',16)
%ylabel('number of cycles','FontSize',16)



   
