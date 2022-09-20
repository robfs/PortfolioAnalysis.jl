"""
Securities

This package provides the various `Security` types together with appropriate methods.
"""
module Securities

using ..Countries, ..Currencies

export AbstractSecurity,
    PhysicalSecurity,
    CashSecurity,
    CommonEquitySecurity,
    securityid,
    securityname,
    securitycountry,
    securitycurrency,
    subindustrynum,
    industrynum,
    industrygroupnum,
    sectornum

abstract type AbstractSecurity end

"""
Returns the identifier of a security
"""
securityid(s::AbstractSecurity)::String = s.identifier

"""
Returns the name of a security
"""
securityname(s::AbstractSecurity)::String = s.name

"""
Returns the country of a security
"""
securitycountry(s::AbstractSecurity)::Type{Country{S}} where {S} = s.country

"""
Returns the currency of a security
"""
securitycurrency(s::AbstractSecurity)::Type{Currency{S}} where {S} = s.currency

abstract type PhysicalSecurity <: AbstractSecurity end

struct CommonEquitySecurity <: PhysicalSecurity
    identifier::String
    name::String
    country::Type{Country{S}} where {S}
    currency::Type{Currency{T}} where {T}
    gicsnum::Int
end

"""
Returns the GICS subindustry number of a security
"""
subindustrynum(s::CommonEquitySecurity)::Int = s.gicsnum

"""
Returns the GICS industry number of a security
"""
industrynum(s::CommonEquitySecurity)::Int = subindustrynum(s) ÷ 100

"""
Returns the GICS industry group number of a security
"""
industrygroupnum(s::CommonEquitySecurity)::Int = industrynum(s) ÷ 100

"""
Returns the GICS sector number of a security
"""
sectornum(s::CommonEquitySecurity)::Int = industrygroupnum(s) ÷ 100

struct CashSecurity <: PhysicalSecurity
    currency::Type{Currency{T}} where {T}
end

securityid(s::CashSecurity)::Symbol = currencyiso(s.currency)
securityname(s::CashSecurity)::String = currencyname(s.currency)
securitycountry(s::CashSecurity)::String = "Cash"
subindustrynum(s::CashSecurity)::Int = 0
industrynum(s::CashSecurity)::Int = 0
industrygroupnum(s::CashSecurity)::Int = 0
sectornum(s::CashSecurity)::Int = 0

end # module
