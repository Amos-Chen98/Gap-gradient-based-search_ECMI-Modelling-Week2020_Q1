function L = object_function(gaps)
    gap_var = var(gaps)
    gap_mean = mean(gaps)

    lambda = 0.6;
    L = lambda*gap_var+(1-lambda)*gap_mean;
end