%% saddle passage:  July 20, 2021
%%
%% idea:  compute variability of passage times near saddles at (0,0) and (K,0) with various ICs and dynamical systems involved
%%
%% algorithm:  
%% (1) choose x-coordinate of entry point to section at y=0.1 from log-normal distribution
%% (2) simulate passage to section at x=0.1 with Euler's method
%% (3) take exit point y-coordinate as y-coordinate of entry point to section at x=K-0.1
%% (4) simulate passage to exit section 
%% repeat for as many iterations as desired (N)
clear x y t torig tcarcap xinit yorig xcarcap

N=100;
dt=0.001;
xlen=808;  %681;  %% depends on which file loaded

for i=1:N
    rm=1.0; % in case noise is in r
    r=1.0; % in case noise is not in r
    K=1.0;
    a=2.0;
    b=0.5;
    hm=0.15; % in case noise is in h
    h=0.15; % in case noise is not in h
    m=0.6;
    gamma=1.0;
    sigma=0.2;
    
    %% (1) 
    %xinit(i)=lognrnd(-5.8,1.95);
    draw=randi(xlen);
    xinit(i)=xval(draw);
    x=xinit(i);
     
    %% (2)
    xold=xinit(i);
    yold=0.1;
    %rold=1.0;
    hold=0.15;
    t=0;
    
    while x<0.1
        %r=rold+gamma*(rm-r)*dt+sigma*sqrt(dt)*sqrt(rold)*randn;
        h=hold+gamma*(hm-h)*dt+sigma*sqrt(dt)*sqrt(hold)*randn;
        x=xold+(r*xold)*dt;
        y=yold+(-m*yold)*dt;
        t=t+dt;
        xold=x;
        yold=y;
        %rold=r;
        hold=h;
    end
    
    torig(i)=t;
    yorig(i)=y;
    
    %% (3)
    xold = K-0.1;
    yold = y;
    %rold = 1.0;
    hold = 0.15;
    t=0;
    
    %% (4)
    while y<0.1
        %r=rold+gamma*(rm-r)*dt+sigma*sqrt(dt)*sqrt(rold)*randn;
        h=hold+gamma*(hm-h)*dt+sigma*sqrt(dt)*sqrt(hold)*randn;
        x=xold+(-r*(xold-K)-yold/h)*dt;
        y=yold+(a*b*yold/h)*dt;
        t=t+dt;
        xold=x;
        yold=y;
        %rold=r;
        hold=h;
    end
    
    tcarcap(i)=t;
    xcarcap(i)=x;

end
    

