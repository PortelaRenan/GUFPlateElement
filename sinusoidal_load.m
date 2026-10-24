function [ Fg ] = sinusoidal_load( degrees_of_freedom_structure, mesh_structure, D_matrix_structure, pressure_applied )

NE = mesh_structure.node_element;
nel = mesh_structure.nel;
nnodes = mesh_structure.nnodes;
inci = mesh_structure.inci;
coord = mesh_structure.coord;
a = mesh_structure.Lx;
b = mesh_structure.Ly;

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

%%------------------------- D matrix --------------------------------------
dxt = D_matrix_structure.uxuxt;
dxb = D_matrix_structure.uxuxb;
dyt = D_matrix_structure.uyuyt;
dyb = D_matrix_structure.uyuyb;
dzt = D_matrix_structure.uzuzt;
dzb = D_matrix_structure.uzuzb;

%%------------------------ Reaction vector --------------------------------
rx = dxt*px_top + dxb*px_bot; 
ry = dyt*py_top + dyb*py_bot; 
rz = dzt*pz_top + dzb*pz_bot; 

%%----------------- Computing elemental load vector -----------------------
PG = sqrt(NE);
[ p, w ] = gaussian_quadrature( PG );
F_global.x = zeros(nnodes*DOFxN,1);
F_global.y = zeros(nnodes*DOFyN,1);
F_global.z = zeros(nnodes*DOFzN,1);

for ii = 1 : nel
    F_load.x = zeros(DOFxN*NE,1); 
    F_load.y = zeros(DOFyN*NE,1); 
    F_load.z = zeros(DOFzN*NE,1);
    load = zeros(NE,1);
    for jj = 1 : PG
        for kk = 1 : PG
            csi = p(jj); eta = p(kk);
            line = inci(ii,:); posxy = coord(line,2:3);
            coordx = posxy(:,1); coordy = posxy(:,2);
            switch mesh_structure.type
                case 'Q4'
                    [ N, B ] = quad4( csi, eta );
                case 'Q9'
                    [ N, B ] = quad9( csi, eta );
            end    
            %%----- Jacobian --------
                J = B*posxy;
            %%----- Load vector -----
            load = load + N'*det(J)*w(jj)*w(kk).*sin(coordx*pi/a).*sin(coordy*pi/b);                
        end
    end
    step_x = 1 : DOFxN : DOFxN*NE;
    for jj = 1 : size(rx,1)
        F_load.x(step_x) = F_load.x(step_x) + load*rx(jj);
        step_x = step_x + 1; 
    end
    step_y = 1 : DOFyN : DOFyN*NE;
    for jj = 1 : size(ry,1)
        F_load.y(step_y) = F_load.y(step_y) + load*ry(jj);
        step_y = step_y + 1; 
    end
    step_z = 1 : DOFzN : DOFzN*NE;
    for jj = 1 : size(rz,1)
        F_load.z(step_z) = F_load.z(step_z) + load*rz(jj);
        step_z = step_z + 1; 
    end
    switch mesh_structure.type
        case 'Q4'
            [ loc ] = loc_vector_QUAD4( degrees_of_freedom_structure, mesh_structure, ii );
        case 'Q9'
            [ loc ] = loc_vector_QUAD9( degrees_of_freedom_structure, mesh_structure, ii );
    end
    F_global.x(loc.x,1) = F_global.x(loc.x,1) + F_load.x;
    F_global.y(loc.y,1) = F_global.y(loc.y,1) + F_load.y;
    F_global.z(loc.z,1) = F_global.z(loc.z,1) + F_load.z;
end

Fg = [F_global.x;F_global.y;F_global.z];

end