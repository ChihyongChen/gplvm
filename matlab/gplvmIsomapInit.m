function [X, sigma2] = gplvmIsomapInit(Y, dims)

% GPLVMISOMAPINIT Initialise gplvm model with isomap (need isomap toolbox).

% GPLVM

% Note isomap code uses the transpose of a design matrix.
if any(any(isnan(Y)))
  error('Cannot initialise gplvm using isomap when missing data is present.')
else
  D = L2_distance(Y', Y', 1);
  options.dims = 1:dims;
  neighbours = 7;
  [Xstruct, sigma2, E] = Isomap(D, 'k', neighbours, options);
  X = Xstruct.coords{dims}';
  % Rescale X so that variance is 1 and mean is zero.
  meanX = mean(X);
  X = X-ones(size(Y, 1), 1)*meanX;
  varX = var(X);
  X = X*diag(sqrt(1./varX));
end