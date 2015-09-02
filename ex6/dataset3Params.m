function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0.01;
sigma = 0.01;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

for c = 1:8

  if (c==1)
      C = 0.01;
  elseif (mod(c,2)==0)
      C = C*3;
  else
      C = C/3*10;
  end
  
  for s = 1:8
  
      if (s==1)
            sigma = 0.01;
      elseif (mod(s,2)==0)
            sigma = sigma*3;
      else
            sigma = sigma/3*10;
      end
      
      model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
      predictions = svmPredict(model, Xval);
      error = mean(double(predictions ~= yval));
      
      if exist("optimMatrix")
            optimMatrix = [optimMatrix; C sigma error];
      else
            optimMatrix = [C sigma error];
      end
   end 
 
end

optims = optimMatrix(optimMatrix(:,3)==min(optimMatrix(:,3)),:);

C = optims(1)
sigma = optims(2)


% =========================================================================

end
