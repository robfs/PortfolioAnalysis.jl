using PortfolioAnalysis
using Test

@testset "PortfolioAnalysis.jl" begin
    @testset "Currencies.jl" begin
        @test_throws CurrencyException currency("ABC")
        @test_throws CurrencyException currency(:ABC)

        @test currency("USD") == Currencies.USD
        @test currency(:USD) == Currencies.USD

        @test iso(currency(:USD)) == :USD
        @test name(currency(:USD)) == "US Dollar"
        @test unit(currency(:USD)) == 2

        @test iso("USD") == :USD
        @test name("USD") == "US Dollar"
        @test unit("USD") == 2
    end
end
