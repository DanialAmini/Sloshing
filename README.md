# Sloshing-Finite-Difference

2D sloshing of inviscid fluid in simple rectangular tanker

Independent variables are x, t
ϕ (potential function) and η (surface elevation) are written with Fourier series in terms of x (space coordinate) with 5 terms:
η=Σ(b(j,n)*cos jx,j=1..5)
ϕ=Σ(a(j,n)*cos jx*(cosh jz+tanh jh sinh jz),j=1..5)
n is counter for time, j is counter for space. 
for time, we use finite difference variables
substitute in dynamic and kinematic free surface boundary conditions:
ηt+u*ηx=w
ϕt+u^2+w^2+gη=0
sinh and cosh functions are expanded with Taylor series
trig_expand command is used to simplify the expressions
the problem is reduced to two ODE's: 
ϕt = f1(ϕ,η) 
ηt = f2(ϕ,η)
Corrector-predictor method is used to solve these equations

ipynb extension is SageMath file for symbolic calculations
