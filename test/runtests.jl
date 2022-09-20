using PortfolioAnalysis
using Dates
using Test

@testset "PortfolioAnalysis.jl" begin
    @testset "Currencies.jl" begin
        currencies = (
            (:USD, 2, 840, "US Dollar"),
            (:EUR, 2, 978, "Euro"),
            (:JPY, 0, 392, "Yen"),
            (:JOD, 3, 400, "Jordanian Dinar"),
            (:CNY, 2, 156, "Yuan Renminbi"),
            ("USD", 2, 840, "US Dollar"),
            ("EUR", 2, 978, "Euro"),
            ("JPY", 0, 392, "Yen"),
            ("JOD", 3, 400, "Jordanian Dinar"),
            ("CNY", 2, 156, "Yuan Renminbi"),
        )

        # This just makes sure that the data was loaded and at least some basic values are set as expected
        @testset "Basic currencies" begin
            for (s, u, c, n) in currencies
                ccy = Currency{Symbol(s)}
                @test currency(s) == ccy
                @test currencyiso(ccy) == Symbol(s)
                @test currencyunit(ccy) == u
                @test currencyname(ccy) == n
                @test currencycode(ccy) == c
            end
        end

        # This makes sure that the values are within expected ranges
        @testset "Validation" begin
            @test length(PortfolioAnalysis.Currencies.allpairs()) >= 155
            for (s, (ct, u, c, n)) in PortfolioAnalysis.Currencies.allpairs()
                ccy = Currency(s)
                @test currencyiso(ct) == Symbol(s)
                @test length(string(s)) == 3
                @test u >= 0
                @test 0 < c < 2000
                @test length(n) < 40
            end
        end
    end

    @testset "Countries.jl" begin
        countries = country.([:US, :PH, :HK, :SG])
        iso3s = ["USA", "PHL", "HKG", "SGP"]
        names = [
            "United States of America",
            "Philippines",
            "China, Hong Kong Special Administrative Region",
            "Singapore",
        ]
        codes = [840, 608, 344, 702]
        capitals = ["Washington", "Manila", "Hong Kong", "Singapore"]
        continents = ["NA", "AS", "AS", "AS"]
        isdevelopings = [false, true, true, true]
        regions = ["Americas", "Asia", "Asia", "Asia"]
        subregions =
            ["Northern America", "South-eastern Asia", "Eastern Asia", "South-eastern Asia"]

        @testset "Basic countries" begin
            for (c, iso3, nm, cd, cp, ct, dv, rg, sr) in zip(
                countries,
                iso3s,
                names,
                codes,
                capitals,
                continents,
                isdevelopings,
                regions,
                subregions,
            )
                @test countryiso3(c) == iso3
                @test countryname(c) == nm
                @test countrycode(c) == cd
                @test capital(c) == cp
                @test continent(c) == ct
                @test isdeveloping(c) == dv
                @test region(c) == rg
                @test subregion(c) == sr
            end
        end
        @testset "Validation" begin
            @test length(PortfolioAnalysis.Countries.allpairs()) >= 155
            for (s, (ct, iso3, n, c, currs, d, cap, cont, isd, reg, sreg)) in
                PortfolioAnalysis.Countries.allpairs()
                cntry = Country(s)
                @test countryiso2(ct) == s
                @test countryiso3(ct) == iso3
                @test countryname(ct) == n
                @test c > 0
                @test all(currency(x) <: Currency for x in currs)
                @test dial(ct) == d
                @test capital(ct) == cap
                @test continent(ct) == cont
                @test isdeveloping(ct) == isd
                @test region(ct) == reg
                @test subregion(ct) == sreg
            end
        end
    end

    @testset "Securities.jl" begin
        @testset "Cash securities" begin
            currencies = (
                (:USD, "US Dollar"),
                (:EUR, "Euro"),
                (:JPY, "Yen"),
                (:JOD, "Jordanian Dinar"),
                (:CNY, "Yuan Renminbi"),
                ("USD", "US Dollar"),
                ("EUR", "Euro"),
                ("JPY", "Yen"),
                ("JOD", "Jordanian Dinar"),
                ("CNY", "Yuan Renminbi"),
            )
            for (iso, name) in currencies
                security = CashSecurity(iso)
                @test securityid(security) == Symbol(iso)
                @test securityname(security) == name
                @test securitycountry(security) == "Cash"
                @test subindustrynum(security) == 0
                @test industrynum(security) == 0
                @test industrygroupnum(security) == 0
                @test sectornum(security) == 0
            end
        end

        @testset "Common Equities" begin
            equities = (("AAPL", "Apple Inc.", "US", "USD", 45202030),)
            for (s, n, c, cu, g) in equities
                security = CommonEquitySecurity(s, n, c, cu, g)
                @test securityid(security) == s
                @test securityname(security) == n
                @test securitycountry(security) == country(c)
                @test securitycurrency(security) == currency(cu)
                @test subindustrynum(security) == g
                @test industrynum(security) == g ÷ 100
                @test industrygroupnum(security) == g ÷ 10000
                @test sectornum(security) == g ÷ 1000000
            end
        end
    end

    @testset "Positions.jl" begin
        @testset "Basic Positions" begin
            include(joinpath(@__DIR__, "dummy-data.jl"))

            function calculate_returns(ps::Vector{Float64})::Vector{Float64}
                rs::Vector{Float64} = []
                p0::Float64 = ps[1]
                r::Float64 = 0
                for p in ps[2:end]
                    r = p / p0 - 1
                    push!(rs, r)
                    p0 = p
                end
                return rs
            end

            calculate_return(ps::Vector{Float64})::Float64 =
                exp(sum(log.(1 .+ calculate_returns(ps)))) - 1

            n = 100
            secs::Vector{AbstractSecurity} = randomequities(n)
            qs::TimeArray{Float64,2,Date} = randomholdings(n)
            ps::TimeArray{Float64,2,Date} = randomprices(n)
            incs::TimeArray{Float64,2,Date} = randomincome(n)
            splits::TimeArray{Float64,2,Date} = randomsplits(n)
            for sec in secs
                name = sec |> securityname |> Symbol
                q = rename(qs[name], :shares)
                p = rename(ps[name], :price)
                inc = rename(incs[name], :income)
                split = rename(splits[name], :split)
                pos = Position(sec, q, p, inc, split)
                sdate = Date(2021,2,1)
                edate = Date(2021,2,28)
                sl = sdate:Day(1):edate

                @test security(pos) == sec
                @test shares(pos) == q
                @test shares(pos, sdate, edate) == q[sl]
                @test marketdata(pos) == merge(p, inc, split)
                @test marketdata(pos, sdate, edate) == merge(p, inc, split)[sl]
                @test prices(pos) == p
                @test prices(pos, sdate, edate) == p[sl]
                @test income(pos) == inc
                @test income(pos, sdate, edate) == inc[sl]
                @test values(marketvalues(pos)) == [x[2] * y[2] for (x, y) in zip(q, p)]
                @test values(marketvalues(pos, sdate, edate)) == [x[2] * y[2] for (x, y) in zip(q[sl], p[sl])]
                @test values(returns(pos)) ≈ calculate_returns(values(p))
                @test values(returns(pos, sdate, edate)) ≈ calculate_returns(values(p[sl]))
                @test values(logreturns(pos)) ≈ log.(1 .+ calculate_returns(values(p)))
                @test values(logreturns(pos, sdate, edate)) ≈ log.(1 .+ calculate_returns(values(p[sl])))
                @test totalreturn(pos) ≈ calculate_return(values(p))
                @test totalreturn(pos, sdate, edate) ≈ calculate_return(values(p[sl]))

            end
        end
    end
end
