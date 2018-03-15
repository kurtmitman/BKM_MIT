function phi = phi_ext(c,params)

%     phi = params.phi_lev ./ (1+params.kappa*c.^-params.psi);
    phi = params.phi_lev*(params.kappa + c).^params.psi_ext; 
end