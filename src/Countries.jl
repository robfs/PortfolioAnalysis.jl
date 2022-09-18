"""
Countries

This package provides the `Country` singleton type, based on the ISO 3166 standard
together with eleven methods:

- `countrysymbol`: The 2-character ISO 3166 alpha symbol of the country.
- `country`: The singleton type instance for a particular country symbol
- `countryname`: The full name of the country.
- `countrycode`: The ISO 3166 code for the country.
- `currencies`: An array of ISO 4167 alpha currency symbols for the country.
- `dial`: Country code for phone numbers.
- `capital`: The capital of the country.
- `continent`: The continent of the country.
- `isdeveloping`: Whether the country is developed or is developing (boolean).
- `region`: The region of the country.
- `subregion`: The subregion of the country.

See README.md for the full documentation

Copyright 2019-2020, Eric Forgy, Scott P. Jones and other contributors

Licensed under MIT License, see LICENSE.md
"""
module Countries

export Country, countrysymbol, country, @country
export countryname,
    countrycode, currencies, dial, capital, continent, isdeveloping, region, subregion

"""
This is a singleton type, intended to be used as a label for dispatch purposes
"""
struct Country{S}
    function Country{S}() where {S}
        haskey(_country_data, S) || error("Country $S is not defined.")
        new{S}()
    end
end
Country(S::Symbol) = Country{S}()

include(joinpath(@__DIR__, "..", "data", "country-data.jl"))

"""
Returns the 2-character ISO 3166 alpha symbol associated with the country
"""
function countrysymbol end

countrysymbol(::Type{Country{S}}) where {S} = S

"""
Returns an instance of the singleton type Country{symbol}
"""
function country end

country(S::Symbol) = _country_data[S][1]
country(S::AbstractString) = S |> Symbol |> country

country(::Type{C}) where {C<:Country} = C

Base.convert(::Type{Type{Country{S}} where {S}}, x::Symbol) = country(x)
Base.convert(::Type{Type{Country{S}} where {S}}, x::AbstractString) = country(x)

macro country(syms)
    args = syms isa Expr ? syms.args : [syms]
    for nam in args
        @eval __module__ const $nam = Countries.$nam
    end
end

"""
Returns the official name from the UN Statistics Division.
"""
function countryname end

"""
Returns the ISO 3166 numeric code.
"""
function countrycode end

"""
Returns a list of ISO 4217 currency symbols used in the country.
"""
function currencies end

"""
Returns the country code for phone numbers
"""
function dial end

"""
Returns the capital of the country.
"""
function capital end

"""
Returns the continent of the country.
"""
function continent end

"""
Returns `true` if the country is developing and `false` if developed.
"""
function isdeveloping end

"""
Returns the region of the country.
"""
function region end

"""
Returns the subregion of the country.
"""
function subregion end

ms = [
    :countryname,
    :countrycode,
    :currencies,
    :dial,
    :capital,
    :continent,
    :isdeveloping,
    :region,
    :subregion,
]
for (i, m) in enumerate(ms)
    @eval $m(S::Symbol) = _country_data[S][$(i + 1)]
    @eval $m(::Type{Country{S}}) where {S} = $m(S)
end

allsymbols() = keys(_country_data)
allpairs() = pairs(_country_data)

# Contruct cash position types for convenience.
for (s, (cntry, u, c, n)) in Countries.allpairs()
    @eval const $s = typeof($(country(cntry))())
end

end # module Countries
