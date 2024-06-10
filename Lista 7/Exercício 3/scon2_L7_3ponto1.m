clc; clear; close all;

%% Item A

%Definição do numerador e denominador
num_a = 1;
den_a = [1 10];

%Criação da função transferência
g1 = tf(num_a,den_a);

%Criação das matrizes em espaço de estados
sys1 = ss(g1);
disp(sys1)

%% Item B
num_b = [1 5 3];
den_b = [1 8 5];
g2 = tf(num_b,den_b);
sys2 = ss(g2);
disp(sys2)

%% Item C
num_c = [1 1];
den_c = [1 3 3 1];
g3 = tf(num_c,den_c);
sys3 = ss(g3);
disp(sys3)