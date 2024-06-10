clc; clear; close all;

%% Definição das matrizes

A = [-9, 1, 0; -26, 0, 1; -24, 0, 0];
B = [0; 0; 2];
C = [1, 0, 0];
D = 0;

%% Definição do sistema de espaço de estados com realimentação

%Visto que o sistema é de tipo 0, precisamos adicionar ξ

%Matrizes de interesse
Ae = [A, zeros(3,1); -C, 0];
Be = [B; 0];

%Pólo relacionado à variável extra, ξ
mi = [-4, -5.6, -3.1, -5.5]; %Polos desejados (escolhidos pelo usuário)

K = acker(Ae,Be,mi);

Kc = K(1:3); %Ganhos de malha fechada
Ki = -K(4); %Ganho para ξ
disp(Kc)
disp(Ki)

%Matrizes com realimentação
A_r = [A-(B*Kc), B*Ki; -C, 0];
B_r = [zeros(3,1); 1];
C_r = [C, 0];
D_r = 0;

%Espaço de estados utilizando as novas matrizes 
sys_r = ss(A_r,B_r,C_r,D_r);
disp(pole(sys_r)) %Verficação da alocação dos polos

%% Simulação do sistema realimentado

t = 0:0.02:10; %Vetor de tempo
[y, T, x] = step(sys_r,t); %Cálculo da resposta ao degrau

%% Plot dos estados

%Plot de x1
subplot(1,4,1);
plot(t,x(:,1),'Color','magenta');
ylabel("x1 [u]");
xlabel("t [s]");
title("x1 (saída)");
hold on;
yline(1);
ylim([0,1.150]);
legend("Saída", "Referência", "Location", "best");
hold on;
grid on;

%Plot de x2
subplot(1,4,2);
plot(t,x(:,2),'Color','blue');
ylabel("x2 [u]");
xlabel("t [s]");
title("x2");
grid on;

%Plot de x3
subplot(1,4,3);
plot(t,x(:,3),'Color','green');
ylabel("x3 [u]");
xlabel("t [s]");
title("X3");
grid on;

%Plot de x4
subplot(1,4,4);
plot(t,x(:,4),'Color','red');
ylabel("\xi [u]");
xlabel("t [s]");
title("x4 (\xi)");
grid on;
