module Securities

using ..Countries, ..Currencies

export AbstractSecurity,
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

securityid(s::AbstractSecurity)::String = s.identifier
securityname(s::AbstractSecurity)::String = s.name
securitycountry(s::AbstractSecurity)::Type{Country{S}} where {S} = s.country
securitycurrency(s::AbstractSecurity)::Type{Currency{S}} where {S} = s.currency
subindustrynum(s::AbstractSecurity)::Int = s.gicsnum
industrynum(s::AbstractSecurity)::Int = subindustrynum(s) ÷ 100
industrygroupnum(s::AbstractSecurity)::Int = industrynum(s) ÷ 100
sectornum(s::AbstractSecurity)::Int = industrygroupnum(s) ÷ 100

abstract type PhysicalSecurity <: AbstractSecurity end

struct CommonEquitySecurity <: PhysicalSecurity
    identifier::String
    name::String
    country::Type{Country{S}} where {S}
    currency::Type{Currency{T}} where {T}
    gicsnum::Int
end

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
