"""
Currencies

This package provides the `Currency` singleton type, based on the ISO 4217 standard together with five methods:

- `currencyiso`: The symbol of the currency.
- `currency`: The singleton type for a particular currency symbol.
- `currencyname`: The ISO 4217 name of the currency.
- `currencycode`: The ISO 4217 code for the currency.
- `currencyunit`: The ISO 4217 minor unit, i.e. number of decimal places, for the currency.

See README.md for the full documentation

Copyright 2019-2020, Eric Forgy, Scott P. Jones and other contributors

Licensed under MIT License, see LICENSE.md
"""
module Currencies

export Currency, currency, currencyiso, currencyunit, currencycode, currencyname

"""
This is a singleton type, intended to be used as a label for dispatch purposes
"""
struct Currency{S}
    function Currency{S}() where {S}
        haskey(_currency_data, S) || error("Currency $S is not defined.")
        new{S}()
    end
end
Currency(S::Symbol) = Currency{S}()
Currency(S::AbstractString) = S |> Symbol |> Currency

include(joinpath(@__DIR__, "..", "data", "currency-data.jl"))

"Returns the symbol associated with a currency"
function currencyiso end

currencyiso(::Type{Currency{S}}) where {S} = S

"Returns a singleton type Currency{S}"
function currency end

currency(S::Symbol) = _currency_data[S][1]
currency(S::AbstractString) = S |> Symbol |> currency

currency(::Type{C}) where {C<:Currency} = C

Base.convert(::Type{Type{Currency{S}} where {S}}, S::Symbol) = currency(S)
Base.convert(::Type{Type{Currency{S}} where {S}}, S::AbstractString) = currency(S)

"Returns the ISO 4217 minor unit associated with a currency"
function currencyunit end

"Returns the ISO 4217 code associated with a currency"
function currencycode end

"Returns the ISO 4217 name associated with a currency"
function currencyname end

ms = [:currencyunit, :currencycode, :currencyname]
for (i, m) in enumerate(ms)
    @eval $m(S::Symbol) = _currency_data[S][$(i + 1)]
    @eval $m(::Type{Currency{S}}) where {S} = $m(S)
end

"Returns all currency symbols"
allsymbols() = keys(_currency_data)

"Returns all currency data as a pairs Symbol => (Currency,Unit,Code,Name)"
allpairs() = pairs(_currency_data)

end # module Currencies
