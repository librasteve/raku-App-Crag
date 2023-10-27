Here are some crags to plunder for a crag-of-the-day generator:

```
crag '$t=♎️<22:04:22>; say $t.in: <millisecs>'
crag 'say ♓️<43°30′30″M>'
crag '{say $^w * $^l}(1.1m±1%, 2.4m±4%)'
crag 'say :<343 m/s ±1> .in: <mph>'
crag 'say e ** (i * π) =~= -1'
crag '$d=7cm ±3%; say π * $d'
crag 'say (:<1676 km> / (^<12:38> - ^<10:22>)).in: <mph>'
crag 'say "{2/0==1/0}, {1/0==0/0}"'
crag 'say (1 / :<30 mpg>).in: <l/100km>'
crag 'say (c * :<13.8 gigayears>).in: <megaparsec>'
crag 'say :<13.8 bn years> .rebase.norm'
crag '$h=450;$w=1520;$d=2315;$v=$h*$w*$d; say (♎️"$v cubic millimetre").in: <cords>'    #hilux load 0.44cord
crag '$h=69;$w=31+21;$d=21+43;$v=$h*$w*$d; say (♎️"$v cu in").in: <cords>'      #my logpile
crag 'say :<1.04 cord> * :<500 kg/m^3>'
crag 'say (:<1884 kg> * :<16 MJ/kg>).in: <kWh>'
crag 'r(0); say :<1 Dalton> .rebase'
crag 'say π²'
crag '$body-temp = 36.8°C; say "Healthy" if $body-temp == 36.6°C ± 3%'
crag 'say "Voltage is {20A * 10kΩ}"'
crag '$x = <௪௨>, say "$x is Tamil for {+$x}." '
crag 'say :<௪௨ mph>'
crag '"#ffffff".subst("#").comb(/(..)/).map({:16($_)}).say'
crag '$fr-max=:<4 W/kg>; $iphone12=:<5.74 W/kg>; say "stop sales in fr" if $iphone12 > $fr-max'
crag '$tub=(1.4m * .5m * .3m); $tap=:<20 L/min>; say $tub/$tap'
crag 'r(0); say "boltzmann-constant is: ", k'
crag 'say (0rXXIII + 0rMM).&to-roman'
crag '$s=Speed.new(value=>0rXL,units=>"mph"); $d=Distance.new(value=>0rMM,units=>"ft"); say "circus-maximus-lap-time {$d/$s}"'
```
