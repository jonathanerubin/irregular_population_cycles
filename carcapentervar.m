% assumes dt=0.001, dat is column of x values, y values
az=-26.3;
el=44.4;

%figure
%hist3(dat,[20,20])
%set(gca,'FontSize',16)
%view(az,el)
%xlabel('x','FontSize',16),ylabel('y','FontSize',16)

clear per yval approach crawl;
%dt=0.01;
dt=0.001;
t=[dt:dt:2500];
%t=[0.001:dt:10000];
thresh=0.004;

s=size(dat);
c1=min(find(dat(:,1)<0.5)); % for h:  0.5)); for r: 0.6)); 
dat=dat(c1:s(1),:);
%s=size(dat);
%c2=min(find(dat(:,1)<0.2));
%dat=dat(c2:s(1),:);

s=size(dat);
s1=s(1);
j=1;

while s1>0
   xc1=min(find(dat(:,1)>0.5));  % for h:  0.5)); for r: 0.6)); 
   yc1=min(find(dat(xc1:s1,2)>0.15)); % for h: -0.11x+0.2; for r: 0.24x-0.03; 
   xc2=min(find(dat(xc1+yc1:s1,1)<0.5)); 
   xc3=min(find(dat(xc1+yc1+xc2:s1,1)>0.5));
   if xc3
       per(j)=(xc3+xc2+yc1)*dt; 
       datchunk=dat(xc1:xc1+yc1+xc2+xc3,:);
       dis=datchunk(:,1).^2+datchunk(:,2).^2;
       crawl(j)=(yc1-xc1)*dt; % changed to time spent within bin with origin
       %length(find(dis<thresh));       % time spent within thresh of origin
       approach(j)=min(dis);   % closest approach to origin
       yval(j)=dat(xc1,2);  
       yvalnext(j)=dat(xc1+yc1+xc2+xc3,2);
       
       j=j+1;
       dat=dat(xc1+yc1+xc2+xc3:s1,:);
       s=size(dat);
       s1=s(1);
   else s1=0;
   end
end

%fprintf('mean crawl time = %5.2f\n', mean(crawl))
%fprintf('mean closest approach = %5.2f\n', mean(approach))
%fprintf('closest approach = %5.2f\n', min(approach))
fprintf('mean y value at section = %10.8f\n', mean(yval));
fprintf('std in y value at section = %10.8f\n', std(yval));
fprintf('min y value at section = %10.8f\n', min(yval));
fprintf('max y value at section = %10.8f\n', max(yval));

%fprintf('mean period = %5.2f\n', mean(per))
%fprintf('median period = %5.2f\n', median(per))
%fprintf('st dev = %5.2f\n', std(per))
%figure
%hist(per)
%set(gca,'FontSize',16)
%xlabel('period','FontSize',16)
%ylabel('number of cycles','FontSize',16)



   
