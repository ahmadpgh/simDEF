function [ P ] = PMI( x )

	[vec , col] = size(x);
	s = sum(sum(x));
	
    m = log10(ones(vec, col)) + repmat((log10((sum(x')+col)))',1,col);
    disp('Done with the rows add')
    
    n = (log10((ones(vec, col))')+repmat((log10(sum(x)+vec))',1,vec))';
    disp('Done with the columns add')
    
    P = log10(((x+1).*(s+vec*col)))-(m+n);
    
end

