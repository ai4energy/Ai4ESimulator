# Ai4ESimulator

高可拓展的云架构流程系统仿真平台（Ai4ESimulator）基于新一代开源科学计算编程语言Julia与Vue3前端框架打造，适用于复杂流程系统的云仿真平台。云仿真平台采用前后端分离技术：前端为Web界面；后端为集解析器、组件库、求解器三大模块为一体的仿真引擎，各模块间通过接口协同工作。仿真平台具备高度可拓展性，后端仿真引擎可嵌入参数辨识问题、优化问题、控制问题等多种问题的代码生成工具；**组件库具有广泛适用于能源、化工、机器、电气等多个领域的建模潜力**。

## 开源技术架构

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

## 项目文档

[文档链接](https://ai4energy.github.io/Ai4ESimulator/dev/)

## 贡献者

**鸣谢：西安交通大学第34届腾飞杯Ai4E代表队全体队员**
<a href="https://github.com/ai4energy/Ai4ESimulator/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ai4energy/Ai4ESimulator"/>
</a>