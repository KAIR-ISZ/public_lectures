data {
  int M;//number of measurements
  int N[M];//count of animals per experiment
  real X[M];//doses of substance per experiment
}


generated quantities {
  real alpha=student_t_rng(5,0,10);
  real beta=student_t_rng(5,0,10);

  int y_sim[M];
  for (k in 1:M) {
    y_sim[k] = binomial_rng(N[k],inv_logit(alpha+beta*X[k]));
  }
}
