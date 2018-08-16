# Sloshing-Finite-Difference

2D sloshing of inviscid fluid in simple rectangular tanker <br />
Independent variables are x, t <br />
ϕ (potential function) and η (surface elevation) are written with Fourier series in terms of x (space coordinate) with 5 terms: <br />
_η=Σ(b(j,n)*cos jx,j=1..5)_ <br />
_ϕ=Σ(a(j,n)*cos jx*(cosh jz+tanh jh sinh jz),j=1..5)_ <br />
n is counter for time, j is counter for space.  <br />
for time, we use finite difference variables <br />
substitute in dynamic and kinematic free surface boundary conditions: <br />
_ηt+u*ηx=w_ <br />
_ϕt+u^2+w^2+gη=0_ <br />
sinh and cosh functions are expanded with Taylor series <br />
trig_expand command is used to simplify the expressions <br />
the problem is reduced to two ODE's:  <br />
_ϕt = f1(ϕ,η)_  <br />
_ηt = f2(ϕ,η)_ <br />
Corrector-predictor method is used to solve these equations <br />
ipynb extension is SageMath file for symbolic calculations <br />
