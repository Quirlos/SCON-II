clc; clear; close all

%% Item A
% Obter G(s) do primeiro sistema
%Definição das matrizes
Aa = [0, 1, 0; 0, 0, 1; -4, -5, -8];
Ba = [0; 0; 4];
Ca = [1, 0, 0];
Da = 0;

%Criação do espaço de estados com as matrizes definidas
sys1 = ss(Aa,Ba,Ca,Da);

%Obtenção da função de transferência
G1_s = tf(sys1);
disp(G1_s)

%% Item B
% Obter G(s) do segundo sistema
Ab = [0.5, 0.5, 0.7071; -0.5, -0.5, 0.7071; -6.3640, -0.7071, -8];
Bb = [0; 0; 4];
Cb = [0.7071, -0.7071, 0];
Db = 0;
sys2 = ss(Ab,Bb,Cb,Db);
G2_s = tf(sys2);
disp(G2_s)

%% Item C
%Podemos observar que ambas as representações em espaço de estados, mesmo sendo distintas, 
%levam à mesma função de tranferência. Logo, são realizações distintas do mesmo sistema.