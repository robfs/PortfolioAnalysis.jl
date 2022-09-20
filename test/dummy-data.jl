# Load libraries
using BusinessDays
using Dates
using Random
using TimeSeries

# define average annual volatility as 20% and average annual return as 10%
const VOL = 0.2 / √252
const RET = 0.1 / 252

# define start and end date for random data
const SDATE = Date(2021, 1, 1)
const EDATE = Date(2021, 12, 31)

# define business calendar
calendars =
    [BusinessDays.UnitedKingdom(), BusinessDays.UnitedStates(), BusinessDays.EuroZone()]
const CAL = CompositeHolidayCalendar(calendars)

# define all dates and select only business days
dates::Vector{Date} = collect(SDATE:Day(1):EDATE)
const BDATES = dates[isbday(CAL, dates)]

# define month ends for rebalancing holdings
monthends::Vector{Date} = lastdayofmonth.(dates) |> unique
const REBALANCES = tobday(CAL, monthends; forward = false)

# set number of dates to generate data for
const NDATES = length(BDATES)

"""
Returns a time series of random returns
"""
function randomreturns(name::AbstractString = "Security")::TimeArray{Float64,1,Date}
    return TimeArray(BDATES, (randn(NDATES) * VOL) .+ RET, [Symbol(name)])
end

"""
Returns a time series of random cumulative returns (based to 1)
"""
randomcumreturns(name::AbstractString = "Security")::TimeArray{Float64,1,Date} =
    cumprod(randomreturns(name) .+ 1)

"""
Returns an initial starting price between 10.00 and 200.00
"""
randomprice()::Float64 = rand(10:0.01:200)

"""
Returns a vector of random prices
"""
randomprices(name::AbstractString = "Security")::TimeArray{Float64,1,Date} =
    round.(randomcumreturns(name) .* randomprice(), digits = 2)

"""
Returns N time series of random prices
"""
randomprices(N::Int)::TimeArray{Float64,2,Date} =
    merge((randomprices("Security_$(i)") for i = 1:N)...)

"""
Returns a random ticker string
"""
randomticker()::String = randstring() |> uppercase

"""
Returns a random subindustry integer
"""
randomind()::Int = rand(10000000:10:99999990)

"""
Returns a random country from UK, USA, France or Germany
"""
randomcountry()::Symbol = rand([:GB, :US, :FR, :DE])

"""
Returns the primary currency of `co`
"""
curr(co::Symbol)::Symbol = currencies(country(co))[1]

"""
Returns a time series of random quantities changing only on rebalance dates
"""
function randomholdings(name::AbstractString = "Security")::TimeArray{Float64,1,Date}
    holdingrange = 100:100:1000
    position = rand(holdingrange)
    holdings::Vector{Float64} = []
    for dt in BDATES
        position = dt in REBALANCES ? rand(holdingrange) : position
        push!(holdings, position)
    end
    return TimeArray(BDATES, holdings, [Symbol(name)])
end

"""
Returns N time series of random quantities changing only on rebalance dates
"""
randomholdings(N::Int)::TimeArray{Float64,2,Date} =
    merge((randomholdings("Security_$(i)") for i = 1:N)...)

"""
Returns a random equity security
"""
function randomequity(i::Int = 1)::CommonEquitySecurity
    t = randomticker()
    n = "Security_$(i)"
    co = randomcountry()
    cu = curr(co)
    ind = randomind()
    return CommonEquitySecurity(t, n, co, cu, ind)
end

"""
Returns a vector of N random equity securities
"""
randomequities(N::Int)::Vector{CommonEquitySecurity} = [randomequity(i) for i = 1:N]

"""
Returns a time series of income values
"""
randomincome(name::AbstractString = "Security")::TimeArray{Float64,1,Date} =
    TimeArray(BDATES, repeat([0.0], NDATES), [Symbol(name)])

"""
Returns N time series of income values
"""
randomincome(N::Int)::TimeArray{Float64,2,Date} =
    merge((randomincome("Security_$(i)") for i = 1:N)...)

"""
Returns a time series of split factors
"""
randomsplits(name::AbstractString = "Security")::TimeArray{Float64,1,Date} =
    TimeArray(BDATES, repeat([1.0], NDATES), [Symbol(name)])

"""
Returns N time series of split factors
"""
randomsplits(N::Int)::TimeArray{Float64,2,Date} =
    merge((randomsplits("Security_$(i)") for i = 1:N)...)
