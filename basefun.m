function [vals, inds]=basefun(grid_x,npx,x) 
%Linear interpolation
jl=1;      
ju=npx;	

while((ju-jl>1))
	jm=round((ju+jl)/2);
        if(x>=grid_x(jm))
            jl=jm;
        else
            ju=jm;
        end

end

	i=jl+1;
	vals(2)=( x-grid_x(i-1) )/(grid_x(i)-grid_x(i-1));
	vals(2)=max(0.0d0,min(1.0d0,vals(2)));
	vals(1)=1.0d0-vals(2);
	inds(2)=i;
	inds(1)=i-1;

