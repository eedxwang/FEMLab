function calcA(files, optProb)
disp('-Setting up element matrices and calculating A')
tic

load(files.respth, 'sElements', 'regSet', 'nNodes', 'nElems', 'prescNodes', ...
    'elemsRegion', 'nTris', 'nLines', 'triangles', 'x', 'y', 'const')

[hFunElemK, hFunElemR] = slv.getFuns('element', optProb);
[hFunQuadK, hFunQuadR] = slv.getFuns('quadrature', optProb);

[xTri, yTri] = msh.getTriXY(triangles, x, y, nTris);
areaTri = util.calcAreaTri(xTri, yTri, nTris);
ABCs = slv.calcAbcs(xTri, yTri, nTris, areaTri);

[matParams, srcParams] = msh.getElemParams(optProb, elemsRegion, regSet, const);

[Uk, Ik] = slv.setKnownPot(triangles, nTris, prescNodes, regSet);

matK = spalloc(nNodes, nNodes, 6*nNodes);
vecR = zeros(nNodes, 1);

for iElem = nLines+1:nElems
    iTri = iElem-nLines;
    abc = reshape(ABCs(iTri,:,:), [3,3]);

    [tK, tR, tU, tn] = ... % U, hFunQuadK, hFunQuadR, hFunElemK, hFunElemR, A, abc, xe, ye, k1, f, I)
        slv.calcElementMats(Uk(iTri,:)', hFunQuadK, hFunQuadR, hFunElemK, hFunElemR, areaTri(iTri),abc,...
        xTri(iTri,:), yTri(iTri,:), matParams(iElem), srcParams(iElem), Ik(iTri,:));
    
    iN = sElements.nodes(iElem, tn);
    
    matK(iN, iN) = matK(iN, iN) + tK(tn, tn);
    vecR(iN) = vecR(iN) + tR(tn);
    
    %elements(iElem).matK = tK(tn, tn);
    %elements(iElem).vecR = tR(tn);
    %elements(iElem).U = tU;
    
end

Ap = zeros(nNodes, 1);

I = any(matK,2);
bUnknownPot = I;
bKnownPot = ~I;
matK = matK(I,:);
vecR = vecR(I);
I = any(matK,1);
matK = matK(:,I);

PotKnown = slv.getKnownPot(bKnownPot, prescNodes, regSet);
PotUnknown = matK\vecR;
Ap(bUnknownPot) = PotUnknown;
Ap(bKnownPot) = PotKnown;

save(files.respth, 'Ap', 'matK', 'vecR', 'areaTri', 'ABCs', '-append');
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end