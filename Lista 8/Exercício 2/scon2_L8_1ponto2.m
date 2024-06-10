clc; clear; close all

%% Definição das matrizes
A = [-3, -1, -1; 4, 0, 0; 0, 1, 0];
B = [3; 0; 0];
C = [1, 0, 0]; %y = x1
D = 0;
J = [-4, -5, -6]; %Polos desejados
x0 = [1, 0.5, 0.1]; %Condições iniciais

%Definição do espaço de estados
sys = ss(A,B,C,D);

%% Construção do ganho de realimentação K utilizando Ackermaan
K = acker(A, B, J);
disp(K)

%% Definição do sistema de espaço de estados com realimentação
A_r = A - B*K;
B_r = B;
C_r = C;
D_r = D;

sys_r = ss(A_r, B_r, C_r, D_r); %Criação do sistema de espaço de estados
disp(pole(sys_r)) %Verificação da alocação dos polos

%% Simulação do sistema
t = 0:0.01:10; %Tempo de simulação
u = zeros(size(t)); %Entrada do sistema
[y, t, x] = lsim(sys_r,u,t,x0); %Simula a resposta do sistema

%% Plot dos estados
figure;
plot(t, x);
xlabel('Tempo (s)');
ylabel('Estados');
title('Resposta dos Estados ao Controle de Realimentação de Estado');
legend('x1', 'x2', 'x3');
grid on;