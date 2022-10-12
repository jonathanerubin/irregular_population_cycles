
%for k=1:21
 %   dat=fulldat((k-1)*2000001+1:k*2000001,2:3);
clear dur;

s=size(dat);
steps=s(1);
sofar=0;
i=1;
dt=0.001;
time=zeros(steps,6);
%dur=0

%if or(dat(1,1)<1e-6,dat(1,2)<1e-6)
%    temp1=min(find(dat(:,1)>1e-6));
%    temp2=min(find(dat(:,2)>1e-6));
%    temp=max(temp1,temp2);
%    dat=dat(temp,:);
%end

if dat(1,1)<0.09
    if dat(1,2)<0.08, cm=1;
%    if dat(1,2)<0.04, cm=1;   
%    elseif dat(1,2)<0.22, cm=6; 
    elseif dat(1,2)<0.23, cm=6;
    else cm=5; 
    end
elseif dat(1,1)>0.5 % 0.4 
    if dat(1,2)<0.15, cm=3; %0.18, cm=3; 
    else cm=4; 
    end
else
    if dat(1,2)<0.18, cm=2; %0.15, cm=2;
    elseif dat(1,2)<0.5*dat(1,1)+0.1, cm=4; 
 %   elseif dat(1,2)<0.5*dat(1,1)+0.1, cm=4; %0.53*dat(1,1)+0.06, cm=4; 
    else cm=5;
    end
end
special=cm;  % first interval 

switch cm
    case 1
        position=min(find(dat(:,1)>0.09));
        cm=2;
    case 2
        position=min(find(dat(:,1)>0.5)); %0.4));  
        cm=3;
    case 3
        position=min(find(dat(:,2)>0.15)); %0.18)); 
        cm=4;
    case 4
        position=min(find(dat(:,2)>0.5*dat(:,1)+0.1)); %0.53*dat(:,1)+0.06)); 
        cm=5; 
    case 5
        position=min(find(dat(:,2)<0.23));
        cm=6;
    case 6
        position=min(find(dat(:,2)<0.08));
        cm=1;
end

sofar=position;
bcheck=0; % use to keep track if x or y got too small on this cycle
bad=0;  % use to check in which segment x or y got too small
badcount=0; % number of cycles thrown out

while sofar<steps
    switch cm
        case 1
            position=min(find(dat(sofar+1:steps,1)>0.09)); %0.1));  
            if and(bcheck==1,bad==1), bcheck=0; end
            if and(bcheck==0, min(min(dat(sofar:sofar+position,:)))<1e-5), bad=1; bcheck=1; badcount=badcount+1; end
        case 2
            position=min(find(dat(sofar+1:steps,1)>0.5)); %0.4)); 
            if and(bcheck==1,bad==2), bcheck=0; end
            if and(bcheck==0, min(dat(sofar:sofar+position,2))<1e-5), bad=2; bcheck=1; badcount=badcount+1; end
        case 3
            position=min(find(dat(sofar+1:steps,2)>0.15)); %0.18)); 
            if and(bcheck==1,bad==3), bcheck=0; end
            if and(bcheck==0, min(dat(sofar:sofar+position,2))<1e-5), bad=3; bcheck=1; badcount=badcount+1; end
        case 4
            position=min(find(dat(sofar+1:steps,2)>0.5*dat(sofar+1:steps,1)+0.1)); %0.53*dat(sofar+1:steps,1)+0.06)); 
        case 5
            position=min(find(dat(sofar+1:steps,2)<0.23)); 
        case 6
            position=min(find(dat(sofar+1:steps,2)<0.08)); 
            if and(bcheck==1,bad==6), bcheck=0; end
            if and(bcheck==0, min(dat(sofar:sofar+position,1))<1e-5), bad=6; bcheck=1; badcount=badcount+1; end
    end
    if and(position,bcheck==0), time(i,cm)=(position)*dt; i=i+1; cm=cm+1; sofar=sofar+position;
    elseif and(position,bcheck==1), cm=cm+1; sofar=sofar+position;
    else sofar=steps;
    end
    %cm=cm+1; 
    %i=i+1; 
    if cm==7, cm=1; end
    %sofar=sofar+positions
end

[i,j,v]=find(time);  % i contains row numbers where each j=1...6 arise
                    % j takes values from 1 to 6
                    % the first set of entries of v are the times for j=1,
                    % then come the times for j=2, etc.
td1=v(1:max(find(j==1))); 
td2=v(max(find(j==1))+1:max(find(j==2)));
td3=v(max(find(j==2))+1:max(find(j==3)));
td4=v(max(find(j==3))+1:max(find(j==4)));
td5=v(max(find(j==4))+1:max(find(j==5)));
td6=v(max(find(j==5))+1:length(v));

switch cm  % check last interval successfully fully traversed
    case 1
        le=length(td1);
    case 2
        le=length(td2);
    case 3
        le=length(td3);
    case 4 
        le=length(td4);
    case 5
        le=length(td5);
    case 6
        le=length(td6);
end
for ind=1:le
    dur(ind)=td1(ind)+td2(ind)+td3(ind)+td4(ind)+td5(ind)+td6(ind);
end

meand=mean(dur)
mediand=median(dur)
vard=var(dur)
CVd=std(dur)/meand

dur=dur';

%l1=length(td1);
m1=mean(td1(1:le))
v1=var(td1(1:le));
s1=sqrt(v1) 
m2=mean(td2(1:le))
v2=var(td2(1:le));
s2=sqrt(v2)
m3=mean(td3(1:le))
v3=var(td3(1:le));
s3=sqrt(v3)
m4=mean(td4(1:le))
v4=var(td4(1:le));
s4=sqrt(v4)
m5=mean(td5(1:le))
v5=var(td5(1:le));
s5=sqrt(v5)
m6=mean(td6(1:le))
v6=var(td6(1:le));
s6=sqrt(v6)
%end
