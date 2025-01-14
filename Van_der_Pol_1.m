clc;
clear;
close all;

% Part 1
tspan=[0,5];
y0=0;
[t,y]=ode45(@(t,y) 2*t, tspan, y0);
figure;
plot(t,y,'-o');

% Part 2
mu=1;
tspan_1=[0, 20];
y_0=[2;0];
[t,y]=ode45(@(t,y) vdp1(t,y,mu), tspan_1, y_0);
figure;
plot(t,y(:,1),'-o',t,y(:,2),'-o');

% Part 3
t=0;
mu_1=1;
[x,fval,exitflag,output,J]=fsolve(@(y) vdp1(t,y,mu_1), [2;0]);
% Max of real part of eigenvalues of Jacobian
a=max(real(eig(J)));

% Part 4
mus=-2:0.02:2;
for j=1:length(mus)
t_1=0;
mu_2=mus(j);
[x,fval,exitflag,output,J]=fsolve(@(y_1) vdp1(t_1,y_1,mu_2), [2;0]);
a(j)=max(real(eig(J)));
end
figure;
plot(mus,a)
xlabel('\mu');
ylabel('max(Re(\lambda))');

% Part 5

mu_7=1;
tspan_1=[0, 20];
ICs=[1;0]; %Change this to get different plot
[t,y_1]=ode45(@(t,y) vdp1(t,y,mu_7), tspan_1, ICs);
figure;
plot(y_1(:,1),y_1(:,2));
xlabel('y1');
ylabel('y2');


function dydt = vdp1(t,y,mu)
    dy1=y(2);
    dy2=mu*(1-y(1)^2)*y(2)-y(1);
    dydt=[dy1; dy2]; %fuction output
end