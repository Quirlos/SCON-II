clc; close all; clear

%% Definição das matrizes
A = [0, 1, 0; 0, 0, 1; 0, -16, -10];
B = [0; 0; 120];
C = [1, 0, 0,];
D = 0;

J = [-15, -2+2i, -2-2i]; %Polos desejados

%% Definição do sistema de espaço de estados com realimentação

K = acker(A, B, J); %Cálculo do ganho K por Ackermaan

%Separação dos ganhos K1, K2 e K3 do sistema
K1 = K(1);
K2 = K(2);
K3 = K(3);

%Matrizes considerando realimentação
A_comp = A - B*K;
B_comp = B;
C_comp = C;
D_comp = D;

sys_comp = ss(A_comp, B_comp, C_comp, D_comp); %Espaço de estados considerando a realimentação
disp(pole(sys_comp)) %Verficação da alocação de polos

%% Simulação do sistema realimentado com uma perturbação do tipo impulso de amplitude 10
t = 0:0.01:10; %Vetor de tempo
u = 10 * [1; zeros(length(t)-1, 1)]; %Entrada impulso com amplitude de 10

[y, t, x] = lsim(sys_comp, u, t);

%% Plot dos estados

%Plot de x1
subplot(1,3,1);
plot(t,x(:,1),'Color','magenta');
xlabel("t [s]");
title("x1");
hold on;
grid on;

%Plot de x2
subplot(1,3,2);
plot(t,x(:,2),'Color','blue');
xlabel("t [s]");
title("x2");
grid on;

%Plot de x3
subplot(1,3,3);
plot(t,x(:,3), 'Color','red');
xlabel("t [s]");
title("x3");
grid on;

%Plot da resposta ao impulso
figure;
plot(t, y);
xlabel('t [s]');
ylabel('\phi(t)');
title('Saída do Sistema para um Sinal do Tipo Impulso');
grid on;