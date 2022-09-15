"""
Currencies
This module provides a `Currency` enum, based on the ISO 4217 standard together with four methods:
- `currency`: The enum for a particular currency symbol.
- `iso`: The iso symbol of the currency.
- `name`: The ISO 4217 name of the currency.
- `unit`: The ISO 4217 minor unit, i.e. number of decimal places, for the currency.
"""
module Currencies

export Currency, CurrencyException, currency, iso, name, unit

@enum Currency begin
    ALL = 8
    DZD = 12
    ARS = 32
    AUD = 36
    BSD = 44
    BHD = 48
    BDT = 50
    AMD = 51
    BBD = 52
    BMD = 60
    BTN = 64
    BOB = 68
    BWP = 72
    BZD = 84
    SBD = 90
    BND = 96
    MMK = 104
    BIF = 108
    KHR = 116
    CAD = 124
    CVE = 132
    KYD = 136
    LKR = 144
    CLP = 152
    CNY = 156
    COP = 170
    KMF = 174
    CRC = 188
    HRK = 191
    CUP = 192
    CZK = 203
    DKK = 208
    DOP = 214
    SVC = 222
    ETB = 230
    ERN = 232
    FJD = 242
    DJF = 262
    GMD = 270
    GIP = 292
    GTQ = 320
    GNF = 324
    GYD = 328
    HTG = 332
    HNL = 340
    HKD = 344
    HUF = 348
    ISK = 352
    INR = 356
    IDR = 360
    IRR = 364
    IQD = 368
    ILS = 376
    JMD = 388
    JPY = 392
    KZT = 398
    JOD = 400
    KES = 404
    KPW = 408
    KRW = 410
    KWD = 414
    KGS = 417
    LAK = 418
    LBP = 422
    LSL = 426
    LRD = 430
    LYD = 434
    MOP = 446
    MWK = 454
    MYR = 458
    MVR = 462
    MRO = 478
    MUR = 480
    MXN = 484
    MNT = 496
    MDL = 498
    MAD = 504
    OMR = 512
    NAD = 516
    NPR = 524
    ANG = 532
    AWG = 533
    VUV = 548
    NZD = 554
    NIO = 558
    NGN = 566
    NOK = 578
    PKR = 586
    PAB = 590
    PGK = 598
    PYG = 600
    PEN = 604
    PHP = 608
    QAR = 634
    RUB = 643
    RWF = 646
    SHP = 654
    STD = 678
    SAR = 682
    SCR = 690
    SLL = 694
    SGD = 702
    VND = 704
    SOS = 706
    ZAR = 710
    SSP = 728
    SZL = 748
    SEK = 752
    CHF = 756
    SYP = 760
    THB = 764
    TOP = 776
    TTD = 780
    AED = 784
    TND = 788
    UGX = 800
    MKD = 807
    EGP = 818
    GBP = 826
    TZS = 834
    USD = 840
    UYU = 858
    UZS = 860
    WST = 882
    YER = 886
    CUC = 931
    ZWL = 932
    BYN = 933
    TMT = 934
    GHS = 936
    VEF = 937
    SDG = 938
    RSD = 941
    MZN = 943
    AZN = 944
    RON = 946
    TRY = 949
    XAF = 950
    XCD = 951
    XOF = 952
    XPF = 953
    ZMW = 967
    SRD = 968
    MGA = 969
    AFN = 971
    TJS = 972
    AOA = 973
    BGN = 975
    CDF = 976
    BAM = 977
    EUR = 978
    UAH = 980
    GEL = 981
    PLN = 985
    BRL = 986
end

struct CurrencyInfo
    currency::Currency
    iso::Symbol
    name::String
    unit::UInt
end

currency(c::CurrencyInfo) = c.currency
iso(c::CurrencyInfo) = c.iso
name(c::CurrencyInfo) = c.name
unit(c::CurrencyInfo) = c.unit

include(joinpath(@__DIR__, "..", "data", "currency-data.jl"))

struct CurrencyException <: Exception
    s::Symbol
end

Base.showerror(io::IO, e::CurrencyException) = print(io, "currency $(e.s) not recognized")

function _lookup_currency(s::Symbol)::CurrencyInfo
    try
        CURRENCY_DATA[s]
    catch error
        if error isa KeyError
            rethrow(CurrencyException(s))
        end
    end
end

currency(s::Symbol)::Currency = _lookup_currency(s) |> currency
iso(s::Symbol)::Symbol = _lookup_currency(s) |> iso
name(s::Symbol)::String = _lookup_currency(s) |> name
unit(s::Symbol)::UInt = _lookup_currency(s) |> unit

currency(s::AbstractString)::Currency = Symbol(s) |> currency
iso(s::AbstractString)::Symbol = Symbol(s) |> iso
name(s::AbstractString)::String = Symbol(s) |> name
unit(s::AbstractString)::UInt = Symbol(s) |> unit

iso(c::Currency)::Symbol = Symbol(c) |> iso
name(c::Currency)::String = Symbol(c) |> name
unit(c::Currency)::UInt = Symbol(c) |> unit

Base.convert(::Type{Currency}, x::Symbol) = currency(x)
Base.convert(::Type{Currency}, x::AbstractString) = currency(x)
Base.convert(::Type{Symbol}, x::Currency) = iso(x)
Base.convert(::Type{T}, x::Currency) where {T<:AbstractString} = iso(x) |> String

end # module
