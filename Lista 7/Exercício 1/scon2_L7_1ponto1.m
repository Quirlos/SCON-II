clc; clear; close all;

%% Declaração das matrizes que compõem o espaço de estados
A = [0, 1, 0; 0, 0, 1; -1, -5, -6]; %Matriz A
B = [0; 0; 1]; %Matriz B
J = [-2+4i, -2-4i, -10]; %Pólos desejados

%% Obtenção da matriz K por Ackermaan
K_ack = acker(A,B,J);
%Queremos que os pólos mudem para: -2 + 4i, -2 - 4i e -10
Ver = eig(A-B*K_ack); %Verificação da posição dos pólos

%% Obtenção da matriz K por 'place'
K_place = place(A,B,J);

%Ao comparar os resultados, podemos ver que obtemos a mesma matriz K