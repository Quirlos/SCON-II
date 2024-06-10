clc; clear; close all

%% Definição das matrizes
A = [0, 1, 0; 0, 0, 1; -8, -3, -3];
B = [0; 0; 4];
C = [2, -9, 2];
D = 0;

%Verificação da controlabilidade e observabilidade do sistema
control = ctrb(A, B);
rank(control)
observ = obsv(A, C);
rank(observ)

%Definição das condições iniciais
x0 = [1; 2; 3];
x0_o = [0; 0; 0]; %Condições iniciais do observador
e = x0-x0_o;

J_c = [-2 ,-1+1j, -1-1j]; %Polos desejados para o controlador
J_o = [-30, -12+2j, -12-2j]; %Polos desejados para o observador

K = acker(A, B, J_c); %Cálculo do ganho K utilizando Ackermaan
K_e = acker(A', C', J_o)'; %Cálculo do ganho do observador utilizando Ackermaan

%Exibição dos ganhos K e K_e
disp('Ganho de realimentação K:');
disp(K);
disp('Ganho do observador L:');
disp(K_e);

%% Criação do sistema realimentado

%Definição das matrizes considerando realimentação
A_comp = [(A - B.*K), (B.*K); zeros(3, 3), A - (K_e.*C)];
B_comp = [B; zeros(size(B))];
C_comp = [C, zeros(size(C))];
D_comp = 0;

%Criação do espaço de estados com as novas matrizes
sys_comp = ss(A_comp, B_comp, C_comp, D_comp);

%% Simulação do sistema 

t = 0:0.01:10; %Vetor de tempo
u = zeros(size(t)); %Entrada zero, R=0
x0_cl = [x0; e]; %Condições iniciais dadas
[y, t, x] = initial(sys_comp, x0_cl, t);

%% Plot dos estados

%Plot de x1
subplot(1,3,1);
plot(t,x(:,1),'Color','magenta');
ylabel("x1 [u]");
xlabel("t [s]");
title("1° estado (x1)");
hold on;
grid on;

%Plot de x2
subplot(1,3,2);
plot(t,x(:,2),'Color','blue');
ylabel("x2 [u]");
xlabel("t [s]");
title("2° estado (x2)");
hold on;
grid on;

%Plot de x3
subplot(1,3,3);
plot(t,x(:,3),'Color','green');
ylabel("x3 [u]");
xlabel("t [s]");
title("3° estado (x3)");
hold on;
grid on;

%Plot de o1
figure;
subplot(1,3,1);
plot(t,x(:,4),'Color','red');
ylabel("o1 [u]");
xlabel("t [s]");
title("o1");
hold on;
grid on;

%Plot de o2
subplot(1,3,2);
plot(t,x(:,5),'Color','yellow');
ylabel("o2 [u]");
xlabel("t [s]");
title("o2");
hold on;
grid on;

%Plot de o3
subplot(1,3,3);
plot(t,x(:,6),'Color','magenta');
ylabel("o3 [u]");
xlabel("t [s]");
title("o3");
hold on;
grid on;

%Plotar a saída
figure;
plot(t, y);
xlabel('t [s]');
ylabel('y [u]');
title('Resposta da Saída do Sistema');
grid on;