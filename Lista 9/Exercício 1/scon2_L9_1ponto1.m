clc; clear; close all

%% Definição das matrizes
A = [1, 2; -6, -12];
B = [-5; 1];
C = [4, -3];
D = 0;

%Verificação de controlabilidade e observabilidade
control = ctrb(A, B);
rank(control)
observ = obsv(A, C);
rank(observ)

%Definição das condições iniciais
x0 = [1; 2];
x0_o = [1; 0]; %Condições iniciais do observador
e = x0-x0_o; %Erro inicial

%% Projeto do controlador
J_c = [-1+1j, -1-1j]; %Polos desejados para o controlador
K = acker(A, B, J_c); %Cálculo do ganho K usando Ackermaan

%% Projeto do observador
J_o = [-12, -12]; %Polos desejados para o observador
K_e = acker(A', C', J_o)'; %Cálculo do ganho do observador usando Ackermaan

%Exibir os ganhos K e K_o
disp('Ganho de realimentação K:');
disp(K);
disp('Ganho do observador L:');
disp(K_e);

%% Criação do sistema realimentado

%Definição das matrizes com realimentação
A_comp = [(A - B*K), (B*K); zeros(2, 2), (A - K_e*C)];
B_comp = zeros(4, 1);
C_comp = [C, zeros(1, 2)];
D_comp = D;

% Criação do espaço de estados com as novas matrizes
sys_comp = ss(A_comp, B_comp, C_comp, D_comp);

%% Simulação do sistema

t = 0:0.01:10; %Vetor de tempo
u = zeros(length(t), 1); %Entrada zero, R=0
x0_cl = [x0; e]; %Condições iniciais dadas
[y, t, x] = initial(sys_comp, x0_cl, t);

%% Plot dos estados

%Plot de x1
subplot(1,2,1);
plot(t,x(:,1),'Color','magenta');
ylabel("x1 [u]");
xlabel("t [s]");
title("1° estado (x1)");
hold on;
grid on;

%Plot de x2
subplot(1,2,2);
plot(t,x(:,2),'Color','blue');
ylabel("x2 [u]");
xlabel("t [s]");
title("2° estado (x2)");
hold on;
grid on;

%Plot de o1
figure;
subplot(1,2,1);
plot(t,x(:,3),'Color','green');
ylabel("o1 [u]");
xlabel("t [s]");
title("o1");
hold on;
grid on;

%Plot de o2
subplot(1,2,2);
plot(t,x(:,4),'Color','red');
ylabel("o2 [u]");
xlabel("t [s]");
title("o2");
hold on;
grid on;

%Plotar a saída
figure;
plot(t, y);
xlabel('Tempo (s)');
ylabel('Saída y');
title('Resposta da Saída do Sistema');
grid on;