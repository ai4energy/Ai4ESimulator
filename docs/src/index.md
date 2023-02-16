# Ai4ESimulator

## 简介

高可拓展的云架构流程系统仿真平台基于新一代开源科学计算编程语言Julia与Vue3前端框架，适用于复杂流程系统的云仿真平台。云仿真平台采用前后端分离技术:前端为Web界面;后端为集解析器、组件库、求解器三大模块为一体的仿引擎，各模块间通过接口协同工作。仿真平台具备高度可拓展性，后端参析器可嵌入参数辨识问题、优化问题、控制问题等多种问题的代码生成工具;组件库广泛适用于能源、化工、机器、电气等多个领域的流程系统模型。

## 开源技术栈

* 前端
  * [VUE3](https://cn.vuejs.org/)——渐进式JavaScript 框架
  * [Soybean-admin](https://github.com/honghuangdc/soybean-admin)——基于Vue3与NaiveUI的中后台模版
* 后端
  * [OptControl.jl](https://ai4energy.github.io/OptControl.jl/dev/)——最优控制拓展包。
  * [Ai4EComponentLib.jl](https://ai4energy.github.io/Ai4EComponentLib.jl/dev/)——组件库
  * [Ai4EMetaPSE.jl](https://ai4energy.github.io/Ai4EMetaPSE.jl/dev/)——解析器
  * [Ai4Server](https://ai4energy.github.io/Ai4EServer/) 基于Genie.jl架构的后端服务框架。
  * [ModelingToolkit.jl](https://github.com/SciML/ModelingToolkit.jl)——组件建模工具包
  * [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl)——微分方程求解引擎


## 系统展示

![fig1](assets/system_show.gif)

## Quick Start

### 本地开启后端服务

### 本地开启前端服务