function flg = judgeInside(x, x_mean, t, th)
e = reproj(x, x_mean, t);
if e>=th
    flg = false;
else
    flg = true;
end
end