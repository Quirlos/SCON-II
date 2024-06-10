clc; clear; close all

%% Definição das matrizes

A = [0, 1; -7, -2];
B = [0; 1];
C = [1, 4];
D = 0;

%Verificação da controlabilidade e observabilidade do sistema
control = ctrb(A, B);
rank(control)
observ = obsv(A, C);
rank(observ)

%Definição das condições iniciais
x0 = [0; 0];
x0_o = [7; 9]; %Condição inicial do observador
e = x0 - x0_o; %Erro inicial do observador

%% Definição dos polos
J_c = [-1 - 0.6i; -1 + 0.6i]; %Polos desejados obtidos pelo sisotool
J_o = [-10 + 1i; -10 - 1i]; %Polo desejado do observador

K = acker(A, B, J_c); %Cálculo do ganho K do controlador por Ackermaan
K_e = acker(A', C', J_o)'; %Cálculo do ganho do observador por Ackermaan

%Exibição dos ganhos K e K_e
disp('Ganho de realimentação K:');
disp(K);
disp('Ganho do observador L:');
disp(K_e);

%% Criação do sistema realimentado

A_comp = [(A-B*K), (B*K); zeros(2, 2), A-(K_e*C)];
B_comp = [B; zeros(size(B))];
C_comp = [C, zeros(size(C))];
D_comp = 0;

sys_comp = ss(A_comp, B_comp, C_comp, D_comp);

%% Simulação do sistema

t = 0:0.01:10;
u = 1.*ones(1, length(t)); %Entrada em degrau unitário
x0_cl = [x0; e]; %Vetor condições iniciais
[y, t, x] = lsim(sys_comp, u, t, x0_cl);

%% Plot dos estados

%Plot de X1
subplot(1,2,1)
plot(t,x(:,1), "Color",'blue');
xlabel('t [s]');
ylabel('x1 [u]');
title('1° estado');
hold on;
grid on;

%Plot de X2
subplot(1,2,2)
plot(t,x(:,2), "Color",'red');
xlabel('t [s]');
ylabel('e1 [u]');
title('Erro do 1° estado');
hold on;
grid on;

%Plot de O1
figure()
subplot(1,2,1)
plot(t,x(:,3), "Color",'magenta');
xlabel('t [s]');
ylabel('e2 [u]');
title('Erro do 1° estado');
hold on;
grid on;

%Plot de O2
subplot(1,2,2)
plot(t,x(:,4), "Color",'green');
xlabel('t [s]');
ylabel('x2 [u]');
title('Erro do 2° estado');
hold on;
grid on;

%Plot da saída
figure()
plot(t,y);
xlabel('t [s]');
ylabel('y [u]');
title('Resposta da saída a um degrau unitário');
hold on;
plot(t,u, LineStyle="--", Color='black');
legend("Saída do sistema", "Referência", Location="best");
grid on;