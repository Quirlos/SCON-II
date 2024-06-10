clc; clear; close all;

%% Item A

%Criação das matrizes
Aa = [0, 1; 2, 8];
Ba = [0; 1];
Ca = [1, 0];
Da = 0;

%Criação do espaço de estados utilizando as matrizes
sys1 = ss(Aa,Ba,Ca,Da);

%Criação da função transferência do sistema
gs1 = tf(sys1);
disp(gs1)

%% Item B
Ab = [1, 1, 0; -2, 0, 4; 5, 4, -7];
Bb = [-1; 0; 1];
Cb = [0, 1, 0];
Db = 0;
sys2 = ss(Ab,Bb,Cb,Db);
gs2 = tf(sys2);
disp(gs2)

%% Item C
Ac = [0, 1; -1, -2];
Bc = [0; 1];
Cc = [-2, 1];
Dc = 0;
sys3 = ss(Ac,Bc,Cc,Dc);
gs3 = tf(sys3);
disp(gs3)