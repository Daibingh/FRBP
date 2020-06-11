function proj_train(trainInfo, method, params, filename)
% proj_train(trainInfo, method, params, filename)

switch method 
    case {'pca','PCA'}
        if nargin == 4
            pca_train(trainInfo, params.newSize, params.lm_num, filename);
        else
            pca_train(trainInfo, params.newSize, params.lm_num);
        end        
    case {'lda','LDA'}
        if nargin == 4
            lda_train(trainInfo, params.newSize, params.lm_num, filename);
        else 
            lda_train(trainInfo, params.newSize, params.lm_num);
        end
    case {'mpca','MPCA'}
        if nargin == 4
            mpca_train(trainInfo, params.newSize, params.p, filename);
        else
            mpca_train(trainInfo, params.newSize, params.p);
        end
    case {'pca+lda','PCA+LDA'}
        if nargin == 4
            pca_lda_train(trainInfo, params.newSize, params.lm_num1, params.lm_num2, filename);
        else
            pca_lda_train(trainInfo, params.newSize, params.lm_num1, params.lm_num2);
        end
    case {'mpca+lda','MPCA+LDA'}
        if nargin == 4
            mpca_lda_train(trainInfo, params.newSize, params.p, filename);
        else 
            mpca_lda_train(trainInfo, params.newSize, params.p);
        end
    otherwise
            disp('proj_train: no method!');
end
end