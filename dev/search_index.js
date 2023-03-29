var documenterSearchIndex = {"docs":
[{"location":"examples/Exam_PEMElectrolyzer/#电解槽","page":"电解槽","title":"电解槽","text":"","category":"section"},{"location":"examples/Exam_PEMElectrolyzer/","page":"电解槽","title":"电解槽","text":"使用光伏电池驱动电解槽：","category":"page"},{"location":"examples/Exam_PEMElectrolyzer/","page":"电解槽","title":"电解槽","text":"(Image: )","category":"page"},{"location":"examples/Exam_PEMElectrolyzer/","page":"电解槽","title":"电解槽","text":"using ModelingToolkit, DifferentialEquations\nusing Ai4EComponentLib\nusing Ai4EComponentLib.Electrochemistry\n\n@named Pv = PhotovoltaicCell()\n@named El = PEMElectrolyzer()\n@named ground = Ground()\neqs = [\n    connect(Pv.p, El.p)\n    connect(Pv.n, El.n, ground.g)\n]\n@named OdeFun = ODESystem(eqs, t)\n@named model = compose(OdeFun, [Pv, El, ground])\nsys = structural_simplify(model)\nu0 = [\n    El.m_H_2 => 0.0\n    El.∂_m_H_2 => 0.0\n]\nprob = ODEProblem(sys, u0, (0.0, 30.0))\nsol = solve(prob)","category":"page"},{"location":"examples/Exam_Li_battery/#锂电池","page":"锂电池","title":"锂电池","text":"","category":"section"},{"location":"examples/Exam_Li_battery/","page":"锂电池","title":"锂电池","text":"使用光伏电池给锂电池充电：","category":"page"},{"location":"examples/Exam_Li_battery/","page":"锂电池","title":"锂电池","text":"(Image: )","category":"page"},{"location":"examples/Exam_Li_battery/","page":"锂电池","title":"锂电池","text":"using ModelingToolkit, DifferentialEquations\nusing Ai4EComponentLib\nusing Ai4EComponentLib.Electrochemistry\nusing Plots\n\n@named batter = Lithium_ion_batteries()\n@named Pv = PhotovoltaicCell()\n@named ground = Ground()\n\neqs = [\n    connect(batter.p, Pv.p)\n    connect(batter.n, Pv.n, ground.g)\n]\n\n@named OdeFun = ODESystem(eqs, t)\n@named model = compose(OdeFun, [Pv, batter, ground])\nsys = structural_simplify(model)\nu0 = [\n    batter.v_f => 0.5\n    batter.v_s => 0.5\n    batter.v_soc => 0.5\n]\nprob = ODEProblem(sys, u0, (0.0, 3600.0))\nsol = solve(prob)","category":"page"},{"location":"examples/Exam_IncompressiblePipe/#水力管网系统","page":"水力管网系统","title":"水力管网系统","text":"","category":"section"},{"location":"examples/Exam_IncompressiblePipe/","page":"水力管网系统","title":"水力管网系统","text":"(Image: 图 1)","category":"page"},{"location":"examples/Exam_IncompressiblePipe/","page":"水力管网系统","title":"水力管网系统","text":"(Image: )","category":"page"},{"location":"examples/Exam_IncompressiblePipe/","page":"水力管网系统","title":"水力管网系统","text":"@info \"Running IncompressiblePipe...\"\nusing Ai4EComponentLib\nusing Ai4EComponentLib.IncompressiblePipe\nusing OrdinaryDiffEq, ModelingToolkit\nusing Test\n\n@info \"Constructing components...\"\n@named high = Source_P(D=0.15, z=25.0, ρ=1.0E3, p=101325, K_inlet=0.5)\n@named low = Sink_P(p=101325)\n@named elbow1 = ElbowPipe(K=0.9, D=0.15, ρ=1.0E3, zin=0.0, zout=0.0)\n@named elbow2 = ElbowPipe(K=0.9, D=0.15, ρ=1.0E3, zin=15.0, zout=15.0)\n@named pipe1 = SimplePipe(L=30.0, D=0.15, f=0.023, zin=25.0, zout=0.0, K_inside=0.0)\n@named pipe2 = SimplePipe(L=15.0, D=0.15, f=0.023, zin=0.0, zout=15.0, K_inside=0.0)\n@named pipe3 = SimplePipe(L=60.0, D=0.15, f=0.023, zin=15.0, zout=15.0, K_inside=10.8)\n\n@info \"Constructing system...\"\neqs = [\n    connect(high.port, pipe1.in)\n    connect(pipe1.out, elbow1.in)\n    connect(elbow1.out, pipe2.in)\n    connect(pipe2.out, elbow2.in)\n    connect(elbow2.out, pipe3.in)\n    connect(pipe3.out, low.port)\n]\n\n@named model = compose(ODESystem(eqs, t, name=:funs), [high, low, pipe1, pipe2, pipe3, elbow1, elbow2])\n\n@info \"Simplifying system...\"\nsys = structural_simplify(model)\n\n@info \"Solving system...\"\nprob = ODEProblem(sys, [], (0, 0))\nsol = solve(prob, Rosenbrock23())\n\n@test isapprox(sol[pipe1.in.q][1], 0.045, atol=0.0005)","category":"page"},{"location":"examples/Exam_ThermodynamicCycle/#热力循环系统","page":"热力循环系统","title":"热力循环系统","text":"","category":"section"},{"location":"examples/Exam_ThermodynamicCycle/","page":"热力循环系统","title":"热力循环系统","text":"简单朗肯循环：","category":"page"},{"location":"examples/Exam_ThermodynamicCycle/","page":"热力循环系统","title":"热力循环系统","text":"(Image: 图 2) ","category":"page"},{"location":"examples/Exam_ThermodynamicCycle/","page":"热力循环系统","title":"热力循环系统","text":"(Image: )","category":"page"},{"location":"examples/Exam_ThermodynamicCycle/","page":"热力循环系统","title":"热力循环系统","text":"@info \"Running ThermodynamicCycle...\"\nusing Ai4EComponentLib\nusing Ai4EComponentLib.ThermodynamicCycle\nusing OrdinaryDiffEq, ModelingToolkit\nusing Test\n\n@info \"Constructing components...\"\n@named pump = IsentropicProcess(inter_state=\"P\")\n@named pump_P = ThermalStates(state=\"P\", value=3.0E6)\n\n@named boiler = IsobaricProcess(inter_state=\"T\")\n@named boiler_T = ThermalStates(state=\"T\", value=723.15)\n\n@named turbine = IsentropicProcess(inter_state=\"P\")\n@named turbine_P = ThermalStates(state=\"P\", value=4.0E3)\n\n@named condenser = IsothermalProcess(inter_state=\"Q_0\")\n\n@info \"Constructing system...\"\neqs = [\n    connect(pump.out, boiler.in)\n    connect(boiler.in, pump_P.node)\n    connect(boiler.out, turbine.in)\n    connect(turbine.in, boiler_T.node)\n    connect(turbine.out, condenser.in)\n    connect(condenser.in, turbine_P.node)\n    connect(condenser.out, pump.in)\n]\n\n@named model = ODESystem(eqs, t, systems=[pump, boiler, turbine, condenser, pump_P, boiler_T, turbine_P])\n\n@info \"Simplifying system...\"\nsys = structural_simplify(model)\n\n@info \"Solving system...\"\nprob = ODEProblem(sys, [], (0, 0))\nsol = solve(prob, Rosenbrock23())\n\nq1 = sol[boiler.Δh][1]\nw = -sol[turbine.Δh][1] - sol[pump.Δh][1]\n\n@test isapprox(w / q1, 0.4, atol=0.05)","category":"page"},{"location":"examples/Exam_AirPipeSim/#空气管道系统","page":"空气管道系统","title":"空气管道系统","text":"","category":"section"},{"location":"examples/Exam_AirPipeSim/","page":"空气管道系统","title":"空气管道系统","text":"(Image: Fig 1.1)","category":"page"},{"location":"examples/Exam_AirPipeSim/","page":"空气管道系统","title":"空气管道系统","text":"(Image: )","category":"page"},{"location":"examples/Exam_AirPipeSim/","page":"空气管道系统","title":"空气管道系统","text":"# Define components\nusing Ai4EComponentLib\nusing Ai4EComponentLib.AirPipeSim\nusing ModelingToolkit, DifferentialEquations\n\n@named inlet = PressureSource(p=6e5, T=300)\n@named pipe1 = AirSimplePipe(R=100, T=300)\n@named pipe2 = TransitionPipe(n=20, f=0.016, D=0.2, L=100, T=300, pins=5.6e5, pouts=4e5)\n@named airTank = AirStorageTank(V=20, T=300, p0=4e5)\n@named pipe3 = TransitionPipe(n=20, f=0.016, D=0.2, L=100, T=300, pins=4e5, pouts=2e5)\n@named outlet = FlowSource(qm=-3.0, T=300)\n\n# Connect components\neqs=[\n    connect(inlet.port,pipe1.inlet)\n    connect(pipe1.outlet,pipe2.inlet)\n    connect(pipe2.outlet,airTank.inlet)\n    connect(airTank.outlet,pipe3.inlet)\n    connect(pipe3.outlet,outlet.port)\n]\n\n@named connects=ODESystem(eqs,t)\n@named model=compose(connects,inlet,pipe1,pipe2,pipe3,airTank,outlet)\n\n# Simplify the system and solve\nsys=structural_simplify(model)\n\nprob=ODAEProblem(sys,[],(0.0,5.0))\n\nsol=solve(prob,Rosenbrock23())","category":"page"},{"location":"#Ai4ESimulator","page":"Home","title":"Ai4ESimulator","text":"","category":"section"},{"location":"#简介","page":"Home","title":"简介","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"高可拓展的云架构流程系统仿真平台基于新一代开源科学计算编程语言Julia与Vue3前端框架，适用于复杂流程系统的云仿真平台。云仿真平台采用前后端分离技术:前端为Web界面;后端为集解析器、组件库、求解器三大模块为一体的仿引擎，各模块间通过接口协同工作。仿真平台具备高度可拓展性，后端参析器可嵌入参数辨识问题、优化问题、控制问题等多种问题的代码生成工具;组件库广泛适用于能源、化工、机器、电气等多个领域的流程系统模型。","category":"page"},{"location":"#开源技术架构","page":"Home","title":"开源技术架构","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"模块 链接 内容\n前端 VUE3 渐进式JavaScript 框架\n前端 Soybean-admin 基于NaiveUI的中后台模版\n后端 OptControl.jl 最优控制拓展包\n后端 Ai4EComponentLib.jl 组件库\n后端 Ai4EMetaPSE.jl 解析器\n后端 Ai4Server 后端服务框架\n后端 ModelingToolkit.jl 组件建模工具包\n后端 DifferentialEquations.jl 微分方程求解引擎\n文档 Ai4EDocs 教程文档、设计文档\n组织 Ai4Energy 开源组织主页","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: 图 1)","category":"page"},{"location":"#系统展示","page":"Home","title":"系统展示","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: fig1)","category":"page"},{"location":"#案例展示","page":"Home","title":"案例展示","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"热力循环\n空气管道\n锂电池\n电解槽\n水力管网","category":"page"},{"location":"#Quick-Start","page":"Home","title":"Quick Start","text":"","category":"section"},{"location":"#本地开启后端服务","page":"Home","title":"本地开启后端服务","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"切换到项目文件夹","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: fig1)","category":"page"},{"location":"#本地开启前端服务","page":"Home","title":"本地开启前端服务","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"切换到项目文件夹，安装依赖","category":"page"},{"location":"","page":"Home","title":"Home","text":"npm install","category":"page"},{"location":"","page":"Home","title":"Home","text":"开启服务","category":"page"},{"location":"","page":"Home","title":"Home","text":"npm run dev","category":"page"},{"location":"#欢迎加入","page":"Home","title":"欢迎加入","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"指导老师：李明涛（mingtao@mail.xjtu.edu.cn）","category":"page"},{"location":"","page":"Home","title":"Home","text":"鸣谢：","category":"page"},{"location":"","page":"Home","title":"Home","text":"年份 贡献者\n2023——第34届腾飞杯 <a href=\"https://github.com/ai4energy/Ai4ESimulator/graphs/contributors\"><img src=\"https://contrib.rocks/image?repo=ai4energy/Ai4ESimulator\"/></a>\n2024——第35届腾飞杯 期待你的加入！\n2025...... ......","category":"page"}]
}
