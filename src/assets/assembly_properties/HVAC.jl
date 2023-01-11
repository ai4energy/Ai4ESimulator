using JSON3, UUIDs

###############################################

# 每个组件每个参数的输入项目
argProperties = [
    "name"
    "type"
    "value"
    "unit"
    "require"
    "holder"
]

portProperties = [
    "gp"
    "lb"
    "clr"
]

sourcePort = [
    Dict(zip(portProperties, [
        "stop",
        "T port 1",
        "#919191"
    ]))
]

sisoPort = [
    Dict(zip(portProperties, [
        "sleft",
        "L port 1",
        "#919191"
    ])),
    Dict(zip(portProperties, [
        "sright",
        "R port 1",
        "#919191"
    ]))
]

fosoPort = [
    Dict(zip(portProperties, [
        "sleft",
        "L port 1",
        "#919191"
    ])),
    Dict(zip(portProperties, [
        "sright",
        "R port 1",
        "#919191"
    ])),
    Dict(zip(portProperties, [
        "stop",
        "T port 1",
        "#919191"
    ])),
    Dict(zip(portProperties, [
        "sbottom",
        "B port 1",
        "#919191"
    ]))
]

# 这个库里有什么组件
libName = :HVAC
components = [
    :CoolingTower
    :FanCoil
    #:FlowPort
    :Pump
    :SimplePipe
    :WaterChiller_SimplifiedPolynomial
    :source
]

# 输入库的guid和组件的uid
category = string(uuid1()) 
componentsUID=Dict()
for component in components
    push!(componentsUID,component=>string(uuid1()))
end

###############################################

###############################################

# 输入每个组件的properties的attrs

# CoolingTower(; name, Tw=26, ΔTct=5)
CoolingTower = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "CoolingTower",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
            "Temperature Tw",
            "number",
            "299.15",
            "K",
            true,
            "请输入环境湿球温度"   
        ])),
        Dict(zip(argProperties,[
            "Temperature ΔTct",
            "number",
            "5",
            "K",
            true,
            "请输入供水温度与湿球温度之间的温差"   
        ]))
    ],
    :ports => sisoPort
)

# FanCoil(; name, D::, Qf0=2000, Tai0=25, Twi0=7, Tai=25, cp=4.18)
FanCoil = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "FanCoil",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
            "Coefficient D",
            "Vector",
            "[1, 1.2, 1.2]",
            "",
            true,
            "请输入系数"
        ])),
        Dict(zip(argProperties,[
            "Rated Power Qf0",
            "number",
            "2500",
            "W",
            true,
            "请输入额定换热功率"   
        ])),
        Dict(zip(argProperties,[
            "Temperature Tai0",
            "number",
            "298.15",
            "K",
            true,
            "请输入额定进风温度"   
        ])),
        Dict(zip(argProperties,[
            "Temperature Twi0",
            "number",
            "280.15",
            "K",
            true,
            "请输入额定进水温度"   
        ])),
        Dict(zip(argProperties,[
            "Temperature Tai",
            "number",
            "298.15",
            "K",
            true,
            "请输入实际进风温度"   
        ])),
        Dict(zip(argProperties,[
            "Specific Heat cp",
            "number",
            "4.18",
            "J/(kg·K)",
            true,
            "请输入水的比热"   
        ]))
    ],
    :ports => sisoPort
)

# Pump(; name, D::, n0=2000, ρ=1.0e3, g=10.0) 
Pump = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "Pump",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
            "Coefficient D",
            "Vector",
            "[120,-1500,-0.5,0.8,0.8,0.8]",
            "",
            true,
            "请输入系数"
        ])),
        Dict(zip(argProperties,[
            "Rated Speed n0",
            "number",
            "2000",
            "r/min",
            true,
            "请输入额定转速"   
        ])),
        Dict(zip(argProperties, [
            "Density ρ",
            "number",
            "1.0e3",
            "kg/m^3",
            true,
            "请输入流体密度"
        ])),
        Dict(zip(argProperties, [
            "Gravitational Acceleration g",
            "number",
            "10.0",
            "m/s²",
            true,
            "请输入重力加速度"
        ]))
    ],
    :ports => sisoPort
)

# SimplePipe(; name, R=100, T=300)
SimplePipe = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "SimplePipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
            "Friction Factor R",
            "number",
            "100",
            "Pa·s/kg",
            true,
            "请输入管道的摩擦阻力系数"   
        ])),
        Dict(zip(argProperties,[
            "Temperature T",
            "number",
            "300",
            "K",
            true,
            "请输入管内流体温度"   
        ]))
    ],
    :ports => sisoPort
)

# WaterChiller_SimplifiedPolynomial(; name, D::, Qe0=3000)
WaterChiller_SimplifiedPolynomial = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "WaterChiller",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
            "Coefficient D",
            "Vector",
            "[22.08252111,-0.008374357,0.605004615,-0.544042021,-2.10E-07,7.04E-05,0.000299955,-0.028824777]",
            "",
            true,
            "请输入系数"
        ])),
        Dict(zip(argProperties,[
            "Cooling Capacity Qe0",
            "number",
            "3000",
            "W",
            true,
            "请输入PLR=1时的制冷量"   
        ]))
    ],
    :ports => fosoPort    
)

# source(; name, qm=100, p=100, t0=30.0)
source = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "source",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Mass Flow Rate"
            "number"
            "100"
            "kg/s"
            true
            "请输入质量流量"
        ])),
        Dict(zip(argProperties,[
            "Pressure p"
            "number"
            "100"
            "Pa"
            true
            "请输入压力"
        ])),
        Dict(zip(argProperties,[
            "Temperature t0"
            "number"
            "303.15"
            "K"
            true
            "请输入温度"
        ]))
    ],
    :ports => sourcePort
)

###############################################

##################################################

# 组装JSON文件

properties = Dict()

for component in components
    push!(properties, component => Dict(
        "name" => componentsUID[component],
        "label" => "logo",
        "category" => category,
        "width" => 100,
        "height" => 100,
        "ports" => eval(component)[:ports],
        "attrs" => eval(component)[:attrs]
    ))
end

output = Dict(
    :uids => Dict(
        :lib => category,
        :components => componentsUID
    ),
    libName => properties
)

open(joinpath(@__DIR__, string(libName, ".json")), "w") do io
    JSON3.pretty(io, output)
end

###################################################