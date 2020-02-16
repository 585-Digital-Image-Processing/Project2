function [B_f, B_b] = Structure_E()
% create a cell for foreground structuring elements
B_f={};
B_f{1} = [0 0 0; 0 1 0; 1 1 1];
B_f{2}= [0 0 0 ;1 1 0; 1 1 0];
B_f{3} = [1 0 0; 1 1 0; 1 0 0 ];
B_f{4} = [1 1 0; 1 1 0; 0 0 0];
B_f{5} = [1 1 1 ; 0 1 0 ; 0 0 0 ];
B_f{6} = [0 1 1 ; 0 1 1 ; 0 0 0 ];
B_f{7} = [0 0 1; 0 1 1; 0 0 1];
B_f{8} = [0 0 0 ; 0 1 1 ; 0 1 1];

 % create a cell for background structuring elements
B_b={};
B_b{1} = [1 1 1; 0 0 0; 0 0 0 ];
B_b{2} = [0 1 1; 0 0 1; 0 0 0];
B_b{3} = [0 0 1; 0 0 1; 0 0 1];
B_b{4} = [0 0 0; 0 0 1; 0 1 1];
B_b{5} = [0 0 0; 0 0 0 ; 1 1 1];
B_b{6}= [0 0 0; 1 0 0 ; 1 1 0];
B_b{7} = [1 0 0 ; 1 0 0 ; 1 0 0 ];
B_b{8} = [1 1 0 ; 1 0 0 ; 0 0 0];



 