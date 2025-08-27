Frink is a precursor to crag with many similar ideas.

NB. Need currency, need LLM

To compare:



And contrast:
- crag has a style `crag 'say ...'` intended for the command line (like raku -e 'say ...')
- SI units are preferred, non-SI need the `^<value units[ ±error]>` syntax
- crag has no support for language translation
- crag has no support for words as numbers


Possible new features inspired by Frink:
- [x] add water, etc. via LLM::DWIM
- [x] add planets, etc. via LLM::DWIM
- [ ] add url fetch and extract
- [x] language translation via LLM::DWIM
- [x] words as numbers via LLM::DWIM

Here are the Frink [Sample Calculations](https://frinklang.org/#SampleCalculations) translated to crag:
(I have converted to european style units too - since that is the up to date way)

## Mass and Volume
```
#10 feet 12 feet 8 feet -> gallons
crag 'say 3.3m * 4m * 6.6m'

#10. feet 12 feet 8 feet water -> pounds
crag 'say (3.3m * 4m * 6.6m * ^<1000 kg/m^3>)'

#if you insist on doing this the american way
crag 'say (^<10 feet> * ^<12 feet> * ^<8 feet> * ^<1000 kg/m^3>).in: <pounds-mass>'

#2. tons / (10 feet 12 feet water) -> feet
crag 'say ^<2 tonne> / (3.3m * 4m * ^<1000 kg/m^3>)'
```

## Liquor
```
#beer = 12 floz 3.2 percent water/alcohol
(^<1 pint> * ^<4 %>).in("alcohol-unit")
 
(330ml * 4%).in("alcohol-unit")   <=== note % #FIXME 

#magnum 13.5 percent -> beer
crag 'say (^<1 magnum> * ^<13.5 %>).in("alcohol-unit")'

#junglejuice = 1.75 liter 190 proof / (5 gallon)
crag 'say (1.75l * ^<190 us-proof> / ^<5 us-gallon>).in: "percent"'

#5 12 floz junglejuice -> "beer"
crag '$jj=(1.75l * ^<190 us-proof> / ^<5 us-gallon>); $beer=(^<12 floz> * ^<4 %>); say (5 * ^<12 floz> * $jj / $beer)'
#Maybe that's why people were getting punched in the head. QED.
```

## More Liquor
```
#keg -> case (locale dependent)
^<1 keg> / ^<1 case>

#keg -> 12 floz (locale dependent)
^<1 keg> / ^<12 floz>

#(60 dollars)/(keg 3.2 percent water/alcohol) -> "dollars/floz"
(^<60 dollars> / (^<1 keg> * ^<4 %>)).in: 'dollars/alcohol-unit'
-or, in metric-
(10$ / (1l * ^<4 %>)).in: '$/alcohol-unit'

#(6.99 dollars)/(winebottle 13 percent) -> "dollars/floz"
(^<6 dollars> / (^<1 bottle> * ^<13 percent>)).in: 'dollars/alcohol-unit'

#(13.99 dollars)/(1750 ml 80 proof) -> "dollars/alcohol-unit"
(^<13.99 dollars> / (^<1750 ml> * ^<80 us-proof>)).in: 'dollars/alcohol-unit'
```

## Movie Magic
```
#1/4 moonmass / (4/3 pi (500/2 km)^3) -> water
( (?^<moonmass in kg> / 4) / (4/3 * pi * (500km/2)**3) ) / ?^<water density in kg/m3>

#G 1/4 moonmass / (500/2 km)^2 -> gravity
( ( (?^<moonmass in kg> / 4) / (500km/2)**2 ) * G ) / ?^<earth gravity in m/s^2>
```

## Fiscal Calculations
need $$

## Ouch!
```
#51 grams TNT -> 185 pounds gravity feet
( ?^<TNT energy in J/kg> * 51g ) / ( 91kg * g )

#51 grams TNT -> "teaspoons gasoline" [hmmm]
( ( 51g * ?^<TNT energy in J/kg> ) / ( ?^<gasoline energy in J/kg> ) ) .in: <g>
```

## Sniping Auctions
```
#now[] + 7 hours + 44 min
(now + ^<7 hr> + ^<44 min>).value.DateTime -or - (now + ^<07:44:00>).value.DateTime
```

## Junkyard Wars
```
#half ton -> barrels water
( ^<1/2 ton> / ?^<water density in kg/m3> ) .in: <barrels>

#2 fathoms water gravity barrel -> 40 watts minutes
( ^<2 fathoms> * ?^<water density in kg/m3> * (g) * ^<1 barrel> ) / ?^<hand crank power in W>

#2 fathoms water gravity barrel -> Calories
( ^<2 fathoms> * ?^<water density in kg/m3> * (g) * ^<1 barrel> ).in: <kcal>
```

## Body Heat
```
#2000 Calories/day -> watts
( ^<2000 kcal> / ^<1 day> ).in: <W>
```

## Microwave Cookery
```
#800 W 60 sec / (27 oz 1 calorie/gram/degC) -> degF
( (^<800 W> * ^<60 sec>) / (^<27 oz> * ^<1 cal/g.K>) )
```

## Why is Superman so Lazy?
```
> $sunpower = ?^<total power radiated by the sun in W>
382799999999999989583362129.92W
> $sundist = ?^<distance between the earth and the sun in m>
149600000000m
> $earthpower = $sunpower / ( 4 * pi * $sundist**2 )
1361.13W/m^2
> $chargerate = $earthpower * ^<12 ft^2>
1517.43W
> ( ^<2 ton> * ^<7 ft> * g ) / $chargerate
25.02s

> ( ^"{225+135} lbm" * ^<15000 ft> * g ) / $chargerate
01:20:24
```

## Fart Jokes
```
#12.5 kilotons TNT / (6 years + 9 months) -> horsepower
( ( ^<12.5 kiloton> * ?^<TNT energy in J/kg> ) / ( ^<6 years> + ^<9 months> ) ).in: <horsepower>

#12.5 kilotons TNT / (6 years + 9 months) -> Calories/day
( ( ^<12.5 kiloton> * ?^<TNT energy in J/kg> ) / ( ^<6 years> + ^<9 months> ) ).in: <kcal/day>

#12.5 kilotons TNT / (2000 Calories/day) -> years
( ( ^<12.5 kiloton> * ?^<TNT energy in J/kg> ) / ^<2000 kcal/day> ).in: <years>
```

et cetera


