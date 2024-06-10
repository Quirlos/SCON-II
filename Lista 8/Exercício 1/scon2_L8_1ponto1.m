clc; clear; close all

%% Declaração das matrizes

A = [0, 1, 0; 0, 0, 1; 0, -4, -5];
B = [0; 0; 1];
C = [4, 0, 0];
D = 0;
J = [-6, -1+0.5i, -1-0.5i]; %Pólos desejados obtidos pelo sisotool

%% Construção do ganho K por Ackermann
K = acker(A,B,J);
disp(K)

%% Simulação do sistema 
t = 0:0.01:10; %Tempo de simulação
th_ref = 5*2*pi; %Referência será 5 voltas completas
r = (th_ref).*ones(1, length(t)); %Entrada em degrau

%Sistema em espaço de estados considerando a realimentação
A_r = A-B*K;
B_r = B*K(1);
sys_r = ss(A_r,B_r,C,D);

[y, T, x] = lsim(sys_r,r,t); %Simula a resposta do sistema à referência

%% Plot dos estados

%Plot de x1
subplot(1,3,1);
plot(t,x(:,1),'Color','magenta');
ylabel("Posição Angular [rad]");
xlabel("t [s]");
title("x1");
hold on;
yline(th_ref);
legend("\theta", "\theta_{ref}", "Location", "best");
grid on;

%Plot de x2
subplot(1,3,2);
plot(t,x(:,2),'Color','blue');
ylabel("Velocidade angular [rad/s]");
xlabel("t [s]");
title("x2");
grid on;

%Plot de x3
subplot(1,3,3);
plot(t,x(:,3), 'Color','red');
ylabel("Corrente de campo [A]");
xlabel("t [s]");
title("x3");
grid on;