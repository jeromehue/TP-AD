

A =[    1 2 3 1 1 2;
        2 2 1 2 2 1;
        1 0 3 2 2 1; 
        8 15 10 5 0 10;
        17 11 12 15 7 12;
        8 1 11 3 0 25;
        2 10 5 4 13 7; 
        15 0 20 7 10 25; 
        15 5 3 12 8 10; 
        15 13 15 18 10 7];

B = [   700; 
        610; 
        815; 
        4800; 
        4800;
        4800; 
        4800; 
        4800; 
        4800; 
        4800];
    
lb = [0; 0; 0; 0; 0; 0];


% Optimisation pour le responsable commercial
% (Equilibrage des famille (A/B/C) et (D/E/F) )
Aeq = [ 1 1 1 -1 -1 -1];
beq = [0];

%Optimisation pour le comptable
%(calcul des bénéfices)
f1 = [-43.66;-24.68; -42.9;-33.25; -23.88; -16.98];

% Optimisation pour le responsable d'atelier
% (Somme des produits finits)
f2 = [-1;-1;-1;-1;-1;-1];

% Optimisation pour le responsable des stocks
f3 = [5; 5; 8; 6; 6; 5];

% Optimisation pour le responsable du personnel
f4 = [32; 11 ; 32; 22; 17; 37];

A2 = [A;
    -1 -1 -1 -1 -1 -1
    ];
Abenefice =[A;
    -43.66 -24.68 -42.9 -33.25 -23.88 -16.98];
B2 = [B; -10000];


for k = 1:100
    x(k) = k;
    B2 = [B; -13392*(k/100)];
    res = linprog(f4,Abenefice,B2,[],[], lb, []);
    y(k) = f3' * res;
end
figure(1)
plot(x, y)

% Optimisation des stocks 
B2 = [B; -13394*0.92];
res_stocks = linprog(f3,Abenefice,B2,[],[], lb, [])
sums = -f1'*res_stocks

% Optimisation de l'utilisation des machines
B2 = [B; -13394*0.56];
res_pers = linprog(f4,Abenefice,B2,[],[], lb, [])
sumpers = -f1'*res_pers

%res = linprog(f4,Abenefice,B2,[],[], lb, []);
%res2 = linprog(f2, A,B, Aeq, beq, lb, [])
%sum = -f1'*res
