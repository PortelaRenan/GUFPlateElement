function [ KG ] = global_stiffness_matrix( degrees_of_freedom_structure, local_stiffness, mesh_structure )

%%------------------------ Mesh Data --------------------------------------
nel = mesh_structure.nel;
nnodes = mesh_structure.nnodes;

%%---------------------- Degrees of freedom -------------------------------
DOFx = degrees_of_freedom_structure.xN;
DOFy = degrees_of_freedom_structure.yN;
DOFz = degrees_of_freedom_structure.zN;

%%---------------------- Matrices pre-allocation --------------------------
global_stiffness.uxux = zeros(DOFx * nnodes);
global_stiffness.uxuy = zeros(DOFx * nnodes, DOFy * nnodes);
global_stiffness.uxuz = zeros(DOFx * nnodes, DOFz * nnodes);
global_stiffness.uyuy = zeros(DOFy * nnodes);
global_stiffness.uyuz = zeros(DOFy * nnodes, DOFz * nnodes);
global_stiffness.uzuz = zeros(DOFz * nnodes);

%%--------------------------- Assembly ------------------------------------
for i = 1 : nel
    
    switch mesh_structure.type
        case 'Q4'
            [ loc ] = loc_vector_QUAD4( degrees_of_freedom_structure, mesh_structure, i );
        case 'Q9'
            [ loc ] = loc_vector_QUAD9( degrees_of_freedom_structure, mesh_structure, i );
    end
    
    global_stiffness.uxux(loc.x, loc.x) = global_stiffness.uxux(loc.x, loc.x) + local_stiffness.uxux;
    global_stiffness.uxuy(loc.x, loc.y) = global_stiffness.uxuy(loc.x, loc.y) + local_stiffness.uxuy;
    global_stiffness.uxuz(loc.x, loc.z) = global_stiffness.uxuz(loc.x, loc.z) + local_stiffness.uxuz;
    global_stiffness.uyuy(loc.y, loc.y) = global_stiffness.uyuy(loc.y, loc.y) + local_stiffness.uyuy;
    global_stiffness.uyuz(loc.y, loc.z) = global_stiffness.uyuz(loc.y, loc.z) + local_stiffness.uyuz;
    global_stiffness.uzuz(loc.z, loc.z) = global_stiffness.uzuz(loc.z, loc.z) + local_stiffness.uzuz;
end

%%------------------------- Transpose matrices ----------------------------
global_stiffness.uyux = transpose(global_stiffness.uxuy);
global_stiffness.uzux = transpose(global_stiffness.uxuz);
global_stiffness.uzuy = transpose(global_stiffness.uyuz);


KG = [global_stiffness.uxux global_stiffness.uxuy global_stiffness.uxuz;
      global_stiffness.uyux global_stiffness.uyuy global_stiffness.uyuz;
      global_stiffness.uzux global_stiffness.uzuy global_stiffness.uzuz];

end

