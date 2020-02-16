function A = thin(X, Bf, Bb)
    % Compute the result of hit or miss with X and Bf, Bb
    X_horm = Hit_Or_Miss(X, Bf, Bb);
    
    % Find out the complement image of X_horm
    X_horm_c = xor(X_horm, 1);
    A = bitand_s(X, X_horm_c);
end