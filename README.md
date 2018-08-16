# Sloshing-Finite-Difference

2D sloshing of inviscid fluid in simple rectangular tanker <br />
Independent variables are x, t <br />
ϕ (potential function) and η (surface elevation) are written with Fourier series in terms of x (space coordinate) with 5 terms: <br />
η=Σ(b(j,n)*cos jx,j=1..5) <br />
ϕ=Σ(a(j,n)*cos jx*(cosh jz+tanh jh sinh jz),j=1..5) <br />
n is counter for time, j is counter for space.  <br />
for time, we use finite difference variables <br />
substitute in dynamic and kinematic free surface boundary conditions: <br />
ηt+u*ηx=w <br />
ϕt+u^2+w^2+gη=0 <br />
sinh and cosh functions are expanded with Taylor series <br />
trig_expand command is used to simplify the expressions <br />
the problem is reduced to two ODE's:  <br />
ϕt = f1(ϕ,η)  <br />
ηt = f2(ϕ,η) <br />
Corrector-predictor method is used to solve these equations <br />
ipynb extension is SageMath file for symbolic calculations <br />
