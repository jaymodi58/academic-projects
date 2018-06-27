% Particle 1_1 
    j = 1;
    System.particles.x(:,j) = System.particles.x(:,j)   - lambda * Grad( System, j );     
    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.',...
        'Color', System.C(j,:) ); 
    
    drawnow;
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;

    % Particle 1_2 
    j = 2;
    System.particles.x(:,j) = System.particles.x(:,j)   - lambda * Grad( System, j );     
    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.',...
        'Color', System.C(j,:) ); 
    
    drawnow;
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;
    
    % Particle 1_3
    j = 3;
    System.particles.x(:,j) = System.particles.x(:,j)   - lambda * Grad( System, j );     
    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.',...
        'Color', System.C(j,:) ); 
    
    drawnow;    
    % Has particle reached destination? Store true or false here.  
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;
    

    % Particle 2_1
    j = 4;
    System.particles.x(:,j) = System.particles.x(:,j) ...
        - lambda * Grad( System, j );   
    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.', ...
        'Color', System.C(j,:) );   
    
    drawnow;
    % Has particle reached destination? Store true or false here.  
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;
    
    
    % Particle 2_2
    j = 5;
    System.particles.x(:,j) = System.particles.x(:,j) ...
        - lambda * Grad( System, j );   
    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.', ...
        'Color', System.C(j,:) );   
    
    drawnow;
    % Has particle reached destination? Store true or false here.  
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;
    
    % Particle 2_3
    j = 6;
    System.particles.x(:,j) = System.particles.x(:,j) ...
        - lambda * Grad( System, j );    
    hold on;
    plot( System.particles.x(1,j), System.particles.x(2,j), '.', ...
        'Color', System.C(j,:) );   
    drawnow;
    % Has particle reached destination? Store true or false here.  
    reached( j ) = norm( System.particles.x(:,j) - System.particles.g(:,j) ) <= System.mindist;