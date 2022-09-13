module PortfolioAnalysis

include("Currencies.jl")
using .Currencies

export Currency, CurrencyException, currency, iso, name, unit

end
