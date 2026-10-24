function [ dof ] = free_DOF( dof, fixedNode, mesh  )
%PURPOSE: This function takes all degrees of freedom vector, the
%         displacement approximation vector, the fixed nodes structure,
%         geometric structure, and the mesh structure. It returns the free
%         degrees of freedom, that is the degrees of freedom reference of
%         the nodes which are not fixed.
%VARIABLES:
%         alldof    - all degrees of freedom
%         app       - displacement approximation vector
%         freedof   - free degrees of freedom
%         fixedNode - fixed node structure
%         mesh      - mesh structure 
%% -----------------------------------------------------------------------

% degrees of freedom for N layers
DOFX = dof.x;
DOFY = dof.y;
DOFZ = dof.z;

% free degrees of freedom vector
dof.free = dof.all;

typeBC = fixedNode.BC;

switch typeBC
    
    case 'cccc'

        % setting the free degrees of freedom in X
        for i = 1 : size(fixedNode.U,1)
            node = fixedNode.U(i);
            loc = 1 : DOFX;
            loc = loc+(node-1)*DOFX;
            dof.free(loc) = 0;
        end

        % setting the free degrees of freedom in Y
        for i = 1 : size(fixedNode.V,1)
            node = fixedNode.V(i);
            loc = 1 : DOFY;
            loc = loc + (node - 1)*DOFY + DOFX*mesh.nnodes;
            dof.free(loc) = 0;
        end

        % setting the free degrees of freedom in Z
        for i = 1 : size(fixedNode.W,1)
            node = fixedNode.W(i);
            loc = 1 : DOFZ;
            loc = loc + (node -1)*DOFZ + DOFX*mesh.nnodes + DOFY*mesh.nnodes;
            dof.free(loc) = 0;
        end
      
    case 'ssss'
           
        % setting the free degrees of freedom in X
        for i = 1 : size(fixedNode.U,1)
            node = fixedNode.U(i);
            loc = 1;
            loc = loc + (node-1)*DOFX;
            dof.free(loc) = 0;
        end
        
        % setting the free degrees of freedom in Y
        for i = 1 : size(fixedNode.V,1)
            node = fixedNode.V(i);
            loc = 1;
            loc = loc + (node - 1)*DOFY + DOFX*mesh.nnodes;
            dof.free(loc) = 0;
        end        
        
        % setting the free degrees of freedom in Z
        for i = 1 : size(fixedNode.W,1)
            node = fixedNode.W(i);
            loc = 1;
            loc = loc + (node -1)*DOFZ + DOFX*mesh.nnodes + DOFY*mesh.nnodes;
            dof.free(loc) = 0;
        end           
end

end

