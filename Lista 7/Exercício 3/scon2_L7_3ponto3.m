clc; clear; close all

%% Item A

%Definição das matrizes
A = [0, 1, 0; 0, 0, 1; -3, -2, -5];
B = [0; 0; 1];
C = [1, 0, 0];
D = 0;

%Criação do espaço de estados com as matrizes
sys = ss(A,B,C,D);

%Obtenção da função de transferência
G_s = tf(sys);

%% Item B
% Com entrada nula, e condições iniciais X0 = [0; -1; 1], plotar resposta
% do sistema entre 0 <= t <= 10

t = 0:0.01:10; %Vetor com os valores de tempo e passos
x0 = [0; -1; 1]; %Condições iniciais
u = 0*t; %Sinal de entrada

%Simulação da resposta do sistema
[y, t, x] = lsim(sys,u,t,x0);

%Plot dos resultados
figure(1)
subplot(3,1,1);
plot(t,x(:,1));
title("Respostas das variáveis de estado")
ylabel("X1 (u)");
grid on;
subplot(3,1,2);
plot(t,x(:,2));
ylabel("X2 (u)");
grid on;
subplot(3,1,3);
plot(t,x(:,3));
ylabel("X3 (u)");
xlabel("t (s)");
grid on;

%% Item C

%Obtencão de x10 simulado
x10 = x(length(t),:)';
disp(x10)

%Cálculo de x10
t10 = 10;
Phi = expm(A*t10); %Cálculo de Phi(10) = e^(A*10)
x10_calc = Phi*x0;
disp(x10_calc)