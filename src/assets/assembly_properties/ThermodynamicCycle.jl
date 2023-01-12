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
libName = :ThermodynamicCycle
components = [
    :ArbitraryProcess
    :DThermalStates
    :IsentropicProcess
    :IsobaricProcess
    :IsochoricProcess
    :IsoenthalpyProcess
    :IsothermalProcess
    # :StreamNode
    # :StreamPort
    :ThermalStates
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

# ArbitraryProcess(; name, inter_state="Q_0", process="T", fluid="Water")
ArbitraryProcess = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "ArbitraryProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'P'",
            "",
            true,
            "给出一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "process",
            "string",
            "'T'",
            "",
            true,
            "给出另一种状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# DThermalStates(; name, state, value, u0=0)
DThermalStates = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "DThermalStates",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "state",
            "string",
            "'P'",
            "",
            true,
            "给出一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "value",
            "number",
            "1.0E6",
            "Pa",
            true,
            "给出已知状态的定值"
        ])),
        Dict(zip(argProperties, [
            "Initial Value u0",
            "number",
            "10.0E6",
            "Pa",
            true,
            "给出已知状态的初始值"
        ]))
    ],
    :ports => sourcePort
)

# IsentropicProcess(; name, inter_state="Q_0", fluid="Water")
IsentropicProcess = Dict(
    :attrs => [
        Dict(zip(argProperties,[
            "name",
            "string",
            "IsentropicProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'P'",
            "",
            true,
            "给出除熵以外另一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# IsobaricProcess(; name, inter_state="Q_0", fluid="Water")
IsobaricProcess = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "IsobaricProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'T'",
            "",
            true,
            "给出除压力以外另一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# IsochoricProcess(; name, inter_state="Q_0", fluid="Water")
IsochoricProcess = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "IsochoricProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'T'",
            "",
            true,
            "给出除体积以外另一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# IsoenthalpyProcess(; name, inter_state="Q_0", fluid="Water")
IsoenthalpyProcess = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "IsoenthalpyProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'P'",
            "",
            true,
            "给出除焓以外另一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# IsothermalProcess(; name, inter_state="Q_0", fluid="Water")
IsothermalProcess = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "IsothermalProcess",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "inter_state",
            "string",
            "'Q_0'",
            "",
            true,
            "给出除温度以外另一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "fluid",
            "string",
            "'Water'",
            "",
            true,
            "请输入流体种类"
        ]))
    ],
    :ports => sisoPort
)

# ThermalStates(; name, state, value)
ThermalStates = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "ThermalStates",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "state",
            "string",
            "'P'",
            "",
            true,
            "给出一种已知状态"
        ])),
        Dict(zip(argProperties, [
            "value",
            "number",
            "3.0E6",
            "Pa",
            true,
            "给出已知状态的值"
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