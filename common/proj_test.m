function [test_label, rate] = proj_test(method, filename,test_name,disFun, test_label_true)
% [labels, rate] = proj_test(method, filename,test_name,disFun, test_label_true)

switch method 
    case {'pca','PCA'}
        if nargin == 5
            [test_label, rate] = pca_test(filename,test_name,disFun, test_label_true);
        else
            [test_label, rate] = pca_test(filename,test_name,disFun);
        end
    case {'lda','LDA'}
        if nargin == 5
            [test_label, rate] = lda_test(filename, test_name, disFun, test_label_true);
        else 
            [test_label, rate] = lda_test(filename, test_name, disFun);
        end
    case {'mpca','MPCA'}
        if nargin == 5
            [test_label, rate] = mpca_test(filename, test_name, disFun, test_label_true);
        else
            [test_label, rate] = mpca_test(filename, test_name, disFun);
        end
    case {'pca+lda','PCA+LDA'}
        if nargin == 5
            [test_label, rate] = pca_lda_test(filename, test_name, disFun, test_label_true);
        else 
            [test_label, rate] = pca_lda_test(filename, test_name, disFun);
        end
    case {'mpca+lda','MPCA+LDA'}
        if nargin == 5
            [test_label, rate] = mpca_lda_test(filename, test_name, disFun, test_label_true);
        else
            [test_label, rate] = mpca_lda_test(filename, test_name, disFun);
        end
    otherwise
            disp('proj_test: no method!'); 
            test_label = []; rate = [];
            return;
end
end