clc; clear; close all

%% Definição das matrizes
A = [0 1 0 0; 0 0 -1 0; 0 0 0 1; 0 0 9.8 0];
B = [0; 1; 0; -1];
C = [0 0 1 0]; %y = x3
D = 0;
x0 = [0.9, 0.6, 0.7, 0.3]; %Condições iniciais
J = [-2+1j, -2-1j, -5, -5]; %Polos desejados

%% Cálculo do ganho K por Ackermaan
K = acker(A, B, J);
disp(K)

%% Definição do sistema de espaço de estados com realimentação
A_r = A - B*K;
B_r = B;
C_r = C;
D_r = D;

sys = ss(A_r, B_r, C_r, D_r); %Criação do sistema de espaço de estados
disp(pole(sys)) %Verificação da alocação dos polos

%% Simulação do sistema
t = 0:0.01:10; %Tempo de simulação
u = zeros(size(t)); %Entrada do sistema
[y, t, x] = initial(sys, x0, t); %Simulação da resposta do sistema

%% Plot dos estados
figure;
plot(t, x);
xlabel('Tempo (s)');
ylabel('Estados');
title('Resposta dos Estados ao Controle de Realimentação de Estado');
legend('x1 - Pos. Angular [rad]', 'x2 - Vel. Angular [rad/s]', 'x3 - Posição [m]', 'x4 - Velocidade [m/s]');
grid on;