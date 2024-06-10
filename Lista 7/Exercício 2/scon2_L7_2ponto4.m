clc; clear; close all;

%% Declaração das matrizes que compõem o espaço de estados
A = [-3, -11, -6; 1, 0, 0; 0, 1, 0];
B = [1; 0; 0];
J = [-2+(1i*2*sqrt(3)), -2-(1i*2*sqrt(3)), -10]; %Polos desejados

%% Obtenção da matriz K por Ackermaan
K = acker(A,B,J);
disp(K)
%Os valores de K são consistentes com o Ex)2.1

%Verificação se os polos estão corretos
eig(A -B*K)
