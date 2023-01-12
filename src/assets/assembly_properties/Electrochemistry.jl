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
libName = :Electrochemistry
components = [
    :Capacitor
    :Conductor
    :Constant
    :Current_source
    :DC2DC
    :Ground
    :Inductor
    # :Lithium_ion_batteries 组件维护：输入数组
    :MPPT_Controller
    # :OnePort
    # :OnePort_key
    :PEMElectrolyzer
    :PhotovoltaicCell
    # :Pin
    # :RealInput
    # :RealOutput
    :Resistor
    # :Secrete 组件维护：输入数组
    :Super_capacity
    # :TwoPort
    :Voltage_source
    :charge_controller
    :electronic_load
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

# Capacitor(; name, C, v_start = 0.0)
Capacitor = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Capacitor",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "Capacitance"
                "number"
                "0.48e-6"
                "F"
                true
                "请输入电容值"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "v_start"
                "number"
                "0.0"
                "V"
                true
                "请输入初始电压"
            ]
        ))
    ],
    :ports => sisoPort
)

# Conductor(; name, G)
Conductor = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Conductor",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "G",
            "number",
            "1",
            "Ω^-1",
            true,
            "请输入电导值"
        ]))
    ],
    :ports => sisoPort
)

# Constant(; name, k = 1)
Constant = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Constant",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "U"
                "number"
                "0.0"
                "V"
                true
                "请输入恒压源的电压值"
            ]
        ))
    ],
    :ports => sourcePort
)

# Current_source
Current_source = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Current_source",
            "",
            true,
            "请输入组件名称"
        ]))
    ],
    :ports => [
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
        ]))
    ]
)

# DC2DC(; name,n = 1.0, type = "voltage", value = 10)
DC2DC = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "DC2DC",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "n"
                "number"
                "0.98"
                ""
                true
                "请输入能量的转化效率"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "type"
                "string"
                "0.98"
                "voltage"
                true
                "请输入能量转化类型"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "value"
                "number"
                "1.0"
                "relate to type"
                true
                "输出值"
            ]
        ))
    ],
    :ports => [
        Dict(zip(portProperties, [
            "sleft",
            "L port 1",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sleft",
            "L port 2",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sright",
            "R port 1",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sright",
            "R port 2",
            "#919191"
        ]))
    ]
)

# Ground(; name)
Ground = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Ground",
            "",
            true,
            "请输入组件名称"
        ]))
    ],
    :ports => sourcePort
)

# Inductor(; name, L, i_start = 0.0)
Inductor = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Inductor",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(
            argProperties,
            [
                "L"
                "number"
                "1e-5"
                "H"
                true
                "请输入电感值"
            ]
        )),
        Dict(zip(
            argProperties,
            [
                "i_start"
                "number"
                "0.0"
                "A"
                true
                "请输入初始电流"
            ]
        ))
    ],
    :ports => sisoPort
)

# Lithium_ion_batteries(; name, R_0=0.01, R_s=0.01, R_f=0.008, R_sd=0.5, C_s=2.5e4, C_f=8.0e3, C_b=108000., SOC2OC=[2.80595458402267,1.55152642441438,9.74740200393579,-63.9029654523517,136.818961490389,-128.826085360179,45.4027129038144])
Lithium_ion_batteries = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Lithium_ion_batteries",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "R_0",
            "number",
            "0.01",
            "Ω",
            true,
            "请输入串联电阻值"
        ])),
        Dict(zip(argProperties, [
            "R_s",
            "number",
            "0.01",
            "Ω",
            true,
            "请输入Short transient resistor"
        ])),
        Dict(zip(argProperties, [
            "R_f",
            "number",
            "0.008",
            "Ω",
            true,
            "请输入Long transient resistor"
        ])),
        Dict(zip(argProperties, [
            "R_sd",
            "number",
            "0.5",
            "Ω",
            true,
            "请输入自放电电阻"
        ])),
        Dict(zip(argProperties, [
            "C_s",
            "number",
            "2.5e4",
            "",
            true,
            "请输入Short transient capacity"
        ])),
        Dict(zip(argProperties, [
            "C_f",
            "number",
            "8.0e3",
            "",
            true,
            "请输入Long transient capacity"
        ])),
        Dict(zip(argProperties, [
            "C_b",
            "number",
            "108000.0",
            "",
            true,
            "请输入Usable capacity"
        ])),
    ],
    :ports => sisoPort
)

# MPPT_Controller(; name,Sampling_time = 0.1)
MPPT_Controller = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "MPPT_Controller",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "Sampling_time",
            "number",
            "0.1",
            "s",
            true,
            "请输入采样时间"
        ]))
    ],
    :ports => [
        Dict(zip(portProperties, [
            "sleft",
            "L port 1",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sleft",
            "L port 2",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sright",
            "R port 1",
            "#919191"
        ])),
        Dict(zip(portProperties, [
            "sright",
            "R port 2",
            "#919191"
        ]))
    ]
)

# PEMElectrolyzer(; name, τ=0.02, I_0=0.01, n=1, u_0=1.47, R_sol=0.22)
PEMElectrolyzer = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "PEMElectrolyzer",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "τ",
            "number",
            "0.1",
            "",
            true,
            "请输入塔费尔斜率"
        ])),
        Dict(zip(argProperties, [
            "I_0",
            "number",
            "0.01",
            "A⋅m^-2",
            true,
            "请输入交换电流密度"
        ])),
        Dict(zip(argProperties, [
            "n",
            "number",
            "1",
            "",
            true,
            "请输入串联的电解槽数量"
        ])),
        Dict(zip(argProperties, [
            "u_0",
            "number",
            "1.47",
            "",
            true,
            "请输入平衡电势"
        ])),
        Dict(zip(argProperties, [
            "R_sol",
            "number",
            "0.22",
            "Ω",
            true,
            "请输入槽内溶液电阻"
        ])),
    ],
    :ports => sisoPort
)

# PhotovoltaicCell(; name, I_ph=6.08, I_0=6.88e-13, a=2.3402, R_s=0.741, R_sh=457.17)
PhotovoltaicCell = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "PhotovoltaicCell",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "I_ph",
            "number",
            "6.08",
            "A",
            true,
            "请输入光电流"
        ])),
        Dict(zip(argProperties, [
            "I_0",
            "number",
            "6.88e-13",
            "A",
            true,
            "请输入反向饱和电流"
        ])),
        Dict(zip(argProperties, [
            "a",
            "number",
            "2.3402",
            "",
            true,
            "请输入修正系数"
        ])),
        Dict(zip(argProperties, [
            "R_s",
            "number",
            "0.741",
            "Ω",
            true,
            "请输入串联电阻值"
        ])),
        Dict(zip(argProperties, [
            "R_sh",
            "number",
            "457.17",
            "Ω",
            true,
            "请输入Ohmic resistance"
        ])),
    ],
    :ports => sisoPort
)

# Resistor(; name, R)
Resistor = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Resistor",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "R",
            "number",
            "1",
            "Ω",
            true,
            "请输入电阻值"
        ]))
    ],
    :ports => sisoPort
)

# Secrete(data; name,type = "s")
Secrete = Dict()

# Super_capacity(; name, R_0=0.0100478, C_0=89.03, K_v=29.1062, R_2=17.4976, C_2=13.7162, R_EPR = 5000.)
Super_capacity = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Super_capacity",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "R_0",
            "number",
            "0.0100478",
            "Ω",
            true,
            "请输入第一分支的串联电阻"
        ])),
        Dict(zip(argProperties, [
            "C_0",
            "number",
            "89.03",
            "H",
            true,
            "请输入第一分支的电容"
        ])),
        Dict(zip(argProperties, [
            "K_v",
            "number",
            "29.1062",
            "",
            true,
            "请输入第一分支的比例系数"
        ])),
        Dict(zip(argProperties, [
            "R_2",
            "number",
            "17.4976",
            "Ω",
            true,
            "请输入第二分支的串联电阻"
        ])),
        Dict(zip(argProperties, [
            "C_2",
            "number",
            "13.7162",
            "H",
            true,
            "请输入第二分支的电容"
        ])),
        Dict(zip(argProperties, [
            "R_EPR",
            "number",
            "5000.0",
            "Ω",
            true,
            "请输入自放电电阻"
        ]))
    ],
    :ports => sisoPort
)

# Voltage_source(; name)
Voltage_source = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "Voltage_source",
            "",
            true,
            "请输入组件名称"
        ]))
    ],
    :ports => [
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
        ]))
    ]
)

# charge_controller(; name,time = 5., value = 1.)
charge_controller = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "charge_controller",
            "",
            true,
            "请输入组件名称"
        ])),
        Dict(zip(argProperties, [
            "time",
            "number",
            "5.0",
            "s",
            true,
            "经过多久后充电"
        ])),
        Dict(zip(argProperties, [
            "value",
            "number",
            "1.0",
            "A",
            true,
            "充电电流大小"
        ]))
    ],
    :ports => sisoPort
)

#
electronic_load = Dict(
    :attrs => [
        Dict(zip(argProperties, [
            "name",
            "string",
            "electronic_load",
            "",
            true,
            "请输入组件名称"
        ]))
    ],
    :ports => [
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
        ]))
    ]
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
