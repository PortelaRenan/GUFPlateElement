function [ stiffness ] = classic_Hook_iso( mat, geo, ply )
%PURPOSE: This function takes the material and geometry properties of each
%         layer and returns the layer stiffness
%VARIABLES:
%         mat - material properties
%         geo - geometry properties
%         ply - ply to be computed
%% ------------------------------------------------------------------------

E = mat(ply).E;
nu = mat(ply).nu;

%%------------------------- Compliance ------------------------------------
y = [1/E -nu/E -nu/E 0 0 0;
    -nu/E 1/E -nu/E  0 0 0;
    -nu/E -nu/E 1/E  0 0 0;
     0 0 0 2*(1+nu)/E  0 0;
     0 0 0 0  2*(1+nu)/E 0;
     0 0 0 0 0  2*(1+nu)/E];
 
y_aux = y; % Auxiliar compliance matrix

y_aux(3,:) = y(6,:); % Swapping lines
y_aux(6,:) = y(3,:);

compliance = y_aux; % Swapping columns 
compliance(:,3) = y_aux(:,6);
compliance(:,6) = y_aux(:,3);

%%---------------- Stiffness at local coordinates -------------------------
stiffness_local = inv(compliance);

%%------------------- Sines & Cossines ------------------------------------
m = cos(geo(ply).theta);
n = sin(geo(ply).theta);

%%------------------- Transformation matrix -------------------------------
transf = [m^2, n^2,   0,   0,   0,   2*m*n;
          n^2, m^2,   0,   0,   0,  -2*m*n;
            0,   0,   1,   0,   0,       0;
            0,   0,   0,   m,  -n,       0;
            0,   0,   0,   n,   m,       0;
         -m*n, m*n,   0,   0,   0, m^2-n^2];
     
%%---------------- Stiffness at global coordinates ------------------------
stiffness = transf\stiffness_local*transf; 

end