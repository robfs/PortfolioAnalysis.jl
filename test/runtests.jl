using PortfolioAnalysis
using Test

@testset "PortfolioAnalysis.jl" begin
    @testset "Currencies.jl" begin
        @test_throws CurrencyException currency("ABC")
        @test_throws CurrencyException currency(:ABC)

        @test currency("USD") == Currencies.USD
        @test currency(:USD) == Currencies.USD

        usd = currency(:USD)

        @test iso(usd) == :USD
        @test name(usd) == "US Dollar"
        @test unit(usd) == 2

        @test iso("USD") == :USD
        @test name("USD") == "US Dollar"
        @test unit("USD") == 2

        @test convert(Currency, :USD) == Currencies.USD
        @test convert(Currency, "USD") == Currencies.USD
        @test convert(Symbol, usd) == :USD
        @test convert(String, usd) == "USD"
    end
end
