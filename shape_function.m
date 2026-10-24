function [ local_stiffness_matrix ] = shape_function( mesh_structure )

theory = mesh_structure.type;

switch theory
    case 'Q4'
    PG = 2;
    [ p, w ] = gaussian_quadrature( PG );

    local_stiffness_matrix = zeros(4,4,9);

    node1 = mesh_structure.inci(1,1); % first node element 
    node2 = mesh_structure.inci(1,2); % second node element
    node3 = mesh_structure.inci(1,3); % third node element
    node4 = mesh_structure.inci(1,4); % fourth node element

    line = [node1, node2, node3, node4];
    posxy = mesh_structure.coord(line, 2:3);

    for ii = 1 : PG
        for jj = 1 : PG
            csi = p(ii);
            eta = p(jj);

            [ N, B ] = quad4( csi, eta );

            % Jacobian
            J = B*posxy;
            % Jacobian's inverse
            iJ = inv(J);
            B_x = iJ(1,1)*B(1,:) + iJ(1,2)*B(2,:);
            B_y = iJ(2,1)*B(1,:) + iJ(2,2)*B(2,:);

    %%------------------------------ Bx Bx ------------------------------------        
            local_stiffness_matrix(:,:,1) = local_stiffness_matrix(:,:,1) + B_x'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ Bx By ------------------------------------
            local_stiffness_matrix(:,:,2) = local_stiffness_matrix(:,:,2) + B_x'*B_y*det(J)*w(ii)*w(jj);
    %%------------------------------ By Bx ------------------------------------
            local_stiffness_matrix(:,:,3) = local_stiffness_matrix(:,:,3) + B_y'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ By By ------------------------------------
            local_stiffness_matrix(:,:,4) = local_stiffness_matrix(:,:,4) + B_y'*B_y*det(J)*w(ii)*w(jj);
    %%------------------------------ N  N  ------------------------------------
            local_stiffness_matrix(:,:,5) = local_stiffness_matrix(:,:,5) + N'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ Bx N  ------------------------------------
            local_stiffness_matrix(:,:,6) = local_stiffness_matrix(:,:,6) + B_x'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ By N  ------------------------------------
            local_stiffness_matrix(:,:,7) = local_stiffness_matrix(:,:,7) + B_y'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ N  Bx ------------------------------------
            local_stiffness_matrix(:,:,8) = local_stiffness_matrix(:,:,8) + N'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ N  By ------------------------------------
            local_stiffness_matrix(:,:,9) = local_stiffness_matrix(:,:,9) + N'*B_y*det(J)*w(ii)*w(jj);
        end
    end

    case 'Q9'
    PG = 3;
    [ p, w ] = gaussian_quadrature( PG );
    
    local_stiffness_matrix = zeros(9,9,9);

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
    posxy = mesh_structure.coord(line, 2:3);    
    
    for ii = 1 : PG
        for jj = 1 : PG
            csi = p(ii);
            eta = p(jj);

            [ N, B ] = quad9( csi, eta );

            % Jacobian
            J = B*posxy;
            % Jacobian's inverse
            iJ = inv(J);
            B_x = iJ(1,1)*B(1,:) + iJ(1,2)*B(2,:);
            B_y = iJ(2,1)*B(1,:) + iJ(2,2)*B(2,:);

    %%------------------------------ Bx Bx ------------------------------------        
            local_stiffness_matrix(:,:,1) = local_stiffness_matrix(:,:,1) + B_x'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ Bx By ------------------------------------
            local_stiffness_matrix(:,:,2) = local_stiffness_matrix(:,:,2) + B_x'*B_y*det(J)*w(ii)*w(jj);
    %%------------------------------ By Bx ------------------------------------
            local_stiffness_matrix(:,:,3) = local_stiffness_matrix(:,:,3) + B_y'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ By By ------------------------------------
            local_stiffness_matrix(:,:,4) = local_stiffness_matrix(:,:,4) + B_y'*B_y*det(J)*w(ii)*w(jj);
    %%------------------------------ N  N  ------------------------------------
            local_stiffness_matrix(:,:,5) = local_stiffness_matrix(:,:,5) + N'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ Bx N  ------------------------------------
            local_stiffness_matrix(:,:,6) = local_stiffness_matrix(:,:,6) + B_x'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ By N  ------------------------------------
            local_stiffness_matrix(:,:,7) = local_stiffness_matrix(:,:,7) + B_y'*N*det(J)*w(ii)*w(jj);
    %%------------------------------ N  Bx ------------------------------------
            local_stiffness_matrix(:,:,8) = local_stiffness_matrix(:,:,8) + N'*B_x*det(J)*w(ii)*w(jj);
    %%------------------------------ N  By ------------------------------------
            local_stiffness_matrix(:,:,9) = local_stiffness_matrix(:,:,9) + N'*B_y*det(J)*w(ii)*w(jj);
        end
    end    
    
end

end

