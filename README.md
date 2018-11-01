# Sloshing-Finite-Difference

2D sloshing of inviscid fluid in simple rectangular tanker <br />
Independent variables are `x`, `t` <br />
`ϕ` (potential function) and `η` (surface elevation) are written with Fourier series in terms of `x` (space coordinate) with 5 (or Nf) terms: <br />

                η=Σ(b(j,n)*cos jx,j=1..5)
                ϕ=Σ(a(j,n)*cos jx*(cosh jz+tanh jh sinh jz),j=1..5)
                
`n` is counter for time, `j` is counter for space.  <br />
for time, we use finite difference variables <br />
substitute in dynamic and kinematic free surface boundary conditions: <br />

                ηt+u*ηx=w
                ϕt+(u^2+w^2)/2+gη=0

sinh and cosh functions are expanded with Taylor series <br />
trig_expand command is used to simplify the expressions <br />
the problem is reduced to two ODE's:  <br />

                ϕt = FD(ϕ,η)
                ηt = FK(ϕ,η)

Corrector-predictor method is used to solve these equations <br />
The variables to be solved are essentially `A` and `B` where `A=[a0 a1 a2 a3 a4 a5]` and `B=[b1 b2 b3 b4 b5]` although higher number of Fourier terms can be prescribed too. 

The code is written in Julia. Julia is a numerical calculation software which can be easily downloaded (50 MB approximately). The code is then copied into the installation directory and called from within Julia. Values of coefficients `a` and `b` should be written in the `.jl` file and the results are stored in text files.

List of works done and future wishlist:

- [x] Implement numerical code, predictor-corrector
- [x] Solve benchmark question
- [ ] Add horizontally forced sloshing
- [ ] Try perturbation/finite difference
- [ ] Extend work of Sobey (2009) to higher orders
- [ ] Try problem with a baffle (bulkhead in oil tankers)

