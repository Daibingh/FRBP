function mat = vhcat(varargin)
n = 0;
for i=1:nargin
    if length(varargin{i})>n
        n = length(varargin{i});
    end
end
mat = zeros(n, nargin);
for i=1:nargin
    mat(:,i) = [varargin{i}; nan(n-length(varargin{i}), 1)];
end
end