using Documenter

makedocs(
    sitename="Ai4ESimulator",
    pages=[
        "Home" => "index.md"
    ]
)

deploydocs(
    repo="https://github.com/ai4energy/Ai4ESimulator.git";
    push_preview=true
    #    target = "../build",
)
