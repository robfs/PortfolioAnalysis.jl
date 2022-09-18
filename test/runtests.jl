using PortfolioAnalysis
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
end
