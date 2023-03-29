# 锂电池

使用光伏电池给锂电池充电：

![](../assets/锂电池.gif)

```julia
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
using Ai4EComponentLib.Electrochemistry
using Plots

@named batter = Lithium_ion_batteries()
@named Pv = PhotovoltaicCell()
@named ground = Ground()

eqs = [
    connect(batter.p, Pv.p)
    connect(batter.n, Pv.n, ground.g)
]

@named OdeFun = ODESystem(eqs, t)
@named model = compose(OdeFun, [Pv, batter, ground])
sys = structural_simplify(model)
u0 = [
    batter.v_f => 0.5
    batter.v_s => 0.5
    batter.v_soc => 0.5
]
prob = ODEProblem(sys, u0, (0.0, 3600.0))
sol = solve(prob)
```