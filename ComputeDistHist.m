trows = zeros(nA_fine*ns*ns*2,1);
tcols = trows;
tvals = tcols;
index = 0;
for j=1:ns
    for ai = 1:nA_fine
        [vals,inds]=basefun(params.Agrid_fine,nA_fine,dec_fine(ai,j));
        for jp=1:ns
            index = index+1;
            trows(index) = ai+(j-1)*nA_fine;
            tcols(index) = inds(1)+(jp-1)*nA_fine;
            tvals(index) = params.piex(j,jp)*vals(1);
            index = index+1;
            trows(index) = ai+(j-1)*nA_fine;
            tcols(index) = inds(2)+(jp-1)*nA_fine;
            tvals(index) = params.piex(j,jp)*vals(2);
        end
    end
end
transMat = sparse(trows,tcols,tvals,nA_fine*ns,nA_fine*ns);
[EigVec,EigVal] = eigs(transMat',1);
EigVec=EigVec/sum(EigVec);
EigVec(EigVec<0)=0;
EigVec=EigVec/sum(EigVec);
G0 = reshape(EigVec/sum(EigVec),[nA_fine ns]);


a = sum(G0.*dec_fine,1);
c = sum(G0.*c_fine,1);
labs = sum(G0.*lab_fine.*repmat(exL',[nA_fine 1]));
for j=1:params.ns
    Capprox(j) = pchip(params.Agrid,cpol(:,j));
    MPCwealth(j) = myfnder(Capprox(j));
    MPCFine(:,j) = ppval(MPCwealth(j),Agrid_fine);
end
mpc = sum(G0.*MPCFine,1);

