using PortfolioAnalysis
using Documenter

DocMeta.setdocmeta!(PortfolioAnalysis, :DocTestSetup, :(using PortfolioAnalysis); recursive=true)

makedocs(;
    modules=[PortfolioAnalysis],
    authors="robfs <robfoxsimms@gmail.com> and contributors",
    repo="https://github.com/robfs/PortfolioAnalysis.jl/blob/{commit}{path}#{line}",
    sitename="PortfolioAnalysis.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://robfs.github.io/PortfolioAnalysis.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/robfs/PortfolioAnalysis.jl",
    devbranch="main",
)
