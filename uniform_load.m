function [ Fg ] = uniform_load( degrees_of_freedom_structure, mesh_structure, D_matrix_structure, pressure_applied )

NE = mesh_structure.node_element;
nel = mesh_structure.nel;
nnodes = mesh_structure.nnodes;
inci = mesh_structure.inci;
coord = mesh_structure.coord;

%%---------------------- Degrees of freedom -------------------------------
DOFxN = degrees_of_freedom_structure.xN;
DOFyN = degrees_of_freedom_structure.yN;
DOFzN = degrees_of_freedom_structure.zN;

%%---------------------- Pressure applied vector --------------------------
px_top = zeros(DOFxN,1);
px_bot = zeros(DOFxN,1);
py_top = zeros(DOFyN,1);
py_bot = zeros(DOFyN,1);
pz_top = zeros(DOFzN,1);
pz_bot = zeros(DOFzN,1);

px_top(1,1)   = pressure_applied(1,1);
px_bot(end,1) = pressure_applied(2,1);
py_top(1,1)   = pressure_applied(1,2);
py_bot(end,1) = pressure_applied(2,2);
pz_top(1,1)   = pressure_applied(1,3);
pz_bot(end,1) = pressure_applied(2,3);

%%----------------- Computing elemental load vector -----------------------
PG = sqrt(NE);
[ p, w ] = gaussian_quadrature( PG );

load = zeros(NE,1);

        %%----------------- Nodes ------------------------
switch NE
    case 4
        node1 = inci(1,1); % first node element
        node2 = inci(1,2); % second node element
        node3 = inci(1,3); % third node element
        node4 = inci(1,4); % fourth node element
        
        line = [node1 node2 node3 node4];
        
    case 9
        node1 = mesh_structure.inci(1,1); % first node element 
        node2 = mesh_structure.inci(1,2); % second node element
        node3 = mesh_structure.inci(1,3); % third node element
        node4 = mesh_structure.inci(1,4); % fourth node element
        node5 = mesh_structure.inci(1,5); % fifth node element
        node6 = mesh_structure.inci(1,6); % sixth node element
        node7 = mesh_structure.inci(1,7); % seventh node element
        node8 = mesh_structure.inci(1,8); % eighth node element
        node9 = mesh_structure.inci(1,9); % ninth node element

        line = [node1, node2, node3, node4, node5, node6, node7, node8, node9];
end

        %%----------------- Element ----------------------

posxy = coord(line, 2:3);

for ii = 1 : PG
    for jj = 1 : PG
        csi = p(ii);
        eta = p(jj);
        
        switch mesh_structure.type
            case 'Q4'
                [ N, B ] = quad4( csi, eta );
            case 'Q9'
                [ N, B ] = quad9( csi, eta );
        end
        
        %%----- Jacobian --------
        J = B*posxy;
        
        %%----- Load vector -----
        load = load + N'*det(J)*w(ii)*w(jj);
    end 
end
%%------------------------- D matrix --------------------------------------
dxt = D_matrix_structure.uxuxt;
dxb = D_matrix_structure.uxuxb;
dyt = D_matrix_structure.uyuyt;
dyb = D_matrix_structure.uyuyb;
dzt = D_matrix_structure.uzuzt;
dzb = D_matrix_structure.uzuzb;

%%------------------------ Reaction vector --------------------------------
rx = dxt*px_top + dxb*px_bot; srx = size(rx,1);
ry = dyt*py_top + dyb*py_bot; sry = size(ry,1);
rz = dzt*pz_top + dzb*pz_bot; srz = size(rz,1);

%%------------------------ Elemental load vector --------------------------
fe_x = zeros(NE*DOFxN,1);
fe_y = zeros(NE*DOFyN,1);
fe_z = zeros(NE*DOFzN,1);

kx = 1 : DOFxN : DOFxN*NE;
for ii = 1 : srx
    fe_x(kx+ii-1) = fe_x(kx+ii-1) + load*rx(ii);
end

ky = 1 : DOFyN : DOFyN*NE;
for ii = 1 : sry
    fe_y(ky+ii-1) = fe_y(ky+ii-1) + load*ry(ii);
end

kz = 1 : DOFzN : DOFzN*NE;
for ii = 1 : srz
    fe_z(kz+ii-1) = fe_z(kz+ii-1) + load*rz(ii);
end

%%------------------------ Global load vector -----------------------------
fg_x = zeros(nnodes*DOFxN,1);
fg_y = zeros(nnodes*DOFyN,1);
fg_z = zeros(nnodes*DOFzN,1);

for ii = 1 : nel
    
    switch mesh_structure.type
        case 'Q4'
            [ loc ] = loc_vector_QUAD4( degrees_of_freedom_structure, mesh_structure, ii );
        case 'Q9'
            [ loc ] = loc_vector_QUAD9( degrees_of_freedom_structure, mesh_structure, ii );
    end
    
    fg_x(loc.x,1) = fg_x(loc.x,1) + fe_x;
    fg_y(loc.y,1) = fg_y(loc.y,1) + fe_y;
    fg_z(loc.z,1) = fg_z(loc.z,1) + fe_z;
end

Fg = [fg_x; fg_y; fg_z];

end