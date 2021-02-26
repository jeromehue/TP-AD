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
Aeq = [ 1 1 1 -1 -1 -1];
     
beq = [0];

%Optimisation pour le comptable (calcul des bénéfices)
f1 = [-43.6667;-24.6833; -42.9;-33.25; -23.8833; -16.9833];

%Optimisation pour le responsable d'atelier
f2 = [-1;-1;-1;-1;-1;-1];

%Optimisation responsable des stocks
f3 = [5; 5; 8; 6; 6; 5];

%Optimisation responsable du personnel
f4 = [32; 11 ; 32; 22; 17; 37];

A2 = [A;
    -1 -1 -1 -1 -1 -1
    ];
Abenefice =[A;
    -43.66 -24.68 -42.9 -33.25 -23.88 -16.98];

B_stocks = [B; -13394*0.92];
B_pers = [B; -13394*0.56];

res_comptable = linprog(f1, A,B, [], [], lb, []);
res_ateliers = linprog(f2, A,B, [], [], lb, []);
res_stocks = linprog(f3,Abenefice,B_stocks,[],[], lb, []);
res_commercial = linprog(f2, A,B, Aeq, beq, lb, []);
res_pers = linprog(f4,Abenefice,B_pers,[],[], lb, []);

% fonction utilitsée pour le critrère du responsable commercial
f5 = [1; 1; 1; -1; -1; -1];

% Ici pour la ligne de mire de la matrice
% Pour calculer une colonne, on remplace fn par la
% fonction qui correspond au critère de la colonne
sum1 = -f1'*res_comptable;
sum2 = -f2'*res_ateliers;
sum3 =  f3'*res_stocks;
sum4 = -f5'*res_commercial;
sum5 =  f4'*res_pers;

% Critère principal : bénéfice. On ajoute 4 lignes à A pour 
% les autres critères
A_mult = [  A;  
            -1 -1 -1 -1 -1 -1;  % Somme des produits
            5 5 8 6 5 5 ;       % Stocks
            1 1 1 -1 -1 -1;     % A+B+C - (D+E+F)
            -1 -1 -1 1 1 1;     % D+E+F - (A+B+C)
            32 11 32 22 17 37  % Utilisation des machines 2 et 5
            ];
B_mult = [  B; 
            - sum2*0.7; % Critère sur le nombre de produits (a maximiser)
              sum3*1.2;  % Critère sur le stock (à minimiser)
              20;        % critère sur la différence des produits (1ère borne)
              20;        % critère sur la différence des produits (2nd borne)
              sum5*1.2   % Critère sur l'utilisation des machines 2 et 5
           ];
% Modélisation multicritère
res_mult = linprog(f1, A_mult,B_mult, [], [], lb, [])
sum_mult = -f2'*res_mult
benef_mult = -f1'*res_mult
