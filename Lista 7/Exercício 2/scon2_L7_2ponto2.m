clc; clear; close all;

%% Declaração das matrizes que compõem o espaço de estados
A = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B = [0; 1; 1];
J = [-2+4i, -2-4i, -10]; %Polos desejados

%% Obtenção da matriz K por Ackermaan
K = acker(A,B,J);
disp(K)
%Os valores de K são consistentes com o Ex)2.1

%Verificação se os polos estão corretos
eig(A -B*K)