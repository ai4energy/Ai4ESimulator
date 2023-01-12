
using JSON3, UUIDs

#################################################
# 前期输入
# 每个组件每个参数的输入项目，这个不用变
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

# 修改此节
# 什么库，这个库里有什么组件
libName = :AirPipeSim
components = [
    :AirStorageTank
    # :FlowPort
    :FlowSource
    :PressureSource
    :SimplePipe
    :TransitionPipe
]

# 输入库的guid和组件的uid
category = string(uuid1()) #库guid
componentsUID = Dict() #组件的uid是字典格式，这个脚本里是自动生成，可以外接JSON输入
for component in components
    push!(componentsUID, component => string(uuid1()))
end

###############################################


###################修改此段######################
# 输入每个组件的properties的attrs

# AirStorageTank(; name, V=20, T=300, p0=5e5)
AirStorageTank = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "AirStorageTank",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "Volum"
                "number"
                "20"
                "m^3"
                true
                "请输入储气罐体积"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Temperature"
                "number"
                "293.15"
                "K"
                true
                "请输入环境温度"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Initial Pressure"
                "number"
                "1e5"
                "Pa"
                true
                "请输入初始压力"
            ]
        ))
    ],
    :ports => sisoPort
)

#FlowPort

# FlowSource(; name, qm=0.0, T=300)
FlowSource = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "FlowSource",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,[
                "Mass Flow Rate"
                "number"
                "0.0"
                "kg/s"
                true
                "请输入质量流量"
        ])),
        Dict(zip(argProperties,[
                "Temperature"
                "number"
                "293.15"
                "K"
                true
                "请输入温度"
        ]))
    ],
    :ports => sourcePort
)

# PressureSource(; name, p=1.013e5, T=300)
PressureSource = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "PressureSource",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "Pressure"
                "number"
                "1.013e5"
                "Pa"
                true
                "请输入压力"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Temperature"
                "number"
                "293.15"
                "K"
                true
                "请输入温度"
            ]
        ))
    ],
    :ports => sourcePort
)

# SimplePipe(; name, R=100, T=300)
SimplePipe = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "SimplePipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "Resistance Factor"
                "number"
                "1000"
                "kg^-1⋅m^-1"
                true
                "请输入阻力系数"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Temperature"
                "number"
                "293.15"
                "K"
                true
                "请输入温度"
            ]
        ))
    ],
    :ports => sisoPort
)

# TransitionPipe(; name,λ1=1.0,λ2=1.0,λ3=1.0, n=10, f=0.016, D=0.2, L=100, T=300, pins=0.56e6, pouts=0.56e6)
TransitionPipe = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "TransitionPipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "λ1"
                "number"
                "1.0"
                ""
                true
                "该系数取1即可"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "λ2"
                "number"
                "1.0"
                ""
                true
                "该系数取1即可"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "λ3"
                "number"
                "1.0"
                ""
                true
                "该系数取1即可"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "n"
                "number"
                "10"
                ""
                true
                "管道分成的节点数"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Friction Factor f"
                "number"
                "0.016"
                ""
                true
                "管道的摩擦阻力系数"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Diameter D"
                "number"
                "1.0"
                "m"
                true
                "管道的直径"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Length L"
                "number"
                "100"
                "m"
                true
                "管道的长度"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Inlet Pressure Pa"
                "number"
                "5.6e5"
                "Pa"
                true
                "管道的入口初始压力"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "Outlet Pressure Pa"
                "number"
                "5.6e5"
                "Pa"
                true
                "管道的出口初始压力"
            ]
        ))
    ],
    :ports => sisoPort
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
