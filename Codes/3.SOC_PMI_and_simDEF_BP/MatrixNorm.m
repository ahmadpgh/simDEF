function [ P ] = MatrixNorm( x )

	a = 1./(sqrt(sum(x.*x,2)));
    n = length(a);
	D = spdiags(a(:),0,n,n);
	P = D*x;
    
end


