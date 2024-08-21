Frink is a precursor to crag with many similar ideas.

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

---

#keg -> case (locale dependent)
crag 'say ^<1 keg> / ^<1 case>'

#keg -> 12 floz (locale dependent)
crag 'say ^<1 keg> / ^<12 floz>'  

```

