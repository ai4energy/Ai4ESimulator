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

# 这个库里有什么组件
libName = :IncompressiblePipe
components = [
    :CentrifugalPump
    :ElbowPipe
    # :PipeNode
    :SimplePipe
    :Sink_P
    :Source_P
    # :_NodeEnergy
    # :_h_f
    # :_h_m
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

# CentrifugalPump(; name, D=25E-3, ω=2500, c_0=4.4e-4, c_1=5.622, ρ=1.0E3)
CentrifugalPump = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "CentrifugalPump",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Diameter D",
            "number",
            "0.15",
            "m",
            true,
            "请输入管径"
        ])),
        Dict(zip(argProperties, [
            "Rotary Speed ω",
            "number",
            "5000",
            "r/min",
            true,
            "请输入离心泵转速"
        ])),
        Dict(zip(argProperties, [
            "Parameter c_0",
            "number",
            "4.4e-4",
            "",
            true,
            "请输入H-Q特性曲线参数c_0"
        ])),
        Dict(zip(argProperties, [
            "Parameter c_1",
            "number",
            "5.622",
            "",
            true,
            "请输入H-Q特性曲线参数c_1"
        ])),
        Dict(zip(argProperties, [
            "Density ρ",
            "number",
            "1.0e3",
            "kg/m^3",
            true,
            "请输入流体密度"
        ]))
    ],
    :ports => sisoPort
)

# ElbowPipe(; name, D=25E-3, K=1.0, ρ=1.0E3, zin=0.0, zout=0.0)
ElbowPipe = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "ElbowPipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Diameter D",
            "number",
            "0.15",
            "m",
            true,
            "请输入管径"
        ])),
        Dict(zip(argProperties, [
            "Local Resistance Loss Coefficient K",
            "number",
            "0.9",
            "",
            true,
            "请输入弯管的局部阻力损失系数"
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
            "Height zin",
            "number",
            "15.0",
            "m",
            true,
            "请输入弯管入口高度"
        ])),
        Dict(zip(argProperties, [
            "Height zout",
            "number",
            "15.0",
            "m",
            true,
            "请输入弯管出口高度"
        ]))
    ],
    :ports => sisoPort
)

# SimplePipe(; name, L=10.0, D=25E-3, f=0.01, ρ=1.0E3, zin=0.0, zout=0.0, K_inside=0.0)
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
        Dict(zip(argProperties, [
            "Length L",
            "number",
            "30",
            "m",
            true,
            "请输入管道长度"
        ])),
        Dict(zip(argProperties, [
            "Diameter D",
            "number",
            "0.15",
            "m",
            true,
            "请输入管径"
        ])),
        Dict(zip(argProperties,[
            "Friction Factor f",
            "number",
            "0.023",
            "",
            true,
            "请输入管道的摩擦阻力系数"
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
            "Height zin",
            "number",
            "25.0",
            "m",
            true,
            "请输入管道入口高度"
        ])),
        Dict(zip(argProperties, [
            "Height zout",
            "number",
            "0.0",
            "m",
            true,
            "请输入管道出口高度"
        ])),
        Dict(zip(argProperties, [
            "Local Resistance Loss Coefficient K_inside",
            "number",
            "10.8",
            "",
            true,
            "请输入管内的局部阻力损失系数"
        ]))
    ],
    :ports => sisoPort
)

# Sink_P(; name, p=101325)
Sink_P = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Sink_P",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Pressure Pa",
            "number",
            "101325",
            "Pa",
            true,
            "请输入储罐压力，默认值101325Pa"
        ]))
    ],
    :ports => sourcePort
)

# Source_P(; name, D=25E-3, z=0.0, ρ=1.0E3, p=101325, K_inlet=0.5)
Source_P = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Source_P",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Diameter D",
            "number",
            "0.15",
            "m",
            true,
            "请输入管径"
        ])),
        Dict(zip(argProperties, [
            "Height z",
            "number",
            "25.0",
            "m",
            true,
            "请输入高度"
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
            "Pressure Pa",
            "number",
            "101325",
            "Pa",
            true,
            "请输入压力，默认值101325Pa"
        ])),
        Dict(zip(argProperties, [
            "Local Resistance Loss Coefficient K_inlet",
            "number",
            "0.5",
            "",
            true,
            "请输入入口局部阻力损失系数，默认值0.5"
        ]))
    ],
    :ports => sourcePort
)

##################################################

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