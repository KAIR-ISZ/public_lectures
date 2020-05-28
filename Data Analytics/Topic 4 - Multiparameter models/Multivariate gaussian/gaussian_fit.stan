data {
  int<lower=1> N; // number of observations
  int<lower=1> J; // dimension of observations
  vector[J] y[N]; // observations
  vector[J] Zero; // a vector of Zeros (fixed means of observations)
}
parameters {
  cholesky_factor_corr[J] Lcorr;
  vector<lower=0>[J] sigma;
}
model {
  y ~ multi_normal_cholesky(Zero, diag_pre_multiply(sigma, Lcorr));
  sigma ~ exponential(1);
  Lcorr ~ lkj_corr_cholesky(10);
}
generated quantities {
  matrix[J,J] Omega;
  matrix[J,J] Sigma;
  Omega = multiply_lower_tri_self_transpose(Lcorr);
  Sigma = quad_form_diag(Omega, sigma);
}
