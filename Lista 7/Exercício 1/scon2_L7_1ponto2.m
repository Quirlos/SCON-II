clc; clear; close all;

%% Declaração das matrizes que compõem o espaço de estados
A = [0, 1, 0; 0, 0, 1; -1, -5, -6]; 
B = [0; 0; 1]; 
J = [-2+4i, -2-4i, -10]; %Pólos desejados
K = [199, 55, 8]; %Matriz K obtida no ex.1.1

t = 0:0.01:4; %Vetor de com os valores de tempo e passos

%% Montando o sistema em espaço de estados
sys = ss(A-B*K, eye(3), eye(3), eye(3)); %Definição do sistema em variáveis de estado
x = initial(sys, [1; 0; 0], t); %Definição das condições iniciais

%Definição das variáveis de estado
x1 = [1 0 0]*x';
x2 = [0 1 0]*x'; 
x3 = [0 0 1]*x'; 

%% Plot das respostas

figure(1)
subplot(3, 1, 1);
plot(t, x1);
title("Resposta às condições iniciais - entrada nula");
ylabel("X1 [u]");
grid on

subplot(3, 1, 2);
plot(t, x2);
ylabel("X2 [u]");
grid on

subplot(3, 1, 3);
plot(t, x3);
xlabel("t [s]")
ylabel("X3 [u]");
grid on