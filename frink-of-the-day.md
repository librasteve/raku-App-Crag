Frink is a precursor to crag with many similar ideas.

NB. Need currency, need LLM

To compare:



And contrast:
- crag has a style `crag 'say ...'` intended for the command line (like raku -e 'say ...')
- SI units are preferred, non-SI need the `^<value units[ ±error]>` syntax
- crag has no support for language translation
- crag has no support for words as numbers


Possible new features inspired by Frink:
- [ ] add water, etc. via Physics::Materials
- [ ] add planets, etc. via Physics::Astronomy
- [ ] add url fetch and extract
- [ ] language translation via Google Translate
- [ ] words as numbers via Google Search box

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
crag 'say (^<1 pint> * ^<4 %>).in("alcohol-unit")'
 
crag 'say (330ml * 4%).in("alcohol-unit")'   <=== note % #FIXME 

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



