const _currency_data = Dict(
    :KYD => (Currency{:KYD}, 2, 136, "Cayman Islands Dollar"),
    :PYG => (Currency{:PYG}, 0, 600, "Guarani"),
    :AWG => (Currency{:AWG}, 2, 533, "Aruban Florin"),
    :LAK => (Currency{:LAK}, 2, 418, "Lao Kip"),
    :TRY => (Currency{:TRY}, 2, 949, "Turkish Lira"),
    :UYU => (Currency{:UYU}, 2, 858, "Peso Uruguayo"),
    :NGN => (Currency{:NGN}, 2, 566, "Naira"),
    :QAR => (Currency{:QAR}, 2, 634, "Qatari Rial"),
    :EUR => (Currency{:EUR}, 2, 978, "Euro"),
    :TTD => (Currency{:TTD}, 2, 780, "Trinidad and Tobago Dollar"),
    :UAH => (Currency{:UAH}, 2, 980, "Hryvnia"),
    :XPF => (Currency{:XPF}, 0, 953, "CFP Franc"),
    :JPY => (Currency{:JPY}, 0, 392, "Yen"),
    :THB => (Currency{:THB}, 2, 764, "Baht"),
    :BHD => (Currency{:BHD}, 3, 48, "Bahraini Dinar"),
    :PEN => (Currency{:PEN}, 2, 604, "Sol"),
    :SOS => (Currency{:SOS}, 2, 706, "Somali Shilling"),
    :TJS => (Currency{:TJS}, 2, 972, "Somoni"),
    :SHP => (Currency{:SHP}, 2, 654, "Saint Helena Pound"),
    :AOA => (Currency{:AOA}, 2, 973, "Kwanza"),
    :SGD => (Currency{:SGD}, 2, 702, "Singapore Dollar"),
    :CHF => (Currency{:CHF}, 2, 756, "Swiss Franc"),
    :IDR => (Currency{:IDR}, 2, 360, "Rupiah"),
    :SDG => (Currency{:SDG}, 2, 938, "Sudanese Pound"),
    :IQD => (Currency{:IQD}, 3, 368, "Iraqi Dinar"),
    :EGP => (Currency{:EGP}, 2, 818, "Egyptian Pound"),
    :SLL => (Currency{:SLL}, 2, 694, "Leone"),
    :UZS => (Currency{:UZS}, 2, 860, "Uzbekistan Sum"),
    :MAD => (Currency{:MAD}, 2, 504, "Moroccan Dirham"),
    :MYR => (Currency{:MYR}, 2, 458, "Malaysian Ringgit"),
    :MMK => (Currency{:MMK}, 2, 104, "Kyat"),
    :DZD => (Currency{:DZD}, 2, 12, "Algerian Dinar"),
    :CAD => (Currency{:CAD}, 2, 124, "Canadian Dollar"),
    :HKD => (Currency{:HKD}, 2, 344, "Hong Kong Dollar"),
    :MWK => (Currency{:MWK}, 2, 454, "Malawi Kwacha"),
    :INR => (Currency{:INR}, 2, 356, "Indian Rupee"),
    :TZS => (Currency{:TZS}, 2, 834, "Tanzanian Shilling"),
    :BTN => (Currency{:BTN}, 2, 64, "Ngultrum"),
    :LRD => (Currency{:LRD}, 2, 430, "Liberian Dollar"),
    :DKK => (Currency{:DKK}, 2, 208, "Danish Krone"),
    :NAD => (Currency{:NAD}, 2, 516, "Namibia Dollar"),
    :PKR => (Currency{:PKR}, 2, 586, "Pakistan Rupee"),
    :JMD => (Currency{:JMD}, 2, 388, "Jamaican Dollar"),
    :XOF => (Currency{:XOF}, 0, 952, "CFA Franc BCEAO"),
    :COP => (Currency{:COP}, 2, 170, "Colombian Peso"),
    :HNL => (Currency{:HNL}, 2, 340, "Lempira"),
    :KWD => (Currency{:KWD}, 3, 414, "Kuwaiti Dinar"),
    :GHS => (Currency{:GHS}, 2, 936, "Ghana Cedi"),
    :BAM => (Currency{:BAM}, 2, 977, "Convertible Mark"),
    :CUC => (Currency{:CUC}, 2, 931, "Peso Convertible"),
    :MXN => (Currency{:MXN}, 2, 484, "Mexican Peso"),
    :TND => (Currency{:TND}, 3, 788, "Tunisian Dinar"),
    :MZN => (Currency{:MZN}, 2, 943, "Mozambique Metical"),
    :BOB => (Currency{:BOB}, 2, 68, "Boliviano"),
    :DOP => (Currency{:DOP}, 2, 214, "Dominican Peso"),
    :ZMW => (Currency{:ZMW}, 2, 967, "Zambian Kwacha"),
    :MVR => (Currency{:MVR}, 2, 462, "Rufiyaa"),
    :BSD => (Currency{:BSD}, 2, 44, "Bahamian Dollar"),
    :KPW => (Currency{:KPW}, 2, 408, "North Korean Won"),
    :HUF => (Currency{:HUF}, 2, 348, "Forint"),
    :BIF => (Currency{:BIF}, 0, 108, "Burundi Franc"),
    :GNF => (Currency{:GNF}, 0, 324, "Guinean Franc"),
    :PAB => (Currency{:PAB}, 2, 590, "Balboa"),
    :VEF => (Currency{:VEF}, 2, 937, "Bolívar"),
    :BZD => (Currency{:BZD}, 2, 84, "Belize Dollar"),
    :HTG => (Currency{:HTG}, 2, 332, "Gourde"),
    :SAR => (Currency{:SAR}, 2, 682, "Saudi Riyal"),
    :GYD => (Currency{:GYD}, 2, 328, "Guyana Dollar"),
    :GMD => (Currency{:GMD}, 2, 270, "Dalasi"),
    :ALL => (Currency{:ALL}, 2, 8, "Lek"),
    :ZAR => (Currency{:ZAR}, 2, 710, "Rand"),
    :PHP => (Currency{:PHP}, 2, 608, "Philippine Piso"),
    :MRO => (Currency{:MRO}, 2, 478, "Ouguiya"),
    :AZN => (Currency{:AZN}, 2, 944, "Azerbaijan Manat"),
    :AED => (Currency{:AED}, 2, 784, "UAE Dirham"),
    :ETB => (Currency{:ETB}, 2, 230, "Ethiopian Birr"),
    :AUD => (Currency{:AUD}, 2, 36, "Australian Dollar"),
    :HRK => (Currency{:HRK}, 2, 191, "Kuna"),
    :VND => (Currency{:VND}, 0, 704, "Dong"),
    :MDL => (Currency{:MDL}, 2, 498, "Moldovan Leu"),
    :GTQ => (Currency{:GTQ}, 2, 320, "Quetzal"),
    :GEL => (Currency{:GEL}, 2, 981, "Lari"),
    :CZK => (Currency{:CZK}, 2, 203, "Czech Koruna"),
    :MOP => (Currency{:MOP}, 2, 446, "Pataca"),
    :PLN => (Currency{:PLN}, 2, 985, "Zloty"),
    :SSP => (Currency{:SSP}, 2, 728, "South Sudanese Pound"),
    :AFN => (Currency{:AFN}, 2, 971, "Afghani"),
    :SYP => (Currency{:SYP}, 2, 760, "Syrian Pound"),
    :STD => (Currency{:STD}, 2, 678, "Dobra"),
    :USD => (Currency{:USD}, 2, 840, "US Dollar"),
    :BND => (Currency{:BND}, 2, 96, "Brunei Dollar"),
    :CVE => (Currency{:CVE}, 2, 132, "Cabo Verde Escudo"),
    :ARS => (Currency{:ARS}, 2, 32, "Argentine Peso"),
    :CDF => (Currency{:CDF}, 2, 976, "Congolese Franc"),
    :PGK => (Currency{:PGK}, 2, 598, "Kina"),
    :RUB => (Currency{:RUB}, 2, 643, "Russian Ruble"),
    :MNT => (Currency{:MNT}, 2, 496, "Tugrik"),
    :RWF => (Currency{:RWF}, 0, 646, "Rwanda Franc"),
    :SZL => (Currency{:SZL}, 2, 748, "Lilangeni"),
    :GBP => (Currency{:GBP}, 2, 826, "Pound Sterling"),
    :WST => (Currency{:WST}, 2, 882, "Tala"),
    :BYN => (Currency{:BYN}, 2, 933, "Belarusian Ruble"),
    :BGN => (Currency{:BGN}, 2, 975, "Bulgarian Lev"),
    :JOD => (Currency{:JOD}, 3, 400, "Jordanian Dinar"),
    :YER => (Currency{:YER}, 2, 886, "Yemeni Rial"),
    :ZWL => (Currency{:ZWL}, 2, 932, "Zimbabwe Dollar"),
    :LYD => (Currency{:LYD}, 3, 434, "Libyan Dinar"),
    :TMT => (Currency{:TMT}, 2, 934, "Turkmenistan New Manat"),
    :FJD => (Currency{:FJD}, 2, 242, "Fiji Dollar"),
    :KHR => (Currency{:KHR}, 2, 116, "Riel"),
    :BMD => (Currency{:BMD}, 2, 60, "Bermudian Dollar"),
    :KZT => (Currency{:KZT}, 2, 398, "Tenge"),
    :XCD => (Currency{:XCD}, 2, 951, "East Caribbean Dollar"),
    :NPR => (Currency{:NPR}, 2, 524, "Nepalese Rupee"),
    :OMR => (Currency{:OMR}, 3, 512, "Rial Omani"),
    :CLP => (Currency{:CLP}, 0, 152, "Chilean Peso"),
    :ERN => (Currency{:ERN}, 2, 232, "Nakfa"),
    :TOP => (Currency{:TOP}, 2, 776, "Pa’anga"),
    :CUP => (Currency{:CUP}, 2, 192, "Cuban Peso"),
    :LBP => (Currency{:LBP}, 2, 422, "Lebanese Pound"),
    :SCR => (Currency{:SCR}, 2, 690, "Seychelles Rupee"),
    :NOK => (Currency{:NOK}, 2, 578, "Norwegian Krone"),
    :RON => (Currency{:RON}, 2, 946, "Romanian Leu"),
    :MUR => (Currency{:MUR}, 2, 480, "Mauritius Rupee"),
    :BDT => (Currency{:BDT}, 2, 50, "Taka"),
    :MGA => (Currency{:MGA}, 2, 969, "Malagasy Ariary"),
    :SBD => (Currency{:SBD}, 2, 90, "Solomon Islands Dollar"),
    :ISK => (Currency{:ISK}, 0, 352, "Iceland Krona"),
    :GIP => (Currency{:GIP}, 2, 292, "Gibraltar Pound"),
    :KES => (Currency{:KES}, 2, 404, "Kenyan Shilling"),
    :BWP => (Currency{:BWP}, 2, 72, "Pula"),
    :BBD => (Currency{:BBD}, 2, 52, "Barbados Dollar"),
    :KMF => (Currency{:KMF}, 0, 174, "Comorian Franc"),
    :XAF => (Currency{:XAF}, 0, 950, "CFA Franc BEAC"),
    :AMD => (Currency{:AMD}, 2, 51, "Armenian Dram"),
    :CNY => (Currency{:CNY}, 2, 156, "Yuan Renminbi"),
    :KRW => (Currency{:KRW}, 0, 410, "Won"),
    :SEK => (Currency{:SEK}, 2, 752, "Swedish Krona"),
    :BRL => (Currency{:BRL}, 2, 986, "Brazilian Real"),
    :CRC => (Currency{:CRC}, 2, 188, "Costa Rican Colon"),
    :SVC => (Currency{:SVC}, 2, 222, "El Salvador Colon"),
    :IRR => (Currency{:IRR}, 2, 364, "Iranian Rial"),
    :NZD => (Currency{:NZD}, 2, 554, "New Zealand Dollar"),
    :SRD => (Currency{:SRD}, 2, 968, "Surinam Dollar"),
    :NIO => (Currency{:NIO}, 2, 558, "Cordoba Oro"),
    :MKD => (Currency{:MKD}, 2, 807, "Denar"),
    :KGS => (Currency{:KGS}, 2, 417, "Som"),
    :DJF => (Currency{:DJF}, 0, 262, "Djibouti Franc"),
    :UGX => (Currency{:UGX}, 0, 800, "Uganda Shilling"),
    :VUV => (Currency{:VUV}, 0, 548, "Vatu"),
    :LKR => (Currency{:LKR}, 2, 144, "Sri Lanka Rupee"),
    :RSD => (Currency{:RSD}, 2, 941, "Serbian Dinar"),
    :ILS => (Currency{:ILS}, 2, 376, "New Israeli Sheqel"),
    :ANG => (Currency{:ANG}, 2, 532, "Netherlands Antillean Guilder"),
    :LSL => (Currency{:LSL}, 2, 426, "Loti"),
)