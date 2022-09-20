"""
Positions

This package provides the `Position` type and associated methods
"""
module Positions

using TimeSeries
using Dates

using ..Securities

export Position,
    security,
    shares,
    marketdata,
    prices,
    income,
    marketvalues,
    returns,
    logreturns,
    totalreturn

struct Position{S<:AbstractSecurity}
    security::S
    shares::TimeArray{<:Real,1,Date}
    marketdata::TimeArray{<:Real,N,Date} where {N}

    Position(
        S::AbstractSecurity,
        shares::TimeArray{<:Real,1,Date},
        data::TimeArray{<:Real,1,Date},
    ) where {N} = new{typeof(S)}(S, shares, data)

    Position(
        S::AbstractSecurity,
        shares::TimeArray{<:Real,1,Date},
        data::TimeArray{<:Real,2,Date},
    ) where {N} = new{typeof(S)}(S, shares, data)

    Position(
        S::AbstractSecurity,
        shares::TimeArray{<:Real,1,Date},
        data::TimeArray{<:Real,1,Date}...,
    ) = new{typeof(S)}(S, shares, merge(data...))

end

"""
Returns the security for a `Position`
"""
security(p::Position{<:AbstractSecurity})::AbstractSecurity = p.security

"""
Returns the shares held for a `Position`
"""
shares(p::Position{<:AbstractSecurity})::TimeArray{Float64,1,Date} = p.shares

"""
Returns the shares held for a `Position` for a given period
"""
shares(
    p::Position{<:AbstractSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = p.shares[sdate:Day(1):edate]

"""
Returns the data for a `Position`
"""
marketdata(p::Position{<:AbstractSecurity})::TimeArray{Float64,N,Date} where {N} =
    p.marketdata

"""
Returns the data for a `Position` between a given window
"""
marketdata(
    p::Position{<:AbstractSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,N,Date} where {N} = p.marketdata[sdate:Day(1):edate]

"""
Returns the prices for a `Position`
"""
prices(p::Position{<:AbstractSecurity})::TimeArray{Float64,1,Date} = marketdata(p)[:price]

"""
Returns the prices for a `Position` for a given period
"""
prices(
    p::Position{<:AbstractSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = marketdata(p, sdate, edate)[:price]

"""
Returns the incomes for a `Position`
"""
income(p::Position{<:AbstractSecurity})::TimeArray{Float64,1,Date} = marketdata(p)[:income]

"""
Returns the incomes for a `Position` between a given window
"""
income(
    p::Position{<:AbstractSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = marketdata(p, sdate, edate)[:income]

"""
Returns the market values for a `Position`
"""
marketvalues(p::Position{<:PhysicalSecurity})::TimeArray{Float64,1,Date} =
    shares(p) .* prices(p)

"""
Returns the market values for a `Position` for a given period
"""
marketvalues(
    p::Position{<:PhysicalSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = shares(p, sdate, edate) .* prices(p, sdate, edate)

"""
Returns the percent returns for a `Position`
"""
returns(p::Position{<:PhysicalSecurity})::TimeArray{Float64,1,Date} =
    percentchange(prices(p))

"""
Returns the percent returns for a `Position` for a given period
"""
returns(
    p::Position{<:PhysicalSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = percentchange(prices(p, sdate, edate))

"""
Returns the log returns for a `Position`
"""
logreturns(p::Position{<:PhysicalSecurity})::TimeArray{Float64,1,Date} =
    percentchange(prices(p), :log)

"""
Returns the log returns for a `Position` for a given period
"""
logreturns(
    p::Position{<:PhysicalSecurity},
    sdate::Date,
    edate::Date,
)::TimeArray{Float64,1,Date} = percentchange(prices(p, sdate, edate), :log)

"""
Returns the total return for a `Position` over all price data
"""
totalreturn(p::Position{<:PhysicalSecurity})::Float64 = exp(sum(values(logreturns(p)))) - 1

"""
Returns the total return for a `Position` for a given period
"""
totalreturn(p::Position{<:PhysicalSecurity}, sdate::Date, edate::Date)::Float64 =
    exp(sum(values(logreturns(p, sdate, edate)))) - 1

end # module Positions
