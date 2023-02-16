using Documenter

examples_files = readdir(joinpath(@__DIR__, "src", "examples"))
examples = map(file -> joinpath("examples", file), examples_files)
makedocs(
    sitename="Ai4ESimulator",
    pages=[
        "Home" => "index.md"
        "实例" => examples
    ]
)

deploydocs(
    repo="https://github.com/ai4energy/Ai4ESimulator.git";
    push_preview=true
    #    target = "../build",
)
