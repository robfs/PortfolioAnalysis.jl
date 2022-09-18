using PortfolioAnalysis
using Test

@testset "PortfolioAnalysis.jl" begin
    @testset "Currencies.jl" begin
        @test_throws CurrencyException currency("ABC")
        @test_throws CurrencyException currency(:ABC)

        @test currency("USD") == Currencies.USD
        @test currency(:USD) == Currencies.USD

        usd = currency(:USD)

        @test currencyiso(usd) == :USD
        @test currencyname(usd) == "US Dollar"
        @test currencyunit(usd) == 2

        @test currencyiso("USD") == :USD
        @test currencyname("USD") == "US Dollar"
        @test currencyunit("USD") == 2

        @test convert(Currency, :USD) == Currencies.USD
        @test convert(Currency, "USD") == Currencies.USD
        @test convert(Symbol, usd) == :USD
        @test convert(String, usd) == "USD"
    end
end
