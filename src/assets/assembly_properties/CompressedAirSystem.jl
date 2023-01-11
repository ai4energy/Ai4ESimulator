# 这个脚本和库在维护中
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
libName = :CompressedAirSystem
components = [
    # :AirStroageTank 组件维护：组件名出错
    :ConstantValve
    #:FlowPort
    :Purifier
    # :SISOComponent
    :SimplifiedPipe
    # :Source 组件维护：输入字典
    :StraightPipe
    # :TransitionPipe 组件维护：输入数组
    # :VarySpeedCompressor 组件维护：输入数组
    # :pipeFriction_turbulent
    # :pipeRe
    # :pipeVelocity
    # :stateEquation
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
        Dict(zip(argProperties,[
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

# ConstantValve
# ConstantValve(; name, R=100)
ConstantValve = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "ConstantValve",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,
            [
                "Resistance Factor"
                "number"
                "100"
                "kg^-1m^-1"
                true
                "请输入储气罐体积"
            ]
        ))
    ],
    :ports => sisoPort
)

# Purifier(; name, c=1, Δp=0, T = 300)
Purifier = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Purifier",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,
            [
                "c"
                "number"
                "0.98"
                ""
                true
                "请输入净化系数"
            ]
        )),
        Dict(zip(argProperties,
            [
                "Δp"
                "number"
                "300"
                "Pa"
                true
                "请输入净化元件的压降"
            ]
        )),
        Dict(zip(argProperties,
            [
                "T"
                "number"
                "293.15"
                "K"
                true
                "请输入环境温度"
            ]
        ))
    ],
    :ports => sisoPort
)

# SimplifiedPipe(; name, R0)
SimplifiedPipe = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "SimplifiedPipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,
            [
                "Resistance Factor"
                "number"
                "100"
                "kg^-1m^-1"
                true
                "请输入储气罐体积"
            ]
        ))
    ],
    :ports => sisoPort
)

#Source

# StraightPipe(; name, D=1.0, L=1.0, ϵ=0.05e-3)
StraightPipe = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "StraightPipe",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties,
            [
                "D"
                "number"
                "1.0"
                "m"
                true
                "请输入管道直径"
            ]
        )),
        Dict(zip(argProperties,
            [
                "L"
                "number"
                "1.0"
                "m"
                true
                "请输入管道长度"
            ]
        )),
        Dict(zip(argProperties,
            [
                "ϵ"
                "number"
                "0.05e-3"
                "m"
                true
                "请输入管道壁面粗糙度"
            ]
        ))
    ],
    :ports => sisoPort
)

# TransitionPipe(; name, n=10, f=0.011, D=1.0, L=1.0, T=300, p0=zeros(n), qm0=zeros(n))
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
                "0.011"
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
                "1.0"
                "m"
                true
                "管道的长度"
            ]
        ))

    ],
    :ports => sisoPort
)

# VarySpeedCompressor

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
