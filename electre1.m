
mat_jug =  [    
3 5 7 4;
6 5 5 4;
5 2 6 7;
3 7 5 4;
5 4 3 9;
];

poids = [1 1 1 1];

[m,n] = size(mat_jug);
P_SUP = zeros(m);
P_INF = zeros(m);
DIFF = zeros(m);

for i = 1:m
    %disp(i)
    for j = 1:m
        if i ~= j 
            for k = 1:n 
                if mat_jug(i,k) >= mat_jug(j,k)
                    P_SUP(i,j) = P_SUP(i,j)+poids(k);
                else 
                   P_INF(i,j) = P_INF(i,j)+poids(k);
                   if (mat_jug(j,k) -  mat_jug(i,k)) > DIFF(i,j)
                        DIFF(i,j) = (mat_jug(j,k) -  mat_jug(i,k));
                   end
                end
            end
        end
    end
end

sum_poids = sum(poids);
disp("Somme des poids : " +sum_poids); 


C = zeros(m);
for i = 1:m
    for j=1:m 
        if i~=j
          C(i,j) = P_SUP(i,j) / sum_poids ;  
        end
    end
end

D = 1/10 * DIFF;

% Choix des seuils de concordances et discordances
c1 = 0.7;   % Seuil de concordance (minimum)
c2 = 0.25;  % Seuil de discordance (max)
R = zeros(m);

for i = 1:m
    for j=1:m 
        if (C(i,j) > c1) && (D(i,j) < c2) 
            R(i,j) = 1;
        end
    end
end


disp(R);

c1 = c1 - 0.1;
c2 = c2 +0.5;

for i = 1:m
    for j=1:m 
        if (C(i,j) > c1) && (D(i,j) < c2) 
            R(i,j) = 1;
        end
    end
end
disp(R);

c1 = c1 - 0.1;
c2 = c2 +0.5;
for i = 1:m
    for j=1:m 
        if (C(i,j) > c1) && (D(i,j) < c2) 
            R(i,j) = 1;
        end
    end
end
disp(R);

c1 = c1 - 0.1;
c2 = c2 +0.5;
for i = 1:m
    for j=1:m 
        if (C(i,j) > c1) && (D(i,j) < c2) 
            R(i,j) = 1;
        end
    end
end
disp(R);


