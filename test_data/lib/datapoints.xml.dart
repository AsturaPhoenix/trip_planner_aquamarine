const kDatapointsXml = r'''
<!-- $Id: datapoints.xml,v 1.105 2022/12/16 21:36:40 wp_us7xtt Exp $ -->
<stations>
<station station_type='current' subtype='Reference' cid='1' title='San Francisco Bay entrance (outside) (depth 19 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1201_26'>
<marker lat='37.8106' lng='-122.502' />
<flow flood='61' ebb='239' />
</station>
<station station_type='current' subtype='Subordinate' cid='2' title='0.3 mile northeast of, Marrowstone Point, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1000' lng='-122.6833' />
<flow flood='170' ebb='15' />
</station>
<station station_type='current' subtype='Subordinate' cid='3' title='0.5 nmi east of entrance (depth 4 ft), Suisun Slough, Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0821_1'>
<marker lat='38.1188' lng='-122.0533' />
<flow flood='358' ebb='156' />
</station>
<station station_type='current' subtype='Subordinate' cid='4' title='1 mi inside entrance (depth 15 ft), Suisun Slough, Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0811_1'>
<marker lat='38.1378' lng='-122.0813' />
<flow flood='34' ebb='202' />
</station>
<station station_type='current' subtype='Subordinate' cid='5' title='1 mi inside west entrance (depth 22 ft), Montezuma Slough, Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0801_1'>
<marker lat='38.1472' lng='-122.0563' />
<flow flood='16' ebb='191' />
</station>
<station station_type='current' subtype='Subordinate' cid='6' title='28th St. Pier (San Diego), 0.35 nmi SW (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0101_1'>
<marker lat='32.6828' lng='-117.1428' />
<flow flood='133' ebb='317' />
</station>
<station station_type='current' subtype='Subordinate' cid='7' title='28th St. Pier (San Diego), 0.92 nmi SW (depth 7 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0096_1'>
<marker lat='32.6747' lng='-117.1495' />
<flow flood='182' ebb='351' />
</station>
<station station_type='current' subtype='Subordinate' cid='8' title='Admiralty Head, 0.5 mile west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1500' lng='-122.7' />
<flow flood='145' ebb='25' />
</station>
<station station_type='tide' subtype='Subordinate' tid='1' title='Ala Spit, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.3967' lng='-122.5867' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='2' title='Ala Spit, Whidbey Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9447993'>
<marker lat='48.3967' lng='-122.587' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='3' title='Alameda Creek, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414632'>
<marker lat='37.5950' lng='-122.145' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='9' title='Alameda Estuary, southeast end (depth 2 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1216_9'>
<marker lat='37.7615' lng='-122.2239' />
<flow flood='178' ebb='1' />
</station>
<station station_type='tide' subtype='Reference' tid='4' title='Alameda Naval Air Station fuel pier, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414767'>
<marker lat='37.7933' lng='-122.315' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='10' title='Alameda Radar Tower, .9 SSW of, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7333' lng='-122.2666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='11' title='Alameda Radar Tower, 0.9 nmi SSW of (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0436_1'>
<marker lat='37.7455' lng='-122.283' />
<flow flood='132' ebb='309' />
</station>
<station station_type='tide' subtype='Reference' tid='5' title='Alameda, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414750'>
<marker lat='37.7717' lng='-122.3' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='6' title='Albion, California' source='legacy-2005-05-02.tcd' zone='455' noaa_id=''>
<marker lat='39.2167' lng='-123.7666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='12' title='Alcatraz (North Point), San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8267' lng='-122.4167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='13' title='Alcatraz Island .8 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.4' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='14' title='Alcatraz Island S, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.4166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='15' title='Alcatraz Island W, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8333' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='16' title='Alcatraz Island, 0.2 mi west of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0291_1'>
<marker lat='37.8278' lng='-122.4303' />
<flow flood='70' ebb='266' />
</station>
<station station_type='current' subtype='Reference' cid='17' title='Alcatraz Island, 0.5 mi north of (depth 6 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1211_22'>
<marker lat='37.8351' lng='-122.4201' />
<flow flood='74' ebb='293' />
</station>
<station station_type='current' subtype='Subordinate' cid='18' title='Alcatraz Island, 5 mi N, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8333' lng='-122.4166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='7' title='Alcatraz Island, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414792'>
<marker lat='37.8267' lng='-122.417' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='19' title='Alcatraz Island, south of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0301_1'>
<marker lat='37.8183' lng='-122.422' />
<flow flood='93' ebb='286' />
</station>
<station station_type='current' subtype='Reference' cid='20' title='Alcatraz Island, southwest of (depth 2 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1204_18'>
<marker lat='37.8143' lng='-122.432' />
<flow flood='86' ebb='271' />
</station>
<station station_type='current' subtype='Subordinate' cid='21' title='Alden Point, Patos Island, 2 mi S of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2286_1'>
<marker lat='48.7578' lng='-122.9803' />
<flow flood='25' ebb='185' />
</station>
<station station_type='tide' subtype='Subordinate' tid='8' title='Aleck Bay, Lopez Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449994'>
<marker lat='48.4250' lng='-122.853' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='22' title='Allan Pass (depth 11 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1737_26'>
<marker lat='48.4716' lng='-122.6998' />
<flow flood='293' ebb='75' />
</station>
<station station_type='tide' subtype='Subordinate' tid='9' title='Anacortes, Guemes Channel, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448794'>
<marker lat='48.5183' lng='-122.62' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='10' title='Angel Island (west side), San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414817'>
<marker lat='37.8600' lng='-122.443' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='23' title='Angel Island .8 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8500' lng='-122.4' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='24' title='Angel Island, 0.75 mi east of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0586_1'>
<marker lat='37.8633' lng='-122.4017' />
<flow flood='351' ebb='192' />
</station>
<station station_type='tide' subtype='Subordinate' tid='11' title='Angel Island, East Garrison, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414818'>
<marker lat='37.8633' lng='-122.42' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='25' title='Angel Island, off Quarry Point, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0581_1'>
<marker lat='37.8633' lng='-122.4133' />
<flow flood='27' ebb='130' />
</station>
<station station_type='current' subtype='Reference' cid='26' title='Angeles Pt., 2 mi NNE of (depth 12 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='PUG1639_16'>
<marker lat='48.1770' lng='-123.5269' />
<flow flood='75' ebb='300' />
</station>
<station station_type='tide' subtype='Subordinate' tid='12' title='Ano Nuevo Island, California' source='harmonics-dwf-20210110-free.tcd' zone='560' noaa_id='9413878'>
<marker lat='37.1083' lng='-122.338' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='27' title='Antioch Point (depth 9 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1327_13'>
<marker lat='38.0239' lng='-121.8226' />
<flow flood='141' ebb='314' />
</station>
<station station_type='current' subtype='Subordinate' cid='28' title='Antioch Point, 0.3 mi east of, San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0926_1'>
<marker lat='38.0333' lng='-121.8167' />
<flow flood='128' ebb='304' />
</station>
<station station_type='current' subtype='Subordinate' cid='29' title='Antioch Pt .3 mi E, San Joaquin River, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0333' lng='-121.8166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='30' title='Antioch, Route 160 bridge (depth 7 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1329_8'>
<marker lat='38.0270' lng='-121.7531' />
<flow flood='96' ebb='277' />
</station>
<station station_type='tide' subtype='Reference' tid='13' title='Antioch, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415064'>
<marker lat='38.0200' lng='-121.815' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='14' title='Arcata Wharf, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418851'>
<marker lat='40.8500' lng='-124.117' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='15' title='Arena Cove, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9416841'>
<marker lat='38.9146' lng='-123.7111' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='16' title='Armitage Island, Thatcher Pass, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449932'>
<marker lat='48.5350' lng='-122.797' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='31' title='Army Pt. Pier Lt. 0.2 nmi SE of (depth 21 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0796_1'>
<marker lat='38.0388' lng='-122.1337' />
<flow flood='63' ebb='238' />
</station>
<station station_type='tide' subtype='Subordinate' tid='17' title='Astoria (Port Docks), Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9439023'>
<marker lat='46.1867' lng='-123.86' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='18' title='Astoria (Youngs Bay), Columbia River, Oregon' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.1717' lng='-123.8416' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='19' title='Astoria (Youngs Bay), Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9439026'>
<marker lat='46.1717' lng='-123.842' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='20' title='Avalon, Santa Catalina Island, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410079'>
<marker lat='33.3450' lng='-118.325' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='32' title='Avon Pier, 0.15 nmi north of (depth 30 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0831_1'>
<marker lat='38.0517' lng='-122.0903' />
<flow flood='59' ebb='237' />
</station>
<station station_type='current' subtype='Subordinate' cid='33' title='Baker Bay entrance, E of Sand Island Tower (depth 23 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1116_1'>
<marker lat='46.2620' lng='-123.998' />
<flow flood='8' ebb='202' />
</station>
<station station_type='current' subtype='Subordinate' cid='34' title='Baker Beach (South Bay), 0.3 nmi NW of (depth 31 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0256_1'>
<marker lat='37.7978' lng='-122.4885' />
<flow flood='38' ebb='208' />
</station>
<station station_type='tide' subtype='Subordinate' tid='21' title='Balboa Pier, Newport Beach, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410583'>
<marker lat='33.6000' lng='-117.9' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='35' title='Ballast Point, 0.55 nmi north of (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0046_1'>
<marker lat='32.6958' lng='-117.2325' />
<flow flood='354' ebb='193' />
</station>
<station station_type='current' subtype='Subordinate' cid='36' title='Ballast Point, 100 yards north of, San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0041_1'>
<marker lat='32.6833' lng='-117.2333' />
<flow flood='325' ebb='133' />
</station>
<station station_type='tide' subtype='Reference' tid='22' title='Ballast Point, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410155'>
<marker lat='32.6867' lng='-117.233' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='37' title='Ballast Point, south of (depth 5 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0036_1'>
<marker lat='32.6845' lng='-117.2322' />
<flow flood='44' ebb='238' />
</station>
<station station_type='tide' subtype='Subordinate' tid='23' title='Bandon, Coquille River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432373'>
<marker lat='43.1200' lng='-124.413' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='24' title='Bar at entrance, Yaquina Bay and River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.6167' lng='-124.0833' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='38' title='Barnes Island, 0.8 mi southwest of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2071_1'>
<marker lat='48.6858' lng='-122.7888' />
<flow flood='315' ebb='140' />
</station>
<station station_type='current' subtype='Subordinate' cid='39' title='Barnes Island, 0.8 mile SW of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6833' lng='-122.7667' />
<flow flood='315' ebb='140' />
</station>
<station station_type='tide' subtype='Subordinate' tid='25' title='Barview, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437581'>
<marker lat='45.5683' lng='-123.943' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='40' title='Bay Bridge, Pier D (depth 9 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1207_18'>
<marker lat='37.8009' lng='-122.3739' />
<flow flood='144' ebb='305' />
</station>
<station station_type='current' subtype='Reference' cid='41' title='Bay Bridge, Span B-C (depth 11 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1208_24'>
<marker lat='37.7975' lng='-122.3739' />
<flow flood='158' ebb='320' />
</station>
<station station_type='tide' subtype='Subordinate' tid='26' title='Bay Center, Palix River, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440846'>
<marker lat='46.6233' lng='-123.945' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='27' title='Bay City, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0865'>
<marker lat='45.5167' lng='-123.9' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='28' title='Bay Slough, east end, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414486'>
<marker lat='37.5450' lng='-122.222' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='29' title='Bay Slough, west end, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414483'>
<marker lat='37.5517' lng='-122.243' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='30' title='Bechers Bay, Santa Rosa Island, California' source='harmonics-dwf-20210110-free.tcd' zone='673' noaa_id='9410962'>
<marker lat='34.0083' lng='-120.047' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='31' title='Bedwell Harbour, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7333' lng='-123.2333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='42' title='Belle Rock Light, east of (depth 23 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1729_21'>
<marker lat='48.4968' lng='-122.7308' />
<flow flood='16' ebb='219' />
</station>
<station station_type='current' subtype='Reference' cid='43' title='Bellingham Channel South (depth 19 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1739_31'>
<marker lat='48.5396' lng='-122.6834' />
<flow flood='59' ebb='216' />
</station>
<station station_type='current' subtype='Reference' cid='44' title='Bellingham Channel north entrance (depth 27 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1741_27'>
<marker lat='48.5928' lng='-122.6577' />
<flow flood='8' ebb='230' />
</station>
<station station_type='current' subtype='Reference' cid='45' title='Bellingham Channel, off Cypress Head Light (depth 31 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1740_19'>
<marker lat='48.5585' lng='-122.6618' />
<flow flood='20' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='46' title='Bellingham Channel, off Cypress I. Light, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5603' lng='-122.6637' />
<flow flood='45' ebb='185' />
</station>
<station station_type='current' subtype='Subordinate' cid='47' title='Bellingham Channel, off Cypress Island, Light of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5500' lng='-122.65' />
<flow flood='45' ebb='185' />
</station>
<station station_type='tide' subtype='Subordinate' tid='32' title='Bellingham, Bellingham Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449211'>
<marker lat='48.7450' lng='-122.495' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='33' title='Bellingham, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-122.5' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='48' title='Benicia Bridge (depth 15 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='s06010_16' observed='true'>
<marker lat='38.0346' lng='-122.1252' />
<flow flood='58' ebb='242' />
</station>
<station station_type='tide' subtype='Subordinate' tid='34' title='Benicia, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415111'>
<marker lat='38.0433' lng='-122.13' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='49' title='Berkeley Yacht Harbor .9 mi S, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8500' lng='-122.3' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='50' title='Berkeley Yacht Harbor, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8522' lng='-122.3112' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='36' title='Berkeley, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414816'>
<marker lat='37.8650' lng='-122.307' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='37' title='Bishop Cut, Disappointment Slough, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415117'>
<marker lat='38.0450' lng='-121.42' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='38' title='Blackslough Landing, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415021'>
<marker lat='37.9947' lng='-121.419' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='39' title='Blaine, Semiahmoo Bay, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='49.0000' lng='-122.7667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='40' title='Blakes Landing, Tomales Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415396'>
<marker lat='38.1900' lng='-122.917' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='51' title='Bluff Point .1 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8833' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='52' title='Bluff Point, 0.1 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0621_1'>
<marker lat='37.8833' lng='-122.435' />
<flow flood='9' ebb='147' />
</station>
<station station_type='current' subtype='Subordinate' cid='53' title='Bluff Point, 1.15 nmi east of (depth 21 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0626_1'>
<marker lat='37.8872' lng='-122.413' />
<flow flood='336' ebb='167' />
</station>
<station station_type='current' subtype='Reference' cid='54' title='Boat Passage, British Columbia Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.8167' lng='-123.1833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='41' title='Bodega Harbor entrance, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415625'>
<marker lat='38.3083' lng='-123.055' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='42' title='Bolinas, Bolinas Lagoon, California' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='9414958'>
<marker lat='37.9078' lng='-122.6786' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='43' title='Borden Highway Bridge, Middle River, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414835'>
<marker lat='37.8917' lng='-121.488' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='44' title='Borden Highway Bridge, Old River, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414836'>
<marker lat='37.8833' lng='-121.577' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='45' title='Borden Highway Bridge, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414367'>
<marker lat='37.9367' lng='-121.3333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='46' title='Bowman Bay, Fidalgo Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4150' lng='-122.6517' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='47' title='Bradmoor Island, Nurse Slough, Suisun Bay, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.1833' lng='-121.9233' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='55' title='Brandt Bridge, San Joaquin River, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8667' lng='-121.3166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='48' title='Brazos Drawbridge, Napa River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415446'>
<marker lat='38.2100' lng='-122.307' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='49' title='Brazos Drawbridge, Napa River, Carquinez Strait, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.2100' lng='-122.3066' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='50' title='Brighton, Nehalem River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437815'>
<marker lat='45.6700' lng='-123.925' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='51' title='Brookings, Chetco Cove, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='356' noaa_id='9430104'>
<marker lat='42.0433' lng='-124.285' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='56' title='Brooklyn Basin (depth 5 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1215_8'>
<marker lat='37.7852' lng='-122.2605' />
<flow flood='114' ebb='290' />
</station>
<station station_type='tide' subtype='Subordinate' tid='52' title='Bucksport, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418778'>
<marker lat='40.7783' lng='-124.197' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='53' title='Burrows Bay (Allan Island), Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448683'>
<marker lat='48.4600' lng='-122.695' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='57' title='Burrows Bay, 0.5 mi east of Allan I, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2006_1'>
<marker lat='48.4628' lng='-122.6828' />
<flow flood='22' ebb='209' />
</station>
<station station_type='tide' subtype='Subordinate' tid='54' title='Burrows Bay, Allan Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4667' lng='-122.7' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='58' title='Burrows I.-Allan I., Passage between, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4717' lng='-122.6997' />
<flow flood='304' ebb='96' />
</station>
<station station_type='current' subtype='Subordinate' cid='59' title='Burrows Island Light, 0.8 miles WNW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4833' lng='-122.7333' />
<flow flood='15' ebb='200' />
</station>
<station station_type='current' subtype='Reference' cid='60' title='Burrows Pass (depth 15 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1738_27'>
<marker lat='48.4895' lng='-122.6867' />
<flow flood='286' ebb='87' />
</station>
<station station_type='tide' subtype='Subordinate' tid='55' title='Cabrillo Beach, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410650'>
<marker lat='33.7067' lng='-118.273' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='56' title='Calaveras Point, west of, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414539'>
<marker lat='37.4667' lng='-122.067' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='57' title='Cape Alava, Washington' source='legacy-2005-05-02.tcd' zone='150' noaa_id=''>
<marker lat='48.1667' lng='-124.7333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='61' title='Cape Blanco, Oregon Current' source='harmonics-dwf-20081228-free.tcd' zone='356' noaa_id=''>
<marker lat='42.8333' lng='-124.5833' />
<flow flood='10' ebb='190' />
</station>
<station station_type='tide' subtype='Reference' tid='58' title='Cape Disappointment, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440581'>
<marker lat='46.2810' lng='-124.0463' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='59' title='Cape Mendocino, California' source='legacy-2005-05-02.tcd' zone='455' noaa_id=''>
<marker lat='40.4333' lng='-124.4166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='62' title='Cape Sebastian, Oregon Current' source='harmonics-dwf-20081228-free.tcd' zone='356' noaa_id=''>
<marker lat='42.3333' lng='-124.4333' />
<flow flood='355' ebb='175' />
</station>
<station station_type='current' subtype='Subordinate' cid='63' title='Cape Vizcaino, California Current' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='39.7333' lng='-123.8333' />
<flow flood='325' ebb='145' />
</station>
<station station_type='tide' subtype='Subordinate' tid='60' title='Carmel Cove, Carmel Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='565' noaa_id='9413375'>
<marker lat='36.5200' lng='-121.94' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='64' title='Carquinez Bridge, I-80 (depth 20 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1318_9'>
<marker lat='38.0624' lng='-122.2275' />
<flow flood='92' ebb='269' />
</station>
<station station_type='current' subtype='Reference' cid='65' title='Carquinez Strait (depth 12 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1319_10'>
<marker lat='38.0614' lng='-122.2182' />
<flow flood='98' ebb='289' />
</station>
<station station_type='tide' subtype='Reference' tid='61' title='Cascade Head, Salmon River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9436381'>
<marker lat='45.0479' lng='-124.0073' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='62' title='Catalina Harbor, California' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='33.4317' lng='-118.5033' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='63' title='Catalina Harbor, Santa Catalina Island, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410092'>
<marker lat='33.4317' lng='-118.503' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='66' title='Cattle Point, 1.2 mile SE of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4167' lng='-122.95' />
<flow flood='340' ebb='195' />
</station>
<station station_type='current' subtype='Subordinate' cid='67' title='Cattle Point, 1.2 miles southeast of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4338' lng='-122.947' />
<flow flood='340' ebb='195' />
</station>
<station station_type='current' subtype='Reference' cid='68' title='Cattle Point, 1.2 nmi SE of (depth 39 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1742_21'>
<marker lat='48.4344' lng='-122.9466' />
<flow flood='2' ebb='183' />
</station>
<station station_type='current' subtype='Subordinate' cid='69' title='Cattle Point, 2.8 mi SSW of, San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT1416_1'>
<marker lat='48.4000' lng='-123' />
<flow flood='46' ebb='187' />
</station>
<station station_type='current' subtype='Reference' cid='70' title='Cattle Point, 4.6 nmi SW of (depth 55 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1743_22'>
<marker lat='48.3840' lng='-123.0157' />
<flow flood='54' ebb='228' />
</station>
<station station_type='current' subtype='Subordinate' cid='71' title='Cattle Point, 5 miles SSW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.3833' lng='-123.0167' />
<flow flood='120' ebb='210' />
</station>
<station station_type='current' subtype='Subordinate' cid='72' title='Chain Island .7 mi SW, Sacramento River, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0500' lng='-121.8666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='73' title='Channel, 1.5 mi north of Westport, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1301_1'>
<marker lat='46.9333' lng='-124.1' />
<flow flood='36' ebb='226' />
</station>
<station station_type='current' subtype='Subordinate' cid='74' title='Channel, 2.1 mi NNE of Westport, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1306_1'>
<marker lat='46.9333' lng='-124.0833' />
<flow flood='21' ebb='249' />
</station>
<station station_type='tide' subtype='Reference' tid='64' title='Charles Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4500' lng='-122.9' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='65' title='Charleston, Coos Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432780'>
<marker lat='43.3450' lng='-124.322' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='66' title='Charleston, Oregon' source='legacy-2005-05-02.tcd' zone='350' noaa_id=''>
<marker lat='43.3450' lng='-124.3217' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='75' title='Cherry Point (depth 47 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='cp0101_20'>
<marker lat='48.8627' lng='-122.761' />
<flow flood='7' ebb='179' />
</station>
<station station_type='current' subtype='Reference' cid='76' title='Cherry Point, 1.8 nmi southeast of (depth 8 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1725_30'>
<marker lat='48.8338' lng='-122.7279' />
<flow flood='346' ebb='156' />
</station>
<station station_type='tide' subtype='Reference' tid='67' title='Cherry Point, Strait of Georgia, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449424'>
<marker lat='48.8633' lng='-122.758' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='68' title='Cherry Point, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.8633' lng='-122.7583' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='69' title='Chevron Oil Company Pier, Richmond, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414863'>
<marker lat='37.9230' lng='-122.4096' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='70' title='Chinook Bend, Siletz River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435992'>
<marker lat='44.8800' lng='-123.9636' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='77' title='Chinook Point, WSW of (depth 14 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1171_1'>
<marker lat='46.2422' lng='-123.9642' />
<flow flood='117' ebb='287' />
</station>
<station station_type='tide' subtype='Subordinate' tid='71' title='Chinook, Baker Bay, Columbia River, Washington' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.2717' lng='-123.9483' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='72' title='Chinook, Baker Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440573'>
<marker lat='46.2717' lng='-123.948' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='73' title='Chuckanut Bay, Bellingham Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='TWC1169'>
<marker lat='48.6667' lng='-122.5' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='78' title='Clark Island, 1.6 mile North of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7333' lng='-122.7667' />
<flow flood='335' ebb='150' />
</station>
<station station_type='current' subtype='Subordinate' cid='79' title='Clark Island, 1.6 miles north of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7313' lng='-122.7733' />
<flow flood='335' ebb='150' />
</station>
<station station_type='current' subtype='Reference' cid='80' title='Clark Island, 1.6 nmi north of (depth 29 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1709_33'>
<marker lat='48.7313' lng='-122.7734' />
<flow flood='335' ebb='159' />
</station>
<station station_type='current' subtype='Subordinate' cid='81' title='Clatsop Spit, NNE of (depth 15 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1121_1'>
<marker lat='46.2462' lng='-123.9942' />
<flow flood='114' ebb='289' />
</station>
<station station_type='tide' subtype='Reference' tid='74' title='Cockrobin Island Bridge, Eel River, San Francisco, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418637'>
<marker lat='40.6372' lng='-124.2822' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='75' title='Collinsville, Sacramento River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415176'>
<marker lat='38.0733' lng='-121.848' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='76' title='Columbia River entrance (north jetty), Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440574'>
<marker lat='46.2733' lng='-124.072' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='82' title='Colville Island, 1 mi SSE of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT1971_1'>
<marker lat='48.4000' lng='-122.8167' />
<flow flood='55' ebb='235' />
</station>
<station station_type='current' subtype='Subordinate' cid='83' title='Colville Island, 1.4 miles east of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4167' lng='-122.7833' />
<flow flood='55' ebb='215' />
</station>
<station station_type='current' subtype='Subordinate' cid='84' title='Coos Bay entrance, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='PCT1061_1'>
<marker lat='43.3550' lng='-124.3412' />
<flow flood='100' ebb='280' />
</station>
<station station_type='tide' subtype='Subordinate' tid='77' title='Coos Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432845'>
<marker lat='43.3800' lng='-124.215' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='85' title='Coquille River entrance, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='PCT1056_1'>
<marker lat='43.1217' lng='-124.4197' />
<flow flood='91' ebb='290' />
</station>
<station station_type='tide' subtype='Subordinate' tid='78' title='Corkscrew Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414505'>
<marker lat='37.5083' lng='-122.21' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='79' title='Cornet Bay, Deception Pass, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9447995'>
<marker lat='48.4017' lng='-122.623' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='86' title='Coronado, off northeast end (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0091_1'>
<marker lat='32.6980' lng='-117.1638' />
<flow flood='128' ebb='317' />
</station>
<station station_type='tide' subtype='Reference' tid='80' title='Corte Madera Creek, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414874'>
<marker lat='37.9433' lng='-122.513' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='81' title='Coupeville, Penn Cove, Whidbey Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9447929'>
<marker lat='48.2233' lng='-122.69' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='82' title='Coyote Creek, Alviso Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414575'>
<marker lat='37.4650' lng='-122.023' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='83' title='Coyote Creek, Tributary #1, San Francisco Bay, California' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.4467' lng='-121.9633' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='84' title='Coyote Creek, Tributary No. 1, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414561'>
<marker lat='37.4467' lng='-121.963' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='85' title='Coyote Hills Slough entrance, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414621'>
<marker lat='37.5633' lng='-122.128' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='86' title='Coyote Point Marina, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414449'>
<marker lat='37.5917' lng='-122.313' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='87' title='Coyote Point, 2.3 nmi NNE of (depth 3 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1306_7'>
<marker lat='37.6255' lng='-122.2961' />
<flow flood='144' ebb='325' />
</station>
<station station_type='current' subtype='Subordinate' cid='88' title='Crane Island, Wasp Passage, South of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5833' lng='-123' />
<flow flood='288' ebb='75' />
</station>
<station station_type='current' subtype='Subordinate' cid='89' title='Crane Island, south of, Wasp Passage, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5895' lng='-122.9987' />
<flow flood='288' ebb='75' />
</station>
<station station_type='tide' subtype='Subordinate' tid='87' title='Crescent Bay, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='9443826'>
<marker lat='48.1617' lng='-123.725' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='88' title='Crescent Bay, Washington' source='legacy-2005-05-02.tcd' zone='131' noaa_id=''>
<marker lat='48.1667' lng='-123.7333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='89' title='Crescent City, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9419750'>
<marker lat='41.7450' lng='-124.183' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='90' title='Crescent City, California (2) (expired 1989-12-31)' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='41.7450' lng='-124.1833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='91' title='Crockett, Carquinez Strait, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415143'>
<marker lat='38.0583' lng='-122.223' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='92' title='Crown Point, Mission Bay, California' source='harmonics-dwf-20081228-free.tcd' zone='750' noaa_id=''>
<marker lat='32.7800' lng='-117.235' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='93' title='Cuyler Harbor, San Miguel Island, California' source='harmonics-dwf-20210110-free.tcd' zone='673' noaa_id='9410988'>
<marker lat='34.0567' lng='-120.355' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='90' title='Davis Point, 1.0 nmi NW of (depth 7 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1316_9'>
<marker lat='38.0619' lng='-122.2767' />
<flow flood='87' ebb='266' />
</station>
<station station_type='current' subtype='Subordinate' cid='92' title='Davis Point, midchannel (depth 8 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0756_1'>
<marker lat='38.0633' lng='-122.2583' />
<flow flood='91' ebb='249' />
</station>
<station station_type='tide' subtype='Subordinate' tid='94' title='Davis Slough, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415053'>
<marker lat='38.0117' lng='-121.638' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='93' title='Deception Island, 2.7 mile West of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4167' lng='-122.7333' />
<flow flood='15' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='94' title='Deception Island, 2.7 miles west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4125' lng='-122.7395' />
<flow flood='15' ebb='190' />
</station>
<station station_type='current' subtype='Reference' cid='95' title='Deception Pass (Narrows) (depth 18 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1701_33'>
<marker lat='48.4062' lng='-122.6431' />
<flow flood='108' ebb='277' />
</station>
<station station_type='tide' subtype='Reference' tid='95' title='Deception Pass St. Park, Bowman Bay, Fidalgo I., Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448614'>
<marker lat='48.4150' lng='-122.652' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='96' title='Depoe Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435827'>
<marker lat='44.8100' lng='-124.058' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='97' title='Destruction Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='153' noaa_id='TWC0965'>
<marker lat='47.6667' lng='-124.4833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='98' title='Dick Point, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437381'>
<marker lat='45.4817' lng='-123.902' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='96' title='Dillon Point (depth 19 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1320_13'>
<marker lat='38.0589' lng='-122.193' />
<flow flood='92' ebb='275' />
</station>
<station station_type='current' subtype='Reference' cid='97' title='Discovery Island, 3.0 nmi NE of (depth 41 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1744_22'>
<marker lat='48.4521' lng='-123.1554' />
<flow flood='17' ebb='160' />
</station>
<station station_type='current' subtype='Subordinate' cid='98' title='Discovery Island, 3.3 miles northeast of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4500' lng='-123.15' />
<flow flood='345' ebb='170' />
</station>
<station station_type='current' subtype='Reference' cid='99' title='Discovery Island, 7.6 mi SSE of (depth 28 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1636_34'>
<marker lat='48.3002' lng='-123.1672' />
<flow flood='69' ebb='240' />
</station>
<station station_type='tide' subtype='Reference' tid='99' title='Drakes Bay, Point Reyes, California' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='9415020'>
<marker lat='37.9961' lng='-122.9767' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='101' title='Drayton Harbor entrance, Georgia Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2301_1'>
<marker lat='48.9908' lng='-122.7678' />
<flow flood='133' ebb='313' />
</station>
<station station_type='tide' subtype='Reference' tid='100' title='Drayton Harbor, Blaine, Strait of Georgia, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449679'>
<marker lat='48.9917' lng='-122.765' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='101' title='Drift Creek, Alsea River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9434938'>
<marker lat='44.4133' lng='-123.99' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='102' title='Dumbarton Bridge, San Francisco Bay, California (2)' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5000' lng='-122.1167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='102' title='Dumbarton Bridge, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5100' lng='-122.12' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='103' title='Dumbarton Highway Bridge (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1301_12'>
<marker lat='37.5018' lng='-122.116' />
<flow flood='139' ebb='320' />
</station>
<station station_type='tide' subtype='Reference' tid='103' title='Dumbarton Highway Bridge, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414509'>
<marker lat='37.5067' lng='-122.115' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='104' title='Dumbarton Hwy Bridge, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5000' lng='-122.1166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='105' title='Dumbarton Hwy. Bridge, 0.28 nmi SE of (depth 25 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0531_1'>
<marker lat='37.5013' lng='-122.1155' />
<flow flood='141' ebb='319' />
</station>
<station station_type='current' subtype='Subordinate' cid='106' title='Dumbarton Point 2.3 mi NE, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.4667' lng='-122.0666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='107' title='Dumbarton Point, 1.15 nmi SE of (depth 17 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0536_1'>
<marker lat='37.4875' lng='-122.0813' />
<flow flood='131' ebb='320' />
</station>
<station station_type='current' subtype='Subordinate' cid='108' title='Dumbarton Point, 2.25 mi SE of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0541_1'>
<marker lat='37.4750' lng='-122.07' />
<flow flood='127' ebb='302' />
</station>
<station station_type='tide' subtype='Subordinate' tid='104' title='Dungeness, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444471'>
<marker lat='48.1667' lng='-123.117' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='105' title='Dungeness, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.1667' lng='-123.1167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='106' title='Eagle Harbor, Cypress Island, Washington' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5833' lng='-122.7' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='107' title='Echo Bay, Sucia Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-122.9' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='108' title='Echo Bay, Sucia Islands, Strait of Georgia, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449712'>
<marker lat='48.7567' lng='-122.897' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='109' title='Edgerley Island, Napa River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415415'>
<marker lat='38.1917' lng='-122.312' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='110' title='Edgerley Island, Napa River, Carquinez Strait, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.1917' lng='-122.3116' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='109' title='Ediz Hook Light, 1.2 mi N of (depth 36 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='PUG1638_22'>
<marker lat='48.1667' lng='-123.4158' />
<flow flood='89' ebb='283' />
</station>
<station station_type='current' subtype='Subordinate' cid='110' title='Ediz Hook Light, 1.2 miles north of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='131' noaa_id=''>
<marker lat='48.1667' lng='-123.4167' />
<flow flood='80' ebb='295' />
</station>
<station station_type='current' subtype='Reference' cid='111' title='Ediz Hook Light, 5.3 mi ENE of (depth 22 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='PUG1637_29'>
<marker lat='48.1823' lng='-123.2815' />
<flow flood='88' ebb='257' />
</station>
<station station_type='current' subtype='Subordinate' cid='112' title='Ediz Hook Light, 5.3 miles ENE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='131' noaa_id=''>
<marker lat='48.1833' lng='-123.2833' />
<flow flood='55' ebb='215' />
</station>
<station station_type='tide' subtype='Subordinate' tid='111' title='Ediz Hook, Port Angeles, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='9444122'>
<marker lat='48.1400' lng='-123.413' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='112' title='Eel River entrance, California' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='40.6333' lng='-124.3166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='113' title='El Segundo, Santa Monica Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410777'>
<marker lat='33.9083' lng='-118.433' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='114' title='Elk River Railroad Bridge #18, Humboldt Bay, California' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='40.7567' lng='-124.1933' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='115' title='Elk River Railroad Bridge, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418757'>
<marker lat='40.7567' lng='-124.193' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='116' title='Elkhorn Slough at Elkhorn, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413631'>
<marker lat='36.8183' lng='-121.747' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='117' title='Elkhorn Slough railroad bridge, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413663'>
<marker lat='36.8567' lng='-121.755' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='118' title='Elkhorn Slough, Highway 1 Bridge, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413623'>
<marker lat='36.8100' lng='-121.785' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='119' title='Elkhorn Yacht Club, California' source='legacy-2005-05-02.tcd' zone='535' noaa_id=''>
<marker lat='36.8133' lng='-121.7866' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='120' title='Elkhorn Yacht Club, Elkhorn Slough, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8133' lng='-121.7867' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='121' title='Elkhorn Yacht Club, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413626'>
<marker lat='36.8133' lng='-121.787' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='122' title='Elkhorn, California' source='legacy-2005-05-02.tcd' zone='535' noaa_id=''>
<marker lat='36.8183' lng='-121.745' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='123' title='Elkhorn, Elkhorn Slough, Monterey Bay, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8183' lng='-121.7467' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='113' title='Emeryville Marina (depth 5 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1218_1'>
<marker lat='37.8433' lng='-122.3254' />
<flow flood='157' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='124' title='Empire, Coos Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432864'>
<marker lat='43.3917' lng='-124.28' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='114' title='Entrance (depth 3 ft), Suisun Slough, Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0816_1'>
<marker lat='38.1212' lng='-122.0675' />
<flow flood='290' ebb='110' />
</station>
<station station_type='current' subtype='Subordinate' cid='115' title='Entrance, 0.2 mi south of north jetty, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1276_1'>
<marker lat='46.9263' lng='-124.1613' />
<flow flood='70' ebb='243' />
</station>
<station station_type='current' subtype='Subordinate' cid='116' title='Entrance, 0.6 mi WNW of Westport, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1286_1'>
<marker lat='46.9147' lng='-124.125' />
<flow flood='44' ebb='238' />
</station>
<station station_type='current' subtype='Subordinate' cid='117' title='Entrance, 0.7 mi SW of Chain Island (depth 7 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0896_1'>
<marker lat='38.0583' lng='-121.8705' />
<flow flood='55' ebb='212' />
</station>
<station station_type='current' subtype='Reference' cid='118' title='Entrance, 0.7 nmi SW of Chain Island (depth 9 ft), Sacramento River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1330_13'>
<marker lat='38.0585' lng='-121.8712' />
<flow flood='49' ebb='226' />
</station>
<station station_type='current' subtype='Subordinate' cid='119' title='Entrance, 1.1 mi NW of Westport, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1296_1'>
<marker lat='46.9167' lng='-124.1333' />
<flow flood='78' ebb='233' />
</station>
<station station_type='current' subtype='Subordinate' cid='120' title='Entrance, Point Chehalis Range, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1281_1'>
<marker lat='46.9083' lng='-124.1555' />
<flow flood='92' ebb='268' />
</station>
<station station_type='tide' subtype='Subordinate' tid='125' title='Entrance, Siuslaw River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='350' noaa_id=''>
<marker lat='44.0167' lng='-124.1333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='126' title='Entrance, Umpqua River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='350' noaa_id=''>
<marker lat='43.6833' lng='-124.2' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='127' title='Eureka Slough Bridge, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418802'>
<marker lat='40.8067' lng='-124.142' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='128' title='Eureka, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418801'>
<marker lat='40.8067' lng='-124.167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='129' title='False River, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415145'>
<marker lat='38.0550' lng='-121.657' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='121' title='Fauntleroy Point Light, 0.8 mile ESE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5200' lng='-122.7697' />
<flow flood='310' ebb='125' />
</station>
<station station_type='current' subtype='Subordinate' cid='122' title='Fauntleroy Point Light, 0.89 mile ESE of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5167' lng='-122.7667' />
<flow flood='310' ebb='125' />
</station>
<station station_type='current' subtype='Reference' cid='123' title='Fauntleroy Point Light, east of (depth 21 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1731_18'>
<marker lat='48.5216' lng='-122.7707' />
<flow flood='334' ebb='157' />
</station>
<station station_type='tide' subtype='Subordinate' tid='130' title='Ferndale, Strait of Georgia, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='TWC1189'>
<marker lat='48.8333' lng='-122.7167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='131' title='Fields Landing, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418723'>
<marker lat='40.7233' lng='-124.222' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='124' title='Fleming Point 1.7 mi SW, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8500' lng='-122.35' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='125' title='Fleming Point, 1.72 nmi SW of (depth 3 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0596_1'>
<marker lat='37.8770' lng='-122.3588' />
<flow flood='82' ebb='259' />
</station>
<station station_type='tide' subtype='Reference' tid='132' title='Florence USCG Pier, Suislaw River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9434098'>
<marker lat='44.0021' lng='-124.123' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='133' title='Florence, Siuslaw River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9434032'>
<marker lat='43.9667' lng='-124.103' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='134' title='Fort Bragg Landing, California' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='39.4500' lng='-123.8167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='135' title='Fort Canby, Jetty A, Columbia River, Washington' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.2667' lng='-124.0366' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='136' title='Fort Canby, Jetty A, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440572'>
<marker lat='46.2683' lng='-124.037' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='126' title='Fort Point, 0.3 nmi west of (depth 75 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0261_1'>
<marker lat='37.8092' lng='-122.4828' />
<flow flood='44' ebb='335' />
</station>
<station station_type='current' subtype='Subordinate' cid='127' title='Fort Point, 0.5 nmi east of (depth 55 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0286_1'>
<marker lat='37.8117' lng='-122.4663' />
<flow flood='99' ebb='287' />
</station>
<station station_type='tide' subtype='Subordinate' tid='137' title='Fort Ross, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9416024'>
<marker lat='38.5133' lng='-123.245' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='138' title='Friday Harbor, San Juan Channel, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5500' lng='-123' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='139' title='Friday Harbor, San Juan Island, San Juan Channel, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449880'>
<marker lat='48.5453' lng='-123.0129' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='140' title='Friday Harbor, San Juan Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5467' lng='-123.01' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='128' title='Frost-Willow Island, between, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2046_1'>
<marker lat='48.5392' lng='-122.8308' />
<flow flood='10' ebb='126' />
</station>
<station station_type='current' subtype='Subordinate' cid='129' title='G St. Pier (San Diego), 0.22 nmi SW of (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0081_1'>
<marker lat='32.7083' lng='-117.1775' />
<flow flood='139' ebb='304' />
</station>
<station station_type='tide' subtype='Subordinate' tid='141' title='Gallinas Creek, San Pablo Bay, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0150' lng='-122.5033' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='142' title='Gallinas, Gallinas Creek, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415052'>
<marker lat='38.0150' lng='-122.503' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='143' title='Gardiner, Discovery Bay, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444705'>
<marker lat='48.0583' lng='-122.917' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='144' title='Gardiner, Discovery Bay, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.0667' lng='-122.9167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='145' title='Gardiner, Umpqua River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='TWC0831'>
<marker lat='43.7333' lng='-124.1167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='146' title='Garibaldi, Oregon' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='45.5583' lng='-123.9117' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='147' title='Garibaldi, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437540'>
<marker lat='45.5545' lng='-123.9189' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='148' title='Gaviota State Park, California' source='harmonics-dwf-20210110-free.tcd' zone='650' noaa_id='9411399'>
<marker lat='34.4694' lng='-120.2283' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='149' title='Gaviota, California' source='harmonics-dwf-20081228-free.tcd' zone='650' noaa_id=''>
<marker lat='34.4667' lng='-120.2167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='150' title='General Fish Company Pier, California' source='legacy-2005-05-02.tcd' zone='535' noaa_id=''>
<marker lat='36.8017' lng='-121.7866' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='151' title='General Fish Company Pier, Moss Landing, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8017' lng='-121.7867' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='152' title='General Fish Company Pier, Moss Landing, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413617'>
<marker lat='36.8017' lng='-121.787' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='153' title='Georgiana Slough entrance, Mokelumne River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415287'>
<marker lat='38.1250' lng='-121.578' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='154' title='Gold Beach, Rogue River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='356' noaa_id='9431011'>
<marker lat='42.4216' lng='-124.4187' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='155' title='Gold Street Bridge, Alviso Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414551'>
<marker lat='37.4233' lng='-121.975' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='130' title='Golden Gate Bridge .8 mi E ., San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.45' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='131' title='Golden Gate Bridge, 0.46 nmi E of (depth 30 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1203_18'>
<marker lat='37.8201' lng='-122.473' />
<flow flood='69' ebb='257' />
</station>
<station station_type='current' subtype='Subordinate' cid='132' title='Golden Gate Bridge, 0.8 mi east of, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0281_1'>
<marker lat='37.8217' lng='-122.4617' />
<flow flood='70' ebb='256' />
</station>
<station station_type='current' subtype='Reference' cid='133' title='Golden Gate Bridge, 0.88 nmi NE of (depth 21 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1202_17'>
<marker lat='37.8292' lng='-122.462' />
<flow flood='52' ebb='238' />
</station>
<station station_type='tide' subtype='Subordinate' tid='156' title='Gooseberry Point, Hale Passage, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449184'>
<marker lat='48.7300' lng='-122.67' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='157' title='Granite Rock, Redwood Creek, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414513'>
<marker lat='37.4950' lng='-122.213' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='158' title='Grant Line Canal (drawbridge), Old River, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8200' lng='-121.4466' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='159' title='Grant Line Canal (drawbridge), San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414785'>
<marker lat='37.8200' lng='-121.447' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='134' title='Grays Harbor entrance (depth 12 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1291_1'>
<marker lat='46.9225' lng='-124.133' />
<flow flood='61' ebb='242' />
</station>
<station station_type='tide' subtype='Reference' tid='160' title='Green Cove, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9416409'>
<marker lat='38.7043' lng='-123.4494' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='135' title='Green Point, 0.8 mi northwest of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2026_1'>
<marker lat='48.5047' lng='-122.7062' />
<flow flood='20' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='136' title='Green Point, 0.8 mile NW of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5000' lng='-122.7' />
<flow flood='20' ebb='190' />
</station>
<station station_type='tide' subtype='Reference' tid='161' title='Greenhead Slough, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440650'>
<marker lat='46.3722' lng='-123.9503' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='137' title='Grizzly Bay entrance (depth 2 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1322_4'>
<marker lat='38.1032' lng='-122.0525' />
<flow flood='62' ebb='228' />
</station>
<station station_type='current' subtype='Subordinate' cid='138' title='Guemes Channel, West entrance of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5167' lng='-122.65' />
<flow flood='95' ebb='255' />
</station>
<station station_type='current' subtype='Reference' cid='139' title='Guemes Channel, east entrance (depth 9 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1735_14'>
<marker lat='48.5277' lng='-122.606' />
<flow flood='75' ebb='268' />
</station>
<station station_type='current' subtype='Reference' cid='140' title='Guemes Channel, west entrance (depth 11 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1734_14'>
<marker lat='48.5212' lng='-122.6522' />
<flow flood='83' ebb='252' />
</station>
<station station_type='current' subtype='Subordinate' cid='141' title='Hale Passage, 0.5 mile SE of Lummi Point, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7313' lng='-122.6778' />
<flow flood='350' ebb='145' />
</station>
<station station_type='current' subtype='Reference' cid='142' title='Hale Passage, east of Lummi Point (depth 8 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1710_14'>
<marker lat='48.7349' lng='-122.6802' />
<flow flood='349' ebb='177' />
</station>
<station station_type='tide' subtype='Subordinate' tid='162' title='Half Moon Bay, California' source='legacy-2005-05-02.tcd' zone='545' noaa_id=''>
<marker lat='37.5017' lng='-122.4866' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='163' title='Halfmoon Bay, Umpqua River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9433445'>
<marker lat='43.6750' lng='-124.192' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='164' title='Hammond, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9439011'>
<marker lat='46.2017' lng='-123.945' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='143' title='Hammond, northeast of ship channel (depth 15 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1151_1'>
<marker lat='46.2112' lng='-123.9345' />
<flow flood='134' ebb='307' />
</station>
<station station_type='tide' subtype='Reference' tid='165' title='Hanbury Point, Mosquito Pass, San Juan I., Haro Strait, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449828'>
<marker lat='48.5817' lng='-123.17' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='144' title='Harbor Island (east end), SSW of (depth 15 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0061_1'>
<marker lat='32.7192' lng='-117.1917' />
<flow flood='97' ebb='293' />
</station>
<station station_type='current' subtype='Subordinate' cid='145' title='Harney Channel, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5908' lng='-122.9205' />
<flow flood='250' ebb='120' />
</station>
<station station_type='current' subtype='Reference' cid='146' title='Harney Channel, north of Point Hudson (depth 10 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1722_27'>
<marker lat='48.5897' lng='-122.9217' />
<flow flood='261' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='147' title='Haro Strait, 1.2 nmi west of Kellett Bluff (depth 66 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1718_36'>
<marker lat='48.5887' lng='-123.2258' />
<flow flood='346' ebb='179' />
</station>
<station station_type='current' subtype='Subordinate' cid='148' title='Heceta Head, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='PCT1071_1'>
<marker lat='44.1333' lng='-124.1333' />
<flow flood='5' ebb='185' />
</station>
<station station_type='tide' subtype='Subordinate' tid='166' title='Hercules, Refugio Landing, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415074'>
<marker lat='38.0233' lng='-122.292' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='167' title='Hog Island, San Antonio Creek, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415344'>
<marker lat='38.1617' lng='-122.55' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='168' title='Holt, Whiskey Slough, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414866'>
<marker lat='37.9350' lng='-121.435' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='169' title='Hookton Slough, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418686'>
<marker lat='40.6867' lng='-124.222' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='170' title='Hope Bay, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.8000' lng='-123.2667' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='149' title='Huckleberry Island, 0.5 mi north of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2106_1'>
<marker lat='48.5458' lng='-122.5663' />
<flow flood='6' ebb='253' />
</station>
<station station_type='tide' subtype='Reference' tid='171' title='Humboldt Bay (south jetty), California (expired 1984-12-31)' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='40.7450' lng='-124.2267' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='172' title='Humboldt Bay Entrance, California' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='40.7667' lng='-124.25' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='150' title='Humboldt Bay ent., 0.1 nmi NE of South Spit Light (depth 14 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='HUB0202_9'>
<marker lat='40.7579' lng='-124.2328' />
<flow flood='168' ebb='341' />
</station>
<station station_type='current' subtype='Reference' cid='151' title='Humboldt Bay entrance channel (depth 15 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='HUB0402_7'>
<marker lat='40.7651' lng='-124.2375' />
<flow flood='140' ebb='323' />
</station>
<station station_type='current' subtype='Reference' cid='152' title='Humboldt Bay entrance channel LB 9 (depth 11 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='hb0201_1'>
<marker lat='40.7570' lng='-124.2234' />
<flow flood='111' ebb='232' />
</station>
<station station_type='tide' subtype='Reference' tid='173' title='Humboldt Bay, North Spit, California (2) (expired 1993-12-31)' source='legacy-2005-05-02.tcd' zone='450' noaa_id=''>
<marker lat='40.7667' lng='-124.2167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='153' title='Humboldy Bay Bar Channel, 0.4 nmi WNW of (depth 4 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='HUB0401_9'>
<marker lat='40.7669' lng='-124.253' />
<flow flood='48' ebb='232' />
</station>
<station station_type='tide' subtype='Subordinate' tid='174' title='Hungry Harbor, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440563'>
<marker lat='46.2583' lng='-123.848' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='175' title='Hungry Harbor., Columbia River, Washington' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.2583' lng='-123.8483' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='154' title='Hunters Point, 1.6 nmi SE of (depth 5 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1308_7'>
<marker lat='37.6960' lng='-122.3381' />
<flow flood='202' ebb='23' />
</station>
<station station_type='tide' subtype='Reference' tid='176' title='Hunters Point, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414358'>
<marker lat='37.7300' lng='-122.357' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='155' title='Iceberg Point, 2.1 mi SSW of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1966_1'>
<marker lat='48.3833' lng='-122.9167' />
<flow flood='10' ebb='260' />
</station>
<station station_type='tide' subtype='Subordinate' tid='177' title='Ilwaco, Baker Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440597'>
<marker lat='46.3033' lng='-124.04' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='178' title='Imperial Beach, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410120'>
<marker lat='32.5783' lng='-117.135' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='179' title='Inverness, Tomales Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415228'>
<marker lat='38.1133' lng='-122.868' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='180' title='Irish Landing, Sand Mound Slough, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415095'>
<marker lat='38.0333' lng='-121.583' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='181' title='James Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='153' noaa_id='9442388'>
<marker lat='47.9067' lng='-124.647' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='182' title='Jim Creek, Washington' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='9443551'>
<marker lat='48.1872' lng='-124.0625' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='156' title='Johns Island, 0.8 mi north of, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2266_1'>
<marker lat='48.6833' lng='-123.15' />
<flow flood='90' ebb='350' />
</station>
<station station_type='tide' subtype='Subordinate' tid='183' title='Joice Island, Suisun Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415379'>
<marker lat='38.1800' lng='-122.045' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='157' title='Juan De Fuca Strait (East), British Columbia Current' source='legacy-2005-05-02.tcd' zone='131' noaa_id=''>
<marker lat='48.2317' lng='-123.53' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='158' title='Kamen Point, 1.3 miles southwest of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1000' lng='-122.9667' />
<flow flood='125' ebb='265' />
</station>
<station station_type='tide' subtype='Reference' tid='184' title='Kanaka Bay, San Juan Island, Haro Strait, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449856'>
<marker lat='48.4850' lng='-123.083' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='185' title='Kanaka Bay, San Juan Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4833' lng='-123.0833' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='159' title='Kanem Point, 1.5 mi SW of Protection Island (depth 22 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1630_53'>
<marker lat='48.1076' lng='-122.9737' />
<flow flood='117' ebb='279' />
</station>
<station station_type='current' subtype='Subordinate' cid='160' title='Kellett Bluff, west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5892' lng='-123.225' />
<flow flood='0' ebb='170' />
</station>
<station station_type='tide' subtype='Subordinate' tid='186' title='Kernville, Siletz River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9436031'>
<marker lat='44.8967' lng='-124' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='187' title='King Harbor, Santa Monica Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410738'>
<marker lat='33.8467' lng='-118.398' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='161' title='Kings Point, Lopez Island, 1 mi NNW of (depth 15 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2191_1'>
<marker lat='48.4833' lng='-122.9558' />
<flow flood='20' ebb='185' />
</station>
<station station_type='current' subtype='Subordinate' cid='162' title='Kings Point, Lopez Island, 1 nnw of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4833' lng='-122.95' />
<flow flood='20' ebb='185' />
</station>
<station station_type='tide' subtype='Subordinate' tid='188' title='Kirby Park, Elkhorn Slough, Monterey Bay, California' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8333' lng='-121.75' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='189' title='Kirby Park, Elkhorn Slough, Monterey Bay, Port San Luis, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413651'>
<marker lat='36.8413' lng='-121.7453' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='190' title='Korths Harbor, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415229'>
<marker lat='38.0976' lng='-121.5684' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='191' title='La Conner, Swinomish Channel, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448558'>
<marker lat='48.3917' lng='-122.497' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='192' title='La Conner, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.3917' lng='-122.4967' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='193' title='La Jolla (Scripps Institution Wharf), California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410230'>
<marker lat='32.8669' lng='-117.2571' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='194' title='La Jolla, Scripps Pier, California' source='legacy-2005-05-02.tcd' zone='750' noaa_id=''>
<marker lat='32.8667' lng='-117.2567' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='195' title='La Push, Quillayute River, Washington' source='harmonics-dwf-20210110-free.tcd' zone='150' noaa_id='9442396'>
<marker lat='47.9133' lng='-124.6369' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='196' title='Lakeville, Petaluma River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415423'>
<marker lat='38.1983' lng='-122.547' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='197' title='Lakeville, Petaluma River, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='TWC0649'>
<marker lat='38.2000' lng='-122.5667' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='163' title='Lawrence Point, Orcas I., 1.3 mi. NE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6783' lng='-122.7145' />
<flow flood='345' ebb='145' />
</station>
<station station_type='current' subtype='Subordinate' cid='164' title='Lawrence Point, Orcas Island, 1.3 mile East of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6500' lng='-122.7167' />
<flow flood='345' ebb='145' />
</station>
<station station_type='current' subtype='Reference' cid='165' title='Lawrence Point, Orcas Island, 1.3 nmi NE of (depth 37 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1708_16'>
<marker lat='48.6794' lng='-122.7147' />
<flow flood='348' ebb='151' />
</station>
<station station_type='current' subtype='Subordinate' cid='166' title='Limestone Point, Spieden Channel, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6263' lng='-123.1092' />
<flow flood='85' ebb='283' />
</station>
<station station_type='current' subtype='Subordinate' cid='167' title='Little Coyote Pt 3.1 mi ENE, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5833' lng='-122.2' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='168' title='Little Coyote Pt 3.4 mi NNE, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.6500' lng='-122.2166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='169' title='Little Coyote Pt., 1.2 nmi NE of (depth 10 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0511_1'>
<marker lat='37.5903' lng='-122.2487' />
<flow flood='121' ebb='303' />
</station>
<station station_type='current' subtype='Subordinate' cid='170' title='Little Coyote Pt., 3.1 nmi ENE of (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0506_1'>
<marker lat='37.5980' lng='-122.2055' />
<flow flood='135' ebb='317' />
</station>
<station station_type='current' subtype='Subordinate' cid='171' title='Little Coyote Pt., 3.4 nmi NNE of (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0501_1'>
<marker lat='37.6238' lng='-122.2313' />
<flow flood='128' ebb='310' />
</station>
<station station_type='tide' subtype='Subordinate' tid='198' title='Long Beach, Inner Harbor, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410686'>
<marker lat='33.7717' lng='-118.21' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='199' title='Long Beach, Middle Harbor, California' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='33.7500' lng='-118.2333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='200' title='Long Beach, Outer Harbor, Pier A, California' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='33.7583' lng='-118.2066' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='201' title='Long Beach, Terminal Island, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410680'>
<marker lat='33.7517' lng='-118.227' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='172' title='Lopez Pass (depth 15 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1730_17'>
<marker lat='48.4797' lng='-122.8189' />
<flow flood='286' ebb='90' />
</station>
<station station_type='tide' subtype='Reference' tid='202' title='Los Angeles (outer harbor), California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410660'>
<marker lat='33.7199' lng='-118.2729' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='203' title='Los Angeles Harbor, Mormon Island, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='TWC0439'>
<marker lat='33.7500' lng='-118.2667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='204' title='Los Angeles, California' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='33.7200' lng='-118.2717' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='205' title='Los Patos (highway bridge), California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='TWC0427'>
<marker lat='33.7167' lng='-118.05' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='206' title='Mad River Slough, Arcata Bay, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418865'>
<marker lat='40.8650' lng='-124.148' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='207' title='Makah Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='150' noaa_id='9442861'>
<marker lat='48.2967' lng='-124.672' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='208' title='Mallard Island Ferry Wharf, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415112'>
<marker lat='38.0433' lng='-121.918' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='209' title='Mansfield Cone, California' source='harmonics-dwf-20210110-free.tcd' zone='565' noaa_id='9412802'>
<marker lat='35.9495' lng='-121.4819' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='210' title='Mare Island Naval Shipyard, Carquinez Strait, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415218'>
<marker lat='38.0700' lng='-122.25' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='173' title='Mare Island Strait (Buoy 4) (depth 20 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0766_1'>
<marker lat='38.0742' lng='-122.2428' />
<flow flood='342' ebb='177' />
</station>
<station station_type='current' subtype='Subordinate' cid='174' title='Mare Island Strait Entrance, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0667' lng='-122.25' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='175' title='Mare Island Strait, NE of Pier 34 (depth 6 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1317_8'>
<marker lat='38.0772' lng='-122.2456' />
<flow flood='351' ebb='167' />
</station>
<station station_type='current' subtype='Subordinate' cid='176' title='Mare Island Strait, So Vallejo, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0833' lng='-122.25' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='177' title='Marrowstone Point, 0.8 mi NE of (depth 29 ft), Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1619_46'>
<marker lat='48.1063' lng='-122.6725' />
<flow flood='129' ebb='349' />
</station>
<station station_type='current' subtype='Subordinate' cid='178' title='Marrowstone Point, 1.1 mi northwest of, Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1511_1'>
<marker lat='48.1167' lng='-122.7' />
<flow flood='100' ebb='275' />
</station>
<station station_type='tide' subtype='Subordinate' tid='211' title='Marrowstone Point, Admiralty Inlet, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444972'>
<marker lat='48.0917' lng='-122.69' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='212' title='Marrowstone Point, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.1000' lng='-122.6833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='213' title='Marshall, Tomales Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415339'>
<marker lat='38.1617' lng='-122.893' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='179' title='Martinez Marina, 0.50 nmi west of (depth 30 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0786_1'>
<marker lat='38.0287' lng='-122.1487' />
<flow flood='89' ebb='271' />
</station>
<station station_type='current' subtype='Subordinate' cid='180' title='Martinez Marina, 0.61 nmi NNW of (depth 23 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0791_1'>
<marker lat='38.0363' lng='-122.1447' />
<flow flood='85' ebb='266' />
</station>
<station station_type='current' subtype='Subordinate' cid='181' title='Martinez Marina, 0.65 nmi NW of (depth 20 ft), Carquinez Strait, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0781_1'>
<marker lat='38.0330' lng='-122.1497' />
<flow flood='91' ebb='272' />
</station>
<station station_type='tide' subtype='Reference' tid='214' title='Martinez-Amorco Pier, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415102'>
<marker lat='38.0346' lng='-122.1252' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='182' title='Matia Island, 0.8 mi west of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2086_1'>
<marker lat='48.7488' lng='-122.8658' />
<flow flood='350' ebb='206' />
</station>
<station station_type='current' subtype='Subordinate' cid='183' title='Matia Island, 0.8 mile West of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-122.8667' />
<flow flood='350' ebb='206' />
</station>
<station station_type='current' subtype='Subordinate' cid='184' title='Matia Island, 1.4 mile North of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-122.8333' />
<flow flood='330' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='185' title='Matia Island, 1.4 miles north of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7722' lng='-122.8495' />
<flow flood='330' ebb='190' />
</station>
<station station_type='current' subtype='Reference' cid='186' title='Matia Island, west of (depth 47 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1711_26'>
<marker lat='48.7749' lng='-122.841' />
<flow flood='327' ebb='153' />
</station>
<station station_type='current' subtype='Subordinate' cid='187' title='McGowan, SSW of (depth 14 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1156_1'>
<marker lat='46.2395' lng='-123.9153' />
<flow flood='107' ebb='282' />
</station>
<station station_type='tide' subtype='Subordinate' tid='215' title='Meins Landing, Montezuma Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415307'>
<marker lat='38.1367' lng='-121.907' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='216' title='Mendocino, Mendocino Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='455' noaa_id='TWC0777'>
<marker lat='39.3000' lng='-123.8' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='217' title='Miami Cove, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0863'>
<marker lat='45.5500' lng='-123.9' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='188' title='Middle Point Lt., 0.18 nmi NNW of (depth 7 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1324_8'>
<marker lat='38.0575' lng='-121.993' />
<flow flood='101' ebb='279' />
</station>
<station station_type='current' subtype='Subordinate' cid='189' title='Mile Rock Lt., 0.2 nmi NW of (depth 15 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0246_1'>
<marker lat='37.7953' lng='-122.5113' />
<flow flood='63' ebb='230' />
</station>
<station station_type='tide' subtype='Reference' tid='218' title='Mission Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410196'>
<marker lat='32.7937' lng='-117.2238' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='190' title='Mission Rock, 0.6 mi east of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0411_1'>
<marker lat='37.7733' lng='-122.3683' />
<flow flood='160' ebb='320' />
</station>
<station station_type='current' subtype='Subordinate' cid='191' title='Mission Rock, 1.3 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0416_1'>
<marker lat='37.7750' lng='-122.3533' />
<flow flood='182' ebb='344' />
</station>
<station station_type='current' subtype='Subordinate' cid='192' title='Mission Rock, 2.0 mi east of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0421_1'>
<marker lat='37.7767' lng='-122.3383' />
<flow flood='142' ebb='330' />
</station>
<station station_type='tide' subtype='Reference' tid='219' title='Monterey, Monterey Harbor, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413450'>
<marker lat='36.6050' lng='-121.8881' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='193' title='Montezuma Slough 1 mi in W Entrance, Suisun Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.1333' lng='-122.05' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='220' title='Montezuma Slough Bridge, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415402'>
<marker lat='38.1867' lng='-121.98' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='194' title='Montezuma Slough E end nr Brg, Suisun Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0833' lng='-121.8833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='221' title='Montezuma Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415205'>
<marker lat='38.0767' lng='-121.885' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='195' title='Montezuma Slough, east end, near bridge (depth 6 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0881_1'>
<marker lat='38.0778' lng='-121.8838' />
<flow flood='135' ebb='315' />
</station>
<station station_type='tide' subtype='Reference' tid='222' title='Morro Bay, California' source='legacy-2005-05-02.tcd' zone='670' noaa_id=''>
<marker lat='35.3670' lng='-120.85' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='223' title='Morro Beach, Estero Bay, California' source='legacy-2005-05-02.tcd' zone='670' noaa_id=''>
<marker lat='35.4000' lng='-120.8667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='224' title='Moss Landing, Ocean Pier, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8000' lng='-121.7833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='225' title='Mowry Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414519'>
<marker lat='37.4933' lng='-122.042' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='226' title='Mugu Lagoon (ocean pier), California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='TWC0445'>
<marker lat='34.1000' lng='-119.1' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='196' title='Mulford Gardens Channel approach (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1307_4'>
<marker lat='37.6501' lng='-122.2628' />
<flow flood='138' ebb='321' />
</station>
<station station_type='tide' subtype='Subordinate' tid='227' title='Mystery Bay, Marrowstone Island, Admiralty Inlet, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444971'>
<marker lat='48.0583' lng='-122.692' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='228' title='Mystery Bay, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.0500' lng='-122.6833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='229' title='Nahcotta, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440747'>
<marker lat='46.5017' lng='-124.023' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='230' title='Nahcotta, Willipa Bay, Washington' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.5000' lng='-124.0233' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='231' title='Napa, Napa River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415623'>
<marker lat='38.2983' lng='-122.28' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='232' title='Napa, Napa River, Carquinez Strait, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.2983' lng='-122.2833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='233' title='Narvaez Bay, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7667' lng='-123.1' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='234' title='Naselle River, 4 mi above swing bridge, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440662'>
<marker lat='46.3883' lng='-123.84' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='235' title='Naselle River, swing bridge, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440691'>
<marker lat='46.4300' lng='-123.903' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='236' title='National City, San Diego Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410152'>
<marker lat='32.6650' lng='-117.118' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='197' title='National City, San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0106_1'>
<marker lat='32.6500' lng='-117.1167' />
<flow flood='166' ebb='2' />
</station>
<station station_type='current' subtype='Subordinate' cid='198' title='National City, WSW of Pier 12 (depth 32 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0111_1'>
<marker lat='32.6622' lng='-117.1255' />
<flow flood='178' ebb='351' />
</station>
<station station_type='tide' subtype='Reference' tid='237' title='Naval Air Station Whidbey Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9447973'>
<marker lat='48.3428' lng='-122.6858' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='238' title='Neah Bay, Strait Of Juan De Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='130' noaa_id='9443090'>
<marker lat='48.3703' lng='-124.6019' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='239' title='Neah Bay, Washington' source='legacy-2005-05-02.tcd' zone='130' noaa_id=''>
<marker lat='48.3683' lng='-124.6167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='240' title='Nehalem, Nehalem River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437908'>
<marker lat='45.7100' lng='-123.89' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='241' title='Nestucca Bay entrance, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0857'>
<marker lat='45.1667' lng='-123.9667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='242' title='Netarts, Netarts Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437262'>
<marker lat='45.4300' lng='-123.945' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='199' title='New Dungeness Light, 2.8 mi NNW of (depth 52 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1635_58'>
<marker lat='48.2335' lng='-123.1334' />
<flow flood='66' ebb='273' />
</station>
<station station_type='current' subtype='Subordinate' cid='200' title='New Dungeness Light, 2.8 miles NNW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.2333' lng='-123.1333' />
<flow flood='75' ebb='255' />
</station>
<station station_type='current' subtype='Subordinate' cid='201' title='New Dungeness Light, 6 mi NNE of (depth 15 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1401_1'>
<marker lat='48.2667' lng='-123.05' />
<flow flood='50' ebb='255' />
</station>
<station station_type='tide' subtype='Subordinate' tid='243' title='New Hope Bridge, Mokelumne River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415478'>
<marker lat='38.2267' lng='-121.49' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='202' title='New York Slough, 0.6 mi E of Pt. Emmet (depth 5 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1326_9'>
<marker lat='38.0325' lng='-121.8691' />
<flow flood='109' ebb='283' />
</station>
<station station_type='current' subtype='Subordinate' cid='203' title='New York Slough, Winter Island (depth 15 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0891_1'>
<marker lat='38.0283' lng='-121.8463' />
<flow flood='122' ebb='302' />
</station>
<station station_type='tide' subtype='Subordinate' tid='244' title='Newark Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414506'>
<marker lat='37.5133' lng='-122.08' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='245' title='Newport Bay Entrance, Corona del Mar, California' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='33.6033' lng='-117.8833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='246' title='Newport Beach, Newport Bay entrance, Corona del Mar, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410580'>
<marker lat='33.6033' lng='-117.883' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='247' title='Newport, Yaquina Bay and River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.6333' lng='-124.05' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='204' title='North Bay Channel at Fairhaven (depth 13 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='PCT1021_1'>
<marker lat='40.7873' lng='-124.1943' />
<flow flood='30' ebb='216' />
</station>
<station station_type='current' subtype='Subordinate' cid='205' title='North Bay Channel at Samoa Channel (depth 15 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='PCT1026_1'>
<marker lat='40.7962' lng='-124.1873' />
<flow flood='15' ebb='196' />
</station>
<station station_type='current' subtype='Reference' cid='206' title='North Bay Channel, Chevron Pier (depth 15 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='hb0401_15'>
<marker lat='40.7775' lng='-124.1966' />
<flow flood='30' ebb='206' />
</station>
<station station_type='current' subtype='Reference' cid='207' title='North Bay Channel, west of Eureka (depth 15 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='HUB0203_6'>
<marker lat='40.7871' lng='-124.1927' />
<flow flood='21' ebb='197' />
</station>
<station station_type='tide' subtype='Reference' tid='248' title='North Fork, Nehalem River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437954'>
<marker lat='45.7338' lng='-123.8764' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='208' title='North Island (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0056_1'>
<marker lat='32.7130' lng='-117.2128' />
<flow flood='62' ebb='245' />
</station>
<station station_type='current' subtype='Reference' cid='209' title='North Point, Pier 35, north of (depth 12 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1205_15'>
<marker lat='37.8142' lng='-122.407' />
<flow flood='106' ebb='300' />
</station>
<station station_type='tide' subtype='Reference' tid='249' title='North Point, Pier 41, San Francisco Bay, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8100' lng='-122.4133' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='250' title='North Point, Pier 41, San Francisco, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414305'>
<marker lat='37.8100' lng='-122.413' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='251' title='North Spit, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418767'>
<marker lat='40.7663' lng='-124.2172' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='252' title='North jetty, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437585'>
<marker lat='45.5700' lng='-123.965' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='253' title='Noyo Harbor, Fort Bragg, California' source='harmonics-dwf-20210110-free.tcd' zone='455' noaa_id='9417426'>
<marker lat='39.4258' lng='-123.8051' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='254' title='Noyo River, California' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='39.4167' lng='-123.8' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='255' title='Nurse Slough, Bradmoor Island, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414811'>
<marker lat='38.1833' lng='-121.923' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='256' title='Oak Bay, Admiralty Inlet, Washington' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.0167' lng='-122.7167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='210' title='Oakland 7th St. Marine, 0.6 nmi SSW of (depth 21 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0396_1'>
<marker lat='37.7945' lng='-122.3442' />
<flow flood='154' ebb='342' />
</station>
<station station_type='current' subtype='Subordinate' cid='211' title='Oakland Airport SW, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.6667' lng='-122.2166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='257' title='Oakland Airport, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414711'>
<marker lat='37.7317' lng='-122.208' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='212' title='Oakland Airport, southwest of (depth 3 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0466_1'>
<marker lat='37.6822' lng='-122.2308' />
<flow flood='125' ebb='304' />
</station>
<station station_type='tide' subtype='Subordinate' tid='258' title='Oakland Berth 67, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414763'>
<marker lat='37.7950' lng='-122.283' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='213' title='Oakland Harbor High Street Bridge, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7667' lng='-122.2166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='214' title='Oakland Harbor WebStreeter Street, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.8000' lng='-122.2666' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='259' title='Oakland Harbor, Park Street Bridge, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414746'>
<marker lat='37.7717' lng='-122.235' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='215' title='Oakland Harbor, Webster Street, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0386_1'>
<marker lat='37.7917' lng='-122.2745' />
<flow flood='120' ebb='300' />
</station>
<station station_type='current' subtype='Reference' cid='216' title='Oakland Inner Harbor Channel (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1213_12'>
<marker lat='37.7950' lng='-122.3183' />
<flow flood='108' ebb='286' />
</station>
<station station_type='current' subtype='Reference' cid='217' title='Oakland Inner Harbor LB4 (depth 14 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='s10010_2' observed='true'>
<marker lat='37.8010' lng='-122.3478' />
<flow flood='165' ebb='348' />
</station>
<station station_type='current' subtype='Reference' cid='218' title='Oakland Inner Harbor Reach (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1214_26'>
<marker lat='37.7929' lng='-122.2855' />
<flow flood='100' ebb='284' />
</station>
<station station_type='current' subtype='Subordinate' cid='220' title='Oakland Inner Harbor entrance (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0371_1'>
<marker lat='37.8017' lng='-122.34' />
<flow flood='178' ebb='338' />
</station>
<station station_type='tide' subtype='Reference' tid='260' title='Oakland Inner Harbor, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414764'>
<marker lat='37.7950' lng='-122.282' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='261' title='Oakland Middle Harbor, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414777'>
<marker lat='37.8050' lng='-122.338' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='221' title='Oakland Outer Harbor Entrance, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.8000' lng='-122.3333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='222' title='Oakland Outer Harbor entrance, LB 3 (depth 14 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='s09010_2' observed='true'>
<marker lat='37.8082' lng='-122.3443' />
<flow flood='191' ebb='359' />
</station>
<station station_type='tide' subtype='Subordinate' tid='262' title='Oakland Pier, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414765'>
<marker lat='37.7950' lng='-122.33' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='263' title='Oakland, Matson Wharf, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414779'>
<marker lat='37.8100' lng='-122.327' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='223' title='Oakland, Yerba Buena Island (depth 13 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0336_1'>
<marker lat='37.8098' lng='-122.3507' />
<flow flood='167' ebb='338' />
</station>
<station station_type='current' subtype='Subordinate' cid='224' title='Obstruction Pass Light, 0.4 mile NW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6037' lng='-122.8133' />
<flow flood='100' ebb='270' />
</station>
<station station_type='current' subtype='Reference' cid='225' title='Obstruction Pass, north of Obstruction Island (depth 8 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1705_15'>
<marker lat='48.6033' lng='-122.8127' />
<flow flood='87' ebb='286' />
</station>
<station station_type='tide' subtype='Reference' tid='264' title='Ocean Beach, California' source='legacy-2005-05-02.tcd' zone='545' noaa_id=''>
<marker lat='37.7667' lng='-122.5167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='265' title='Ocean Beach, outer coast, California' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='9414275'>
<marker lat='37.7750' lng='-122.513' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='266' title='Ocean Pier, Moss Landing, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413616'>
<marker lat='36.8017' lng='-121.79' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='267' title='Oil Platform Harvest (Topex Project), California' source='harmonics-dwf-20210110-free.tcd' zone='673' noaa_id='9411406'>
<marker lat='34.4692' lng='-120.6819' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='268' title='Orcas, Orcas Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449798'>
<marker lat='48.6000' lng='-122.95' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='269' title='Orwood, Old River, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414868'>
<marker lat='37.9383' lng='-121.56' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='226' title='Oyster Point 2.8 mi E, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.6500' lng='-122.3166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='270' title='Oyster Point Marina, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414392'>
<marker lat='37.6650' lng='-122.377' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='227' title='Oyster Point, 2.8 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0481_1'>
<marker lat='37.6650' lng='-122.3233' />
<flow flood='172' ebb='345' />
</station>
<station station_type='tide' subtype='Subordinate' tid='271' title='Pacific Mariculture Dock, Elkhorn Slough, California' source='legacy-2005-05-02.tcd' zone='535' noaa_id=''>
<marker lat='36.8133' lng='-121.7583' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='272' title='Pacific Mariculture Dock, Elkhorn Slough, Monterey Bay, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.8167' lng='-121.7667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='273' title='Pacific Mariculture Dock, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413624'>
<marker lat='36.8133' lng='-121.758' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='274' title='Palix River, south fork, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440813'>
<marker lat='46.5867' lng='-123.91' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='275' title='Palo Alto Yacht Harbor, California' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.4500' lng='-122.1' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='276' title='Palo Alto Yacht Harbor, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414525'>
<marker lat='37.4583' lng='-122.105' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='277' title='Paradise Point, Long Island, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440723'>
<marker lat='46.4683' lng='-123.945' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='228' title='Parker Reef Light, 0.5 mile north of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7330' lng='-122.89' />
<flow flood='67' ebb='278' />
</station>
<station station_type='current' subtype='Subordinate' cid='229' title='Parker Reef Light, 1 mile North of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7333' lng='-122.8833' />
<flow flood='65' ebb='265' />
</station>
<station station_type='current' subtype='Reference' cid='230' title='Parker Reef Light, north of (depth 25 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1712_25'>
<marker lat='48.7326' lng='-122.8864' />
<flow flood='75' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='231' title='Patos Island Light, 1.4 miles west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7888' lng='-123.0033' />
<flow flood='65' ebb='180' />
</station>
<station station_type='current' subtype='Reference' cid='232' title='Patos Island Light, 1.4 nmi west of (depth 46 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1714_27'>
<marker lat='48.7731' lng='-123.0058' />
<flow flood='45' ebb='209' />
</station>
<station station_type='tide' subtype='Subordinate' tid='278' title='Patos Island Wharf, Boundary Pass, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449704'>
<marker lat='48.7867' lng='-122.97' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='279' title='Patos Island Wharf, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7833' lng='-122.9667' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='233' title='Patos Island, south of Toe Point (depth 14 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1713_25'>
<marker lat='48.7721' lng='-122.9337' />
<flow flood='54' ebb='188' />
</station>
<station station_type='current' subtype='Subordinate' cid='234' title='Peapod Rocks Light, 1.2 mile South of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6167' lng='-122.7333' />
<flow flood='30' ebb='215' />
</station>
<station station_type='current' subtype='Subordinate' cid='235' title='Peapod Rocks Light, 1.2 miles south of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6222' lng='-122.7472' />
<flow flood='30' ebb='215' />
</station>
<station station_type='current' subtype='Reference' cid='236' title='Peapod Rocks Light, 1.2 nmi south of (depth 39 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1706_11'>
<marker lat='48.6224' lng='-122.7476' />
<flow flood='22' ebb='220' />
</station>
<station station_type='current' subtype='Subordinate' cid='237' title='Pear Point, 1.1 miles east of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5113' lng='-122.9528' />
<flow flood='359' ebb='203' />
</station>
<station station_type='current' subtype='Subordinate' cid='238' title='Pear Point, San Juan Island, 1.1 mile East of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5167' lng='-122.95' />
<flow flood='359' ebb='203' />
</station>
<station station_type='current' subtype='Reference' cid='239' title='Pear Point, east of (depth 32 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1746_10'>
<marker lat='48.5114' lng='-122.9529' />
<flow flood='22' ebb='192' />
</station>
<station station_type='tide' subtype='Subordinate' tid='280' title='Peavine Pass, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='TWC1165'>
<marker lat='48.6000' lng='-122.8' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='240' title='Peavine Pass, West Entrance of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5833' lng='-122.8167' />
<flow flood='55' ebb='285' />
</station>
<station station_type='current' subtype='Reference' cid='241' title='Peavine Pass, west entrance (depth 9 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1704_13'>
<marker lat='48.5871' lng='-122.8193' />
<flow flood='56' ebb='231' />
</station>
<station station_type='current' subtype='Subordinate' cid='242' title='Peavine Pass, west entrance, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5870' lng='-122.82' />
<flow flood='55' ebb='285' />
</station>
<station station_type='current' subtype='Subordinate' cid='243' title='Petaluma River Approach #3/#4, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0500' lng='-122.4166' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='244' title='Petaluma River approach (Buoys 3 and 4) (depth 2 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1313_4'>
<marker lat='38.0435' lng='-122.4263' />
<flow flood='354' ebb='179' />
</station>
<station station_type='current' subtype='Subordinate' cid='245' title='Petaluma River approach (depth 4 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0731_1'>
<marker lat='38.0700' lng='-122.42' />
<flow flood='18' ebb='186' />
</station>
<station station_type='current' subtype='Subordinate' cid='246' title='Petaluma River entrance (depth 7 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0736_1'>
<marker lat='38.1105' lng='-122.493' />
<flow flood='277' ebb='95' />
</station>
<station station_type='tide' subtype='Reference' tid='281' title='Petaluma River entrance, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415252'>
<marker lat='38.1153' lng='-122.5057' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='247' title='Pier 23 (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1206_11'>
<marker lat='37.8053' lng='-122.3973' />
<flow flood='143' ebb='323' />
</station>
<station station_type='tide' subtype='Subordinate' tid='282' title='Pierce Harbor, Goodyear Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415266'>
<marker lat='38.1267' lng='-122.1' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='283' title='Pillar Point Harbor, Half Moon Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='9414131'>
<marker lat='37.5025' lng='-122.4822' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='248' title='Pillar Point, 6 mi NNE of (depth 41 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='PUG1641_75'>
<marker lat='48.3000' lng='-124.0374' />
<flow flood='115' ebb='290' />
</station>
<station station_type='current' subtype='Subordinate' cid='249' title='Pillar Point, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='131' noaa_id=''>
<marker lat='48.2667' lng='-124.0667' />
<flow flood='100' ebb='280' />
</station>
<station station_type='current' subtype='Subordinate' cid='250' title='Pinole Point 1.2 mi W, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0167' lng='-122.3666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='251' title='Pinole Point, 1.18 nmi west of (depth 19 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0706_1'>
<marker lat='38.0080' lng='-122.3897' />
<flow flood='43' ebb='218' />
</station>
<station station_type='current' subtype='Reference' cid='252' title='Pinole Point, 1.27 nmi NNW of (depth 5 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1314_9'>
<marker lat='38.0308' lng='-122.3772' />
<flow flood='50' ebb='232' />
</station>
<station station_type='current' subtype='Subordinate' cid='253' title='Pinole Point, 1.42 nmi NNW of (depth 21 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0721_1'>
<marker lat='38.0338' lng='-122.3792' />
<flow flood='52' ebb='233' />
</station>
<station station_type='current' subtype='Subordinate' cid='254' title='Pinole Point, 3.0 nmi WNW of (depth 8 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0711_1'>
<marker lat='38.0267' lng='-122.4247' />
<flow flood='7' ebb='185' />
</station>
<station station_type='tide' subtype='Reference' tid='284' title='Pinole Point, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415056'>
<marker lat='38.0150' lng='-122.363' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='255' title='Pinole Shoal (depth 3 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1315_6'>
<marker lat='38.0476' lng='-122.3341' />
<flow flood='76' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='285' title='Pittsburg, New York Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415096'>
<marker lat='38.0367' lng='-121.88' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='256' title='Point Adams, NNE of (depth 14 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1166_1'>
<marker lat='46.2278' lng='-123.9675' />
<flow flood='139' ebb='297' />
</station>
<station station_type='tide' subtype='Subordinate' tid='286' title='Point Adams, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0881'>
<marker lat='46.2000' lng='-123.95' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='287' title='Point Arena, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='TWC0771'>
<marker lat='38.9500' lng='-123.7333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='257' title='Point Arguello, California Current' source='harmonics-dwf-20081228-free.tcd' zone='673' noaa_id=''>
<marker lat='34.5667' lng='-120.6667' />
<flow flood='5' ebb='185' />
</station>
<station station_type='current' subtype='Subordinate' cid='258' title='Point Avisadero .3 mi E, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7167' lng='-122.3333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='259' title='Point Avisadero 2 mi E, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7167' lng='-122.3' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='260' title='Point Avisadero, 0.3 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0441_1'>
<marker lat='37.7300' lng='-122.3483' />
<flow flood='156' ebb='337' />
</station>
<station station_type='current' subtype='Subordinate' cid='261' title='Point Avisadero, 0.6 nmi ESE of (depth 21 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0456_1'>
<marker lat='37.7230' lng='-122.3238' />
<flow flood='140' ebb='335' />
</station>
<station station_type='current' subtype='Subordinate' cid='262' title='Point Avisadero, 1 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0446_1'>
<marker lat='37.7300' lng='-122.3367' />
<flow flood='154' ebb='352' />
</station>
<station station_type='current' subtype='Subordinate' cid='263' title='Point Avisadero, 1.25 nmi SSE of (depth 20 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0461_1'>
<marker lat='37.7078' lng='-122.3495' />
<flow flood='175' ebb='4' />
</station>
<station station_type='current' subtype='Subordinate' cid='264' title='Point Avisadero, 2 mi east of (depth 6 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0451_1'>
<marker lat='37.7317' lng='-122.3133' />
<flow flood='148' ebb='335' />
</station>
<station station_type='current' subtype='Subordinate' cid='265' title='Point Beenar, 0.7 nmi north of (depth 5 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0916_1'>
<marker lat='38.0422' lng='-121.838' />
<flow flood='163' ebb='349' />
</station>
<station station_type='current' subtype='Subordinate' cid='266' title='Point Beenar, 100 yd NE of (depth 14 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0921_1'>
<marker lat='38.0325' lng='-121.8355' />
<flow flood='137' ebb='314' />
</station>
<station station_type='current' subtype='Subordinate' cid='267' title='Point Blunt .8 mi SE, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8333' lng='-122.4' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='268' title='Point Blunt, Angel I., 0.25 mi S of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0566_1'>
<marker lat='37.8467' lng='-122.4167' />
<flow flood='103' ebb='258' />
</station>
<station station_type='current' subtype='Subordinate' cid='269' title='Point Blunt, Angel I., 0.5 nmi SW of (depth 21 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0561_1'>
<marker lat='37.8455' lng='-122.423' />
<flow flood='77' ebb='258' />
</station>
<station station_type='current' subtype='Subordinate' cid='270' title='Point Bonita Lt., 0.4 nmi SSE of (depth 43 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0236_1'>
<marker lat='37.8120' lng='-122.5212' />
<flow flood='104' ebb='229' />
</station>
<station station_type='current' subtype='Subordinate' cid='271' title='Point Bonita Lt., 5.27 nmi WSW of (depth 39 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='PCT0181_1'>
<marker lat='37.8045' lng='-122.6388' />
<flow flood='95' ebb='266' />
</station>
<station station_type='current' subtype='Subordinate' cid='272' title='Point Bonita, 0.8 nmi NE of (depth 22 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0231_1'>
<marker lat='37.8208' lng='-122.5162' />
<flow flood='64' ebb='267' />
</station>
<station station_type='current' subtype='Reference' cid='273' title='Point Bonita, 0.95 nmi SSE of (depth 17 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1220_13'>
<marker lat='37.8011' lng='-122.5184' />
<flow flood='70' ebb='238' />
</station>
<station station_type='current' subtype='Subordinate' cid='274' title='Point Bonita, 0.95 nmi. SSE of, California Current (22d)' source='harmonics-dwf-20081228-free.tcd' zone='530' noaa_id=''>
<marker lat='37.8012' lng='-122.5188' />
<flow flood='72' ebb='239' />
</station>
<station station_type='tide' subtype='Subordinate' tid='288' title='Point Bonita, Bonita Cove, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414906'>
<marker lat='37.8183' lng='-122.528' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='289' title='Point Brown, Grays Harbor, Washington' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='9441156'>
<marker lat='46.9500' lng='-124.128' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='290' title='Point Buckler, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415227'>
<marker lat='38.1000' lng='-122.033' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='275' title='Point Cabrillo, California Current' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='39.3500' lng='-123.8333' />
<flow flood='345' ebb='165' />
</station>
<station station_type='current' subtype='Subordinate' cid='276' title='Point Cavallo 1.3 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='277' title='Point Cavallo, 1.3 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0556_1'>
<marker lat='37.8317' lng='-122.4433' />
<flow flood='87' ebb='256' />
</station>
<station station_type='current' subtype='Subordinate' cid='278' title='Point Chauncey, 0.75 nmi NW of (depth 19 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0641_1'>
<marker lat='37.9030' lng='-122.4588' />
<flow flood='317' ebb='131' />
</station>
<station station_type='current' subtype='Reference' cid='279' title='Point Chauncey, 1.25 nmi north of (depth 5 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1310_9'>
<marker lat='37.9153' lng='-122.4461' />
<flow flood='351' ebb='177' />
</station>
<station station_type='current' subtype='Reference' cid='280' title='Point Chauncey, 1.3 mi east of (depth 7 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1309_11'>
<marker lat='37.8908' lng='-122.4188' />
<flow flood='345' ebb='173' />
</station>
<station station_type='tide' subtype='Subordinate' tid='291' title='Point Chauncey, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414837'>
<marker lat='37.8917' lng='-122.443' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='281' title='Point Colville, 1.4 nmi east of (depth 29 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1728_26'>
<marker lat='48.4181' lng='-122.7812' />
<flow flood='39' ebb='207' />
</station>
<station station_type='current' subtype='Reference' cid='282' title='Point Colville, 3.0 nmi east of (depth 34 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1727_30'>
<marker lat='48.4125' lng='-122.7403' />
<flow flood='21' ebb='186' />
</station>
<station station_type='current' subtype='Subordinate' cid='283' title='Point Delgada, California Current' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='40.0000' lng='-124.0667' />
<flow flood='325' ebb='145' />
</station>
<station station_type='current' subtype='Subordinate' cid='284' title='Point Diablo, 0.2 mi SE of, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0251_1'>
<marker lat='37.8178' lng='-122.4967' />
<flow flood='82' ebb='263' />
</station>
<station station_type='current' subtype='Subordinate' cid='285' title='Point Disney, 1.6 mile East of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6667' lng='-123.0167' />
<flow flood='20' ebb='230' />
</station>
<station station_type='current' subtype='Subordinate' cid='286' title='Point Disney, 1.6 miles east of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6728' lng='-123.0062' />
<flow flood='20' ebb='230' />
</station>
<station station_type='current' subtype='Subordinate' cid='287' title='Point Ellice, east of (depth 17 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1161_1'>
<marker lat='46.2417' lng='-123.8483' />
<flow flood='65' ebb='254' />
</station>
<station station_type='current' subtype='Reference' cid='288' title='Point George, west of (depth 53 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1745_24'>
<marker lat='48.5567' lng='-122.9985' />
<flow flood='321' ebb='152' />
</station>
<station station_type='tide' subtype='Subordinate' tid='292' title='Point Grenville, Washington' source='harmonics-dwf-20210110-free.tcd' zone='153' noaa_id='9441627'>
<marker lat='47.3033' lng='-124.27' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='289' title='Point Hammond, 1.1 mi northwest of (depth 15 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2281_1'>
<marker lat='48.7320' lng='-123.0253' />
<flow flood='55' ebb='255' />
</station>
<station station_type='current' subtype='Subordinate' cid='290' title='Point Hammond, 1.1 miles NW of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7333' lng='-123.0333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='291' title='Point Hudson, 0.5 mile E of, Washington Current' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.1167' lng='-122.7167' />
<flow flood='115' ebb='10' />
</station>
<station station_type='current' subtype='Subordinate' cid='292' title='Point Hudson, 0.5 mile east of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1167' lng='-122.7333' />
<flow flood='115' ebb='10' />
</station>
<station station_type='tide' subtype='Subordinate' tid='293' title='Point Isabel, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414843'>
<marker lat='37.8983' lng='-122.32' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='293' title='Point Lobos, 1.3 nmi SW of (depth 46 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0201_1'>
<marker lat='37.7717' lng='-122.5355' />
<flow flood='8' ebb='182' />
</station>
<station station_type='current' subtype='Subordinate' cid='294' title='Point Lobos, 3.73 nmi W of (depth 46 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='PCT0191_1'>
<marker lat='37.7875' lng='-122.5887' />
<flow flood='92' ebb='241' />
</station>
<station station_type='current' subtype='Subordinate' cid='295' title='Point Lobos, 5.47 nmi SW of (depth 39 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0211_1'>
<marker lat='37.7205' lng='-122.5978' />
<flow flood='48' ebb='211' />
</station>
<station station_type='current' subtype='Subordinate' cid='296' title='Point Loma Light, 0.8 nmi east of (depth 15 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0026_1'>
<marker lat='32.6658' lng='-117.2262' />
<flow flood='328' ebb='174' />
</station>
<station station_type='tide' subtype='Subordinate' tid='294' title='Point Loma, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='TWC0405'>
<marker lat='32.6667' lng='-117.2333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='295' title='Point Migley, Hale Passage, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='TWC1173'>
<marker lat='48.7500' lng='-122.7167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='296' title='Point Migley, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-122.7166' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='297' title='Point Orient, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414881'>
<marker lat='37.9583' lng='-122.425' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='297' title='Point Partridge, 3.7 mi west of, Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1466_1'>
<marker lat='48.2333' lng='-122.8667' />
<flow flood='140' ebb='250' />
</station>
<station station_type='tide' subtype='Subordinate' tid='298' title='Point Partridge, Whidbey Island, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9447934'>
<marker lat='48.2317' lng='-122.765' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='299' title='Point Partridge, Whidbey Island, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.2333' lng='-122.7667' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='298' title='Point Piedras Blancas, California Current' source='harmonics-dwf-20081228-free.tcd' zone='565' noaa_id=''>
<marker lat='35.6667' lng='-121.3' />
<flow flood='315' ebb='135' />
</station>
<station station_type='current' subtype='Subordinate' cid='299' title='Point Pinos, California Current' source='harmonics-dwf-20081228-free.tcd' zone='565' noaa_id=''>
<marker lat='36.6333' lng='-121.95' />
<flow flood='35' ebb='215' />
</station>
<station station_type='tide' subtype='Reference' tid='300' title='Point Reyes, California' source='legacy-2005-05-02.tcd' zone='545' noaa_id=''>
<marker lat='37.9967' lng='-122.975' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='300' title='Point Richmond .5 mi W, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9000' lng='-122.4' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='301' title='Point Richmond, 0.5 mi west of (depth 6 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0656_1'>
<marker lat='37.9050' lng='-122.4' />
<flow flood='332' ebb='142' />
</station>
<station station_type='current' subtype='Subordinate' cid='302' title='Point Richmond, 0.8 nmi NNW of (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0661_1'>
<marker lat='37.9208' lng='-122.3967' />
<flow flood='325' ebb='147' />
</station>
<station station_type='tide' subtype='Reference' tid='301' title='Point Roberts, Strait of Georgia, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449639'>
<marker lat='48.9750' lng='-123.083' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='303' title='Point Sacramento, 0.2 nmi NE of (depth 4 ft), Sacramento River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1331_18'>
<marker lat='38.0643' lng='-121.8337' />
<flow flood='98' ebb='283' />
</station>
<station station_type='current' subtype='Subordinate' cid='304' title='Point Sacramento, 0.3 mi NE of (depth 7 ft), Sacramento River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0901_1'>
<marker lat='38.0667' lng='-121.8333' />
<flow flood='98' ebb='286' />
</station>
<station station_type='current' subtype='Subordinate' cid='305' title='Point San Bruno, 0.51 nmi east of (depth 10 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0491_1'>
<marker lat='37.6542' lng='-122.3638' />
<flow flood='174' ebb='359' />
</station>
<station station_type='tide' subtype='Subordinate' tid='302' title='Point San Bruno, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414402'>
<marker lat='37.6500' lng='-122.377' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='306' title='Point San Pablo Midchannel, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9667' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='307' title='Point San Pablo, midchannel (depth 11 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1312_16'>
<marker lat='37.9689' lng='-122.4391' />
<flow flood='18' ebb='199' />
</station>
<station station_type='current' subtype='Subordinate' cid='308' title='Point San Pedro, 0.55 nmi SE of (depth 20 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0701_1'>
<marker lat='37.9797' lng='-122.4367' />
<flow flood='16' ebb='192' />
</station>
<station station_type='tide' subtype='Subordinate' tid='303' title='Point San Pedro, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415009'>
<marker lat='37.9933' lng='-122.447' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='309' title='Point San Quentin 1.9 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9500' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='310' title='Point San Quentin, 0.82 nmi east of (depth 15 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0681_1'>
<marker lat='37.9412' lng='-122.4617' />
<flow flood='13' ebb='182' />
</station>
<station station_type='current' subtype='Subordinate' cid='311' title='Point San Quentin, 1.3 nmi east of (depth 23 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0686_1'>
<marker lat='37.9422' lng='-122.4527' />
<flow flood='5' ebb='181' />
</station>
<station station_type='current' subtype='Subordinate' cid='312' title='Point San Quentin, 1.9 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0691_1'>
<marker lat='37.9500' lng='-122.44' />
<flow flood='14' ebb='168' />
</station>
<station station_type='tide' subtype='Subordinate' tid='304' title='Point San Quentin, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414873'>
<marker lat='37.9450' lng='-122.475' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='313' title='Point Simpson, Angel I., 1.05 nmi E of (depth 21 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0591_1'>
<marker lat='37.8738' lng='-122.4028' />
<flow flood='332' ebb='177' />
</station>
<station station_type='current' subtype='Subordinate' cid='314' title='Point Sur, California Current' source='harmonics-dwf-20081228-free.tcd' zone='565' noaa_id=''>
<marker lat='36.3000' lng='-121.9167' />
<flow flood='325' ebb='145' />
</station>
<station station_type='current' subtype='Subordinate' cid='315' title='Point Wilson, 0.5 mi., northeast of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1500' lng='-122.75' />
<flow flood='114' ebb='298' />
</station>
<station station_type='current' subtype='Reference' cid='316' title='Point Wilson, 0.6 mi NE of (depth 17 ft), Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1623_45'>
<marker lat='48.1501' lng='-122.7454' />
<flow flood='120' ebb='321' />
</station>
<station station_type='current' subtype='Subordinate' cid='317' title='Point Wilson, 0.8 mi east of, Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1496_1'>
<marker lat='48.1500' lng='-122.7333' />
<flow flood='165' ebb='280' />
</station>
<station station_type='current' subtype='Subordinate' cid='318' title='Point Wilson, 1.1 miles NW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1667' lng='-122.7667' />
<flow flood='85' ebb='285' />
</station>
<station station_type='current' subtype='Subordinate' cid='319' title='Point Wilson, 1.4 miles northeast of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1667' lng='-122.7333' />
<flow flood='112' ebb='297' />
</station>
<station station_type='current' subtype='Reference' cid='320' title='Point Wilson, 1.6 mi NE of (depth 21 ft), Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1624_47'>
<marker lat='48.1569' lng='-122.726' />
<flow flood='126' ebb='319' />
</station>
<station station_type='current' subtype='Subordinate' cid='321' title='Point Wilson, 2.3 miles NE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1667' lng='-122.7' />
<flow flood='143' ebb='323' />
</station>
<station station_type='current' subtype='Reference' cid='322' title='Point Wilson, 2.7 mi NE of (depth 20 ft), Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1625_45'>
<marker lat='48.1671' lng='-122.7074' />
<flow flood='138' ebb='333' />
</station>
<station station_type='tide' subtype='Reference' tid='305' title='Port Angeles, Strait Of Juan De Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='9444090'>
<marker lat='48.1250' lng='-123.44' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='306' title='Port Angeles, Washington' source='legacy-2005-05-02.tcd' zone='131' noaa_id=''>
<marker lat='48.1167' lng='-123.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='307' title='Port Chicago, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415144'>
<marker lat='38.0560' lng='-122.0395' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='308' title='Port Chicago, Suisun Bay, California (2) (expired 1996-12-31)' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0567' lng='-122.0383' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='309' title='Port Hueneme, California' source='harmonics-dwf-20210110-free.tcd' zone='650' noaa_id='9411065'>
<marker lat='34.1483' lng='-119.203' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='310' title='Port Orford, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='356' noaa_id='9431647'>
<marker lat='42.7390' lng='-124.4983' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='311' title='Port San Luis, Pacific Ocean, California' source='harmonics-dwf-20081228-free.tcd' zone='670' noaa_id=''>
<marker lat='35.1767' lng='-120.76' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='312' title='Port Townsend (Point Hudson), Admiralty Inlet, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444900'>
<marker lat='48.1129' lng='-122.7595' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='313' title='Port Townsend (Point Hudson), Admiralty Inlet, Washington (sub)' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1167' lng='-122.75' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='323' title='Port Townsend Canal (depth 5 ft), Admiralty Inlet, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1614_7'>
<marker lat='48.0325' lng='-122.7326' />
<flow flood='140' ebb='323' />
</station>
<station station_type='tide' subtype='Reference' tid='314' title='Port Townsend, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.1117' lng='-122.7583' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='324' title='Potrero Point 1.1 mi E, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7500' lng='-122.35' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='325' title='Potrero Point, 1.08 nmi east of (depth 20 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0426_1'>
<marker lat='37.7575' lng='-122.3578' />
<flow flood='169' ebb='342' />
</station>
<station station_type='current' subtype='Subordinate' cid='326' title='Potrero Point, 2 mi east of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0431_1'>
<marker lat='37.7500' lng='-122.3333' />
<flow flood='159' ebb='328' />
</station>
<station station_type='tide' subtype='Subordinate' tid='315' title='Potrero Point, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414334'>
<marker lat='37.7583' lng='-122.383' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='316' title='President Channel, Orcas Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6550' lng='-123.0083' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='327' title='President Channel, east of Point Disney (depth 69 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1715_38'>
<marker lat='48.6733' lng='-123.006' />
<flow flood='37' ebb='218' />
</station>
<station station_type='tide' subtype='Subordinate' tid='317' title='Princeton, Half Moon Bay, California' source='harmonics-dwf-20081228-free.tcd' zone='545' noaa_id=''>
<marker lat='37.5000' lng='-122.4833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='318' title='Prisoners Harbor, Santa Cruz Island, California' source='harmonics-dwf-20210110-free.tcd' zone='650' noaa_id='9410971'>
<marker lat='34.0200' lng='-119.683' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='319' title='Prisoners Point, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415149'>
<marker lat='38.0617' lng='-121.555' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='328' title='Pt. Blunt, Angel I., 0.25 nmi east of (depth 21 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0576_1'>
<marker lat='37.8528' lng='-122.4122' />
<flow flood='49' ebb='185' />
</station>
<station station_type='current' subtype='Subordinate' cid='329' title='Pt. Blunt, Angel I., 0.8 mi SE of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0571_1'>
<marker lat='37.8450' lng='-122.405' />
<flow flood='86' ebb='297' />
</station>
<station station_type='current' subtype='Subordinate' cid='330' title='Pt. Edith, 1.7 nmi NNW of (depth 24 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0836_1'>
<marker lat='38.0787' lng='-122.0838' />
<flow flood='35' ebb='219' />
</station>
<station station_type='current' subtype='Subordinate' cid='331' title='Pt. San Joaquin, 0.45 nmi ENE of (depth 18 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0911_1'>
<marker lat='38.0617' lng='-121.85' />
<flow flood='108' ebb='282' />
</station>
<station station_type='current' subtype='Subordinate' cid='332' title='Puffin Island Light, 4.8 mi north of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2166_1'>
<marker lat='48.8222' lng='-122.8083' />
<flow flood='325' ebb='210' />
</station>
<station station_type='current' subtype='Subordinate' cid='333' title='Punta Gorda, California Current' source='harmonics-dwf-20081228-free.tcd' zone='455' noaa_id=''>
<marker lat='40.2500' lng='-124.3667' />
<flow flood='335' ebb='155' />
</station>
<station station_type='tide' subtype='Reference' tid='320' title='Pyramid Point, Smith River, California' source='harmonics-dwf-20210110-free.tcd' zone='356' noaa_id='9419945'>
<marker lat='41.9453' lng='-124.2009' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='334' title='Quarantine Station, La Playa, San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0051_1'>
<marker lat='32.7000' lng='-117.2333' />
<flow flood='21' ebb='200' />
</station>
<station station_type='current' subtype='Reference' cid='335' title='Queens Gate (depth 35 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='lb0101_6'>
<marker lat='33.7170' lng='-118.1879' />
<flow flood='48' ebb='257' />
</station>
<station station_type='current' subtype='Subordinate' cid='336' title='Quillayute River entrance, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='150' noaa_id='PCT1321_1'>
<marker lat='47.9167' lng='-124.6333' />
<flow flood='15' ebb='345' />
</station>
<station station_type='tide' subtype='Subordinate' tid='321' title='Quivira Basin, Mission Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='TWC0413'>
<marker lat='32.7667' lng='-117.2333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='337' title='Raccoon Point, 0.6 mi NNE of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2076_1'>
<marker lat='48.7063' lng='-122.8292' />
<flow flood='286' ebb='101' />
</station>
<station station_type='current' subtype='Reference' cid='338' title='Raccoon Strait (depth 19 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1212_9'>
<marker lat='37.8719' lng='-122.442' />
<flow flood='57' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='339' title='Raccoon Strait off Hospital Cove, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8667' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='340' title='Raccoon Strait off Point Stuart, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8667' lng='-122.45' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='341' title='Raccoon Strait, off Point Stuart (depth 15 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0606_1'>
<marker lat='37.8612' lng='-122.452' />
<flow flood='14' ebb='226' />
</station>
<station station_type='current' subtype='Reference' cid='342' title='Race Rocks, 4.5 mi S of (depth 60 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='PUG1640_18'>
<marker lat='48.2232' lng='-123.5323' />
<flow flood='91' ebb='268' />
</station>
<station station_type='current' subtype='Subordinate' cid='343' title='Racoon Point, 0.6  mile NNE of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7000' lng='-122.8167' />
<flow flood='286' ebb='101' />
</station>
<station station_type='current' subtype='Subordinate' cid='344' title='Red Rock .1 E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9333' lng='-122.4333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='345' title='Red Rock, 0.60 nmi NNE of (depth 17 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0676_1'>
<marker lat='37.9400' lng='-122.4267' />
<flow flood='337' ebb='155' />
</station>
<station station_type='current' subtype='Subordinate' cid='346' title='Red Rock, east of (depth 11 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0671_1'>
<marker lat='37.9295' lng='-122.4283' />
<flow flood='318' ebb='175' />
</station>
<station station_type='current' subtype='Subordinate' cid='347' title='Redding Rock Light, California Current' source='harmonics-dwf-20081228-free.tcd' zone='450' noaa_id=''>
<marker lat='41.3500' lng='-124.1833' />
<flow flood='10' ebb='190' />
</station>
<station station_type='tide' subtype='Reference' tid='322' title='Redwood City, Wharf 5, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414523'>
<marker lat='37.5067' lng='-122.21' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='348' title='Redwood Creek (depth 4 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1304_6'>
<marker lat='37.5258' lng='-122.1991' />
<flow flood='234' ebb='51' />
</station>
<station station_type='tide' subtype='Reference' tid='323' title='Redwood Creek Marker 8, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414501'>
<marker lat='37.5333' lng='-122.193' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='324' title='Redwood Creek entrance (inside), San Francisco Bay, California' source='harmonics-dwf-20081228-free.tcd' zone='531' noaa_id=''>
<marker lat='37.5167' lng='-122.2' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='325' title='Redwood Creek, C.M. No.8, San Francisco Bay, California' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5333' lng='-122.1933' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='349' title='Redwood Point, 1.7 nmi east of (depth 7 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1302_8'>
<marker lat='37.5306' lng='-122.1601' />
<flow flood='127' ebb='305' />
</station>
<station station_type='current' subtype='Subordinate' cid='350' title='Redwood Pt., Blair I., 1.15 nmi NNE of (depth 19 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0521_1'>
<marker lat='37.5580' lng='-122.1988' />
<flow flood='120' ebb='310' />
</station>
<station station_type='tide' subtype='Reference' tid='326' title='Reedsport, Umpqua River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9433501'>
<marker lat='43.7083' lng='-124.098' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='327' title='Requa Dock, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9419551'>
<marker lat='41.5450' lng='-124.07' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='328' title='Reservation Bay, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4167' lng='-122.6667' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='329' title='Reynolds, Tomales Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415320'>
<marker lat='38.1467' lng='-122.883' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='351' title='Richardson Bay Entrance, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8500' lng='-122.4666' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='330' title='Richardson, Lopez Island, San Juan Channel, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449982'>
<marker lat='48.4467' lng='-122.9' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='352' title='Richmond (depth 7 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0666_1'>
<marker lat='37.9293' lng='-122.425' />
<flow flood='324' ebb='150' />
</station>
<station station_type='tide' subtype='Subordinate' tid='331' title='Richmond Inner Harbor, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414849'>
<marker lat='37.9100' lng='-122.358' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='332' title='Richmond, Chevron Oil Pier, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9283' lng='-122.4' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='333' title='Rincon Island, California (2)' source='legacy-2005-05-02.tcd' zone='650' noaa_id=''>
<marker lat='34.3500' lng='-119.45' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='353' title='Rincon Point (depth 9 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1217_16'>
<marker lat='37.7903' lng='-122.3734' />
<flow flood='149' ebb='333' />
</station>
<station station_type='current' subtype='Subordinate' cid='354' title='Rincon Point midbay, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7833' lng='-122.35' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='334' title='Rincon Point, Pier 22½, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414317'>
<marker lat='37.7900' lng='-122.387' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='355' title='Rincon Point, midbay (depth 11 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0406_1'>
<marker lat='37.7833' lng='-122.3538' />
<flow flood='166' ebb='322' />
</station>
<station station_type='tide' subtype='Reference' tid='335' title='Rink Creek entrance, Coquille River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432436'>
<marker lat='43.1579' lng='-124.1818' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='336' title='Rio Vista, Sacramento River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415316'>
<marker lat='38.1450' lng='-121.692' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='337' title='Roberts Landing, 1.3 mi west of, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='TWC0547'>
<marker lat='37.6667' lng='-122.2' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='338' title='Roche Harbor, San Juan Island, Haro Strait, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449834'>
<marker lat='48.6100' lng='-123.155' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='339' title='Roche Harbor, San Juan Island, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6167' lng='-123.15' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='356' title='Roe Island Channel (depth 6 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1323_8'>
<marker lat='38.0651' lng='-122.0345' />
<flow flood='93' ebb='276' />
</station>
<station station_type='current' subtype='Subordinate' cid='358' title='Roe Island, Gilbert Pt., 0.15 nmi NW of (depth 16 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0851_1'>
<marker lat='38.0737' lng='-122.0217' />
<flow flood='105' ebb='283' />
</station>
<station station_type='current' subtype='Reference' cid='359' title='Rosario Strait (depth 37 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1702_16'>
<marker lat='48.4581' lng='-122.7501' />
<flow flood='5' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='340' title='Rosario, East Sound, Orcas Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449771'>
<marker lat='48.6467' lng='-122.87' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='360' title='Sacramento River Light 14 (depth 3 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1332_15'>
<marker lat='38.0772' lng='-121.7639' />
<flow flood='55' ebb='235' />
</station>
<station station_type='current' subtype='Reference' cid='361' title='Saddle Bag Island Passage (depth 22 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1736_34'>
<marker lat='48.5359' lng='-122.5639' />
<flow flood='342' ebb='166' />
</station>
<station station_type='current' subtype='Subordinate' cid='362' title='Salt Point, California Current' source='harmonics-dwf-20081228-free.tcd' zone='540' noaa_id=''>
<marker lat='38.5667' lng='-123.35' />
<flow flood='325' ebb='145' />
</station>
<station station_type='tide' subtype='Reference' tid='341' title='Samoa, Humboldt Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9418817'>
<marker lat='40.8267' lng='-124.18' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='342' title='Samuel Island (North Shore), British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.8167' lng='-123.2' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='343' title='Samuel Island (South Shore), British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.8000' lng='-123.2' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='344' title='San Clemente, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='TWC0419'>
<marker lat='33.4167' lng='-117.6167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='363' title='San Diego Bay entrance (depth 33 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0031_1'>
<marker lat='32.6817' lng='-117.23' />
<flow flood='355' ebb='173' />
</station>
<station station_type='current' subtype='Subordinate' cid='364' title='San Diego, 0.5 mi west of, San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0066_1'>
<marker lat='32.7167' lng='-117.1833' />
<flow flood='121' ebb='304' />
</station>
<station station_type='tide' subtype='Reference' tid='345' title='San Diego, California' source='legacy-2005-05-02.tcd' zone='750' noaa_id=''>
<marker lat='32.7133' lng='-117.1733' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='346' title='San Diego, Quarantine Station, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410166'>
<marker lat='32.7033' lng='-117.235' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='347' title='San Diego, San Diego Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410170'>
<marker lat='32.7142' lng='-117.1736' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='365' title='San Francisco Bar, north of ship channel (depth 5 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='SFB1221_7'>
<marker lat='37.7853' lng='-122.614' />
<flow flood='66' ebb='260' />
</station>
<station station_type='current' subtype='Reference' cid='366' title='San Francisco Bay Entrance (Golden Gate), California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.4833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='348' title='San Francisco, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8067' lng='-122.465' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='349' title='San Francisco, Pier 22 1/2, California' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.7900' lng='-122.3867' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='350' title='San Francisco, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414290'>
<marker lat='37.8063' lng='-122.4659' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='367' title='San Juan Channel (south entrance), Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4613' lng='-122.9508' />
<flow flood='10' ebb='180' />
</station>
<station station_type='current' subtype='Reference' cid='368' title='San Juan Channel, south entrance (depth 75 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1703_17'>
<marker lat='48.4610' lng='-122.952' />
<flow flood='347' ebb='168' />
</station>
<station station_type='tide' subtype='Subordinate' tid='351' title='San Leandro Channel, San Leandro Bay, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414724'>
<marker lat='37.7483' lng='-122.235' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='352' title='San Leandro Marina, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414688'>
<marker lat='37.6950' lng='-122.192' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='353' title='San Mateo Bridge (West), California' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5800' lng='-122.2533' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='369' title='San Mateo Bridge (depth 11 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1305_7'>
<marker lat='37.5878' lng='-122.2502' />
<flow flood='136' ebb='298' />
</station>
<station station_type='tide' subtype='Subordinate' tid='354' title='San Mateo Bridge (east end), San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414637'>
<marker lat='37.6083' lng='-122.182' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='355' title='San Mateo Bridge (west end), San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414458'>
<marker lat='37.5800' lng='-122.253' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='370' title='San Mateo Bridge, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.5833' lng='-122.25' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='356' title='San Nicolas Island, California' source='harmonics-dwf-20210110-free.tcd' zone='676' noaa_id='9410068'>
<marker lat='33.2667' lng='-119.497' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='357' title='San Simeon, California' source='harmonics-dwf-20210110-free.tcd' zone='670' noaa_id='9412553'>
<marker lat='35.6417' lng='-121.188' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='371' title='Sand Island Tower, 0.9 nmi SE of (north channel) (depth 15 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1111_1'>
<marker lat='46.2578' lng='-123.9945' />
<flow flood='92' ebb='262' />
</station>
<station station_type='current' subtype='Subordinate' cid='372' title='Sand Island Tower, 1 nmi SE of (midchannel) (depth 15 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1106_1'>
<marker lat='46.2528' lng='-123.9908' />
<flow flood='107' ebb='275' />
</station>
<station station_type='current' subtype='Subordinate' cid='373' title='Sand Island, SSE of (depth 12 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1126_1'>
<marker lat='46.2555' lng='-123.968' />
<flow flood='97' ebb='265' />
</station>
<station station_type='tide' subtype='Subordinate' tid='358' title='Sandy Point, Lummi Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449292'>
<marker lat='48.7900' lng='-122.708' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='359' title='Santa Ana River entrance (inside), California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410599'>
<marker lat='33.6300' lng='-117.958' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='360' title='Santa Barbara Island, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='TWC0463'>
<marker lat='33.4833' lng='-119.0333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='361' title='Santa Barbara, California' source='harmonics-dwf-20210110-free.tcd' zone='650' noaa_id='9411340'>
<marker lat='34.4031' lng='-119.6928' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='362' title='Santa Cruz, Monterey Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413745'>
<marker lat='36.9583' lng='-122.017' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='363' title='Santa Cruz, Monterey Bay, California (sub)' source='harmonics-dwf-20081228-free.tcd' zone='535' noaa_id=''>
<marker lat='36.9667' lng='-122.0167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='364' title='Santa Monica, Municipal Pier, California (2)' source='legacy-2005-05-02.tcd' zone='655' noaa_id=''>
<marker lat='34.0000' lng='-118.5' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='365' title='Santa Monica, Municipal Pier, San Pedro Channel, California' source='harmonics-dwf-20210110-free.tcd' zone='655' noaa_id='9410840'>
<marker lat='34.0083' lng='-118.5' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='366' title='Sausalito, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8500' lng='-122.4833' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='367' title='Sausalito, Corps of Engineers Dock, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414819'>
<marker lat='37.8650' lng='-122.493' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='368' title='Sausalito, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414806'>
<marker lat='37.8467' lng='-122.477' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='374' title='Seal Island, south of (depth 24 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0841_1'>
<marker lat='38.0533' lng='-122.0495' />
<flow flood='69' ebb='271' />
</station>
<station station_type='tide' subtype='Subordinate' tid='369' title='Seaplane Harbor, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414413'>
<marker lat='37.6367' lng='-122.383' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='370' title='Seaside, 12th Avenue bridge, Necanicum River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='250' noaa_id=''>
<marker lat='46.0017' lng='-123.92' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='371' title='Sekiu, Clallam Bay, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='130' noaa_id='9443361'>
<marker lat='48.2633' lng='-124.297' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='372' title='Sekiu, Washington' source='legacy-2005-05-02.tcd' zone='130' noaa_id=''>
<marker lat='48.2667' lng='-124.3' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='373' title='Selby, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415142'>
<marker lat='38.0583' lng='-122.243' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='375' title='Sequim Bay Entrance, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.0833' lng='-123.05' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='376' title='Sequim Bay entrance, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9444555'>
<marker lat='48.0817' lng='-123.043' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='375' title='Shannon Point, 2 mile W of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5000' lng='-122.7167' />
<flow flood='5' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='376' title='Shannon Point, 2.0 miles west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5105' lng='-122.7305' />
<flow flood='5' ebb='190' />
</station>
<station station_type='tide' subtype='Subordinate' tid='377' title='Shaw Island, Ferry Terminal, Harney Channel, San Juan Channel, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449904'>
<marker lat='48.5850' lng='-122.928' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='378' title='Shaw Island, Ferry Terminal, Harney Channel, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5850' lng='-122.9283' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='379' title='Shelter Cove, California' source='harmonics-dwf-20210110-free.tcd' zone='455' noaa_id='9418024'>
<marker lat='40.0250' lng='-124.058' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='377' title='Sherman Island (East), California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0587' lng='-121.8' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='378' title='Sherman Island East, 0.2 mi north of (depth 14 ft), Sacramento River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0906_1'>
<marker lat='38.0587' lng='-121.8042' />
<flow flood='94' ebb='270' />
</station>
<station station_type='tide' subtype='Subordinate' tid='380' title='Ship Harbor, Fidalgo Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448772'>
<marker lat='48.5067' lng='-122.677' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='379' title='Sierra Point 1.3 mi ENE, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.6833' lng='-122.3666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='380' title='Sierra Point 4.4 mi E, South San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='531' noaa_id=''>
<marker lat='37.6667' lng='-122.2833' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='381' title='Sierra Point, 1.2 nmi east of (depth 18 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0476_1'>
<marker lat='37.6780' lng='-122.3175' />
<flow flood='210' ebb='358' />
</station>
<station station_type='current' subtype='Subordinate' cid='382' title='Sierra Point, 1.3 mi ENE of, San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0471_1'>
<marker lat='37.6847' lng='-122.3567' />
<flow flood='180' ebb='3' />
</station>
<station station_type='current' subtype='Subordinate' cid='383' title='Sierra Point, 4.4 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0486_1'>
<marker lat='37.6733' lng='-122.295' />
<flow flood='152' ebb='329' />
</station>
<station station_type='current' subtype='Reference' cid='384' title='Simmons Point, 0.6 nmi ESE of (depth 6 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1325_9'>
<marker lat='38.0481' lng='-121.9225' />
<flow flood='102' ebb='281' />
</station>
<station station_type='current' subtype='Subordinate' cid='385' title='Simmons Pt., Chipps Is., 0.6 nmi ESE of (depth 12 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0871_1'>
<marker lat='38.0645' lng='-121.9217' />
<flow flood='101' ebb='279' />
</station>
<station station_type='current' subtype='Subordinate' cid='386' title='Sinclair Island Light, 0.6 mile SE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6028' lng='-122.6487' />
<flow flood='45' ebb='210' />
</station>
<station station_type='current' subtype='Subordinate' cid='387' title='Sinclair Island, 1 mile NE of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6167' lng='-122.65' />
<flow flood='307' ebb='112' />
</station>
<station station_type='current' subtype='Reference' cid='388' title='Sinclair Island, 1.0 nmi NE of (depth 26 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1707_28'>
<marker lat='48.6442' lng='-122.6587' />
<flow flood='324' ebb='131' />
</station>
<station station_type='tide' subtype='Subordinate' tid='381' title='Sitka Dock, Coos Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9432879'>
<marker lat='43.3767' lng='-124.297' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='382' title='Siuslaw River entrance, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='9434132'>
<marker lat='44.0167' lng='-124.13' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='389' title='Skagit Bay channel, SW of Hope Island (depth 10 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1628_13'>
<marker lat='48.3978' lng='-122.5795' />
<flow flood='345' ebb='170' />
</station>
<station station_type='current' subtype='Subordinate' cid='390' title='Skipjack Island, 1.5 mi northwest of (depth 15 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2276_1'>
<marker lat='48.7495' lng='-123.0608' />
<flow flood='35' ebb='290' />
</station>
<station station_type='current' subtype='Subordinate' cid='391' title='Skipjack Island, 2 mile nne of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7500' lng='-123.05' />
<flow flood='40' ebb='205' />
</station>
<station station_type='current' subtype='Subordinate' cid='392' title='Skipjack Island, 2 miles NNE of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7667' lng='-123.0167' />
<flow flood='41' ebb='203' />
</station>
<station station_type='current' subtype='Subordinate' cid='393' title='Smith Island, 1.4 mi SSW of, Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PCT1451_1'>
<marker lat='48.3000' lng='-122.85' />
<flow flood='90' ebb='280' />
</station>
<station station_type='current' subtype='Subordinate' cid='394' title='Smith Island, 2 miles east of, Washington Current' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.3167' lng='-122.8' />
<flow flood='90' ebb='220' />
</station>
<station station_type='current' subtype='Reference' cid='395' title='Smith Island, 3.4 mi ESE of (depth 20 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1634_36'>
<marker lat='48.2964' lng='-122.7763' />
<flow flood='114' ebb='218' />
</station>
<station station_type='current' subtype='Subordinate' cid='396' title='Smith Island, 3.7 miles ESE of, Washington Current' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.3000' lng='-122.75' />
<flow flood='0' ebb='225' />
</station>
<station station_type='current' subtype='Reference' cid='397' title='Smith Island, 5.5 mi WNW of (depth 43 ft), Strait of Juan de Fuca, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1632_41'>
<marker lat='48.3246' lng='-122.9647' />
<flow flood='58' ebb='255' />
</station>
<station station_type='tide' subtype='Subordinate' tid='383' title='Smith Island, Alaska' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.3167' lng='-122.8366' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='384' title='Smith Island, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9447985'>
<marker lat='48.3167' lng='-122.837' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='385' title='Smith Island, Washington' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.3167' lng='-122.8333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='386' title='Smith Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414511'>
<marker lat='37.5017' lng='-122.223' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='387' title='Sneeoosh Point, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448576'>
<marker lat='48.4000' lng='-122.548' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='388' title='Snodgrass Slough, Sacramento River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415565'>
<marker lat='38.2767' lng='-121.495' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='389' title='Sonoma Creek, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415338'>
<marker lat='38.1567' lng='-122.407' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='390' title='South Bay Wreck, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414609'>
<marker lat='37.5517' lng='-122.162' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='391' title='South Beach, Yaquina Bay and River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435380'>
<marker lat='44.6250' lng='-124.043' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='398' title='South Channel, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0206_1'>
<marker lat='37.7500' lng='-122.5333' />
<flow flood='23' ebb='180' />
</station>
<station station_type='current' subtype='Reference' cid='399' title='South Haro Strait, south of Lime Kiln Light (depth 107 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1724_31'>
<marker lat='48.4980' lng='-123.1599' />
<flow flood='310' ebb='147' />
</station>
<station station_type='tide' subtype='Reference' tid='392' title='South San Diego Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='9410135'>
<marker lat='32.6291' lng='-117.1078' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='393' title='South San Francisco, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414391'>
<marker lat='37.6667' lng='-122.39' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='400' title='South Spit, 0.1 nmi E of (depth 15 ft), Humboldt Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='HUB0207_3'>
<marker lat='40.7478' lng='-124.2241' />
<flow flood='178' ebb='2' />
</station>
<station station_type='current' subtype='Reference' cid='401' title='Southampton Shoal Channel, LB 6 (depth 15 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='s08010_2' observed='true'>
<marker lat='37.9162' lng='-122.4223' />
<flow flood='359' ebb='169' />
</station>
<station station_type='current' subtype='Subordinate' cid='403' title='Southampton Shoal Light, 0.2 mi E of (depth 10 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0631_1'>
<marker lat='37.8825' lng='-122.3958' />
<flow flood='19' ebb='188' />
</station>
<station station_type='tide' subtype='Subordinate' tid='394' title='Southbeach, Yaquina Bay and River, Oregon (sub)' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.6250' lng='-124.0433' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='395' title='Southeast Farallon Island, California' source='harmonics-dwf-20210110-free.tcd' zone='545' noaa_id='9414262'>
<marker lat='37.7000' lng='-123' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='404' title='Spieden Channel, north of Limestone Point (depth 47 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1719_19'>
<marker lat='48.6278' lng='-123.1116' />
<flow flood='85' ebb='281' />
</station>
<station station_type='current' subtype='Subordinate' cid='405' title='Spoonbill Creek near Bridge, Suisun Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0667' lng='-121.9' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='406' title='Spoonbill Creek, near bridge (depth 3 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0876_1'>
<marker lat='38.0588' lng='-121.9047' />
<flow flood='105' ebb='285' />
</station>
<station station_type='current' subtype='Subordinate' cid='407' title='Spring Passage, South entrance of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6000' lng='-123.0333' />
<flow flood='10' ebb='150' />
</station>
<station station_type='current' subtype='Reference' cid='408' title='Spring Passage, south entrance (depth 13 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1720_26'>
<marker lat='48.6115' lng='-123.0341' />
<flow flood='5' ebb='148' />
</station>
<station station_type='current' subtype='Subordinate' cid='409' title='St. George Reef, California Current' source='harmonics-dwf-20081228-free.tcd' zone='356' noaa_id=''>
<marker lat='41.8167' lng='-124.3333' />
<flow flood='5' ebb='185' />
</station>
<station station_type='current' subtype='Subordinate' cid='410' title='Stake Point .9 Mi NNW, Suisun Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0500' lng='-121.95' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='411' title='Stake Point, 0.9 nmi NNW of (depth 4 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0866_1'>
<marker lat='38.0647' lng='-121.9555' />
<flow flood='77' ebb='283' />
</station>
<station station_type='tide' subtype='Subordinate' tid='396' title='Steamboat Slough, Snug Harbor Marina, Sacramento River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415414'>
<marker lat='38.1833' lng='-121.655' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='397' title='Stockton, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9414883'>
<marker lat='37.9583' lng='-121.29' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='412' title='Strait of Georgia, 4.5 nmi SW of Point Roberts (depth 31 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1726_35'>
<marker lat='48.9389' lng='-123.1651' />
<flow flood='332' ebb='129' />
</station>
<station station_type='current' subtype='Reference' cid='413' title='Strait of Juan de Fuca entrance (depth 89 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='130' noaa_id='PUG1642_49'>
<marker lat='48.4500' lng='-124.5838' />
<flow flood='125' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='398' title='Strawberry Bay, Cypress Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448876'>
<marker lat='48.5650' lng='-122.722' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='414' title='Strawberry Island, 0.8 mile W of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5667' lng='-122.75' />
<flow flood='20' ebb='190' />
</station>
<station station_type='current' subtype='Subordinate' cid='415' title='Strawberry Island, 0.8 mile west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5612' lng='-122.7542' />
<flow flood='20' ebb='190' />
</station>
<station station_type='current' subtype='Reference' cid='416' title='Strawberry Island, west of (depth 33 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1732_25'>
<marker lat='48.5610' lng='-122.7543' />
<flow flood='356' ebb='174' />
</station>
<station station_type='tide' subtype='Subordinate' tid='399' title='Suisun City, Suisun Slough, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415498'>
<marker lat='38.2367' lng='-122.03' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='417' title='Suisun Cutoff (depth 24 ft), Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0856_1'>
<marker lat='38.0888' lng='-122.0072' />
<flow flood='126' ebb='298' />
</station>
<station station_type='tide' subtype='Reference' tid='401' title='Suisun Slough entrance, Suisun Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415265'>
<marker lat='38.1283' lng='-122.073' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='402' title='Sunset Beach, Whidbey Island, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='9447951'>
<marker lat='48.2833' lng='-122.728' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='419' title='Sweetwater Channel, southwest of (depth 14 ft), San Diego Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='750' noaa_id='PCT0116_1'>
<marker lat='32.6450' lng='-117.1228' />
<flow flood='203' ebb='348' />
</station>
<station station_type='tide' subtype='Subordinate' tid='403' title='Swinomish Channel ent., Padilla Bay, Washington' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.4667' lng='-122.5167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='404' title='Swinomish Channel entrance, Padilla Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448682'>
<marker lat='48.4583' lng='-122.513' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='420' title='Table Bluff Light, California Current' source='harmonics-dwf-20081228-free.tcd' zone='450' noaa_id=''>
<marker lat='40.7000' lng='-124.2833' />
<flow flood='10' ebb='190' />
</station>
<station station_type='tide' subtype='Subordinate' tid='405' title='Taft, Siletz Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9436101'>
<marker lat='44.9267' lng='-124.013' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='406' title='Taholah, Washington' source='harmonics-dwf-20210110-free.tcd' zone='153' noaa_id='9441644'>
<marker lat='47.3482' lng='-124.2848' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='407' title='Tarlatt Slough, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0933'>
<marker lat='46.3700' lng='-124.005' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='408' title='Tatoosh Island, Cape Flattery, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='150' noaa_id='9442971'>
<marker lat='48.3917' lng='-124.737' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='409' title='Telegraph Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449988'>
<marker lat='48.4433' lng='-122.805' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='410' title='Terminous, South Fork, Mokelumne River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415257'>
<marker lat='38.1100' lng='-121.498' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='421' title='Thatcher Pass (depth 28 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1733_22'>
<marker lat='48.5274' lng='-122.804' />
<flow flood='256' ebb='93' />
</station>
<station station_type='tide' subtype='Subordinate' tid='411' title='Thatcher Pass, Washington' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5333' lng='-122.8' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='422' title='Thatcher Pass, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5275' lng='-122.803' />
<flow flood='300' ebb='75' />
</station>
<station station_type='tide' subtype='Reference' tid='412' title='Threemile Slough entrance, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415193'>
<marker lat='38.0867' lng='-121.685' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='413' title='Threemile Slough, Sacramento River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415236'>
<marker lat='38.1067' lng='-121.7' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='414' title='Tidal Creek, Elkhorn Slough, Monterey Bay, Port San Luis, California' source='harmonics-dwf-20210110-free.tcd' zone='535' noaa_id='9413643'>
<marker lat='36.8333' lng='-121.745' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='415' title='Tide Point, Cypress Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448918'>
<marker lat='48.5867' lng='-122.748' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='423' title='Tillamook Bay entrance, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1096_1'>
<marker lat='45.5622' lng='-123.9383' />
<flow flood='141' ebb='305' />
</station>
<station station_type='tide' subtype='Subordinate' tid='416' title='Tillamook, Hoquarten Slough, Tillamook Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9437331'>
<marker lat='45.4600' lng='-123.845' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='424' title='Toe Point, Patos Island, 0.5 mile S of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7783' lng='-122.9408' />
<flow flood='45' ebb='270' />
</station>
<station station_type='current' subtype='Subordinate' cid='425' title='Toe Point, Patos Island, 0.5 mile South of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7667' lng='-122.9333' />
<flow flood='45' ebb='270' />
</station>
<station station_type='tide' subtype='Reference' tid='417' title='Toke Point, Willapa Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='9440910'>
<marker lat='46.7075' lng='-123.9669' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='418' title='Toledo, Yaquina Bay and River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.6167' lng='-123.9333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='419' title='Toledo, Yaquina River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435362'>
<marker lat='44.6167' lng='-123.937' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='420' title='Tomales Bay entrance, California' source='harmonics-dwf-20210110-free.tcd' zone='540' noaa_id='9415469'>
<marker lat='38.2283' lng='-122.977' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='426' title='Towhead Island, 0.4 mi east of, Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PCT2126_1'>
<marker lat='48.6122' lng='-122.7022' />
<flow flood='315' ebb='125' />
</station>
<station station_type='current' subtype='Subordinate' cid='427' title='Towhead Island, 0.4 mile East of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.6000' lng='-122.7' />
<flow flood='315' ebb='125' />
</station>
<station station_type='current' subtype='Subordinate' cid='428' title='Treasure Island .3 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8167' lng='-122.35' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='429' title='Treasure Island .5 mi N, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8333' lng='-122.3666' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='430' title='Treasure Island, 0.2 mi west of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0326_1'>
<marker lat='37.8217' lng='-122.3783' />
<flow flood='172' ebb='343' />
</station>
<station station_type='current' subtype='Subordinate' cid='431' title='Treasure Island, 0.3 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0356_1'>
<marker lat='37.8267' lng='-122.355' />
<flow flood='140' ebb='327' />
</station>
<station station_type='current' subtype='Subordinate' cid='432' title='Treasure Island, 0.5 mi north of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0346_1'>
<marker lat='37.8405' lng='-122.3683' />
<flow flood='118' ebb='304' />
</station>
<station station_type='current' subtype='Reference' cid='433' title='Treasure Island, 0.78 nmi NW of (depth 3 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1210_13'>
<marker lat='37.8373' lng='-122.3872' />
<flow flood='126' ebb='302' />
</station>
<station station_type='current' subtype='Subordinate' cid='434' title='Treasure Island, 0.8 mi west of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0321_1'>
<marker lat='37.8217' lng='-122.3917' />
<flow flood='148' ebb='334' />
</station>
<station station_type='current' subtype='Subordinate' cid='435' title='Treasure Island, 0.85 nmi east of (depth 11 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0351_1'>
<marker lat='37.8250' lng='-122.3463' />
<flow flood='161' ebb='340' />
</station>
<station station_type='tide' subtype='Subordinate' tid='421' title='Trinidad Harbor, California' source='harmonics-dwf-20210110-free.tcd' zone='450' noaa_id='9419059'>
<marker lat='41.0567' lng='-124.147' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='436' title='Trinidad Head, California Current' source='harmonics-dwf-20081228-free.tcd' zone='450' noaa_id=''>
<marker lat='41.0500' lng='-124.1667' />
<flow flood='5' ebb='185' />
</station>
<station station_type='tide' subtype='Reference' tid='422' title='Tsawwassen, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='49.0000' lng='-123.1333' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='423' title='Tskawahyah Island, Cape Alava, Washington' source='harmonics-dwf-20210110-free.tcd' zone='150' noaa_id='9442705'>
<marker lat='48.1711' lng='-124.7369' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='424' title='Tumbo Channel, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.7833' lng='-123.1' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='437' title='Turn Point, Boundary Pass (depth 116 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1717_35'>
<marker lat='48.6912' lng='-123.245' />
<flow flood='3' ebb='236' />
</station>
<station station_type='tide' subtype='Subordinate' tid='425' title='Turn Point, Stuart Island, Haro Strait, Washington' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.6833' lng='-123.2333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='438' title='Turn Rock Light, 1.9 miles northwest of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5567' lng='-122.9983' />
<flow flood='330' ebb='135' />
</station>
<station station_type='current' subtype='Subordinate' cid='439' title='Turn Rock, 1.9 mile NW of, Washington Current' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.5500' lng='-122.9833' />
<flow flood='330' ebb='135' />
</station>
<station station_type='tide' subtype='Reference' tid='426' title='Turner Bay, Similk Bay, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448657'>
<marker lat='48.4450' lng='-122.555' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='427' title='Twin Rivers, Strait of Juan de Fuca, Washington' source='harmonics-dwf-20210110-free.tcd' zone='131' noaa_id='9443644'>
<marker lat='48.1750' lng='-123.95' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='440' title='Umpqua River entrance, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='350' noaa_id='PCT1066_1'>
<marker lat='43.6783' lng='-124.1933' />
<flow flood='10' ebb='190' />
</station>
<station station_type='tide' subtype='Subordinate' tid='428' title='Upper Guadalupe Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414549'>
<marker lat='37.4350' lng='-122.007' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='429' title='Upper drawbridge, Petaluma River, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415584'>
<marker lat='38.2283' lng='-122.613' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='441' title='Upright Channel narrows (depth 24 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1723_18'>
<marker lat='48.5538' lng='-122.9226' />
<flow flood='40' ebb='230' />
</station>
<station station_type='tide' subtype='Reference' tid='430' title='Upright Head, Lopez Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449911'>
<marker lat='48.5717' lng='-122.885' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='431' title='Vallejo, Mare Island Strait, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415165'>
<marker lat='38.1117' lng='-122.273' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='432' title='Vallejo, Mare Island Strait, Carquinez Strait, California' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.1000' lng='-122.2666' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='433' title='Ventura, California' source='harmonics-dwf-20210110-free.tcd' zone='650' noaa_id='9411189'>
<marker lat='34.2667' lng='-119.283' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='434' title='Village Point, Lummi Island, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449161'>
<marker lat='48.7167' lng='-122.708' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='442' title='Violet Point, 3.2 miles northwest of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='132' noaa_id=''>
<marker lat='48.1667' lng='-122.9667' />
<flow flood='120' ebb='325' />
</station>
<station station_type='current' subtype='Reference' cid='443' title='Violet Point, 3.7 mi NW of Protection Island (depth 17 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='132' noaa_id='PUG1631_33'>
<marker lat='48.1614' lng='-122.9681' />
<flow flood='102' ebb='290' />
</station>
<station station_type='current' subtype='Subordinate' cid='444' title='Violet Point, 3.7 miles N of, Washington Current' source='legacy-2005-05-02.tcd' zone='132' noaa_id=''>
<marker lat='48.1833' lng='-122.9167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='445' title='Vulcan Island .5 mi E, San Joaquin River, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.9833' lng='-121.3833' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='446' title='Vulcan Island, 0.5 mi east of (depth 17 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0936_1'>
<marker lat='37.9853' lng='-121.3908' />
<flow flood='135' ebb='315' />
</station>
<station station_type='tide' subtype='Reference' tid='435' title='Waldport, Alsea Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9434939'>
<marker lat='44.4344' lng='-124.0581' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='447' title='Waldron Island, 1.7 miles west of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.7042' lng='-123.1087' />
<flow flood='40' ebb='260' />
</station>
<station station_type='current' subtype='Subordinate' cid='448' title='Waldron Island, 1.7 nmi west of (depth 27 ft), Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1716_23'>
<marker lat='48.7042' lng='-123.1048' />
<flow flood='325' ebb='252' />
</station>
<station station_type='tide' subtype='Reference' tid='436' title='Waldron Island, Haro Strait, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9449746'>
<marker lat='48.6868' lng='-123.0376' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='437' title='Wards Island, Little Connection Slough, San Joaquin River, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415105'>
<marker lat='38.0500' lng='-121.4969' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='438' title='Warrenton, Skipanon River, Columbia River, Oregon' source='legacy-2005-05-02.tcd' zone='250' noaa_id=''>
<marker lat='46.1650' lng='-123.92' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='439' title='Warrenton, Skipanon River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='TWC0883'>
<marker lat='46.1667' lng='-123.9167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='449' title='Wasp Passage Light, 0.5 mile WSW of, Washington Current' source='harmonics-dwf-20081228-free.tcd' zone='133' noaa_id=''>
<marker lat='48.5922' lng='-122.9895' />
<flow flood='300' ebb='110' />
</station>
<station station_type='current' subtype='Reference' cid='450' title='Wasp Passage narrows (depth 11 ft), San Juan Channel, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1721_17'>
<marker lat='48.5925' lng='-122.9896' />
<flow flood='256' ebb='60' />
</station>
<station station_type='tide' subtype='Subordinate' tid='440' title='Wedderburn, Rogue River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='356' noaa_id='TWC0817'>
<marker lat='42.4333' lng='-124.4167' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='441' title='Weiser Point, Yaquina River, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435308'>
<marker lat='44.5933' lng='-124.008' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='451' title='West Island Lt .5 mi SE, San Joaquin River, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0167' lng='-121.7667' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='452' title='West Island Lt., 0.5 mi SE of (depth 5 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0931_1'>
<marker lat='38.0212' lng='-121.762' />
<flow flood='90' ebb='270' />
</station>
<station station_type='current' subtype='Reference' cid='453' title='West Island, north of (depth 3 ft), San Joaquin River, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='SFB1328_8'>
<marker lat='38.0249' lng='-121.79' />
<flow flood='76' ebb='255' />
</station>
<station station_type='tide' subtype='Subordinate' tid='442' title='West Point Slough, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414507'>
<marker lat='37.5050' lng='-122.192' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='454' title='West entrance (depth 6 ft), Montezuma Slough, Suisun Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0806_1'>
<marker lat='38.1320' lng='-122.058' />
<flow flood='135' ebb='315' />
</station>
<station station_type='tide' subtype='Subordinate' tid='443' title='Westport, California' source='harmonics-dwf-20210110-free.tcd' zone='455' noaa_id='9417624'>
<marker lat='39.6333' lng='-123.783' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Reference' tid='444' title='Westport, Point Chehalis, Grays Harbor, Washington' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='9441102'>
<marker lat='46.9043' lng='-124.1051' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='455' title='Westport, channel 0.4 mi NE of, Grays Harbor, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='156' noaa_id='PCT1316_1'>
<marker lat='46.9142' lng='-124.1083' />
<flow flood='113' ebb='310' />
</station>
<station station_type='tide' subtype='Reference' tid='445' title='Wilson Cove, San Clemente Island, California' source='harmonics-dwf-20210110-free.tcd' zone='775' noaa_id='9410032'>
<marker lat='33.0050' lng='-118.557' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='456' title='Wilson Point 3.9 mi NNW, San Pablo Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='38.0667' lng='-122.3333' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='457' title='Wilson Point, 1.55 nmi north of (depth 10 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0741_1'>
<marker lat='38.0375' lng='-122.1505' />
<flow flood='71' ebb='253' />
</station>
<station station_type='current' subtype='Subordinate' cid='458' title='Wilson Point, 3.90 nmi NNW of (depth 4 ft), San Pablo Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0746_1'>
<marker lat='38.0745' lng='-122.3425' />
<flow flood='46' ebb='237' />
</station>
<station station_type='tide' subtype='Subordinate' tid='446' title='Winant, Yaquina Bay and River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.5833' lng='-124' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='447' title='Wingo, Sonoma Creek, San Pablo Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='9415447'>
<marker lat='38.2100' lng='-122.427' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='459' title='Yaquina Bay entrance, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='PCT1076_1'>
<marker lat='44.6167' lng='-124.0667' />
<flow flood='50' ebb='235' />
</station>
<station station_type='current' subtype='Subordinate' cid='460' title='Yaquina Bay, Highway Bridge, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='PCT1081_1'>
<marker lat='44.6233' lng='-124.057' />
<flow flood='44' ebb='222' />
</station>
<station station_type='current' subtype='Subordinate' cid='461' title='Yaquina River, 1 mi below Toledo, Yaquina Bay, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='PCT1091_1'>
<marker lat='44.6005' lng='-123.9417' />
<flow flood='332' ebb='132' />
</station>
<station station_type='tide' subtype='Subordinate' tid='448' title='Yaquina USCG station, Newport, Yaquina Bay, Oregon' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='9435385'>
<marker lat='44.6267' lng='-124.055' />
<flow flood='' ebb='' />
</station>
<station station_type='tide' subtype='Subordinate' tid='449' title='Yaquina, Yaquina Bay and River, Oregon' source='harmonics-dwf-20081228-free.tcd' zone='255' noaa_id=''>
<marker lat='44.6000' lng='-124.0167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='462' title='Yaquina, Yaquina River, Yaquina Bay, Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='255' noaa_id='PCT1086_1'>
<marker lat='44.6020' lng='-124.0113' />
<flow flood='184' ebb='2' />
</station>
<station station_type='current' subtype='Subordinate' cid='463' title='Yellow Bluff .8 mi E, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8333' lng='-122.45' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='464' title='Yellow Bluff, 0.8 mi east of (depth 8 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0551_1'>
<marker lat='37.8350' lng='-122.455' />
<flow flood='22' ebb='257' />
</station>
<station station_type='current' subtype='Subordinate' cid='465' title='Yellow Bluff, 0.8 nmi NE of (depth 19 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='530' noaa_id='PCT0546_1'>
<marker lat='37.8455' lng='-122.4572' />
<flow flood='13' ebb='211' />
</station>
<station station_type='current' subtype='Subordinate' cid='466' title='Yerba Buena Island W of, San Francisco Bay, California Current' source='legacy-2005-05-02.tcd' zone='530' noaa_id=''>
<marker lat='37.8000' lng='-122.3833' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='467' title='Yerba Buena Island, 0.3 nmi SE of (depth 23 ft), San Francisco Bay, California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='PCT0361_1'>
<marker lat='37.8042' lng='-122.3572' />
<flow flood='159' ebb='316' />
</station>
<station station_type='tide' subtype='Subordinate' tid='450' title='Yerba Buena Island, San Francisco Bay, California' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='9414782'>
<marker lat='37.8100' lng='-122.36' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='468' title='Yerba Buena Island, west of (midchannel) (depth 12 ft), California Current' source='harmonics-dwf-20210110-free.tcd' zone='531' noaa_id='SFB1209_23'>
<marker lat='37.8100' lng='-122.3831' />
<flow flood='143' ebb='331' />
</station>
<station station_type='tide' subtype='Reference' tid='451' title='Yokeko Point, British Columbia' source='legacy-2005-05-02.tcd' zone='133' noaa_id=''>
<marker lat='48.4167' lng='-122.6167' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Reference' cid='469' title='Yokeko Point, Deception Pass (depth 7 ft), Rosario Strait, Washington Current' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='PUG1629_9'>
<marker lat='48.4127' lng='-122.6132' />
<flow flood='55' ebb='230' />
</station>
<station station_type='tide' subtype='Reference' tid='452' title='Yokeko Point, Deception Pass, Washington' source='harmonics-dwf-20210110-free.tcd' zone='133' noaa_id='9448601'>
<marker lat='48.4133' lng='-122.615' />
<flow flood='' ebb='' />
</station>
<station station_type='current' subtype='Subordinate' cid='470' title='Youngs Bay Bridge (depth 9 ft), Oregon Current' source='harmonics-dwf-20210110-free.tcd' zone='250' noaa_id='PCT1146_1'>
<marker lat='46.1778' lng='-123.8683' />
<flow flood='135' ebb='320' />
</station>
<station station_type='current' subtype='Subordinate' cid='471' title='Youngs Bay Entrance, Oregon Current (17d)' source='harmonics-dwf-20081228-free.tcd' zone='250' noaa_id=''>
<marker lat='46.1863' lng='-123.8878' />
<flow flood='93' ebb='260' />
</station>
<station station_type="meeting" xid='1' title="East Bay Carpool" zone="530">
    <marker lat="37.83922" lng="-122.29532"/>
    <city>Emeryville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The East Bay carpool regularly drives to BASK General Meetings. It meets in the parking lot of Wells Fargo Bank, 5801 Christie Ave, Emeryville. 
        This is near the intersection of Powell and Christie. Meeting time is between 5:00pm and 5:30pm. With three sharing a car, the carpool is eligible to save time and toll costs by taking the carpool lane.
		  ]]>
    </details>
  </station>
  <station station_type="meeting" xid='2' title="North Bay Carpool" zone="530">
    <marker lat="38.23412" lng="-122.61899"/>
    <city>Petaluma</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The North Bay/Sonoma County carpool regularly drives to BASK General Meetings. It meets in the Park & Ride lot at the Lakeville Highway Exit in Petaluma (west side of Hwy 101). Carpools leave by 5:15pm. With three sharing a car, the carpool is eligible to save toll costs for the Golden Gate bridge.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="3" station_class="water_trail" title="Alviso" zone="531" modtime="1526531994129" modby="bask0099" >
  <marker lat="37.429186" lng="-121.981353"/>
  <tide_station>155</tide_station>
  <city>Alviso</city>
  <details><![CDATA[
      <p><b>Overview: </b>New dock and ramp are already getting silted in at low tide. There are both low and high freeboard floats. It is 3.5 miles to the bay. You can also paddle up the Guadalupe Creek to explore. The park is open 8AM to sunset. There is a site host present 24/7.</p>
      <p><b>Parking: </b>Free parking for about 70 cars. Roughly 400&#x27; from the ramp. There is a loading area by the ramp.</p>
      <p><b>Facilities: </b>Restrooms and water about 200 yds from ramp. New and well maintained. There is a picnic area.</p>
      <p><b>Address: </b>1160 Taylor St at the corner of Hope and Mill Streets.</p>
      <p><b>Contact Info: </b>Alviso Marina Park, 408-262-6980<br>County of Santa Clara, 408-358-3741</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/alviso-marina-county-park/">Bay Area Water Trail - Alviso Marina County Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.sccgov.org/sites/parks/parkfinder/pages/alvisomarina.aspx">http://www.sccgov.org/sites/parks/parkfinder/pages/alvisomarina.aspx</a></p>
      <p><img class="details_img" src="images/alviso1.jpg" height="252" width="400">
      <br><span class='details_caption'>High and low floats at mid-tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526531994129-3-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Alviso High 2</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526531994130-3-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Alviso Low</span>
  ]]></details>
</station>
  <station station_type="launch" xid='4' title="Crescent City" zone='450'>
    <marker lat="41.759719" lng="-124.222431"/>
    <tide_station>89</tide_station>
    <city>Crescent_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No facilities, sheltered cove with slight shore break.
        <p><b> Facilities: </b> None
        <p><b> Parking: </b>Free
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='5' title="Brandon, Oregon" zone='350' chart_title="Brandon" >
    <marker lat="43.148475" lng="-124.4015083"/>
    <tide_station>89</tide_station>
    <city>Brandon</city>
    <details>
      <![CDATA[<p><b>Overview: </b>
        <p><b> Facilities: </b>Bathroom facilities available at Bullards Beach State Park.
        <p><b> Parking: </b> Parking is available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='6' title="North Bend, Oregon" zone='350' chart_title="North Bend" >
    <marker lat="43.4157333" lng="-124.2797722"/>
    <tide_station>89</tide_station>
    <city>North_Bend</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Launch ramp and facilities are available, day use fees apply.
        <p><b> Facilities: </b>facilities are separate bathrooms
        <p><b> Parking: </b> Parking is available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='7' title="Myrtle Creek">
    <marker lat="41.801970" lng="-124.054516"/>
    <city>Crescent City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Recommended for boats up to 12 foot.  You'll have to carry the boat down a trail which is a block or two long.  
        It takes about 1 1/2 hours to go down the 4 miles to the day use area at Jedediah Smith Campgound.
        <p><b> Parking: </b>Free parking on the road above.
        <p><b> Facilities: </b> Restrooms
		  ]]>
    </details>
  </station>
<station station_type="destination" xid="8" title="Swede’s Beach" zone="530" modtime="1526054277365" modby="bask0099" >
  <marker lat="37.848056" lng="-122.48"/>
  <tide_station>368</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Foot of Valley St. in Sausalito. It&#x27;s a nice spot to stop for a rest or lunch. The beach is sand and usable at all tides.</p>
      <p><b>Parking: </b>There are 9 parking places on the street above the 36 steps that lead to the beach. Parking is limited to 2 hours between 7AM and 6:30PM. There is never a spot available</p>
      <p><b>Facilities: </b>Public beach with no facilities but there is a little cafe on the corner of 2nd St. and Valley St.</p>
      <p><b>Address: </b>City of Sausalito, Dept. of Parks and Rec., 415-289-4100</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.sausalito.ca.us/business/park-rec/parks.htm">http://www.ci.sausalito.ca.us/business/park-rec/parks.htm</a></p>
      <p><img class="details_img zoomable" src="images/details/swedes-bch1.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Swedes%20beach%20at%207'%20tide%20on%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img" src="images/editor_uploads/details/1526054277365-8-bask0099.jpg" height="268" width="400">
      <br><span class='details_caption'>Swede&#x27;s beach stairs</span>
  ]]></details>
</station>
<station station_type="destination" xid="9" title="Bar Bocce" zone="530" modtime="1526055311538" modby="bask0099" >
  <marker lat="37.859722" lng="-122.484722"/>
  <tide_station>368</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Destination at high tide &#x28;beach is sand&#x29;. At low tide there is slippery mud and rocks. The easiest landing spot is the north side of the beach along the sea wall. The public access path to the beach is around the south side of the restaurant. The reason to come here is the restaurant.</p>
      <p><b>Parking: </b>Parking is free but very limited when restaurant is open. Best to arrive by kayak or park at the foot of Locust St at the far north end of the parking lot which allows 3 hours between 6AM and 2AM but no overnight.</p>
      <p><b>Facilities: </b>There is a bathroom in the restaurant for customers. Good pizza and a full bar. No other amenities.</p>
      <p><b>Address: </b>1205 Bridgeway in Sausalito &#x28;foot of Pine St.&#x29; in the same parking lot as the Turney Street ramp.</p>
      <p><img class="details_img" src="images/barbocce1.jpg" height="321" width="400">
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Bar%20Bocce%20in%20Sausalito.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Bar%20Bocce%20beach%20at%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="10" title="Turney Street Public Boat Ramp" zone="530" modtime="1526074873379" modby="bask0099" chart_title="Turney St" >
  <marker lat="37.86" lng="-122.485472"/>
  <tide_station>368</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Due to difficult parking this site is a better destination than launch.</p>
      <p><b>Parking: </b>Free parking at the foot of Locust Street. Parking is limited to 3 hours. Dunphy Park is a little further but allows all day parking.</p>
      <p><b>Facilities: </b>Free public ramp. No facilities except restaurants.</p>
      <p><b>Address: </b>1200 Bridgeway, Sausalito, CA</p>
      <p><img class="details_img" src="images/turney1.jpg" height="249" width="400" >
      <br><span class='details_caption'>New ADA gangway. Note gravel beach to right of ramp.</span>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Turney_St_Sausalito.jpg" height="299" width="400" >
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Turney%20St%20ramp,%207'%20tide,%201-1-18.jpg" height="300" width="400" >
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526074873379-10-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Turney st, 4-24-18, zero tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="11" station_class="water_trail" title="Bayfront Park, Mill Valley (AKA Dog Park)" zone="530" modtime="1530226983004" modby="petolino" edits_since="1530224889751" chart_title="Bayfront Park" >
  <marker lat="37.896806" lng="-122.525306"/>
  <tide_station>367</tide_station>
  <city>Mill Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide Launch. Then meander down to Richardson Bay. Bring binoculars. Good birding. Be sure to get back before low tide or else run a shuttle. Launch from the mud bank next to the footbridge or the new dock.</p>
      <p><b>Parking: </b>Parking is free but limited on the street. Weekends there is also parking at the adjacent school. it is about a 50yd carry to the beach and another 100yds to the new canoe dock. There is space to load and rig.</p>
      <p><b>Facilities: </b>Bathrooms are across the foot bridge by the public safety building or in sewage treatment plant &#x28;open Mon-Fri 7AM-4PM, Sat-Sun 7AM-2PM&#x29;.</p>
      <p><b>Address: </b>Foot of Sycamore St.</p>
      <p><b>Contact Info: </b>City of Mill Valley, Parks and Rec. 415-388-4033</p>
      <p><img class="details_img" src="images/new/BayFrontPark-MillValley-mid-tide.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at mid-tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Bay%20Front%20Park%20in%20MV,%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7 foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526077153575-11-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Front Park warning sign, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526077153576-11-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Front park dock detail, low tide 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526077153577-11-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Front Park at the mud beach, zero tide &#x28;notice site of new dock in background&#x29;</span>
  ]]></details>
</station>
  <station station_type="launch" xid="12" title="Brickyard Park, Strawberry" zone="530" modtime="1526618309244" modby="bask0099" chart_title="Brickyard Park" >
  <marker lat="37.8825" lng="-122.503889"/>
  <tide_station>367</tide_station>
  <city>Strawberry</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide Launch or Destination. The beach is approximately 100 yds from the street down a gently sloped concrete path. The beach is sand below a low rip rap wall and goes to firm mud which gets progressively softer as the tide goes out. At low tide the mud extends quite a ways into the bay. Plan to launch or land at mid to high tide. This is protected water but subject to brisk west wind in the summer.</p>
      <p><b>Parking: </b>Parking is on the street. There is space for about 12 cars with no time restrictions, including overnight.</p>
      <p><b>Facilities: </b>Porta potty, playground equipment, benches, picnic table and a trash can.</p>
      <p><b>Address: </b>8 Great Circle Dr. Entrance to park is by the intersection of Seminary Dr and Great Circle Dr. Beach is about 100yds from street.</p>
      <p><b>Contact Info: </b>Strawberry Recreation District, 415-383-6494</p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Brickyard%20Park%204,%20Tiburon,%20Zero%20tide,%20Nov%2015,%202013.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526167564703-12-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Brickyard Park, Strawberry, hi tide, Mar 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526167564704-12-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Brickyard Park, mid-tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="13" title="Harbor Cove Canoe Dock, Strawberry" zone="530" modtime="1526168307704" modby="bask0099" chart_title="Harbor Cove" >
  <marker lat="37.895444" lng="-122.503389"/>
  <tide_station>367</tide_station>
  <city>Strawberry</city>
  <details><![CDATA[
      <p><b>Overview: </b>Free public dock is located between two McMansions at &#x23;40 Harbor Cove Way. Seals may haul out on nearby island. If they are there you can&#x27;t launch. The dock is down a dirt path and the carry from the street is about 50&#x27;. Note that this area is closed from October 1- March 31 because of the migrating birds. Birds&#x21; Bring binoculars. It is a fairly low dock and in good repair.</p>
      <p><b>Parking: </b>Parking is on the road and very limited &#x28;2-8 spaces max&#x29;. No time restrictions.</p>
      <p><b>Facilities: </b>No facilities. Access limited to daylight hours.</p>
      <p><b>Address: </b>40 Harbor Cove Way</p>
      <p><b>Contact Info: </b>Strawberry recreation district, 415-383-6494</p>
      <p><img class="details_img" src="images/harbor-cove.jpg" height="303" width="400">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526168307704-13-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Harbor Cove Dock, 7&#x27; tide, 2018</span>
  ]]></details>
</station>
  <station station_type="launch" xid="14" title="Bon Aire Landing on Corte Madera Creek" zone="530" modtime="1526615516536" modby="bask0099" chart_title="Bon Aire Landing" >
  <marker lat="37.944667" lng="-122.528889"/>
  <tide_station>80</tide_station>
  <city>Corte_Madera</city>
  <details><![CDATA[
      <p><b>Overview: </b>Small neighborhood park and dock. High tide only. The dock is old and funky.</p>
      <p><b>Parking: </b>Park on street. There are no time restrictions and overnight is OK. Tis is a neighborhood of condo and apartments and there are not many available spots.</p>
      <p><b>Facilities: </b>No facilities except a few benches and a picnic table.</p>
      <p><b>Address: </b>557 S. Elisio Dr.</p>
      <p><b>Contact Info: </b>City of Larkspur, 415-927-5110</p>
      <p><img class="details_img" src="images/bon-aire-lch.jpg" height="284" width="400">
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/0_Tide,_Bon_Aire_Landing,_Corte_Madera_Creek.jpg" height="276" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20Bon%20Aire%20dock,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="15" title="Starkweather Shoreline Park" zone="530" modtime="1605393486857" modby="bask0099" edits_since="1528688272088" chart_title="Starkweather Park" >
  <marker lat="37.94575" lng="-122.483861"/>
  <tide_station>304</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide launch. The launch is a white sand beach that goes to a wide expanse of slimy mud at low tide. Launching at tide levels over +2&#x27; is fine. Wind blows from the west in the afternoons and this spot then becomes a favorite of windsurfers. There will be wind chop but no swell. Currents are negligible here but are strong just to the east in the shipping channel. Watching out for ships and ferries. Paddle to McNears or China Camp or up the San Rafael Canal to Pier 15 or to the east bay. Lots of choices.</p>
      <p><b>Parking: </b>Free parking right next to the beach. Overnight parking does not seem to be prohibited.</p>
      <p><b>Facilities: </b>No facilities. the Bay Cafe &#x28;in the same parking lot&#x29; is open 6:30AM-5:30PM. There is a porta potty sometimes maintained.</p>
      <p><b>Address: </b>Located at Bay Park Business Center just NW of the San Rafael Bridge.</p>
      <p><img class="details_img" src="images/starkwthr-c1.jpg" height="200" width="400">
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Starkweather_Park_San_Rafael.jpg" height="298" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20Starkweather%20Park,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="destination" xid="16" title="Pier 15 Restaurant and Bar, San Rafael" zone="530" modtime="1526269570545" modby="bask0099" chart_title="Pier 15 Bar" >
  <marker lat="37.965944" lng="-122.5135"/>
  <tide_station>142</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>Restaurant has a small concrete ramp and serves good food at reasonable prices. There is also a dock that looks like it could sink any minute. The restaurant is located in very protected water in a small yacht harbor just off the canal on the south side.</p>
      <p><b>Parking: </b>Parking very limited to non-existent. Come by boat. Forget trying to find parking although they do have valet service.</p>
      <p><b>Facilities: </b>Restaurant with bathrooms inside for customers.</p>
      <p><b>Address: </b>15 Harbor St on the San Rafael Canal</p>
      <p><b>Contact Info: </b>Pier 15 Restaurant, 415-256-9121</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.pierfifteen.com">http://www.pierfifteen.com</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Pier%2015%20ramp%20at%200%20tide.JPG" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/Pier15Ramp+4.2ft.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at +4.2 ft tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="17" title="Highway 101 Bridge (SE side)" zone="530" modtime="1526076060552" modby="bask0099" chart_title="Hwy 101 Bridge" >
  <marker lat="37.882083" lng="-122.516389"/>
  <tide_station>367</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide launch. Good for exploration of upper Richardson Bay &#x28;maybe lunch at the Dipsea Cafe&#x29; or the Sausalito waterfront. Be sure to get back before low tide or else run a shuttle.</p>
      <p><b>Parking: </b>Abundant free parking under the bridge and next to water. There are about 25 spaces. there are no apparent time restrictions, including overnight.</p>
      <p><b>Facilities: </b>No facilities.</p>
      <p><b>Address: </b>Stinson exit from 101 North to Pohono Ave to Bolinas Ave to end</p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Hwy_101_Bridge,_Richardson_Bay,.jpg" height="299" width="400" >
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/editor_uploads/details/1526076060552-17-bask0099.jpg" height="268" width="400" >
      <br><span class='details_caption'>Richardson Bay under the 101 bridge, high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='18' title="Jedediah Smith State Park" chart_title="Jedediah Smith SP" >
    <marker lat="  41.80268" lng="-124.08616"/>
    <city>Crescent_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Take-out point for float trips on the Smith River. California State Park with day use area and campground.
        <p><b> Parking: </b>Use fees.
        <p><b> Facilities: </b>Restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='19' title="Smith River access">
    <marker lat="  41.82246" lng="-124.10963"/>
    <city>Crescent_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Take out/put in on the Smith River.  Off of North Bank Road, Ginny Lane from Tan Oak Drive.
        <p><b> Parking: </b>Parking on dirt or riverbed. No fees, no security.
        <p><b> Facilities: </b> None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='20' title="Samoa Boat Ramp" zone="450">
    <marker lat="40.7673" lng="-124.2241"/>
    <tide_station>341</tide_station>
    <city>Eureka</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available.
        <p><b> Parking: </b>Free day use.
        <p><b> Facilities: </b>Restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='21' title="Fields Landing Boat Ramp" zone="450" chart_title="Fields Landing" >
    <marker lat="40.7256" lng="-124.2236"/>
    <tide_station>131</tide_station>
    <city>Eureka</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Convenient to Eureka, the Fields Landing Boat Ramp is an excellent access to
        the southern portion of Humboldt Bay.  By way of the Fields Landing Channel,
        which is dredged to approximately 30 feet depth, the harbor entrance can be
        reached by boats of any size.<p>
        <p>At low tide, the southern part of
        Humboldt Bay can be little more than mud flats--be sure to check tide tables
        and know the locations of the main channels.  Use caution if approaching the
        main channel, swells and tidal currents can cause turbulence in this area.
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>Boat launch. Picnic area
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="22" title="Caspar Beach" zone="455" modtime="1670647544551" modby="petolino" edits_since="0" >
  <marker lat="39.361" lng="-123.81769"/>
  <tide_station>253</tide_station>
  <city>Mendocino</city>
  <details><![CDATA[
      <p><b>Overview: </b>Caspar is a sheltered, sandy beach. It&#x27;s a great place for kayak surfing when swells are too big to explore sea caves, or a nice launch or take-out spot on day trips along the Mendocino coast.</p>
      <p><b>Parking: </b>Free parking along the road.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Caspar-Beach-Surf-Report/4630/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="23" title="Russian Gulch" zone="455" modtime="1670647649998" modby="petolino" edits_since="0" >
  <marker lat="39.32906" lng="-123.80604"/>
  <tide_station>216</tide_station>
  <city>Mendocino</city>
  <details><![CDATA[
      <p><b>Overview: </b>Russian Gulch is in a sheltered cove with a sandy beach. It&#x27;s a great launch place to explore the sea caves north towards the Pt. Cabrillo Lighthouse or south towards Mendocino.</p>
      <p><b>Parking: </b>State Park day use or camping fee.</p>
      <p><b>Facilities: </b>State Park campground and day use area. Restrooms.</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Russian-Gulch-Surf-Report/7631/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="24" title="Big River" zone="455" modtime="1670647928227" modby="petolino" edits_since="0" >
  <marker lat="39.30239" lng="-123.78757"/>
  <tide_station>216</tide_station>
  <city>Mendocino</city>
  <details><![CDATA[
      <p><b>Overview: </b>Access to the Big River for a flat water paddle, and to Mendocino Bay. Conditions at the mouth of the Big River can be dangerous, especially on an ebb.</p>
      <p><b>Parking: </b>Plenty of free parking.</p>
      <p><b>Facilities: </b>Restrooms.</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Mendocino-Headlands-Surf-Report/7632/">Magic Seaweed Surf Report &#x28;Mendocino Headlands&#x29;</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid='25' title="Van Damme State Park" zone="455" chart_title="Van Damme SP" >
    <marker lat="39.27331" lng="-123.79168"/>
    <tide_station>216</tide_station>
    <city>Mendocino</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Van Damme beach is a great place to launch for exploring sea caves along the Mendocino coast or to go diving. 
        The beach is somewhat sheltered from northwest swells and has easy access.
        <p><b> Parking: </b>Plenty of free parking. 
        <p><b> Facilities: </b>Restrooms. Van Damme State Park campground is just across the highway.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='26' title="Navarro River, Hendy Woods" chart_title="Hendy Woods" >
    <marker lat="39.08573" lng="-123.48509"/>
    <city>Navarro</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Put-in for a wet season float downstream (Class I-II). A whitewater run is also possible from upstream.
        <p><b> Links: </b><a href="http://www.cacreeks.com/navarro.htm" target="tp_details">California Creeks - Navarro River to Dimmick State Park</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='27' title="Navarro River, Dimmick Memorial Grove" zone='455' chart_title="Dimmick Grove" >
    <marker lat="39.17804" lng="-123.69443"/>
    <tide_station>216</tide_station>
    <city>Navarro</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Take-out for a wet season float downstream (Class I-II) from Hendy Woods State Park.
        <p><b> Links: </b><a href="http://www.cacreeks.com/navarro.htm" target="tp_details">California Creeks - Navarro River to Dimmick State Park</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='28' title="Little River, Albion" zone="455" chart_title="Little River" >
    <marker lat="39.2266" lng="-123.7667"/>
    <tide_station>216</tide_station>
    <city>Albion</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Paddle upstream to explorer the river, or out to the ocean. Albion Cove Cove has a
        rocky bottom and full of rock crab. 35/day limit, 5inches or larger, fishing license required. Learn the difference between males and females, 
        release the females because they spawn thousands of eggs each year and that's next year's crab.
        <p><b> Parking: </b>$10 day use and launch fee combined 
        <p><b> Facilities: </b>Restrooms. Hamburger, Chilli, and crab chowder bar. Boat ramp.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='29' title="Albion River" zone="455">
    <marker lat="39.2312" lng="-123.7613"/>
    <tide_station>216</tide_station>
    <city>Albion</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Explore the Albion River or venture out into the Pacific. 
        Mouth of the harbor is rock bottom with Rock
        Crabs a plenty!  Fishing license required, 35 per day limit, 5 inches or
        larger.  Just as sweet as Dungeness only less meat per crab and a little
        more work to get at it.  "When it's good, it should cause you to sweat to
        get to it"  Please learn the difference between males and females, release
        the females, they supply the population for the next year.
        <p><b> Parking: </b>$10 launch fee 
        <p><b> Facilities: </b>Launch ramp, lunch counter, restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='30' title="Navarro State Beach" zone="455">
    <marker lat="39.18972" lng="-123.75866"/>
    <tide_station>216</tide_station>
    <city>Navarro</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Wide sandy beach at the mouth of the Navarro River. Somewhat exposed. Good launch spot for one way trips south to Elk.
        <p><b> Parking: </b>Plenty of free parking. 
        <p><b> Facilities: </b>Restrooms. Camping.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="31" title="McAvoy Yacht Harbor" zone="530" modtime="1528077307526" modby="petolino" edits_since="1527968910949" >
  <marker lat="38.040167" lng="-121.960556"/>
  <tide_station>307</tide_station>
  <city>Bay_Point</city>
  <details><![CDATA[
      <p><b>Overview: </b>This private marina has a launch ramp and charges &#x24;10 if you drive to the ramp. Kayaks are usually allowed to launch for free if boats are carried to the ramp. Check at the bait shop to see about fees and to let them know how long you&#x27;ll be there.</p>
      <p><b>Parking: </b>Free if you launch there or are eating at the Caf&#xE9;.</p>
      <p><b>Facilities: </b>There is the Lost Anchor Bait Shop &#x28;Hours: M-F, 6-10AM and S/S, 6AM-6PM&#x29; and Big Daddy Ross&#x27;s Caf&#xE9; &#x28;hours: 7AM-2PM, closed Mon and Tues&#x29;. There are bathrooms by the caf&#xE9;.</p>
      <p><b>Address: </b>1001 McAvoy Rd in Bay Point</p>
      <p><b>Contact Info: </b>Marina office, 925-458-2568<br>Bait shop, 925-458-1717<br>Cafe, 925-709-1357</p>
      <p><img class="details_img" src="images/mcavoy-mar.jpg" height="299" width="400">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527968910949-31-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McAvoy ramp at a negative tide, 6-1-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527968910950-31-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McAvoy Yacht Harbor sign</span>
  ]]></details>
</station>
  <station station_type="launch" xid="32" title="Bay Point Regional Shoreline Park" zone="530" modtime="1625612176600" modby="bask0099" edits_since="1617378746403" chart_title="Bay Point Park" >
  <marker lat="38.039667" lng="-121.963194"/>
  <tide_station>4</tide_station>
  <city>Bay_Point</city>
  <details><![CDATA[
      <p><b>Overview: </b>East Bay Regional Parks has recently installed a kayak/canoe launch dock. It is about 1000&#x27; from the parking lot so bring wheels. Do not even think of coming here at anything but high tide. At a 1&#x27; tide there is only about 3&#x22; of water. Right next door at McAvoy Harbor there is a nice launch ramp. When you come here think birds and bring binoculars. The slough is about 1/2 mile long and J shaped. If you paddle out to the Strait be prepared for wind and possibly strong currents both ebbing and flooding. It is 8 miles to Martinez and about the same to Big Break. From here go northeast to explore Chipps Island and Spoonbill Creek or east to Pittsburg Marina. It&#x27;s about 10 miles west to Martinez for a longer trip.</p>
      <p><b>Parking: </b>Free. Hours are 8AM-5PM but they leave the exit gate open until 10PM. Curfew is 10PM-5AM. There are 12 spaces.</p>
      <p><b>Facilities: </b>Park has an ADA bathroom that is clean and well maintained. There are 9 picnic tables and 2 BBQs. No water.<br>Two of the picnic tables are under a roof.</p>
      <p><b>Address: </b>1001 McAvoy Rd in Bay Point</p>
      <p><b>Contact Info: </b>East Bay Regional Park District, Public Affairs, 510-544-2200.</p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Bay%20Point%20launch.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526963000474-32-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Point at high tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606687641453-32-bask0099.jpg" height="400" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Point dock up close, 11-2020</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606687641454-32-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bay Point dock</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1617233282584-32-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>dock at low tide, 2</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1625612176600-32-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Modified railing, 7-6-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1625612176601-32-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>modified launch, 7-6-21</span>
  ]]></details>
</station>
  
  <station station_type="launch" xid="34" station_class="water_trail" title="Big Break Regional Shoreline Park" zone="530" modtime="1526615650324" modby="bask0099" chart_title="Big Break Park" >
  <marker lat="38.012057" lng="-121.728771"/>
  <tide_station>13</tide_station>
  <city>Oakley</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is THE place to start explorations of Big Break or to head downriver to Antioch or north to Sherman Island or east into the delta. Park hours &#x28;i.e. gates are open&#x29; are 8AM-6PM with curfew from 10PM-5AM. In winter migrating birds abound. Bring binoculars. The kayak launch is a little keyhole beach that is usable at all tides but sometimes is plagued with water hyacinths.</p>
      <p><b>Parking: </b>Free parking but lot is about 1/4 mile from the put-in. Bring wheels or borrow some from the Visitor Center.</p>
      <p><b>Facilities: </b>Restrooms, water, picnic area, wonderful visitor center &#x28;hours 10AM-6PM&#x29;. There is a great big, on the ground, relief map of the Delta. This alone is worth the trip. There are ranger led kayak trips here.</p>
      <p><b>Address: </b>69 Big Break Road, Oakley, CA 94561</p>
      <p><b>Contact Info: </b>Visitor Center, 510-544-3050 or<br>East Bay Regional Park District, 1888-327-2757, Option 3, x4525</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/big_break">East bay parks, Big Break</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/big-break-regional-shoreline/">Bay Area Water Trail - Big Break</a></p>
      <p><img class="details_img" src="images/big-break.jpg" height="299" width="400">
      <br><span class='details_caption'>High tide</span>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Big%20Break%20launch.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526399294189-34-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Big Break, June, 2013</span>
  ]]></details>
</station>
  <station station_type="destination" xid="35" title="Rodeo, Lone Tree Beach Park" zone="530" modtime="1527738998820" modby="petolino" edits_since="1527650532654" chart_title="Lone Tree Beach" >
  <marker lat="38.03675" lng="-122.274333"/>
  <tide_station>284</tide_station>
  <city>Rodeo</city>
  <details><![CDATA[
      <p><b>Overview: </b>Beautiful sand beach is accessible at all tides. It is also protected from the summer winds by a little point &#x28;Lone Tree Point&#x29; that sticks out just to the southwest.</p>
      <p><b>Parking: </b>There is a parking lot for this site but it is so far from the beach &#x28;1/3 mile&#x29; that you are better off paddling here from someplace else. There is no car access to the beach itself.</p>
      <p><b>Facilities: </b>Picnic table. Maybe a porta potty</p>
      <p><b>Address: </b>Located at the end of Pacific Ave in Rodeo just south of Rodeo Marina.</p>
      <p><b>Contact Info: </b>East Bay Regional Parks, 510-562-PARK &#x28;510-562-7275&#x29;</p>
      <p><img class="details_img" src="images/lonetree-pk1.jpg" height="267" width="400">
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Lone%20Tree%20Beach%20in%20Rodeo.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Lone%20Tree%20at%207+'%20tide,%201-2-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527650532654-35-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lone Tree Beach,</span>
  ]]></details>
</station>
  <station station_type="destination" xid="36" title="Point Pinole Regional Shoreline Park" zone="530" modtime="1625612777339" modby="bask0099" edits_since="1625362359676" chart_title="Point Pinole Park" >
  <marker lat="38.01025" lng="-122.363611"/>
  <tide_station>284</tide_station>
  <city>Pinole</city>
  <details><![CDATA[
      <p><b>Overview: </b>Kayak camping here&#x21; There is a great deal of mud here at less than high tide. The best lowish tide landing is right by the old pier. This spot has sand that goes to mud at low tide. The closest landing to the campsite is just north of it beside some eucalyptus trees &#x28;high tide only&#x29;. Park curfew is 10PM-5AM. If you are camping and come by car be there by 4PM. The wind howls here on summer afternoons. Expect a wild ride. EBRPD is &#x28;summer 2021&#x29; building a ramp to the water for kayak access. It is just north of the fishing pier.</p>
      <p><b>Parking: </b>The parking lot and entry kiosk is 1 mile from the campsite and beach. With a camping reservation, 4 cars can be parked at the campsite and 3 in the main lot are OK overnight. If you want to leave a car in the parking lot overnight &#x28;say, while you are on a multi-day trip&#x29; call and let the ranger know. Parking costs &#x24;3/car/day on weekends April-October.</p>
      <p><b>Facilities: </b>Bathrooms, running water, fishing pier, picnic tables and campsite. The campsite has water, an outdoor shower. shelter, picnic tables, BBQ, and is protected from the wind. There is a grassy area for tents. The campsite is for groups and is quite private. It costs &#x24;75/night plus a &#x24;75 security deposit and an &#x24;8 processing fee.</p>
      <p><b>Address: </b>3000 Atlas Rd or 5551 Giant Highway. Both come to the same place.</p>
      <p><b>Contact Info: </b>Group campsite reservation, 888-327-2757<br>Park office, 510-544-3063</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/pt_pinole">http://www.ebparks.org/parks/pt_pinole</a></p>
      <p><img class="details_img" src="images/pt-pinole1.jpg" height="278" width="400">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527097705569-36-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Point Pinole, high tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527097705570-36-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Point Pinole, high tide near the campsite</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527793160858-36-bask0099.jpg" height="293" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Campsite</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1625350342396-36-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>beach with new path</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1625350342397-36-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Top of new path</span>
  ]]></details>
</station>
  <station station_type="launch" xid='37' title="Elk" zone="455">
    <marker lat="39.12888" lng="-123.71824"/>
    <tide_station>216</tide_station>
    <city>Elk</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Elk has some great rock gardening, especially to the north. The beach usually has moderate surf, but it can be dumpy. It's a long way from the parking lot down to the beach and back uphill after the paddle - bring wheels!
        <p><b> Parking: </b>Free parking. 
        <p><b> Facilities: </b>Restrooms near the parking lot and on the way down to the beach.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='38' title="Rancheria Creek">
    <marker lat="38.9937" lng="-123.435"/>
    <city>Boonville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Rancheria Creek put in. Class1 and 2 run. Generally not navigable until after a rain
        <p><b> Links: </b><a href="http://www.cacreeks.com/ranchria.htm" target="tp_details">California Creeks - Rancheria Creek and Upper Navarro River</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='39' title="Fort Ross" zone="540">
    <marker lat="38.51207" lng="-123.24314"/>
    <tide_station>137</tide_station>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Fort Ross is a State Historic Park. The beach is in a very protected cove. 
        It is a great launch spot for exploring the Sonoma Coast or to play on the reef
        just south of the cove. 
        <p><b> Parking: </b>You can drive down the road towards the beach for unloading 
        your boat, but you have to park in the upper parking lot. State Park entrance fee. 
        <p><b> Facilities: </b>Restrooms are near the main parking lot at the visitor's center.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='40' title="Stillwater Cove" zone="540">
    <marker lat="38.54709" lng="-123.29748"/>
    <tide_station>137</tide_station>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Stillwater Cove provides a relatively protected launch beach for paddling along the Sonoma coast. 
        <p><b> Parking: </b>Free parking. Unload your boat in the loading zone, and then park your car 
        off the road on top of the bluff to the south. Obey the "No parking between sunset and sunrise" signs, or parking might not be free. 
        <p><b> Facilities: </b>Restrooms along the trail to the beach.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='41' title="Salt Point State Park" zone="540" chart_title="Salt Point SP" >
    <marker lat="38.56741" lng="-123.33040"/>
    <tide_station>137</tide_station>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The Salt Point cove is very protected from the northwest swells. There is not much of a beach though 
        and your launch or landing might be over rocky ground.
        <p><b> Parking: </b>State Park day use or camping fee.
        <p><b> Facilities: </b>Restrooms, visitors center, campground.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='42' title="Stump Beach" zone="540">
    <marker lat="38.58157" lng="-123.33580"/>
    <tide_station>137</tide_station>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Stump beach is a good launch spot for exploring the Sonoma coast. It is relatively protected, 
        but it is open to northwest swells. It's a long carry from the parking area to the beach, so check conditions 
        first before hauling the boat. 
        <p><b> Parking: </b>Plenty of free parking.
        <p><b> Facilities: </b>Restrooms at the parking lot.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='43' title="Yorti Creek Recreational Area, Lake Sonoma" chart_title="Yorti Creek" >
    <marker lat="38.77225" lng="-123.07492"/>
    <city>Cloverdale</city>
    <details>
      <![CDATA[<p><b>Overview: </b> Nice, protected, lake paddling. Sometimes, it even has warm water! Can get crowded in the summer.
        It provides access to boat-in camping on Lake Sonoma. 
        <p><b> Parking: </b>Free parking. $3 launch fee ($1.50 with Golden Eagle Pass).
        <p><b> Facilities: </b>Restrooms, picnic tables.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='44' title="Lake Sonoma">
    <marker lat="38.71494" lng="-123.01834"/>
    <city>Cloverdale</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Another free launch site on Lake Sonoma, but it has a steep grade, and a long walk to the car.
        <p><b> Parking: </b>No information currently available.
        <p><b> Facilities: </b>No information currently available.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='45' title="Lake Sonoma Marina">
    <marker lat="38.70769" lng="-123.01858"/>
    <city>Cloverdale</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This launch site requires a launch fee, and has lot's of power boats. 
        Consider launching from Yorty Creek instead.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='46' title="Cloverdale">
    <marker lat="38.80892" lng="-123.00699"/>
    <city>Cloverdale</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='47' title="Geyserville">
    <marker lat="38.71169" lng="-122.89593"/>
    <city>Geyserville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='48' title="Healdsburg, Alexander Valley Campground" chart_title="Alexander Valley Campground" >
    <marker lat="38.659321" lng="-122.83303"/>
    <city>Healdsburg</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Launch fee $10/boat.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='49' title="Healdsburg, Veterans Memorial Beach" chart_title="Veterans Memorial Beach" >
    <marker lat="38.60440" lng="-122.85960"/>
    <city>Healdsburg</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available.
        <p><b> Parking: </b>Fee.
        <p><b> Facilities: </b>Picnic tables.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='50' title="Forestville, Steelhead Beach" chart_title="Steelhead Beach" >
    <marker lat="38.50008" lng="-122.89995"/>
    <city>Forestville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='51' title="Guerneville, Johnson's Beach" chart_title="Johnson&#39;s Beach" >
    <marker lat="38.50007" lng="-122.99809"/>
    <city>Guerneville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='52' title="Monte Rio Beach">
    <marker lat="38.46681" lng="-123.00986"/>
    <city>Guerneville</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='53' title="Casini Ranch Campground, Duncans Mills" chart_title="Casini Ranch Campground" >
    <marker lat="38.46357" lng="-123.05117"/>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='54' title="Goat Rock, Jenner" zone="540" chart_title="Goat Rock" >
    <marker lat="38.44079" lng="-123.12522"/>
    <tide_station>137</tide_station>
    <city>Jenner</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This is a good launch and landing spot in the Jenner area. Great rock gardening north of Jenner. 
        The most protected launch is from the beach just south of the parking lot. Getting there involves some scrambling over the rocks.
        <p><b>Parking: </b> Free parking.
        <p><b>Facilities: </b>Restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='55' title="Spring Lake County Park, Santa Rosa" chart_title="Spring Lake Park" >
    <marker lat="38.4516" lng="-122.6597"/>
    <city>Santa_Rosa</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
        <p><b>Parking: </b> $6 day use fee. No launch fee.
        <p><b>Facilities: </b>Restrooms, Picnic area
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='56' title="Fountaingrove Lake, Nagasawa Community Park" chart_title="Nagasawa Park" >
    <marker lat="38.4852" lng="-122.7171"/>
    <city>Santa_Rosa</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Small (60-80 acre) lake, protected clear water, no entrance/parking/launching fee.
        <p><b>Parking: </b> Free! No launch fee.
        <p><b>Facilities: </b>restroom, picnic tables, barbeque stands
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="57" title="Bodega Bay, Doran Beach and Campground" zone="540" chart_title="Doran Beach" modtime="1670616751790" modby="petolino" edits_since="1530747124273" >
  <marker lat="38.31345" lng="-123.0476"/>
  <tide_station>41</tide_station>
  <city>Bodega_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>Doran beach is protected from northwest swells and provides access to Bodega Bay and the open coast around Bodega Head. There is a launch ramp that puts you inside the harbor. It has plenty of parking and a boat rinse station &#x28;water faucet but no hose&#x29;. There are numerous places that one can launch from the beach &#x28;oceanside&#x29;. Basically the surf is non-existent on the west end of the beach and increases as you go east. The best put-in is at the Jetty Day Use Area which is at the furthest west point of the park. The carry from the car to the beach is about 30 feet and the site is protected from both wind and swell.</p>
      <p><b>Parking: </b>Day use fee &#x24;7 per vehicle &#x28;with 9 people or less&#x29;. Park is open from 7AM to Sunset.</p>
      <p><b>Facilities: </b>Restrooms, picnic area, campground. The Miwok camp area is right across the road from the launch ramp and is for tent camping only. Bathrooms at the camping areas have showers. Camping is &#x24;35/night. That includes two cars and 9 people</p>
      <p><b>Address: </b>201 Doran Beach Rd. in Bodega Bay</p>
      <p><b>Contact Info: </b>Sonoma County Regional Parks, 707-565-2041<br>Ranger Station, 707-875-3540<br>Camping reservations, 707-565-2267</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Doran-Beach-Surf-Report/8057/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530747124273-57-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Doran Beach Park, ramp, 7-3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530747124274-57-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Doran beach at 4.2&#x27; tide, 7-3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530747124275-57-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>doran beach at jetty end, 4.2&#x27; tide, 7-3-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="58" title="Westside Regional Park Campground in Bodega Harbor." zone="540" modtime="1530749021319" modby="bask0099" edits_since="0" chart_title="Westside Regional" >
  <marker lat="38.32299" lng="-123.054922"/>
  <tide_station>41</tide_station>
  <city>Bodega_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>Access to protected Bodega Bay Harbor. There are two adjacent areas here--the campground &#x28;&#x24;35/night&#x29; and the boat launch area. The campground looks to be mostly RVs but the host says that tent camping is OK. The other area is a huge parking lot and launch ramp. Beside the ramp is a small gravel beach perfect for kayaks and there is also an ADA, E-Z Port, kayak launch on the dock. There is a staging area by the ramp.</p>
      <p><b>Parking: </b>Day use fee &#x24;7 per vehicle. Pay at the iron ranger beside the ramp. Parking area sign says open from 5:30AM to sunset. There is parking for at least 100 cars. It may be possible to leave a car overnight &#x28;while one is expeditioning to Tomales for example&#x29;. Check in with the campground host so they know.</p>
      <p><b>Facilities: </b>Bathrooms, campground. There is a boat rinse station at the launch ramp with water but no hose &#x28;BYO&#x29;. The bathroom in the campground has showers. There is a picnic table by the ramp.</p>
      <p><b>Address: </b>2400 Westshore Rd. in Bodega Harbor</p>
      <p><b>Contact Info: </b>Sonoma County Regional Parks, 707-565-2041<br>Ranger Station, 707-875-3540<br>Reservations, 707-565-2267</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sonomacountyparks.org">http://www.sonomacountyparks.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530749021319-58-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>WEstside Park, ADA kayak launch, 7-3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530749021320-58-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westside Park, gravel kayak launch, 4.7&#x27; tide, 7-3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530749021321-58-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westside Park, ramp, bodega, 7-3-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="59" title="Bodega Bay, Campbell Cove" zone="540" modtime="1530747646225" modby="bask0099" edits_since="0" chart_title="Campbell Cove" >
  <marker lat="38.30502" lng="-123.05717"/>
  <tide_station>41</tide_station>
  <city>Bodega_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>Very protected launch, but can get muddy at low tide. The launch is a small, east facing, white sand beach. The path from the parking lot is about 100yds. It is not maintained and is steep and narrow in places. Although very protected it gets big fast when you head south.</p>
      <p><b>Parking: </b>About 30 parking spaces and it is free. Open sunrise to sunset.</p>
      <p><b>Facilities: </b>Pit toilet. One stall. No water. Couple picnic tables</p>
      <p><b>Address: </b>End of Westshore Rd in Bodega Harbor</p>
      <p><b>Contact Info: </b>Sonoma Coast State Beach</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530747646225-59-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Campbell Cove beach, 4.7&#x27; tide, 7-3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530747646226-59-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Campbell cove path, 7-3-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="60" station_class="water_trail" title="Petaluma Municipal Marina" zone="530" modtime="1606696144149" modby="petolino" edits_since="1605568274084" chart_title="Petaluma Marina" >
  <marker lat="38.23169" lng="-122.61465"/>
  <tide_station>429</tide_station>
  <city>Petaluma</city>
  <details><![CDATA[
      <p><b>Overview: </b>Petaluma City Marina. The former harbormasters are gone and the City Dept of Public Works is now in charge. They are seldom there. There is a free launch ramp with a high dock.</p>
      <p><b>Parking: </b>Plenty of free parking with a 72 hour limit, especially for trailered boats</p>
      <p><b>Facilities: </b>Restrooms are open daily during business hours &#x28;12N-4PM&#x29;. Kayak storage on a locked dock is available for &#x24;110/quarter. Call 707-778-4489 for info. After hours, 707-778-4303</p>
      <p><b>Address: </b>781 Baywood Dr., Petaluma</p>
      <p><b>Contact Info: </b>City of Petaluma Public Works, 707-778-4489</p>
      <p><b>Links: </b><a target="tp_details" href="https://cityofpetaluma.org/marina/">Petaluma Marina</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/petaluma-marina/">Bay Area Water Trail - Petaluma Marina</a></p>
      <p><img class="details_img" src="images/Sonoma,%20Zero%20Tide/Petaluma%20Marina%20ramp.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525922670747-60-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Petaluma Marina kayak storage, 2018</span>
  ]]></details>
</station>
<station station_type="launch" xid="61" station_class="water_trail" title="Petaluma River Turning Basin" modtime="1605567820569" modby="bask0099" edits_since="1525923214885" chart_title="Petaluma Turning Basin" >
  <marker lat="38.23433" lng="-122.6396"/>
  <tide_station>429</tide_station>
  <city>Petaluma</city>
  <details><![CDATA[
      <p><b>Overview: </b>Petaluma city guest dock which can be accessed from either the parking lot of the River Plaza Shopping Center &#x28;2 hour limit&#x29; or from Weller St. The dock is a high dock. A kayak/canoe rental facility is planned for this dock in the future</p>
      <p><b>Parking: </b>Ample free parking at River Plaza shopping center on E. Washington Blvd. Park on the street on Weller or at 3 spots by the dock but signs also say 2 hour parking, 7-6PM Mon.-Fri.</p>
      <p><b>Facilities: </b>There are no public facilities but there are many restaurants, pubs and coffee shops right in the immediate vicinity. The Weller St. gangway has a loading area, the shopping center parking lot does not.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/petaluma-river-turning-basin/">Bay Area Water Trail - Petaluma River Turning Basin</a></p>
      <p><img class="details_img" src="images/Sonoma,%20Zero%20Tide/Petaluma%20turning%20basin.JPG" height="298" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605567820569-61-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Petaluma turning basin PSACC dock, 11-16-2020</span>
  ]]></details>
</station>
<station station_type="launch" xid="62" title="Gilardi&apos;s Lakeville Marina" zone="530" modtime="1527793441418" modby="bask0099" edits_since="1525992320239" chart_title="Gilardi&#39;s Marina" >
  <marker lat="38.19756" lng="-122.54751"/>
  <tide_station>197</tide_station>
  <city>Petaluma</city>
  <details><![CDATA[
      <p><b>Overview: </b>Private property. Concrete ramp with mud at the bottom. this funky little spot is still owned by the Gilardi family and is undergoing MAJOR renovations &#x28;May 2018&#x29;. Kayakers are still welcome. The docks are private and should not be used. The restaurant is being torn down.</p>
      <p><b>Parking: </b>&#x24;2 Fee to launch and park. Put the money in the mail slot in the shack next to the porta potty. Hours are not posted.</p>
      <p><b>Facilities: </b>1 porta pottie. Condition questionable. A little picnic area but no other facilities.</p>
      <p><b>Address: </b>5688 Lakeville Highway. Look for the big Papa&#x27;s Taverna sign.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525992320239-62-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Gilardis Ramp, 4&#x27; tide, 5-10-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525992320240-62-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Gilardi&#x27;s Marina 0Tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="63" station_class="water_trail" title="Black Point Boat Launch" zone="530" modtime="1525991614996" modby="bask0099" chart_title="Black Point" >
  <marker lat="38.11416" lng="-122.50623"/>
  <tide_station>281</tide_station>
  <city>Novato</city>
  <details><![CDATA[
      <p><b>Overview: </b>Ramp and dock with high float. There is a picnic area that you can practically paddle right into. The Petaluma River is actually a slough and is tidal. It is 12 miles to Petaluma, 6 miles to Lakeville Marina and 1 1/2 miles down river to the Bay.</p>
      <p><b>Parking: </b>&#x24;5 fee for parking. Hours are dawn to dusk with no overnight parking allowed. Pay at the iron ranger in the parking lot. There are spaces for 8 cars at the ramp and another 20 in a paved lot across the street. Also a couple &#x28;free&#x29; dirt spots on the road.</p>
      <p><b>Facilities: </b>Bathrooms, picnic tables and running water. Rossi&#x27;s Rossi&#x27;s Deli is nearby in case you forgot lunch.</p>
      <p><b>Address: </b>Under the Highway 37 bridge &#x28;south side&#x29; over the Petaluma River.
      <p><b>Contact Info: </b>Site is managed by Marin County Parks. Main office: 415-473-6387 and Field Office: 415-473-6407.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/black-point-boat-launch/">Bay Area Water Trail - Black Point Boat Launch</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Black_Point_0Tide.jpg">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525991614996-63-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>black Point picnic area from dock, 5-10-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525991614997-63-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Black Point at high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='64' title="Sears Point Boat Launch" zone='530' chart_title="Sears Point" >
    <marker lat="38.1275" lng="-122.47143"/>
    <tide_station>281</tide_station>
    <city>Novato</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Public Shore. Gravel launch to San Pablo Bay via mud flats. <b>Warning:</b> verify tide height for Petaluma River Entrance Tide Station is greater than 2 ft when launching or landing.
        <p><b>Address: </b>Reclamation Rd, South of intersection of Lakeville Rd and Hwy 37.
        <p><b>Parking: </b>Free parking at trailhead lot. 0.25 mile walk, cross RR track to launch
        <p><b>Facilities: </b>Porta potty, trail map.
		  <p><img class='details_img' src="images/new/SearsPt1.jpg" alt="Sears Point"/>
		  <p>Trailhead parking lot
		  <p><img class='details_img' src="images/new/SearsPt2.jpg" alt="Sears Point"/>
		  <p>High Tide
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="65" title="Sonoma Creek at the Hwy 37 Bridge" zone="530" modtime="1527967550025" modby="bask0099" edits_since="0" chart_title="Sonoma Creek" >
  <marker lat="38.15608" lng="-122.40622"/>
  <tide_station>389</tide_station>
  <city>Vallejo</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public shore. Access is from the west bound highway only. It is 360 yards or 0.20 mile to the river so bring your kayak wheels. When heading to the river from the parking lot do not take the left hand, flat, paved path labeled Wildlife Viewing. No oh no. Instead take the right hand abandoned road and go to the end. Turn right along a dirt path to where the fisherpeople have made a trail down to the floodplain just north of the power tower. Here is a side creek that is a pretty easy launch. Or walk &#x28;you did bring your wheels didn&#x27;t you&#x29; to the shore of Sonoma Creek. Why would anyone put up with so much hassle&#x3F; 8 miles to Black Point, 14 miles to Vallejo, 7 miles to the Sears Point Boat Launch, 6.5 miles to Hudeman Slough. There&#x27;s a lot to see to and from any of these places. This is a central location and the paddling is good. Note: duck hunting season is October to February.</p>
      <p><b>Parking: </b>Free parking for about 12 cars. Hide your valuables &#x28;lots of broken glass&#x29;.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Address: </b>Westbound Hwy 37 just before the bridge over Sonoma Creek. Turnoff says Vista Point.</p>
      <p><b>Contact Info: </b>Site managed by Fish and Wildlife Service, 707-769-4200</p>
      <p><img class="details_img" src="images/Sonoma,%20Zero%20Tide/Sonoma%20Creek%20at%20Hwy%2037.JPG" height="299" width="400">
      <br><span class='details_caption'>Sonoma Creek at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527967550025-65-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Access Path to Sonoma Creek at Hwy 37 +3.5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527967550026-65-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Side creek at low tide. Note power tower landmark</span>
  ]]></details>
</station>  <station station_type="launch" xid="66" title="Cullinan Ranch" zone="530" modtime="1526344013470" modby="bask0099" >
  <marker lat="38.13599" lng="-122.34426"/>
  <tide_station>389</tide_station>
  <city>Mare Island</city>
  <details><![CDATA[
      <p><b>Overview: </b>Levee breached in December 2014. This is a large restored wetland. There are no tides or currents except at the breaches in the levees. There is an ADA kayak launch at the SW corner by the highway &#x28;for launching&#x29; and a gravel ramp at the NW corner &#x28;destination only&#x29;. There are lots of birds but otherwise it is pretty boring.</p>
      <p><b>Parking: </b>Limited to 8 cars. Access is from west bound highway 37 only.</p>
      <p><b>Facilities: </b>Porta potty.</p>
      <p><b>Contact Info: </b>SF Bay NWR Complex, 707-769-4200</p>
      <p><img class="details_img" src="images/new/CullinanRanch.jpg" height="299" width="400">
      <br><span class='details_caption'>Kayak dock Cullinan Ranch &#x28;launch&#x29;</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526344013470-66-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cullinan Ranch launch ramp &#x28;destination&#x29;</span>
  ]]></details>
</station>
  <station station_type="launch" xid='67' title="Lake Hennessey" zone='530' >
    <marker lat="38.4834" lng="-122.3576"/>
    <city>Napa</city>
    <details>
      <![CDATA[<p><b>Overview: </b>$4 launch fee, $25 yearly pass available at the City of Napa Water Division Headquarters at 1340 Clay Street in Napa.  Picnic tables, no open fires.  
        <p><b>Parking: </b>Free
        <p><b>Facilities: </b>Restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="68" title="Green Island Road, American Canyon" zone="530" modtime="1539549603253" modby="bask0099" edits_since="1526615728966" chart_title="Green Island Road" >
  <marker lat="38.201867" lng="-122.304567"/>
  <tide_station>109</tide_station>
  <city>American_Canyon</city>
  <details><![CDATA[
      <p><b>Overview: </b>Gated, open sunrise to sunset. One concrete launch ramp and one rocky, muddy shore launch both within 50 yards of parking lot. You cannot drive up to ramps. The gravel launch is large gravel and covered with silt at the bottom. that&#x27;s a good thing. It provides firm footing &#x28;instead of sucking slime&#x29; and protects the bottom of your boat from the rocks. Note the edge of rocks at the gravel ramp at low tide. There is about a foot drop off to sucking slime.</p>
      <p><b>Parking: </b>43 parking spaces.</p>
      <p><b>Facilities: </b>Restrooms that are barely maintained.</p>
      <p><b>Address: </b>Closest address is 2580 Green Island Rd, American Canyon. Continue further on Green Island Rd and take next left into park.</p>
      <p><img class="details_img" src="images/green-island.jpg" height="283" width="400">
      <p><img class="details_img" src="images/Napa,%20Zero%20Tide/Green%20Island%20Kayak%20Launch%20-%20Cement%20Ramp%20_1[1].jpg" height="480" width="270">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Napa,%207'%20tides/Green%20Island%20gravel%20ramp,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>High tide</span>
      <p><img class="details_img" src="images/7foot/Napa,%207'%20tides/Green%20Island%20concrete%20ramp,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Pictures taken at 7-foot tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="69" station_class="water_trail" title="Cuttings Wharf" zone="530" modtime="1615916065513" modby="bask0099" edits_since="1527018620312" >
  <marker lat="38.226111" lng="-122.307833"/>
  <tide_station>29</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from new concrete ramps or high float docks onto Napa River. Paddle up to downtown Napa &#x28;5 miles&#x29; or down to Vallejo &#x28;8 miles&#x29; or into the north Bay sloughs to Hudeman Slough. The river is tidal so plan accordingly.</p>
      <p><b>Parking: </b>Parking is free. Closed 10PM-4AM. Overnight parking is OK with a permit. There is a rigging area beside the ramp.</p>
      <p><b>Facilities: </b>Restrooms in the parking lot. The cafe is still closed &#x28;May, 2018&#x29;.</p>
      <p><b>Address: </b>Located at the end of Cuttings Wharf Rd.<p></p>
      <p><b>Contact Info: </b>Napa County, 707-253-4421</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/cuttings-wharf/">Bay Area Water Trail - Cuttings Wharf</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://dbw.ca.gov/BoatingFacilities/Details/386">http://dbw.ca.gov/BoatingFacilities/Details/386</a></p>
      <p><img class="details_img" src="images/cuttings-wrf.jpg" height="284" width="400">
      <p><img class="details_img" src="images/Napa,%20Zero%20Tide/Cuttings%20Wharf.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="70" title="Riverside Dr, Napa" zone="530" modtime="1615938029697" modby="petolino" edits_since="1615915285494" chart_title="Riverside Dr" >
  <marker lat="38.286972" lng="-122.284333"/>
  <tide_station>131</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from small public concrete ramp. There is a loading/rigging area next to the ramp. There is no dock and the river bank is steep on either side of the ramp.</p>
      <p><b>Parking: </b>Park on the street. 6 spaces. No apparent time restrictions.</p>
      <p><b>Facilities: </b>No facilities. Napa Valley YC is right next door.</p>
      <p><b>Address: </b>Far south end of Riverside Dr. in downtown Napa.</p>
      <p><b>Contact Info: </b>The site is operated by Napa County, 707-253-4421.</p>
      <p><b>Links: </b><a target="tp_details" href="https://cityofnapa.org/Facilities/Facility/Details/Riverside-Park-Boat-Launch-22">https://cityofnapa.org/Facilities/Facility/Details/Riverside-Park-Boat-Launch-22</a></p>
      <p><img class="details_img" src="images/Napa,%20Zero%20Tide/Riverside%20Dr,%20ramp.BMP" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Napa,%207'%20tides/Riverside%20Drive%20Ramp,%20Napa,%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="destination" xid="71" station_class="water_trail" title="Napa Dowtown Dock" zone="530" modtime="1615938088801" modby="petolino" edits_since="1615915411613" >
  <marker lat="38.297511" lng="-122.283452"/>
  <tide_station>131</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Destination. The revamp of downtown Napa made parking and carrying boats to this dock impossible. The dock has a state-of-the-art-kayak float which is removed in winter to protect it from winter floods. You can come here from Cuttings Wharf or just about anywhere on the Napa River and get out to stretch, eat, browse etc. The dock is unlocked from 7AM-11PM.</p>
      <p><b>Parking: </b>Forget it. And there is no place to stop and unload a boat either.</p>
      <p><b>Facilities: </b>What this dock has that others do not are racks for temporary storage of your kayak while you are off to lunch, tasting wine &#x28;just a little&#x29; or perhaps staying overnight in a local hotel. There are no restrooms at the dock but there are plenty of places close by that do have restrooms.</p>
      <p><b>Address: </b>Main and 4th in downtown Napa.</p>
      <p><b>Contact Info: </b>Napa Parks and Rec, 707-257-9629</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/downtown-napa-main-st-dock/">Bay Area Water Trail - Downtown Napa Dock</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.cityofnapa.org/752/Main-Street-Boat-Dock">https://www.cityofnapa.org/752/Main-Street-Boat-Dock</a></p>
      <p><img class="details_img" src="images/new/NapaDowntownDock+6ft.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at +6 ft tide</span>
      <p><img class="details_img" src="images/7foot/Napa,%207'%20tides/Downtown%20Napa%2012-31-17.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at +7 ft tide in winter &#x28;dock is hibernating&#x29;</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527007998997-71-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Downtown napa kayak racks, 3-28-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527007998998-71-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Downtown napa sign, 3-28-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527008404799-71-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Downtown dock, Napa, at zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="72" title="Trancas Crossing Park, Napa" modtime="1615938377407" modby="petolino" edits_since="1615938148792" chart_title="Trancas Crossing Park" >
  <marker lat="38.328056" lng="-122.283306"/>
  <tide_station>131</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>The Napa River is a small creek here. The path from the drop-off zone to the river is about 100 yds along a level paved path and then a dirt path. Launch from a firm mud bank. Go down river to town of Napa or as far as you wish. There are a number of places to take out on the Napa River between here and Vallejo. Also, be aware that Trancas Park is in a high risk flood zone. Don&#x27;t go here after heavy rains.</p>
      <p><b>Parking: </b>Free parking in the park for 6 cars. There is space on the adjacent street for about 10 Cars. Parking on the street overnight is OK. The park is closed sunset to sunrise.</p>
      <p><b>Facilities: </b>Bathrooms and a drinking fountain are located about 200 yds from the launch area on the river.</p>
      <p><b>Address: </b>610 Trancas St in downtown Napa</p>
      <p><b>Contact Info: </b>City of Napa Parks and Rec. 707-257-9529</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.cityofnapa.org/facilities/facility/details/trancascrossingboatlaunch-23">http://www.cityofnapa.org/facilities/facility/details/trancascrossingboatlaunch-23</a></p>
      <p><img class="details_img" src="images/Napa,%20Zero%20Tide/Trancas%20Crossing.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526327527003-72-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Napa River, Trancas launch spot</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526327527004-72-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Trancas trail to launch, Feb 2012</span>
  ]]></details>
</station>
<station station_type="launch" xid="73" title="Hudeman Slough" zone="530" modtime="1525969171910" modby="bask0099" >
  <marker lat="38.20637" lng="-122.37544"/>
  <tide_station>109</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Hudeman has a dock and a concrete ramp. The dock is now boarded up and closed. It is still possible to launch kayaks from the ramp. This is a great start or end for flat water slough paddling. It is tidal and there are very few places to get out. On ebb tides the current goes to your right as you face the water.</p>
      <p><b>Parking: </b>There is ample free parking.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Address: </b>28020 Skaggs Island Rd, Napa.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sonoma-county.org/parks/">Sonoma County Regional Parks</a></p>
      <p><img class="details_img" src="images/Sonoma,%20Zero%20Tide/Hudeman%20Slough%20ramp.JPG">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Sonoma,%207'%20tides/Hudeman%20Slough%20ramp,%207+'%20tide.jpg">
      <br><span class='details_caption'>Picture taken at 7-foot+ tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525969171910-73-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hudeman Slough Sign on 3-28-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525969171911-73-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hudeman Slough dock, 3-28-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="74" title="Kennedy Park, Napa" zone="530" modtime="1615937755483" modby="petolino" edits_since="1615915656139" chart_title="Kennedy Park" >
  <marker lat="38.265564" lng="-122.283719"/>
  <tide_station>131</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Boat ramp in public park on the Napa River. This fully developed park has lots to offer but at low tide Beware of the Mud&#x21; The dock is high freeboard.</p>
      <p><b>Parking: </b>Parking is ample and free. There is a loading area beside the ramp. Hours are Nov-March, 7AM-7PM&#x3B; April-October, 7AM-10PM.</p>
      <p><b>Facilities: </b>Bathrooms, drinking fountain, picnic area, BBQs.</p>
      <p><b>Address: </b>From Hwy 121 &#x28;the Napa-Vallejo Hwy&#x29; Turn west onto Streblow Dr. and find your way to the launch ramp.</p>
      <p><b>Contact Info: </b>Napa Dept of Community Resources, 707-257-9529</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.cityofnapa.org/Facilities/Facility/Details/Kennedy-Park-Boat-Launch-24">https://www.cityofnapa.org/Facilities/Facility/Details/Kennedy-Park-Boat-Launch-24</a></p>
      <p><img class="details_img" src="images/kennedy-pk2.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at low tide</span>
      <p><img class="details_img" src="images/kennedy-pk1.jpg" height="301" width="400">
      <br><span class='details_caption'>Picture taken at high tide</span>
      <p><img class="details_img" src="images/7foot/Napa,%207'%20tides/Kennedy%20Park%20ramp,%20Napa,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot+ tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="75" title="Horseshoe Cove, Presidio Yacht Club" zone="530" modtime="1526012292879" modby="bask0099" chart_title="Presidio Yacht Club" >
  <marker lat="37.833628" lng="-122.474356"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Horseshoe Cove is a protected cove just east of the north tower of the Golden Gate bridge. Depending on the tides, it is a great launch site for paddling to Angel Island or Out The Gate. Inside the cove it is protected and outside are some of the strongest currents and most violent tide rips in the Bay. It is only about 1/2 mile to Yellow Bluff. Launching is possible from the beach below the PYC. There is a new concrete ramp leading from the parking lot to the beach. The beach is home of the Tamalpais Outrigger Canoe Club. Their boats are stored on the beach. The beach is launchable at all tides. The Presidio Yacht Club is operated by Travis Air force Base and welcomes kayakers and the general public. Nice bar for apres-paddle snacks and drinks with wonderful views.</p>
      <p><b>Parking: </b>Free. 20-30 spaces. Overnight is possible with a permit obtained from the Headlands Visitor Center, 415-331-1540, 9:30-4:30PM daily.</p>
      <p><b>Facilities: </b>Restrooms and bar in the Presidio Yacht Club which is open Th-Fri,4-11PM, Sat 11-12 Midnight and Sunday 11-7PM. At other times there are porta-potties near the Coast Guard pier. There is a picnic table on the beach.</p>
      <p><b>Contact Info: </b>Marina Manager, Louis Canotas, 415-332-2319</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.presidioyachtclub.org/">Presidio Yacht Club</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.nps.gov/goga/planyourvisit/fort-baker.htm">http://www.nps.gov/goga/planyourvisit/fort-baker.htm</a></p>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/PYC%20beach%20at%207'%20tide%20on%201-1-18.jpg">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526011790377-75-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Horseshoe cove and beach at PYC</span>
  ]]></details>
</station>
<station station_type="launch" xid="76" title="Horseshoe Cove, gravel ramp" zone="530" modtime="1526012352405" modby="bask0099" chart_title="Horseshoe Cove" >
  <marker lat="37.833576" lng="-122.477491"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Horseshoe Cove is a protected cove just east of the north tower of the Golden Gate bridge. Depending on the tides, it is a great launch site for paddling to Angel Island or Out The Gate. There is a concrete ramp with a gravel beach beside it at the west end of the cove and just below the Coast Guard Station. It is usable at all tides and not used by many other boats at all.</p>
      <p><b>Parking: </b>Free along the sea wall. there is an area for rigging and loading at the top of the ramp. Overnight parking is by permit obtained at the Headlands Visitor Center. 415-331-1540.</p>
      <p><b>Facilities: </b>Porta-potties are near the Coast Guard pier.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/goga/planyourvisit/fort-baker.htm">http://www.nps.gov/goga/planyourvisit/fort-baker.htm</a></p>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Fort%20Baker%20gravel%20ramp%20at%207'%20tide%201-1-18.jpg">
      <br><span class='details_caption'>Picture taken at 7-foot tide. Blue porta-potties visible on the right.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526010321516-76-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Horseshoe cove, launch ramp, zero tide</span>
  ]]></details>
</station>
  <station station_type="destination" xid="77" station_class="water_trail" title="Angel Island, Perles Beach" zone="530" modtime="1604613300635" modby="bask0099" edits_since="0" chart_title="Perles Beach" >
  <marker lat="37.854467" lng="-122.437183"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sandy landing, panoramic view of San Francisco, 3 miles from Golden Gate Bridge, steps up to service road. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="78" station_class="water_trail" title="Angel Island, Pallet Beach" zone="530" modtime="1604864258662" modby="petolino" edits_since="1604861831871" chart_title="Pallet Beach" >
  <marker lat="37.855333" lng="-122.427983"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sandy landing, secluded location, views of San Francisco, Alcatraz, and Golden Gate Bridge.<br>This is &#x22;Sand Springs Beach&#x22; on the Water Trail website. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604698151054-78-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pallet beach, 2020</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604723544089-78-bask0099.jpg" height="214" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pallet Beach</span>
  ]]></details>
</station>
  <station station_type="destination" xid="79" title="Angel Island, Casey Walker Memorial Bench" zone="530" modtime="1604864222538" modby="petolino" edits_since="0" chart_title="Casey Walker Bench" >
  <marker lat="37.855667" lng="-122.426094"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Casey Walker Memorial Bench and Picinic Table. About half mile walk from Quarry Beach. Enjoy sweeping views of the City as well as Sausalito to Oakland. &#x24;3 day use fee.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.bask.org/casey-walkers-bench-and-picnic-table-on-angel-island/">Casey&#x27;s Bench</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.bask.org/upcoming-general-meeting-saturday-july-28/">In Memoriam</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
      <p><img class="details_img" src="images/CaseyBench.jpg" height="300" width="400">
      <p><img class="details_img" src="images/CaseyView.jpg" height="300" width="400">
  ]]></details>
</station>
  <station station_type="destination" xid="80" title="Angel Island, Broken Windmill Beach" zone="530" modtime="1604629332034" modby="bask0099" edits_since="0" chart_title="Broken Windmill Beach" >
  <marker lat="37.85305" lng="-122.419867"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Long sandy landing, views of San Francisco, Alcatraz and Golden Gate Bridge. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="81" station_class="water_trail" title="Angel Island, Quarry Beach" zone="530" modtime="1605553072204" modby="bask0099" edits_since="1604864317049" chart_title="Quarry Beach" >
  <marker lat="37.859217" lng="-122.4209"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Long sandy landing, easy hike to old buildings on Angel Island. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>Restrooms nearby</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605553072204-81-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
  ]]></details>
</station>
  <station station_type="destination" xid="82" station_class="water_trail" title="Angel Island, East Garrison" zone="530" modtime="1605552764994" modby="bask0099" edits_since="1605543840781" chart_title="East Garrison" >
  <marker lat="37.863666" lng="-122.421616"/>
  <current_station>131</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Tide-dependent rocky beach. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>Restrooms nearby</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="83" title="Muir Beach" zone="545" modtime="1527739146803" modby="petolino" edits_since="1527709855279" >
  <marker lat="37.85921" lng="-122.57632"/>
  <tide_station>288</tide_station>
  <city>Mill_Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>Once upon a time Muir Beach was a great launching spot for coastal exploration and surfing practice. Now the beach is 1/4 mile from the parking lot. Some of this hike is on a flat boardwalk and the rest is on a dirt trail that goes up a hill and then down again. Bring wheels if you feel up for this. Otherwise come by kayak from Rodeo, Horseshoe Cove or Bolinas. The surf is generally gentle and spills. The very far NW beach is pretty free of tourists, is the most protected place to land and is &#x22;clothing optional&#x22;.</p>
      <p><b>Parking: </b>Free for about 100 cars. The lot is open from 9AM-9PM</p>
      <p><b>Facilities: </b>4 basic pit toilets in the parking lot &#x28;no running water&#x29;. Also, there&#x27;s a picnic table in the parking lot. The Pelican Inn is located right on the highway outside the parking lot for lunch. Hours: 11:30AM-3PM for lunch and 5:30-9PM for dinner. It is also a cozy little inn with rooms in the &#x24;250-&#x24;350 range&#x21;&#x21;</p>
      <p><b>Address: </b>Highway 1 over the hill from Mill Valley.</p>
      <p><b>Contact Info: </b>GGNRA at Fort Mason, 415-561-4700<br>Pelican Inn, 415-383-6000</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/goga/planyourvisit/muirbeach.htm">GGNRA</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527709855279-83-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Muir Beach path, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527709855280-83-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Muir Beach, 2&#x27; tide, 5-18</span>
  ]]></details>
</station>
  <station station_type="destination" xid='84' title="Mill Valley, Lone Tree Beach" zone="545" chart_title="Lone Tree Beach" >
    <marker lat="37.878633" lng="-122.613350"/>
    <tide_station>288</tide_station>
    <city>Mill_Valley</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Destination from either Muir or Stinson beach.  The beach is landable with sand at low tide to +4 ft tides where landing area is higher with rocks.  Beach is suitable for a lunch stop and accessible by kayak only.  There is a nice fresh water creek running into the ocean, Lone Tree Creek, as named on the charts.
        <p><b>Parking: </b>None.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="85" title="Bolinas" zone="545" modtime="1670616458084" modby="petolino" edits_since="1670616304514" >
  <marker lat="37.90457" lng="-122.68614"/>
  <tide_station>42</tide_station>
  <city>Bolinas</city>
  <details><![CDATA[
      <p><b>Overview: </b>Paddle out to Duxbury Reef or just play in the surf. Gentle sloping beach, spilling waves. Bolinas has lots of board surfers, and if you get anywhere near them, you should know about surf etiquette and right of way &#x28;see links below&#x29;. There are two places to launch in Bolinas. Both are old concrete ramps to the beach. One is located at the end of Brighton Way. The other is at the end of Wharf Road at the entrance to the lagoon. At high tides the water comes right up to both ramps. Normally the channel into the lagoon has the lowest surf &#x28;if any&#x29; for surf chickens.</p>
      <p><b>Parking: </b>Free, on the street. Finding a place to park ANYWHERE in Bolinas is impossible on sunny weekends or holidays. There is space to unload at both ramps.</p>
      <p><b>Facilities: </b>Restrooms are by the tennis court, at the community center and also just east of the community center.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.bask.org/surf-etiquette/">Surf Etiquette &#x28;BASK website&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.bask.org/surfing-right-of-way/">Surfing Right Of Way &#x28;BASK website&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Bolinas-Jetty-Surf-Report/4215/">Magic Seaweed Surf Report &#x28;east of lagoon mouth&#x29;</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527478364004-85-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bolinas Lagoon entance, 3&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527478364005-85-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bolinas Lagoon path and beach, 3&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527478364006-85-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bolinas launch at Brighton, 3&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527478364007-85-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bolinas, ramp at Brighton, 3&#x27; tidejpg</span>
  ]]></details>
</station>
<station station_type="launch" xid="86" title="Dunphy Park" zone="530" modtime="1606695128700" modby="petolino" edits_since="1606695110477" >
  <marker lat="37.86165" lng="-122.48799"/>
  <tide_station>367</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Protected launch into Richardson Bay. Good put-in for trips to Angel Island or along the Sausalito waterfront. It gets quite muddy at low tide. The launch beach is firm mud and little rocks at high tide and soft slimy mud at low tide. Dunphy Parks underwent a massive facelift &#x28;2020&#x29;. There is now more parking. Cass Gidley Marina &#x28;at the north end of the park&#x29; will have a kayak launch from its dock. The path to the old launching area is less than 100yds.</p>
      <p><b>Parking: </b>Parking free. There are 30-40 spaces. No overnight parking allowed.</p>
      <p><b>Facilities: </b>There are new bathrooms by the parking lot and bocce ball court. There is a drinking fountain.</p>
      <p><b>Address: </b>300 Napa St, Sausalito</p>
      <p><b>Contact Info: </b>City of Sausalito Parks and Rec. 415-289-4152.</p>
      <p><img class="details_img" src="images/dunphy-pk.jpg" height="287" width="400">
      <p><img class="details_img" src="images/new/DunphyPark-hightide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at high tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Dunphey%20Park2,%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526074990192-86-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Dunphy Park, 4-24-18, zero tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="87" title="Schoonmaker Marina" zone="530" modtime="1526075618077" modby="bask0099" chart_title="Schoonmaker" >
  <marker lat="37.86379" lng="-122.48937"/>
  <tide_station>367</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Protected launch into Richardson Bay. Good put-in for trips to Angel Island or along the Sausalito waterfront. Nice sand beach the gets muddy at very low tide. Beach opens 30 minutes before sunrise and closes 30 minutes after sunset. Formerly home of Sea Trek. Currently home of Environmental Traveling Companions</p>
      <p><b>Parking: </b>Free, but limited. There are 7 green spaces for the public and it generally OK to park there all day. More parking off Liberty Ship Way South or at the Bay Model.</p>
      <p><b>Facilities: </b>Restrooms, drinking fountain, beach and restaurant.</p>
      <p><b>Contact Info: </b>The harbormaster is present 7AM-3PM. 415-331-5550 or 415-717-2701.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.shcoonmakermarina.com">http://www.shcoonmakermarina.com</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Schoonmaker_Beach,_Sausalito.jpg" height="299" width="400" >
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Schoonmaker%20at%207'%20tide,%201-1-18.jpg" height="300" width="400" >
      <br><span class='details_caption'>Picture taken at 7&#x27; tide tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="88" title="Paradise Beach" zone="530" modtime="1527446118177" modby="petolino" edits_since="1527387665926" >
  <marker lat="37.894157" lng="-122.45742"/>
  <current_station>278</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>Marin County Park. Open during daylight hours. Fully developed park. Launch from concrete ramp next to pier. Launch is a long, steep downhill from parking. Bring wheels for the return. Better yet run a shuttle to somewhere flat. If there is a ranger present and it is not busy they will let you drive down to unload. Launch is rocky and dangerous at low tide. There is a beautiful white sand beach to the north of the ramp that belongs to the park. The stairs to it are formidable. It is a Destination not a launch. Be aware that the ferry and freighters kick up wakes that do not reach the beach or ramp &#x28;as surf&#x29; for several minutes after they disappear.</p>
      <p><b>Parking: </b>Fee schedule is: &#x24;5/car, M-F and &#x24;10/car on weekends in the summer. If you walk in or kayak in it is free. It is also free the first Saturday of each month. Pay at the iron ranger in the parking lot. The park is open: 7AM-8PM in summer&#x3B; 7AM-7PM, Sept-Nov&#x3B; 8AM-5PM in winter. It is also possible to make arrangements with the ranger to leave a car overnight if you are on a multiday trip.</p>
      <p><b>Facilities: </b>Bathrooms, drinking fountain, fishing pier, lawn, picnic area, BBQ grill, beach shower.</p>
      <p><b>Address: </b>3450 Paradise Dr.</p>
      <p><b>Contact Info: </b>Park office, 415-435-9212<br>Mike Maraccini is the head ranger for Paradise Park.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/paradise-beach">http://www.marincounty.org/depts/pk/divisions/parks/paradise-beach</a></p>
      <p><img class="details_img" src="images/new/Paradise%20Park.jpg" height="299" width="400">
      <br><span class='details_caption'>High tide</span>
      <p><img class="details_img" src="images/paradisepark1.jpg" height="300" width="400">
      <br><span class='details_caption'>High tide view of ramp and beach</span>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Tiburon,_Paradise_Park.jpg" height="299" width="400">
      <br><span class='details_caption'>Pictures taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527387665926-88-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Paradise Park, 3&#x27; tide, 5-18</span>
  ]]></details>
</station>
  
  <station station_type="launch" xid="90" title="San Quentin Beach" zone="530" modtime="1526246509822" modby="bask0099" >
  <marker lat="37.94144" lng="-122.48236"/>
  <tide_station>304</tide_station>
  <city>Larkspur</city>
  <details><![CDATA[
      <p><b>Overview: </b>Small beach located near the west end of the Richmond-San Rafael bridge. A variety of bay paddling destinations to the north, east and south. Sometimes called &#x22;Jail House Beach&#x22;. There is a gently sloping path from the street to the beach with two sets of stairs &#x28;one very funky and one wood&#x29;. the park is open from 9AM-4PM but this is not posted. Watch out for happy running dogs&#x21;</p>
      <p><b>Parking: </b>Parking is very limited along the side of the road. 1 hour 8AM-6PM every day. There are only a couple unrestricted spots on the entire street.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Address: </b>23 Main St. This road leads to the main gate for San Quentin.</p>
      <p><b>Contact Info: </b>Marin county Parks and Open Space, 415-499-7371</p>
      <p><img class="details_img" src="images/sanquentin1.jpg" height="251" width="400">
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/San_Quentin_Beach.jpg" height="267" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20San%20Quentin%20beach2,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="91" title="Corte Madera Creek, Windsurfer Beach" zone="530" modtime="1605393364915" modby="bask0099" edits_since="1526170649976" chart_title="Corte Madera Creek" >
  <marker lat="37.94266" lng="-122.5017"/>
  <tide_station>80</tide_station>
  <city>Larkspur</city>
  <details><![CDATA[
      <p><b>Overview: </b>Nice launch beach for trips into the bay or Corte Madera Creek. Gravel and rocks, good at all tides. Easy access from East Bay and Marin. Watch out for ferries and wakes and pull your boat up high enough to escape the wash. The site was developed by the windsurfers. Windy&#x21; The wind blows down the creek and is brisk on summer afternoons.</p>
      <p><b>Parking: </b>Along the side of the road, close to launch, there are about 10 spaces. Free. Be sure to park well off the pavement. It&#x27;s a busy street. The carry to the beach is down a small bluff on a dirt path.</p>
      <p><b>Facilities: </b>ADA-compliant porta-potty 100 yards from launch.</p>
      <p><img class="details_img" src="images/windsurf-bch.jpg" height="261" width="400">
      <br><span class='details_caption'>Windsurfers Beach at mid-tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20Windsurfers%20beach,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526170649976-91-bask0099.jpg" height="266" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windsurfers Beach, corte Madera Creek, zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="92" title="San Rafael, Loch Lomond Marina" zone="530" chart_title="Loch Lomond" modtime="1657206651652" modby="petolino" edits_since="1657206573717" >
  <marker lat="37.972729" lng="-122.48419"/>
  <tide_station>304</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b><p><i>As of June 17, 2022, the <b>beach on the far east side</b> of Loch Lomond Marina is <b>closed for construction</b>, but the launch ramp is still usable.</b> Because of this, we&#x27;ve moved the Trip Planner site marker to the launch ramp. Scheduled completion date is November 22, 2022. See the link below for more information.</i><p>A nice launch spot for trips in the northern part of San Francisco Bay. The Marin Islands &#x28;off-limits&#x29;, the Brothers, the Sisters, and Red Rock are all in reach. The whole area gets muddy at low tide. The marina is under a new owner and is undergoing massive redevelopment. A housing development has been added, Andy&#x27;s Market relocated to beside the ramp and a kiddy playground incorporated. All these things mean less parking. More changes to come. The channel into the marina is dredged so there is always water there. As of May 2018 kayak launching at the ramp was free for kayakers. Ditto for the muddy beach at the far east end. The launch ramp is open 24/7.</p>
      <p><b>Parking: </b>The best place to park and to launch for free is on the far east side of the harbor. As you enter work your way left until you get to the far east end. There is very limited parking by the launch ramp.</p>
      <p><b>Facilities: </b>A bathroom has been built at the far east beach. There are porta potties beside the harbormaster&#x27;s office &#x28;by the ramp&#x29;. Andy&#x27;s market is right there so no one will starve.</p>
      <p><b>Address: </b>110 Loch Lomond Dr., San Rafael</p>
      <p><b>Contact Info: </b>Harbormaster, 415-454-7228 &#x28;hours for the harbormaster, 8AM-4:30PM Mon-Sat&#x29;</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.lochlomondmarina.com/">https://www.lochlomondmarina.com</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://sprcoalition.org/marina/construction-plans/">Construction closure, 2022</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Loch%20Lomond,%200'%20tide.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken of east beach at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526272359116-92-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Loch Lomond east beach at 7ft tide, Dec 2016</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526272359117-92-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Loch Lomond, mid-tide, May 4, 2016</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1539567992287-92-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Loch Lomond ramp</span>
  ]]></details>
</station>
  <station station_type="launch" xid="93" title="San Rafael, Bull Head Flat" zone="530" modtime="1526615940068" modby="bask0099" chart_title="Bull Head Flat" >
  <marker lat="38.00378" lng="-122.46731"/>
  <tide_station>303</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>Bull Head Flat is part of China Camp State Park. There is a gravel ramp, but it gets muddy at low tide. Wind surfers have cleared the area of rocks. Windsurfers&#x21; It does get windy &#x28;blowing from the west&#x29; especially on summer afternoons. Otherwise this is a great place to start an exploration of Gallinas Creek &#x28;Buck&#x27;s Landing, McInnis Park, even the Marin Civic Center&#x29; or, going south, China Camp or McNear&#x27;s Beach.</p>
      <p><b>Parking: </b>&#x24;5 day use fee. Parking is right beside launch. There are 14 spaces. The gate is open from 8AM-7PM &#x28;or sunset&#x29;. No overnight parking.</p>
      <p><b>Facilities: </b>Restrooms are closed because of a fire. Never fear, there is a porta potty. China Camp State Park camping nearby at Back Ranch Meadows. This site has an outdoor shower, drinking fountain, picnic tables and BBQ grills.</p>
      <p><b>Contact Info: </b>China Camp State Park, 415-459-9877 or 415-456-0766</p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Bullhead_Flat,_China_Camp_State_Park.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20Bull%20head%20Flat,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="94" title="San Rafael, China Camp State Park" zone="530" modtime="1612492513075" modby="bask0099" edits_since="1527223081244" chart_title="China Camp SP" >
  <marker lat="38.00047" lng="-122.46102"/>
  <tide_station>303</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>China Camp is a great place for easy paddles into San Pablo Bay, and to explore some of the small islands &#x28;Rat Island, The Sisters&#x29;. It has a nice sandy beach, but gets muddy at low tide &#x28;less than 2&#x27;&#x29;. May be crowded weekends. It is a State Park that is operated by Friends of China Camp and is open 8AM-sunset. This site is protected from wind and generally sunny when it is foggy everywhere else. Water is warm &#x28;well sort of&#x29; so it&#x27;s a good place to practice paddling and rescue techniques--but not at low tide.</p>
      <p><b>Parking: </b>Day use fee, &#x24;5/car. Distance, car to water - close. There is parking beside the launch area and also up the hill nearer the gate as well as outside on the road.</p>
      <p><b>Facilities: </b>Restrooms, picnic tables, outdoor shower, grassy area. This is also an historical site so don&#x27;t miss wandering around. Camping is at Backranch Meadows &#x28;3 miles west on N.San Pedro Rd&#x29;.</p>
      <p><b>Address: </b>899 North San Pedro Rd., San Rafael</p>
      <p><b>Contact Info: </b>Friends of China Camp, 415-456-0766<br>Backranch Meadow Campground, 415-456-1286</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=466">China Camp State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.friendsofchinacamp.org/">Friends of China Camp</a></p>
      <p><img class="details_img" src="images/chinacamp1.jpg" height="300" width="400">
      <p><img class="details_img" src="images/new/ChinaCamp+4ft.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at +4 ft tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20China%20Camp,%207'%20tide.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at +7 ft tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="95" station_class="water_trail" title="McNears Beach, Marin County Park" zone="530" modtime="1527552908622" modby="bask0099" edits_since="1526616058125" chart_title="McNears Beach" >
  <marker lat="37.9922" lng="-122.45189"/>
  <tide_station>303</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>This Marin county park is a favorite among families on summer weekends. It has a sandy beach and provides easy paddling access to San Pablo Bay and The Sisters. It also has a pool with changing rooms and a bathroom with showers. Kayaks can be launched from the beach opposite the pool &#x28;very busy in summer and muddy at low tide&#x29; or at the far south end of the park where the overflow parking is located. Entry to the park is &#x24;10 in summer and &#x24;5 in winter and &#x24;2 if you arrive by boat. The hours are 7AM-8PM in the summer. The site is sheltered and sunny on days when it is blowing and foggy everywhere else.</p>
      <p><b>Parking: </b>Day use fee. the lot is large but often full on summer weekends. There is an overflow lot at the far south end that has the better kayak launch as well &#x28;gravel going to firm mud and then to soft mud&#x29;. There used to be a launch ramp here and the remains create firm access at low tide.</p>
      <p><b>Facilities: </b>Fully developed park with parking and bathrooms, showers, pool etc. picnic tables, BBQ grills, snack bar &#x28;with beer&#x29; and fishing pier.</p>
      <p><b>Address: </b>201 Cantera Way in San Rafael</p>
      <p><b>Contact Info: </b>Marin County Parks, 415-499-6387</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/mcnears-beach/">Bay Area Water Trail-McNears Beach</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/mcnears-beach">http://www.marincounty.org/depts/pk/divisions/parks/mcnears-beach</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/McNear's_Beach,_north_end,_San_Rafael.jpg" height="299" width="400">
      <br><span class='details_caption'>By McNear&#x27;s launch ramp at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526273602039-95-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McNears launch ramp, 4&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527552908622-95-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McNears Beach, looking north from south beach, high tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527552908623-95-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McNears Beach, south end at mid tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="96" title="Foot of Locust, Sausalito" zone="530" chart_title="Foot of Locust" modtime="1670540600749" modby="petolino" edits_since="1526074133934" >
  <marker lat="37.861284" lng="-122.486152"/>
  <tide_station>367</tide_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a small informal path through the low rip rap. Best at medium to high tide. The shore below the rip rap is firm mud. At very high tides the rip rap is covered with water and may be more difficult. It is normally very calm here.</p>
      <p><b>Parking: </b>The parking lot has 60-70 spaces with a 3 hour limit and very close to launch. No parking 2AM-6AM. Dunphy Park just to the north has free parking all day.</p>
      <p><b>Facilities: </b>None but restaurants are very close by. There is a picnic table.</p>
      <p><b>Address: </b>102 Locust St., Sausalito, CA 94965</p>
      <p><b>Contact Info: </b>City of Sausalito Parks and Rec. 415-289-4152.</p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/Locust_st_Sausalito.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/Locust%20Street,%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='97' title="San Rafael Yacht Club, San Rafael" zone="530" chart_title="San Rafael Yacht Club" >
    <marker lat="37.968900" lng="-122.518222"/>
	 <tide_station>303</tide_station>
    <city>San_Rafael</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The YC is located at the far west end of the San Rafael Canal.  Launching and landing at their docks is permitted on weekends when the YC is open.  There is serious mud along the shore at low tide.
        <p><b>Parking: </b>Along the street and free.
        <p><b>Address: </b>445 Francisco Blvd, E San Rafael, CA 94901
        <p><b>Facilities: </b>It may be possible to use the YC bathrooms.  Be nice.  It is easy walking distance to Terrapin Crossroads for lunch.
		  <p><img class='details_img' src="images/new/SanRafaelYCLowFloatDock.jpg" alt="San Rafael Yacht Club"/>
		  <p><img class='details_img' src="images/Marin, Zero Tide/San_Rafael_YC.jpg" alt="San Rafael Yacht Club"/>
		  <br><span class='details_caption'>Picture taken at zero tide</span>
		  <p><img class='details_img' src="images/7foot/Marin, 7' tides/2017-12-04 SR YC, 7' tide.jpg" alt="San Rafael Yacht Club, 7' tide"/>
		  <br><span class='details_caption'>Picture taken at 7-foot tide</span>
		  ]]>
    </details>
  </station>

  <station station_type="launch" xid="98" title="101 Surf Sports (San Rafael)" zone="530" modtime="1526270489083" modby="bask0099" chart_title="101 Surf Sports" >
  <marker lat="37.968608" lng="-122.512813"/>
  <tide_station>303</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>This friendly kayak and paddleboard outfitter welcomes kayakers. Launching or landing at their dock is possible or even just a stop for a rest. Please use the eastern most dock. Paddle up the canal to Terrapin Crossing restaurant or down the canal to the Marin Islands or Loch Lomond or McNears Beach. They are open 10AM-6PM M-F and 9AM-6PM Sat/Sun.</p>
      <p><b>Parking: </b>Free parking on the street. Please leave their small lot available for customers.</p>
      <p><b>Facilities: </b>Bathrooms in the shop and a place to change clothes. Kayak storage is available here. It&#x27;s also a retail shop.</p>
      <p><b>Address: </b>115 3rd St, San Rafael, CA 94901</p>
      <p><b>Contact Info: </b>415-524-8492</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.101surfsports.com">http://www.101surfsports.com</a></p>
      <p><img class="details_img" src="images/new/101Surf-mid-tide.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at mid tide</span>
  ]]></details>
</station>

  <station station_type="launch" xid="99" title="San Rafael, John McInnis County Park" zone="530" modtime="1639523081661" modby="petolino" edits_since="1638743894191" chart_title="John McInnis Park" >
  <marker lat="38.01815" lng="-122.52293"/>
  <tide_station>142</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>John McInnis County Park provides access to the north fork of Gallinas Creek. Located at the end of Smith Ranch Road in San Rafael. Launch from the canoe dock into Gallinas Creek. Park open 7AM-10PM. The dock is high freeboard and there is a rigging area at the top of the gangway. This is a mid to high tide launch. Lots of mud at low tide. the only place to go here is east towards the bay--Buck&#x27;s Landing and China Camp</p>
      <p><b>Parking: </b>Free and close to launch. There are 12 spaces beside the dock with unlimited parking nearby.</p>
      <p><b>Facilities: </b>Restrooms in the main parking lot. Country Club restaurant as well as a snack bar nearby at golf course. There is a picnic table at the head of the gangway.</p>
      <p><b>Address: </b>310 Smith Ranch Road</p>
      <p><b>Contact Info: </b>Ranger: 415-446-4423. Marin County Parks, 415-499-6387</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.marincounty.org/parkspreserves/parks/mcinnis-park">https://www.parks.marincounty.org/parkspreserves/parks/mcinnis-park</a></p>
      <p><img class="details_img" src="images/Marin,%20Zero%20Tide/McInnis_Park_dock,_San_Rafael.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/McInnisDock+4ft.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at +4 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1568242738124-99-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McInnis gangway, 9-2019</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1568242738125-99-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McInnis picnic tables, 9-2019</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638743894191-99-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mc Innes, King tide, 12-5-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638743894192-99-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>McInnes dock at 7&#x27; tide, 12-5-21</span>
  ]]></details>
</station>
  <station station_type="launch" xid="100" title="Buck&apos;s Landing, San Rafael" zone="530" modtime="1527187319661" modby="bask0099" edits_since="0" chart_title="Buck&#39;s Landing" >
  <marker lat="38.015937" lng="-122.503349"/>
  <tide_station>142</tide_station>
  <city>San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>Bucks Landing is in transition &#x28;2018&#x29;. It will wind up as a Marin County Park eventually. In the meantime there is an outfitter there, Outback Adventures, that is closed in winter. Kayaks can still launch at the ramp.</p>
      <p><b>Parking: </b>There are lots of parking spaces in a large dirt lot. It&#x27;s not clear what belongs to who and where you can park or not.</p>
      <p><b>Facilities: </b>Outback Adventures has a porta potty and a changing shed.</p>
      <p><b>Address: </b>665 North San Pedro Rd.</p>
      <p><b>Contact Info: </b>Will Hudson has been the manager of the property, 415-472-1502<br>Outback Adventures main store, 510-440-8888</p>
      <p><b>Links: </b><a target="tp_details" href="http://outbackadventures.com">http://outbackadventures.com</a></p>
      <p><img class="details_img" src="images/7foot/Marin,%207'%20tides/2017-12-04%20Bucks%20landing2.jpg" height="400" width="400">
      <br><span class='details_caption'>Picture taken at +7 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527187319661-100-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bucks landing at low tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="101" title="Tomales Bay, Chicken Ranch Beach" zone="540" modtime="1529332122270" modby="bask0099" edits_since="1527528077189" chart_title="Chicken Ranch" >
  <marker lat="38.10979" lng="-122.86512"/>
  <tide_station>179</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Chicken Ranch is a long, wide beach but a bit muddy at low tide. It provides access to the southern part of Tomales Bay. The beach is sand and goes to firm mud as the tide drops There is a creek that goes into the bay here that winds across the beach.</p>
      <p><b>Parking: </b>Free parking along the road, but space is limited to 10-15 cars. It is about 100 yd carry to the beach.</p>
      <p><b>Facilities: </b>One porta potty beside the road.</p>
      <p><b>Address: </b>This beach is unmarked so look for the porta potty &#x28;behind a wood fence&#x29; 1.2 miles past Inverness and just as Sir Francis Drake Blvd turns west.</p>
      <p><b>Contact Info: </b>Marin County Parks, 415-499-6387</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/chicken-ranch-beach">http://www.marincounty.org/depts/pk/divisions/parks/chicken-ranch-beach</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178228853-101-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Chicken Ranch Beach, 0.6&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178228854-101-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>chicken Ranch creek, 0.6&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529332122270-101-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Chicken ranch BEach, at 4.7&#x27; tide, 6-17-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529332122271-101-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Chicken Ranch Beach, 4.7&#x27; tide, 6-17-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="102" title="Tomales Bay, Nick&apos;s Cove" zone="540" modtime="1627341555043" modby="bask0099" edits_since="1529331819776" chart_title="Nick&#39;s Cove" >
  <marker lat="38.19984" lng="-122.92163"/>
  <tide_station>40</tide_station>
  <city>Marshall</city>
  <details><![CDATA[
      <p><b>Overview: </b>Nick&#x27;s Cove, also known as Miller County Park, provides good access to the northern part of Tomales Bay. It has a paved launch ramp, or you can launch from the little beach at the northern end of the parking lot.</p>
      <p><b>Parking: </b>Plenty both on the level of the launch ramp &#x28;which is often full&#x29; or on the bluff above. There is a loading area beside the ramp. There is supposed to be a &#x24;5 fee to park but it is not clear how it is collected. The upper lot had signs of break-ins. Overnight is OK at the upper lot &#x28;but not camping&#x29;. All Marin county parks are free on the first Saturday of the month.</p>
      <p><b>Facilities: </b>Bathrooms are well maintained and located in the parking lot near the ramp</p>
      <p><b>Address: </b>23240 Hwy 1. Four miles north of Marshall.</p>
      <p><b>Contact Info: </b>Marin County Parks, 415-473-6387 or 415-499-6387</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/main/info">Marin County Parks</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/miller-boat-launch">http://www.marincounty.org/depts/pk/divisions/parks/miller-boat-launch</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527089289096-102-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Nicks cove ramp at very low tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527089289097-102-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Nick&#x27;s Cove ramp at 0.7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527089289098-102-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Nicks Cove, north beach at 0.7&#x27; tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529331819776-102-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Nicks cove beach at 4.5&#x27; tide, 6-17-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529331819777-102-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Nicks cove ramp, 4.5&#x27; tide, 6-17-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1627341555043-102-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Miller Ramp at a negative tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="103" title="Dillon Beach" zone="540" modtime="1670616554355" modby="petolino" edits_since="0" >
  <marker lat="38.249926" lng="-122.966881"/>
  <tide_station>420</tide_station>
  <city>Dillon_Beach</city>
  <details><![CDATA[
      <p><b>Overview: </b>Moderate surf, nice for surf zone practice. Access to fine coastal paddling towards Bodega Bay to the north, or the entrance of Tomales Bay and Tomales Head to the south.</p>
      <p><b>Parking: </b>Plenty of parking, but expensive, &#x24;8 per vehicle.</p>
      <p><b>Facilities: </b>Restrooms, picnic tables.</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Dillon-Beach-Surf-Report/4628/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="104" title="Lawson&apos;s Landing" zone="540" modtime="1527527730080" modby="bask0099" edits_since="0" >
  <marker lat="38.2319" lng="-122.9682"/>
  <tide_station>420</tide_station>
  <city>Tomales</city>
  <details><![CDATA[
      <p><b>Overview: </b>Float south in the shallows and see Dungeness Crabs, jelly fish, bait fish, and seals. Cross over to the preserve and look at the elk. &#x24;8 entrance fee plus &#x24;3 per kayak launching fee. Inside Tomales Bay and protected from surf surge. This site provides access to the north end of Tomales Bay. There is a ramp. There is a day use fee and an overnight charge and camping.</p>
      <p><b>Parking: </b>yes</p>
      <p><b>Facilities: </b>Combination Deli and Bait Shop &#x28;don&#x27;t get the two mixed up or lunch could be interesting&#x29;, restrooms, one-hose wash off station.</p>
      <p><b>Contact Info: </b>707-878-2443</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.lawsonslanding.com">http://www.lawsonslanding.com</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="105" title="Tomales Bay, Marconi Cove" zone="540" modtime="1529331930159" modby="bask0099" edits_since="1527121611083" chart_title="Marconi Cove" >
  <marker lat="38.14092" lng="-122.87395"/>
  <tide_station>329</tide_station>
  <city>Marshall</city>
  <details><![CDATA[
      <p><b>Overview: </b>Marconi Cove is a sweet little put-in on the east shore of Tomales Bay, across the bay from Heart&#x27;s Desire Beach. Ownership of the site is unclear but there has been a dirt launch ramp here for years which is pretty much usable at all tides. The surface is pebbles, sand and small rocks. From here you can go anyplace in Tomales Bay. Right next door to the south is Tomales State Park land which will eventually be developed. The wish list includes camping and a ramp. Be aware that wind comes from the north and can create significant chop.</p>
      <p><b>Parking: </b>Free in a dirt lot which gets pretty muddy when it rains. There are no other facilities.</p>
      <p><b>Facilities: </b>None. Tony&#x27;s restaurant is just up the road.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527088703499-105-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Marconi beach looking north low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527088703500-105-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Marconi cove ramp at .7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529331930159-105-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Marconi cove at 4.5&#x27; tide, 6-17-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="106" title="Tomales Bay, Heart&apos;s Desire Beach" zone="540" modtime="1605544320361" modby="bask0099" edits_since="1529332293924" chart_title="Heart&#39;s Desire" >
  <marker lat="38.13241" lng="-122.8932"/>
  <tide_station>329</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Heart&#x27;s Desire is a popular beach in Tomales Bay State Park. When launching or landing your kayak, stay to the south of the swimmers area. By the way, this part of the beach was cleared of a lot of brush by the State Park with the help of about 20 volunteers from BASK&#x21; ETC keeps a container of boats here and runs programs for special needs kids here.</p>
      <p><b>Parking: </b>The parking lot holds over 50 cars with lots more parking available up the hill. On summer weekends it&#x27;s all full&#x21;&#x21; Day use fee of &#x24;8. 100 yds car to water. Gate is open 8AM-sunset.</p>
      <p><b>Facilities: </b>Clean, well maintained restrooms, outdoor shower, drinking fountain, about 30 picnic tables, BBQ grills.</p>
      <p><b>Address: </b>1100 Pierce Point Rd &#x28;past Inverness&#x29;</p>
      <p><b>Contact Info: </b>Park Office, 415-669-1140</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=470">Tomales Bay State Park</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527179082641-106-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hearts Desire Beach, .6&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527179082642-106-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hearts Desire, .5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529332293924-106-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hearts desire beach, 4.7&#x27; tide, 6-17-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529332293925-106-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hearts Desire at 4.7&#x27; tide, 6-17-18, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605544320361-106-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hearts Desire, 7&#x27;</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605544320362-106-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Heart&#x27;s Desire at 7&#x27; tide, 11-2020</span>
  ]]></details>
</station>
  <station station_type="launch" xid="107" title="Drakes Estero, (formerly Johnson&apos;s Oyster Farm)" zone="545" modtime="1606695328099" modby="petolino" edits_since="1605544129267" chart_title="Drakes Estero" >
  <marker lat="38.08278" lng="-122.93283"/>
  <tide_station>99</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Drakes Estero &#x28;formerly Johnson&#x27;s Oyster Farm&#x29; is located at the northern end of Schooner Bay and provides access to all areas of Drakes Estero. There are two places to launch. One is right next to the bathroom and is only about 10 yds from the parking lot. It gets REALLY muddy at low tide. The other is about 100 yds west over flat ground where the buildings used to be. It has a pebble beach that doesn&#x27;t go to mud until fairly low tides. To avoid getting stuck in the mud, plan your trip around a high tide. Drakes Estero is closed each spring for seal pupping season, usually between March 1 and June 30.</p>
      <p><b>Parking: </b>Free parking for about 30-40 cars. No time restrictions but no overnight parking allowed.</p>
      <p><b>Facilities: </b>Well maintained one seater bathroom. That&#x27;s it.</p>
      <p><b>Address: </b>Head out Sir Francis Drake Blvd. past the turn off to Tomales Point and turn left at the Drake&#x27;s Estero sign. Then it&#x27;s about 3/4 mile of one lane dirt road.</p>
      <p><b>Contact Info: </b>Bear Valley Visitor Center, general park number, 415-464-5100</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/pore/">Point Reyes National Seashore</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178070171-107-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drakes Estero south beach, .5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178070172-107-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drakes Estero, bathroom beach, .5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605544129267-107-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drake&#x27;s estero kayak launch, 7&#x27; tide, 11-2020</span>
  ]]></details>
</station>
  <station station_type="launch" xid="108" title="Drakes Bay, Limantour Beach" zone="545" modtime="1604699146485" modby="bask0099" edits_since="1527737582493" chart_title="Limantour Beach" >
  <marker lat="38.0252" lng="-122.8834"/>
  <tide_station>99</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Limantour Rd, which had been closed during summer 2020 due to fires is now open &#x28;Nov. 2020&#x29;. Limantour Beach provides access to Drakes Bay, and is a good launch location for a coastal paddle. It usually has moderate surf that can be dumpy. The sand beach is wide and flat. There are two access points at this location. Note that Limantour Spit is closed March 1- June 30 for seal pupping. Also note: the meander under the bridge has been known to be used as a bail-out spot when the wind in Drakes Estero was too strong to paddle against. Did I mention the wind&#x3F;</p>
      <p><b>Parking: </b>Free. Over 100 spaces. .3 mile to the beach at the west parking lot and .2 mile at the east parking lot &#x28;which only has spaces for 12 cars&#x29;. Part of the path is hard dirt and the rest is soft sand. This is the same at both lots. Bring wheels and a couple of able-bodied friends. Parking closed 12AM-6AM.</p>
      <p><b>Facilities: </b>Six very basic pit toilets, an outdoor shower, and two picnic tables near the west parking lot. One pit toilet in the east parking lot. The signs say that fires and camping require permits. Ditto overnight parking.</p>
      <p><b>Contact Info: </b>Bear Valley Visitor Center, 415-464-5100</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/pore/">Point Reyes National Seashore</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527477520520-108-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Limantour Beach at 3.5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527477520521-108-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Limantour Sign, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527477520522-108-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Limantour meander at 3.5&#x27; tide. Leads to Limantour and Drake&#x27;s Esteros, 5-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="109" title="Drakes Bay, Drakes Beach" zone="545" modtime="1605544036060" modby="bask0099" edits_since="1604861082692" chart_title="Drakes Beach" >
  <marker lat="38.026826" lng="-122.96133"/>
  <tide_station>99</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Drakes Beach provides access to Drakes Bay, and is a good launch location for a coastal paddle to the Pt Reyes Headlands or Limantour. It usually has moderate surf that dumps hard and often. It can be windy. The beach is closed March 1-June 30th for elephant seal pupping.</p>
      <p><b>Parking: </b>Free parking for over 50 cars. It is then about 100 yds to the beach. There is no formal loading area. The lot is closed 12AM-6AM unless you get a permit.</p>
      <p><b>Facilities: </b>October 2020: due to pandemic only the bathrooms are open. Normally there are well maintained restrooms with changing areas, bookstore, National Park Service visitor&#x27;s center, outdoor shower that doesn&#x27;t work, picnic tables and BBQs. Evidently fires are OK on the beach with a permit.</p>
      <p><b>Address: </b>Take Sir Francis Drake Blvd out past North Beach and look for the sign. Take a left on Drake&#x27;s Beach Rd.</p>
      <p><b>Contact Info: </b>Drake&#x27;s Beach Visitor Center, 415-669-1250<br>Bear Valley Visitor Center, 415-464-5100 &#x28;general number for park&#x29;</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/pore/">Point Reyes National Seashore</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178403494-109-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drakes Beach surf, .5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527178403495-109-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drakes Beach, .5&#x27; tide, 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604813111691-109-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>High tide in January. Elephant seal invasion</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605544036060-109-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Drake&#x27;s Beach at 7&#x27; tide, 11-2020</span>
  ]]></details>
</station>
  <station station_type="launch" xid="110" title="Estero Americano" zone="540" modtime="1528681382401" modby="bask0099" edits_since="0" >
  <marker lat="38.30953" lng="-122.93593"/>
  <tide_station>41</tide_station>
  <city>Valley_Ford</city>
  <details><![CDATA[
      <p><b>Overview: </b>Flat water paddling through cow pastures to a sandy beach at the mouth of the Estero. The important thing to know is whether or not the mouth of the Estero is open. If open then the Estero is subject to the tide and is very muddy at low tide. Also know that ALL the land bordering the Estero is private and they don&#x27;t want trespassers. However, as you near the mouth the land to the north belongs to the Sonoma Land Trust. The beach on the south of the Estero, above the high tide line, is private. It is 7 miles to the beach.</p>
      <p><b>Parking: </b>Free, but limited. Please be sensitive to the residents and don&#x27;t obstruct emergency access when parking. The access is just east and below the bridge over the Estero on Valley Ford Rd.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sonomalandtrust.org">Sonoma Land Trust</a></p>
      <p><img class="details_img" src="images/estero-amer.jpg" height="268" width="400">
      <br><span class='details_caption'>High tide.</span>
  ]]></details>
</station>
  <station station_type="launch" xid="111" title="San Francisco, Crissy Field" zone="530" chart_title="Crissy Field" modtime="1659394416867" modby="bask0099" edits_since="1526776647110" >
  <marker lat="37.80646" lng="-122.45131"/>
  <current_station>133</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Crissy Field is a great launch site for paddles along the San Francisco waterfront. Be aware that the currents can be strong here, it can be very windy, there can be wind opposing current &#x28;big chop&#x29; and that there will be a fair amount of boat traffic. Crissy Field is a pretty busy place and a favorite of windsurfers and kite boarders as well as tourist, joggers, dog walkers etc. etc. The beach itself is sand and usable at all tides. It often has some little surf. Often it has no surf.</p>
      <p><b>Parking: </b>Ample free parking. There is a free electric charging station at the far east end of the parking lot. There are no time restrictions. Overnight parking &#x28;11PM-6AM&#x29; is not allowed.  There is no formal loading zone. The distance to the beach varies depending on where you park.</p>
      <p><b>Facilities: </b>Clean restrooms and changing rooms. Drinking fountain and an outdoor shower. Also a dog rinsing spot&#x21; There are picnic tables and a BBQ by the bathrooms. The Warming Hut at the west end of the beach has food and a touristy shop. There is no place to launch there and has pay parking 10AM-5PM on weekends.</p>
      <p><b>Contact Info: </b>GGNRA &#x28;Crissy Field Center&#x29; 415-561-7690<br>Presidio Visitor Center, 415-561-4323</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.presidio.gov/places/crissy-field">http://www.presidio.gov/places/crissy-field</a></p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/Crissy%20Field,%20SF.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Crissy%20Field%20at%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="112" station_class="water_trail" title="San Francisco Marina- East End" zone="530" modtime="1526777621275" modby="bask0099" edits_since="1526777487382" chart_title="SF Marina East End" >
  <marker lat="37.806594" lng="-122.442302"/>
  <current_station>133</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>ADA accessible kayak launch ramp inside a locked gate.<br>Be aware that the currents can be strong outside the marina and that there will be a fair amount of boat traffic. You&#x27;ll need to get let in the gate by the harbormaster &#x28;open 8:30AM-5PM daily&#x29;. Once through the gate it is about 100 yds to the end of the docks to the launch.</p>
      <p><b>Parking: </b>Parking is free but very limited due to heavy use by other people. Park as close to the harbormaster&#x27;s office as possible. Parking is permitted 6AM-10PM in non-permitted spaces. No overnight parking allowed. There is ia rigging area in the parking lot, near the gate, beside the dumpster.</p>
      <p><b>Facilities: </b>Restrooms are located by the harbormaster&#x27;s office and are open sunrise to sunset.</p>
      <p><b>Contact Info: </b>Harbormaster, Scott Grindy, 415-832-6322</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/san-francisco-marina/">Bay Area Water Trail - San Francisco Marina</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.sfrecpark.org/marina">http://www.sfrecpark.org/marina</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526777621275-112-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>San Francisco Marina kayak launch</span>
  ]]></details>
</station>
  <station station_type="launch" xid="113" title="San Francisco, Aquatic Park" zone="530" modtime="1526755701381" modby="bask0099" edits_since="0" chart_title="Aquatic Park" >
  <marker lat="37.80757" lng="-122.42215"/>
  <current_station>20</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>This San Francisco waterfront park houses several historic ships. It has a sandy beach, and is very protected. It makes for a good launch or rest stop for paddles along the San Francisco waterfront. When launching or landing, be aware of swimmers in the water. Buoys mark the swimming area. South End and Dolphin clubs are located here. Due to the awful parking think destination rather than launch. The beach is usable at all tide levels. Once out of this lagoon there are strong currents, strong wind and boat traffic. Paddle under the piers to avoid all three.</p>
      <p><b>Parking: </b>Limited street parking at the bottom of Van Ness, Hyde or Polk. At the bottom of Polk there are wide paved ramps that lead around both end of the Maritime Museum. The carry is about 100 yds. Van Ness and Hyde Streets are closer. Although parking is free you have a better chance of winning the lottery. If by accident you find a spot it will have a 4 hour time limit between 5AM and 5PM. There is no place to unload or rig your boat. Good luck.</p>
      <p><b>Facilities: </b>You can find restrooms in the Maritime Museum &#x28;hours are 10AM-4PM daily&#x29; and on the Hyde Street Pier. There are many restaurants and a chi-chi hotel right across the street.</p>
      <p><b>Address: </b>Foot of Van Ness, Hyde and Polk Streets</p>
      <p><b>Contact Info: </b>Maritime Museum, 415-561-7100<br></p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/Aquatic%20Park,%20SF5.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Aquatic%20park%207'%20tide,%201-1-18.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>

  <station station_type="launch" xid="114" station_class="water_trail" title="San Francisco, Pier 39" zone="530" modtime="1526752709114" modby="bask0099" edits_since="0" chart_title="Pier 39" >
  <marker lat="37.808682" lng="-122.409051"/>
  <current_station>209</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Pier 39 has the Mercedes of kayak launches. It is ADA accessible, it has racks to put your boat on when you get out, it is behind a locked gate so you can leave for lunch or overnight or wherever without worrying about your boat. Security will let you in when you come back. It is free. It located on the east side of Pier 39 next to the street. Because parking and traffic are outrageous this is definitely a Destination. Come here from the east Bay, from Horseshoe Cove, from Pier 52... Wear something cool under your drysuit. Oh, this is a busy commercial harbor so keep your eyes peeled.</p>
      <p><b>Parking: </b>Paid garages are nearby if you think you need to come by car. Be prepared to mortgage the house to get your car back.</p>
      <p><b>Facilities: </b>Restrooms, restaurants, tourists. Harbormaster&#x27;s office hours are 9AM-5PM daily.</p>
      <p><b>Contact Info: </b>Security &#x28;to get back onto the dock&#x29;, 415-705-5544<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/pier-39/">Bay Area Water Trail - Pier 39</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.pier39marina.com">http://www.pier39marina.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526752709114-114-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Dock at Pier 39</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526752709115-114-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kayak racks at Pier 39</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526752709116-114-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>sign at Pier 39</span>
  ]]></details>
</station>

  <station station_type="launch" xid="115" title="Treasure Island, North Ramp" zone="530" modtime="1530136625726" modby="bask0099" edits_since="1529608952221" chart_title="North Ramp" >
  <marker lat="37.83226" lng="-122.37314"/>
  <current_station>432</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>The north end sits behind a short breakwater and is protected from the wind. Did I say wind&#x3F; Be ready for it especially on summer afternoons. there is significant mud at the bottom at low tide.</p>
      <p><b>Parking: </b>Free. There are 3 or 4 spots about 30 yds from the ramp with more a little further away.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Address: </b>At the end of Avenue I. Avenue I has a gate and a &#x22;Closed Road&#x22; sign but the gate is open and the site accessible by car.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529608952223-115-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Treasure Island, north end, -1.5&#x27; tide, 6-16-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="116" station_class="water_trail" title="San Francisco, Pier 52 Boat Launch" zone="531" modtime="1615081877967" modby="bask0099" edits_since="1615080611505" chart_title="Pier 52" >
  <marker lat="37.771237" lng="-122.386153"/>
  <tide_station>177</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public ramp. the lego type kayak launch is gone and the right side of the boat ramp is closed due to dock rotting and collapsing. From here tour the SF waterfront or run a shuttle to Crissy Field &#x28;6 miles&#x29; or the East Bay or... The entire roadway is under construction so getting here &#x28;early 2021&#x29; takes patience.</p>
      <p><b>Parking: </b>Meters on street operate 9AM-10PM. There is a pay lot 50 yards south by the Bay View Boat club. On event days parking is limited to 90 minutes. There is a loading area by the ramp.</p>
      <p><b>Facilities: </b>None, although the Bay View Boat Club has been gracious about letting kayakers use their bathrooms. The old ramp beside the Boat Club is not available.</p>
      <p><b>Address: </b>Pier 52</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/pier-52/">Bay Area Water Trail - Pier 52</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527971936792-116-bask0099.jpg" height="400" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 52</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615080611505-116-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 52 blocked ramp, 3-6-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615080611506-116-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 52 parking sign, 3-6-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615080611507-116-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 52 ramp, 3-6-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615081877967-116-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 52 parking rates</span>
  ]]></details>
</station>
  <station station_type="launch" xid="117" station_class="water_trail" title="San Francisco, Islais Creek" zone="531" modtime="1539552658307" modby="bask0099" edits_since="1530226167480" chart_title="Islais Creek" >
  <marker lat="37.7468" lng="-122.38867"/>
  <tide_station>176</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Waterfront park with a sand/pebble beach. Best at high tide. This is a calm creek, well off the Bay in an industrial neighborhood. The site is home to Kayaks Unlimited, a non-motorized boating co-op. They have a secure storage container and boat storage of members boats is possible. The site is owned by the Port of San Francisco and there are plans to put in a public toilet...sometime. There is a dock but it is locked and unusable. From here go north along the city front or south to Candlestick Park. Recently the pilings were all removed from Islais Creek making maneuvering safer and easier.</p>
      <p><b>Parking: </b>On the street. Free but only about a dozen spots. There is a loading area.</p>
      <p><b>Facilities: </b>None except a picnic table.</p>
      <p><b>Address: </b>Corner of Quint and Arthur, by the 3rd St bridge.</p>
      <p><b>Contact Info: </b>SF Port, 415-274-0539<br>Kayaks Unlimited, kayaks.unlimited@gmail.com</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/islais-creek/">Bay Area Water Trail - Islais Creek</a></p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/Islais%20Creek4,%20Zero%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Islais%20Creek2,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528321311615-117-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Islais Creek beach, low tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="118" title="San Francisco, India Basin Shoreline Park" zone="531" modtime="1604785395649" modby="bask0099" edits_since="1530123156225" chart_title="India Basin" >
  <marker lat="37.73509" lng="-122.37506"/>
  <tide_station>176</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from a small sand/rocky/mud beach at the turn around that goes quickly to mud at low tide. The park is open from 7AM-6PM. The park is fairly protected but is in the same wind tunnel that makes Candlestick a favorite of windsurfers. From here paddle south to Candlestick or north to destinations in SF or even cross the Bay to Alameda Island or San Leandro. For a short paddle go north to Heron Head park for a picnic. There is a possible alternate launch directly behind the lower parking lot. High tide only.</p>
      <p><b>Parking: </b>Free parking for about 20 cars. There is a gate. Don&#x27;t get locked in.</p>
      <p><b>Facilities: </b>Porta potties, picnic tables, benches, lawn. The Bay trail goes through here.</p>
      <p><b>Address: </b>Hunters Point Rd. to Hawes St. and go to the end.</p>
      <p><b>Contact Info: </b>SF Dept of Parks and Rec, 415-822-1900</p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/India%20Basin.JPG" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/India%20Basin%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604785395649-118-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>4 foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604785395650-118-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>4&#x27; tide. Possible launch at high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="119" title="Candlestick Point State Recreation Area, San Francisco" zone="531" modtime="1538601592837" modby="petolino" edits_since="1537826618445" chart_title="Candlestick Pt" >
  <marker lat="37.70901" lng="-122.38204"/>
  <tide_station>176</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>There are two launch spots in the park about 50 yds apart. One is at the far south end at Windsurfers Circle and the other, about midway between the park entrance and Windsurfers Circle, is a beautiful, east facing, white sand beach that goes to very serious mud at low tide. Bear in mind that places with names like Windsurfers Circle can have howling wind. Also note that the windsurfers have cleared a path through the rocks to the water making this usable at mid as well as high tides.</p>
      <p><b>Parking: </b>Parking is plentiful and free. The park is open Sat-Wed, 8AM-5PM. Rangers warn about car break-ins in the parking lot.</p>
      <p><b>Facilities: </b>Facilities include restrooms, picnic tables, BBQ grills and running water. There is a camping area out by the fishing pier. It has 6 sites, each with a flat spot for a tent, picnic table and BBQ grill. New bathrooms are near the pier. Future plans include a launch ramp near the camping area. Presently kayaks must land some distance from the camping area.</p>
      <p><b>Address: </b>Hunters Point in San Francisco</p>
      <p><b>Contact Info: </b>Ranger, 415-671-0145</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=519">http://www.parks.ca.gov/&#x3F;page_id&#x3D;519</a></p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/Candlestick,%20east-facing%20beach.jpg" height="299" width="400">
      <br><span class='details_caption'>East facing beach at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Candlestick%20main%20beach,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>East facing beach at high tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Candlestick%20windsurf%20launch,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Windsurfers circle at 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528318904107-119-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Candlestick Park, Windsurfers circle, low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1537826618445-119-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Candlestick campsite, 9-2018</span>
  ]]></details>
</station>
  <station station_type="launch" xid="120" title="Brisbane Marina" zone="531" modtime="1526751369172" modby="bask0099" edits_since="0" >
  <marker lat="37.673167" lng="-122.381167"/>
  <tide_station>270</tide_station>
  <city>Brisbane</city>
  <details><![CDATA[
      <p><b>Overview: </b>Lawns and picnic tables. Public restrooms. Check in the harbormasters office to get access to the guest dock &#x28;high dock&#x29; for launching. Hours are M-Sat, 8AM-5PM and Sun 8AM-4:30PM. Although the docks are locked this marina has been very kayak friendly.</p>
      <p><b>Parking: </b>Free.</p>
      <p><b>Facilities: </b>Restrooms. You need a key to get in. Get it from the harbormaster. Harbormaster&#x27;s office hours are 8AM-5PM M-Sat&#x3B; 8AM-4:30PM, Sun.</p>
      <p><b>Address: </b>400 Sierra Pt. Parkway, Brisbane</p>
      <p><b>Contact Info: </b>Harbormaster, 415-583-6975</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.brisbane.ca.us/about-brisbane-marina">http://www.ci.brisbane.ca.us/about-brisbane-marina</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="121" title="Oyster Point Park in the Oyster Point Marina" zone="531" modtime="1530137472688" modby="bask0099" edits_since="1528388159312" chart_title="Oyster Point Park" >
  <marker lat="37.66399" lng="-122.38348"/>
  <tide_station>270</tide_station>
  <city>Brisbane</city>
  <details><![CDATA[
      <p><b>Overview: </b>This lovely, protected, white sand beach is at the back of the marina with an exit from the marina through a break in the northern sea wall. Watch out for arriving and departing ferries if going through the main marina entrance.<br></p>
      <p><b>Parking: </b>Free parking. Marina is open from 5:30AM-10:30PM. There are 10 spaces by the beach. Loading happens and rigging in the parking lot at the beach.</p>
      <p><b>Facilities: </b>No facilities at the beach. The hotel is closed. Restrooms are located in the main part of the marina. Kayak storage is now offered next to the harbormaster&#x27;s office. There is a spot for a picnic. Harbormaster office hours are 9AM-4PM, M-F.</p>
      <p><b>Address: </b>95 Harbormaster Rd, South San Francisco</p>
      <p><b>Contact Info: </b>Harbormaster, 415-952-0808<br>San Mateo County Harbor District, 650-726-4723</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smharbor.com/oyster-point-marina-park">http://www.smharbor.com/oyster-point-marina-park</a></p>
      <p><img class="details_img" src="images/San%20Mateo,%20Zero%20Tide/Oyster%20Point%20beach,%20looking%20east.jpg" height="299" width="400">
      <br><span class='details_caption'>Beach at low tide</span>
      <p><img class="details_img" src="images/7foot/San%20Mateo,%207'%20tides/Oyster%20Point%20beach,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Beach at high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="122" title="Coyote Point Beach" zone="531" modtime="1526679093611" modby="bask0099" edits_since="0" chart_title="Coyote Pt Beach" >
  <marker lat="37.58995" lng="-122.32521"/>
  <tide_station>86</tide_station>
  <city>San_Mateo</city>
  <details><![CDATA[
      <p><b>Overview: </b>San Mateo County Park has a nice sandy beach that faces north and is attractive to kayakers and windsurfers and kiteboarders. Generally the east end of the beach is for kayakers and the west end for the windsurfers. The windsurf outfitter Boardsports has a facility in the building at the west end. The wind blows here and the airport is dead ahead. Best to paddle south.</p>
      <p><b>Parking: </b>Once inside the park there is no other charge for parking. It costs &#x24;6 to get into the park. The east and west ends of the beach have separate parking areas. Both have loading areas.</p>
      <p><b>Facilities: </b>Both the east and west ends have restrooms with changing areas, picnic areas, drinking fountain and outdoor showers.</p>
      <p><b>Address: </b>1900 Coyote Point Rd, San Mateo</p>
      <p><b>Contact Info: </b>Coyote Park Headquarters, 650-573-2592<br>Boardsports, 415-385-1224<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smcoparks.org">http://www.smcoparks.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526679093611-122-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Coyote Point, kayak ramp, mid-tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526679093612-122-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kayak ramp at east beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526679093613-122-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Coyote Point beach, looking west</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526679093614-122-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Coyote Point, Windsurf ramp, mid-tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526679093615-122-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windsurf ramp at coyote Point, high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="123" title="Coyote Point Marina" zone="531" modtime="1526678127479" modby="bask0099" edits_since="1526678064331" chart_title="Coyote Pt Marina" >
  <marker lat="37.59086" lng="-122.31839"/>
  <tide_station>86</tide_station>
  <city>San_Mateo</city>
  <details><![CDATA[
      <p><b>Overview: </b>San Mateo County Park marina. It has a ramp with high float dock. The park is open from 8AM-8PM</p>
      <p><b>Parking: </b>Once inside the park there is no further charge for parking. it costs &#x24;6 to get into the park. There is plenty of parking and some of it is close to the ramp.</p>
      <p><b>Facilities: </b>There are restrooms, a drinking fountain and outdoor shower by the harbormaster&#x27;s office.</p>
      <p><b>Address: </b>1900 Coyote Point Rd.</p>
      <p><b>Contact Info: </b>Harbormaster, Mike Bettis, 650-573-2594 or 650-207-5419</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smcoparks.org/">http://www.smcoparks.org</a></p>
      <p><img class="details_img" src="images/San%20Mateo,%20Zero%20Tide/Coyote%20Point%20launch%20ramp.JPG" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526678064331-123-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>High tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="124" station_class="water_trail" title="East 3rd Avenue (AKA Baywinds Park), Foster City" zone="531" modtime="1528314495994" modby="bask0099" edits_since="1526674841762" chart_title="Baywinds Park" >
  <marker lat="37.5715" lng="-122.27874"/>
  <tide_station>355</tide_station>
  <city>San_Mateo</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is a public south facing shore pretty much developed for and by windsurfers and kite boarders. Did I mention that it&#x27;s windy&#x3F; However, on calm mornings this is an pretty nice launch site for kayakers too There is a sandy beach that goes to mud at low tide. Don&#x27;t be there then. High tide only. At the west end of the parking lot the Bay Trail provides a wide, flat paved path to the beach from the parking lot. The carry is about 100 yds along the path and shorter &#x28;30 yds&#x29; if you are willing to carry your boat through a low rip rap wall. At the east end of the parking lot there is a narrow concrete ramp through the rip rap to the water. The carry is about 30 yds.</p>
      <p><b>Parking: </b>There is plenty of free parking in the lot as well as along the road coming in. No time restrictions are posted.</p>
      <p><b>Facilities: </b>There are clean, well maintained, bathrooms with an outdoor shower and drinking fountain by the parking lot. There are picnic tables and a BBQ. There are astroturf rigging areas at both ends of the parking lot. A couple kiteboarding outfitters have storage containers here.</p>
      <p><b>Contact Info: </b>Foster City Parks and Rec, 650-286-3380</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/baywinds-park-2/">Bay Area Water Trail - Baywinds Park</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526674841762-124-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>3rd St beach at low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526674841763-124-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>3rd ave. beach at mid-tide, 4-13-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526674841764-124-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>3rd ave. path to beach 4-13-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526674841765-124-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>3rd ave ramp with fisherman, 4-13-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528314495994-124-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windsurf Launch RAmp at a very low tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='125' title="Foster City, Beaches on the Bay" zone='531' chart_title="Beaches on the Bay" >
    <marker lat="37.56415" lng="-122.24935"/>
    <tide_station>29</tide_station>
    <city>Foster_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This is a public shore with a sandy beach. High tide only.
        <p><b>Parking: </b>On street parking.
        <p><b>Facilities: </b>None.
		  <p><img class='details_img' src="images/San Mateo, Zero Tide/Foster City shoreline.JPG" alt="Foster City shoreline"/>
  		  <br><span class='details_caption'>Picture taken at zero tide</span>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="126" title="Seal Point Park, San Mateo" zone="531" modtime="1528313595545" modby="bask0099" edits_since="1526676244807" chart_title="Seal Pt Park" >
  <marker lat="37.575806" lng="-122.300417"/>
  <tide_station>29</tide_station>
  <city>San_Mateo</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch consists of slimy concrete stairs through the rip rap about &#xBC; mile from the parking lot. This place is inconvenient and dangerous. Don&#x27;t go here.</p>
      <p><b>Parking: </b>Plenty of free parking.</p>
      <p><b>Facilities: </b>Facilities include bathrooms and a drinking fountain and a small lawn beside the launch stairs.</p>
      <p><b>Contact Info: </b>City of San Mateo, 415-377-3340</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528313595545-126-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
  ]]></details>
</station>
  <station station_type="launch" xid="127" title="Ryder Park" zone="531" modtime="1526676389420" modby="bask0099" edits_since="0" >
  <marker lat="37.575028" lng="-122.305778"/>
  <tide_station>29</tide_station>
  <city>San_Mateo</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch at high tide &#x28;beware the mud of low tide&#x29; from the mud bank under the power tower.</p>
      <p><b>Parking: </b>Plenty of parking</p>
      <p><b>Facilities: </b>Just across the foot bridge is Seal Point Park with more parking, bathrooms etc. Park has a kiddie playground, grass trees etc.</p>
      <p><b>Address: </b>1801 J. Hart Clinton Dr., San Mateo</p>
  ]]></details>
</station>
  <station station_type="launch" xid='128' title="Foster City Lagoon" zone='531' >
    <marker lat="37.55568" lng="-122.25972"/>
    <tide_station>29</tide_station>
    <city>Foster_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Waterfront park with a launch ramp. Sheltered, shallow water paddling. 
        No boats with gas engines allowed. 
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>Restrooms.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='129' title="Redwood Shores Lagoon" zone='531' >
    <marker lat="37.52867" lng="-122.25852"/>
    <tide_station>29</tide_station>
    <city>Foster_City</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Public access to a dirt beach. 
        <p><b>Parking: </b>Available.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="130" station_class="water_trail" title="Redwood City Municipal Marina" zone="531" modtime="1537825408672" modby="bask0099" edits_since="1526661849846" chart_title="Municipal Marina" >
  <marker lat="37.50237" lng="-122.21461"/>
  <tide_station>322</tide_station>
  <city>Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>A good launch location for exploring the sloughs or a paddle out into the South Bay. Convenient to Bair Island, Corkscrew Slough, Steinberger Slough, Smith Slough, and Redwood Creek. You can launch from either the concrete launch ramp of the nearby low float dock. From here explore the sloughs or head out to the Bay. This is a commercial port so watch out for big boats. The ramp is supposed to be open 6AM-10:30PM. It is supposed to cost &#x24;5 to launch. If more people paid it maybe the bathrooms would be better.<br></p>
      <p><b>Parking: </b>Free. 9 spaces in the lot and 15-20 on the street. There is a loading area and no time restrictions. No overnight parking allowed. Hours are 6AM to 10:30PM</p>
      <p><b>Facilities: </b>Restrooms &#x28;old and in need of repair&#x29;, lawn, picnic tables, drinking fountain. There is a large low float dock that is separate from the launch ramp that can be used when not in use by the youth sailing club. Picnic table, lawn and drinking fountain.</p>
      <p><b>Contact Info: </b>Harbormaster, 650-306-4150<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/redwood-city-municipal-marina/">Bay Area Water Trail - Redwood City Municipal Marina</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.gobair.org/Bair_Island">Bair Island Aquatic Center</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526661849846-130-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Redwood City Muni High Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526661849847-130-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Redwood City Muni Low Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526661849848-130-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Redwood City Muni hand launch Low Tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="131" title="Corkscrew Slough/Westpoint Slough Entrance" zone="531" modtime="1526660877410" modby="bask0099" chart_title="Corkscrew Slough West" >
  <marker lat="37.51628" lng="-122.20303"/>
  <tide_station>322</tide_station>
  <city>Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>A good launch location for exploring the sloughs. It is nearly straight across from the entrance to Corkscrew Slough at the intersection with Westpoint Slough. Go on Seaport Blvd past Chesapeake. As you come into the office complex, go to the left on the loop road. Go past the office buildings and take a left into the parking area by the water. There is a nice public park there. The launch is across some rocks, but not bad. The shoreline goes from rocks at high tide to mud at low tide. Choose you poison.</p>
      <p><b>Parking: </b>Available in the lot.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Address: </b>End of Seaport Blvd.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526660877410-131-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Corkscrew/Westpoint Slough High Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526660877411-131-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Corkscrew/westpoint Slough Low Tide 1</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526660877412-131-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Corkscrew/Westpoint Slough Low Tide 2</span>
  ]]></details>
</station>
  <station station_type="launch" xid="132" title="Redwood Creek off Herkner Rd." zone="531" modtime="1526660090535" modby="bask0099" chart_title="Redwood Creek" >
  <marker lat="37.509066" lng="-122.21113"/>
  <tide_station>322</tide_station>
  <city>Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>A good launch location for exploring the sloughs or a paddle out into the South Bay. As you go on Seaport Blvd past Chesapeake, you will come up to another stoplight. You go left &#x28;kind of&#x29; at the light and end up paralleling Seaport, but on the slough side of it. It is a kind of frontage road, the light being more of a fork in the road. A little ways down you will see a &#x22;public access&#x22; sign pointing you to a left turn into what looks like a parking lot for one of the industrial sites. Follow the road past all the warning signs and you will find a small park and a boat ramp. the dock is locked and unavailable to the public. The concrete launch ramp has a chain across it which is easily stepped over...</p>
      <p><b>Parking: </b>Free with space for 6 cars and a loading area about 50 yds from the ramp. It has no time restrictions from 8AM to 5PM with no overnight parking allowed. It may be that the roadway is locked after these hours.</p>
      <p><b>Facilities: </b>Picnic tables. No restrooms.</p>
      <p><b>Address: </b>Just off Herkner Rd before it does a 120 degree turn.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526660090535-132-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Redwood Creek High Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526660090536-132-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Redwood Creek Low Tide</span>
  ]]></details>
</station>
  
  <station station_type="launch" xid="134" station_class="water_trail" title="Palo Alto Baylands Launch Ramp" zone="531" modtime="1538602148608" modby="petolino" edits_since="1537825667052" chart_title="Baylands Ramp" >
  <marker lat="37.45751" lng="-122.10116"/>
  <tide_station>276</tide_station>
  <city>Palo_Alto</city>
  <details><![CDATA[
      <p><b>Overview: </b>A nice launch spot to explore the South Bay. Just don&#x27;t get stuck in the mud at low tide&#x21; The sign suggests being back at the dock 3 hours before low tide. There is a low float dock that is in the water at all tides even though the slough may be too shallow to paddle in at low tide. There is supposed to be a deep channel that extends to mid-bay. Local knowledge is good.</p>
      <p><b>Parking: </b>Free. there is a large gravel lot next to the floating dock for about 15 cars with room for 10 more in the overflow parking. There is a loading area. Park hours are 8:00AM-sunset according to the city website, although a sign on-site says 8:30AM-sunset.</p>
      <p><b>Facilities: </b>Restrooms are about 200 yds away from the ramp. There is one unit and it is clean and well maintained. There is a hose bib to wash off your boat. There is a drinking fountain near the bathroom and a picnic area.</p>
      <p><b>Address: </b>East end of Embarcadero Road</p>
      <p><b>Contact Info: </b>City of Palo Alto, Parks, 650-617-3156</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/palo-alto/">Bay Area Water Trail - Baylands Sailing Station</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.cityofpaloalto.org/gov/depts/csd/parks/preserves/baylands.asp">Baylands Nature Preserve</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695191-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto High Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695192-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto Low Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695193-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto Low Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695194-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto, Parking Lot-south side</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695195-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto, facilities sign</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526606695196-134-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Palo Alto, low dock, high tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="135" title="Westpoint Slough - Bedwell Bayfront Park" zone="531" modtime="1527221544414" modby="petolino" edits_since="1526608207059" chart_title="Westpoint Slough" >
  <marker lat="37.489889" lng="-122.177611"/>
  <tide_station>442</tide_station>
  <city>Palo_Alto</city>
  <details><![CDATA[
      <p><b>Overview: </b>This park borders a slough that runs along the side of the road and connects to the Bay The bank where you can launch is pickleweed with major mud at low tide. The &#x22;beach&#x22; is an undeveloped mud bank. This is another park built on a former garbage dump. Break-ins are common so don&#x27;t leave anything valuable in the car.</p>
      <p><b>Parking: </b>Free parking in a paved lot with about 20 spaces. There is a loading area for one car. No overnight parking allowed. Park opens at 7AM. Closing times vary. The launch, into the slough, is about 30 yds from the parking lot.</p>
      <p><b>Facilities: </b>There are bathrooms at the parking lot which are old but clean. The park also has a drinking fountain and a picnic area.</p>
      <p><b>Address: </b>1600 Marsh Road</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526608207059-135-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Bayfront, High Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526608207060-135-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Bayfron,t Low Tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="136" title="Pt. San Pablo Yacht Harbor" zone="530" modtime="1604723677296" modby="bask0099" edits_since="1548088630262" chart_title="Point SPYH" >
  <marker lat="37.96331" lng="-122.41984"/>
  <current_station>307</current_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Funky place. Park in the lot you first arrive at. You can unload your stuff down the road by the house boats. The launch beach is to your left as you look at the bay. The launch is muddy at low tide. The harbor was sold a couple years ago and many positive changes are occuring. The launch beach belongs to Chevron. The harbor is open from 8AM to 7PM.</p>
      <p><b>Parking: </b>Free. There are quite a few &#x22;Public Shoreline Access&#x22; parking spots but to be polite to the tenants unload by the beach and park in the main dirt lot. For overnight parking contact the owner.</p>
      <p><b>Facilities: </b>There is a public restroom by the house boats. It is a one seater, clean and well maintained. The cafe, Nobilis Restaurant, has re-opened with limited hours.</p>
      <p><b>Address: </b>1900 Stenmark Dr. Take the last exit from westbound Hwy 580 just before the toll plaza for the San Rafael Bridge. The road to the harbor is narrow and very &#x22;interesting&#x22;.</p>
      <p><b>Contact Info: </b>Harbormaster, 510-233-3224<br>info@pspharbor.com<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://www.pspyh.com/">http://www.pspyh.com/</a></p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Point%20San%20Pablo%20Yacht%20Harbor2,%20Zero%20tide.JPG" height="300" width="400">
      <br><span class='details_caption'>Launch beach at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527998485647-136-bask0099.jpg" height="298" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pt San Pablo Yacht Harbor,launch beach at mid-tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1548088630262-136-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Seven foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1548088630263-136-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Seven foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604723677296-136-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pt. San Pablo Harbor</span>
  ]]></details>
</station>
  <station station_type="launch" xid='137' title="Richmond, Western Drive Pocket Beach" zone="530" chart_title="Pocket Beach" >
    <marker lat="37.92638" lng="-122.39218"/>
    <current_station>302</current_station>
    <city>Richmond</city>
    <details>
      <![CDATA[<p><b>Overview: </b>No information currently available
		  <p><img class='details_img' src="images/Contra Costa, Zero Tide/Wester Dr Pocket Beach.JPG" alt="Western Drive Pocket Beach"/>
  		  <br><span class='details_caption'>Picture taken at zero tide</span>
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid="138" title="Richmond, Keller Beach" zone="530" modtime="1548089344414" modby="bask0099" edits_since="1529370926200" chart_title="Keller Beach" >
  <marker lat="37.92068" lng="-122.3865"/>
  <current_station>302</current_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is more of a destination than launch because of the uphill climb from the beach. Sandy beach access is down a 150 yd sloping, paved path. Bring wheels for the carry back up the path. The beach is usable at all tide levels although at low tide there is firm mud. Park hours are 5AM-10PM. Closed at night. Whereas the beach is protected it isn&#x27;t far to exposed water where you&#x27;ll feel the summer wind. It also isn&#x27;t far to the main north/south shipping lanes where you&#x27;ll encounter strong currents as well as boat traffic. Do not try to paddle under or close to the Chevron pier. 5 miles to the Richmond Marina, 8 miles to Berkeley, 6 miles to China Camp.</p>
      <p><b>Parking: </b>On the road. There are no parking restrictions but overnight is not allowed.</p>
      <p><b>Facilities: </b>Restrooms &#x28;about 70 yds to the beach&#x29;, picnic tables. There is a drinking fountain near the bathrooms and a grassy area. This site is within walking distance of downtown Point Richmond where there are quite a few eating and drinking opportunities.</p>
      <p><b>Address: </b>Dornan Dr at the intersection of Western Dr and just after exiting the tunnel.</p>
      <p><b>Contact Info: </b>East Bay Regional Parks</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/keller-beach/">Bay Area Water Trail - Keller Beach</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ebparks.org/parks/miller_knox">http://www.ebparks.org/parks/miller_knox</a></p>
      <p><img class="details_img" src="images/keller-bch.jpg" height="284" width="400">
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Kellers_BEach,_Richmond.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/2017-12-02%20Kellers%20beach%20at%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="139" title="Point Molate Beach Park, Richmond" zone="530" modtime="1548088980802" modby="bask0099" edits_since="1530232034261" chart_title="Point Molate Park" >
  <marker lat="37.941628" lng="-122.410689"/>
  <current_station>345</current_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Easy access to Red Rock, China Camp, Point San Pablo, and even Point Pinole. Note: +2 foot tide is needed to launch or land without mud. The stairs to the beach are highly eroded and it is a scramble. The distance from the parking lot to the stairs is about 30 or 40 yds. The beach is sand going to firm mud then going to sucking slime, and lots of it.</p>
      <p><b>Parking: </b>Parking is free in a large lot for 22 cars. It is open sunrise to sunset. It is about 50 yds to the beach. There is a loading area. There are no time restrictions but overnight parking is not allowed.</p>
      <p><b>Facilities: </b>Portable ADA toilet &#x28;disgusting&#x29;, picnic tables, and charcoal grills.</p>
      <p><b>Address: </b>Point Molate can only be reached from west bound Hwy 580. It&#x27;s the last exit before the tollbooth &#x28;Stenmark Dr or maybe Western Dr.&#x29;. The park is about 1 mile from the bridge.</p>
      <p><b>Contact Info: </b>City of Richmond Parks and Landscaping Division, https://ci.richmond.ca.us/71/Parks-and-Landscaping</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.pointrichmond.com/pointsanpablo/pointmolate.htm">http://www.pointrichmond.com/pointsanpablo/pointmolate.htm</a></p>
      <p><img class="details_img" src="images/ptmolate1.jpg" height="300" width="400">
      <br><span class='details_caption'>Path to beach</span>
      <p><img class="details_img" src="images/ptmolate2.jpg" height="271" width="400">
      <br><span class='details_caption'>Point Molate, mid-tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/2017-12-02%20point%20molate%20beach%20at%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527216307455-139-bask0099.jpg" height="400" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Decrepit, leg breaking stairs</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527216307456-139-bask0099.jpg" height="400" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>0.6&#x27; tide at Point Molate Beach</span>
  ]]></details>
</station>
  <station station_type="launch" xid="140" station_class="water_trail" title="Richmond, Ferry Point" zone="530" modtime="1590941459215" modby="petolino" edits_since="1548088061273" chart_title="Ferry Pt" >
  <marker lat="37.90959" lng="-122.38775"/>
  <current_station>301</current_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>A good launch spot for trips in the central San Francisco Bay. There is a sand beach which fronts to the deep-water, dredged channel going to the Richmond Harbor. The beach is usable at all tides. There is a new paved, ADA-accessible path that leads from the parking lot to the tideline. The beach faces south and tends to collect flotsam and jetsam. From here you can poke around the Richmond Harbor &#x28;historically interesting&#x29;, go to Red Rock, Pt. San Pablo Yacht Harbor, Berkeley or Angel Island. Check the tides and go with the flow.</p>
      <p><b>Parking: </b>Free parking in a large lot that is open from 8AM-4PM. there are 31 spaces plus 18 in a nearby lot. It is about 70 yds to the launch from the lot. Street parking is also available, and needed, as this is a very popular spot on weekends. They leave the exit gate open so you can get out after hours. There have been reports of vehicle break-ins. Do not leave anything of value out in the open in your car. It is likely that the development of &#x22;Terminal One&#x22; next to Ferry Point will make the parking situation worse. No overnight parking.</p>
      <p><b>Facilities: </b>New restrooms and a drinking fountain in the parking lot. Three stars out of 4. There is also three level outdoor shower. There is a picnic area with BBQs.</p>
      <p><b>Address: </b>At the corner of Dornan Dr and Brickyard Cove Rd.</p>
      <p><b>Contact Info: </b>East Bay Regional Parks, 510-635-0135</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/ferry-point-beach/">Bay Area Water Trail - Ferry Point Beach</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ebparks.org/parks/miller_knox">http://www.ebparks.org/parks/miller_knox</a></p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Ferry_Point,_Richmond.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Ferry%20Point3,%207'%20tide,%20Dec%202,%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide. Note new concrete ramp to the beach.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527100559359-140-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mid-tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="141" station_class="water_trail" title="Richmond, Boat Ramp Street" zone="530" modtime="1526422665309" modby="bask0099" chart_title="Boat Ramp Street" >
  <marker lat="37.924737" lng="-122.375887"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>A launch ramp for kayaks, next to the Point San Pedro Yacht Club. Walking distance to West Marine. The ramp is historic. That means old, funky and slippery. Since this is the very far back corner of the harbor it is very calm and protected. From here you could do a harbor tour of Richmond, go to Brooks Island &#x28;only if you signed up for a tour&#x29;, Berkeley etc.</p>
      <p><b>Parking: </b>You can unload near ramp but there are only 3 parking places. Parking is possible along Cutting Blvd. There is space for rigging next to the ramp.</p>
      <p><b>Facilities: </b>No bathroom. The little park has a picnic table and a garbage can.</p>
      <p><b>Address: </b>700 West Cutting Blvd., Richmond</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/boat-ramp-street/">Bay Area Water Trail - Boat Ramp Street</a></p>
      <p><img class="details_img" src="images/richmd-rampst.jpg" height="318" width="400">
      <br><span class='details_caption'>Rigging area and picnic table</span>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Boat_Ramp-Street_Richmond.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Boat%20Ramp%20St.2,%207'%20tide,%20Dec%202%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="142" station_class="water_trail" title="Richmond Municipal Marina" zone="530" modtime="1635118369348" modby="petolino" edits_since="1632343108448" chart_title="Richmond Marina" >
  <marker lat="37.9135" lng="-122.35433"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch ramp. You do have to pay for parking here, but there are all kinds of facilities and security is good. The ADA accessible kayak launch is next to the boat ramps.</p>
      <p><b>Parking: </b>&#x24;15/day for parking and use of the ramp with a 48 hour limit unless you get permission from the harbormaster. If you are storing a boat there you get a parking pass for the year.</p>
      <p><b>Facilities: </b>Restrooms and drinking fountain. The marina has secure storage for kayaks for &#x24;30/month outside and &#x24;40/month inside. Contact the harbormaster for more details.</p>
      <p><b>Address: </b>1340 Marina Way South, Richmond</p>
      <p><b>Contact Info: </b>Harbormaster, 510-236-1013, hours are Mon-Sat, 9AM-5PM</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/marina-bay-yacht-harbor/">Bay Area Water Trail - Marina Bay Yacht Harbor</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.mbyh.com/">http://www.mbyh.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526423855103-142-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Richmond Marina Launch ramp.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604095617342-142-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Richmond Marina kayak launch</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1612493950571-142-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Richmond marina kayak dock</span>
  ]]></details>
</station>
  <station station_type="launch" xid="143" title="Richmond, Marina Bay Park &amp; Rosie the Riveter WWII National Memorial" zone="530" modtime="1526616697599" modby="bask0099" chart_title="Marina Bay Park" >
  <marker lat="37.91421" lng="-122.34758"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public shoreline with a sand beach. Time restriction is sunrise to sunset. Below the beach is a low seawall of rip rap. The best place to launch is beside the little observation pier. At high tide the water comes over the rip rap and wall onto the beach.</p>
      <p><b>Parking: </b>Free and in a very large lot that may be private. Street parking is OK.</p>
      <p><b>Facilities: </b>Restrooms with drinking fountain is in the parking lot, about 100 yds from beach. There is also a picnic table back from the beach. Grassy areas.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.richmond.ca.us/1646/marina-park-green">http://www.ci.richmond.ca.us/1646/marina-park-green</a></p>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/2017-12-02%20Rosie%20Riviter%20beach,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526424891263-143-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rosie the Riveter beach, Richmond Marina, mid tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526424891264-143-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rosie the Riviter beach, mid tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526424891265-143-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rosie the Riveter at zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="144" station_class="water_trail" title="Richmond, Vincent Park-South" zone="530" modtime="1526616775502" modby="bask0099" chart_title="Vincent Park S" >
  <marker lat="37.90767" lng="-122.35027"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is the sweetest of the Richmond launches&#x21; South Beach is at end of broad concrete walkway, close to parking. From here paddle around Brooks Island, tour the Richmond harbor, go to Angel island or Berkeley. The beach is usable at all but the very lowest tides. Just west of the beach is a set of stairs through the rip rap. At low tide there is sand.</p>
      <p><b>Parking: </b>Free and plenty of it.</p>
      <p><b>Facilities: </b>Restrooms and a picnic area with 9 tables and 4 BBQs.</p>
      <p><b>Address: </b>Location is the end of Peninsula Drive.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/vincent-park/">Bay Area Water Trail - Vincent Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ci.richmond.ca.us/1620/barbara-jay-vincent-park">http://www.ci.richmond.ca.us/1620/barbara-jay-vincent-park</a></p>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Vincent%20Park2,%207'%20tide,%20Dec%202,%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526427318462-144-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jay Vincent Park at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526427318463-144-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Vincent Park beach, mid tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="145" station_class="water_trail" title="Richmond, Vincent Park-West" zone="530" modtime="1526427731531" modby="bask0099" chart_title="Vincent Park W" >
  <marker lat="37.90787" lng="-122.35187"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Another sweet Richmond Beach. West Beach is longer walk from the parking lot at Vincent Park, but, because it lies inside the breakwater it is protected from wind waves. It is usable at all tides.</p>
      <p><b>Parking: </b>Free and plenty of it.</p>
      <p><b>Facilities: </b>Restrooms, picnic area with 9 tables and 4 BBQs..</p>
      <p><b>Address: </b>Location is the end of Peninsula Dr.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/vincent-park/">Bay Area Water Trail - Vincent Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ci.richmond.ca.us/1620/barbara-jay-vincent-park">http://www.ci.richmond.ca.us/1620/barbara-jay-vincent-park</a></p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Vincent%20Park,%20West%20Beach.JPG" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/VincentParkInnerBeach+5ft.jpg" height="300" width="400">
      <br><span class='details_caption'>View west along breakwater. Picture taken at +5 ft tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Vincent%20Park,%20west%20beach,%207'%20tide,%20Dec%202,%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at +7 ft tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="146" station_class="water_trail" title="Shimada Park, Richmond" zone="530" modtime="1538600509275" modby="petolino" edits_since="1526428407198" chart_title="Shimada Park" >
  <marker lat="37.90766" lng="-122.34466"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Nice shoreline park in a residential neighborhood. It has a set of concrete stairs through the rip rap. Below the stairs is sand then mud. Beware, the last couple of steps are very slippery&#x21; There is a rigging area near the stairs. The park is open from sunrise to sunset. This site is quite popular with windsurfers. Otherwise, like Vincent Park, it is a good starting point for a paddle around Brooks Island or a tour of the Richmond Marina or a trip to Angel Island or Berkeley.</p>
      <p><b>Parking: </b>Free. There are 8 spaces near the stairs and 10 more further away. No overnight parking allowed.</p>
      <p><b>Facilities: </b>Restrooms which are closed and locked at sunset. The park has grass, benches, 4 picnic tables and 4 BBQs and running water.</p>
      <p><b>Address: </b>Location is on Peninsula Drive</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/shimada-friendship-park/">Bay Area Water Trail - Shimada Friendship Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ci.richmond.ca.us/2309/shimada-friendship-park">http://www.ci.richmond.ca.us/2309/shimada-friendship-park</a></p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Richmond,_Shimada_Park.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Shimada%20Park,%207ft%20tide,%20dec%202,%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="147" title="Point Isabel Regional Shoreline" zone="530" modtime="1634184536900" modby="bask0099" edits_since="1568242907289" chart_title="Point Isabel" >
  <marker lat="37.89896" lng="-122.3253"/>
  <tide_station>293</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Point Isabel is a waterfront park and dog park managed by East Bay Regional Park District. Improvements to the launching area have recently been completed. The site was improved with windsurfers in mind &#x28;oh yes, there&#x27;s wind&#x29; but is pretty wonderful for kayakers too.</p>
      <p><b>Parking: </b>Free. But there are time limits.</p>
      <p><b>Facilities: </b>The dog park has restrooms, picnic tables, benches, BBQ grills, a snack bar and happy dogs running free. Watch where you step.</p>
      <p><b>Address: </b>2701 Isabel St. Just beyond Costco.</p>
      <p><b>Contact Info: </b>East Bay Regional Parks, 510-635-0138</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/pt_isabel">East Bay Regional Parks - Point Isabel</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1554262952294-147-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1568242907289-147-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pt Isabel, ADA ramp, 6&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634184536900-147-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Launch at .4&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="148" station_class="water_trail" title="Albany Beach" zone="530" modtime="1604201660773" modby="bask0099" edits_since="1539551384372" >
  <marker lat="37.88815" lng="-122.31611"/>
  <tide_station>293</tide_station>
  <city>Albany</city>
  <details><![CDATA[
      <p><b>Overview: </b>Albany Beach is a beautiful white sand beach accessible at both low and high tides. The park is closed from 10PM -5AM. The path from the parking lot to the beach is concrete and a boardwalk and is maybe 40-50 yds. It is very popular especially with happy dogs.</p>
      <p><b>Parking: </b>Drive to the end of Buchanan St. and then go left. There are 17 parking places along the bike path very near the path to the beach. there is a turn around area at the end that can be used for loading. There is also a large amount of parking along Buchanan St. It is often full on weekends.</p>
      <p><b>Facilities: </b>Bathrooms. No running water. Picnic tables near the bathrooms.</p>
      <p><b>Address: </b>West end of Buchanan Street</p>
      <p><b>Contact Info: </b>City of Albany, 510-528-5710</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/albany-beach/">Bay Area Water Trail - Albany Beach</a></p>
      <p><img class="details_img" src="images/albany-bch.jpg" height="298" width="400">
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/PB150016%20-%20Albany%20Bulb%20Beach%20at%200%20Tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Albany%20Beach,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604201660773-148-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Albany Beach 10-2020 access from parking</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604201660774-148-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Albany Beach access, 10-2020</span>
  ]]></details>
</station>
  <station station_type="launch" xid="149" title="Tom Bates Regional Sports Complex" zone="530" modtime="1526490978033" modby="bask0099" chart_title="Tom Bates Sports" >
  <marker lat="37.877361" lng="-122.310056"/>
  <tide_station>293</tide_station>
  <city>Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>Located just north of the sports complex and south of the racetrack. Launch from a tiny spit with access through the rip rap. At low tide there is a small beach &#x28;behind the taco truck&#x29;. Enter via the race track. There are plenty of birds in the north basin. Bring binoculars and don&#x27;t disturb.</p>
      <p><b>Parking: </b>Free parking. Lot is closed from 11PM to 8AM. The parking lot is heavily used by people using the sports complex.</p>
      <p><b>Facilities: </b>Porta potties &#x28;disgusting&#x29;, drinking fountain and picnic tables. There is also a taco truck that is often present.</p>
      <p><b>Contact Info: </b>City of Berkeley, Parks, Rec and Waterfront, 510-981-6715<br>East Bay Regional Park District, 888-327-2757, option 3 x4528</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/eastshore/">http://www.ebparks.org/parks/eastshore/</a></p>
      <p><img class="details_img" src="images/new/TomBatesFieldLowTide.jpg" height="535" width="400">
      <br><span class='details_caption'>Picture taken at low tide</span>
      <p><img class="details_img" src="images/new/TomBatesSportsCtr+4.2ft.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at +4.2 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526490218462-149-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tom Bates sports center beach, +4.2&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526490218463-149-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tom Bates launch at +1&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="150" station_class="water_trail" title="Berkeley Marina Launch Ramp" zone="530" modtime="1607896684416" modby="bask0099" edits_since="1526616798214" chart_title="Berkeley Marina Ramp" >
  <marker lat="37.868611" lng="-122.3175"/>
  <tide_station>36</tide_station>
  <city>Berkeley</city>
  <details><![CDATA[
      <p><b>Overview: </b>Located inside the marina at the far north end. Launch from concrete ramp or dock. &#x24;16/day fee to launch &#x28;includes parking&#x29;. The dock by the ramp is high freeboard. There is a rigging area. From here go just about anyplace. Expect wind in the afternoons.</p>
      <p><b>Parking: </b>The parking lot is for trailers. Maybe cars are supposed to park on the street where it&#x27;s free. there is a gate to get into the ramp and parking lot so you have to pay in order to get in.</p>
      <p><b>Facilities: </b>Bathrooms are there but locked. There is a picnnic tsble.</p>
      <p><b>Contact Info: </b>Harbormaster, 510-981-6740<br>City of Berkeley, Parks and Rec. 510-981-6715</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/berkeley-marina-ramp/">Bay Area Water Trail - Berkeley Marina Boat Ramp</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ci.berkeley.ca.us/marina">http://www.ci.berkeley.ca.us/marina</a></p>
      <p><img class="details_img" src="images/berkeley-rmp.jpg" height="257" width="400">
  ]]></details>
</station>
  <station station_type="launch" xid="151" title="Point Emery, Emeryville" zone="530" modtime="1526498898858" modby="bask0099" chart_title="Point Emery" >
  <marker lat="37.845944" lng="-122.300278"/>
  <tide_station>36</tide_station>
  <city>Emeryville</city>
  <details><![CDATA[
      <p><b>Overview: </b>Located at the foot of Ashby Ave. Launch is a sand beach at mid or high tide. Mud and/or rocks at low tide. This site is completely exposed to wind no matter what direction it is blowing. This is probably a better bail-out spot than launch.</p>
      <p><b>Parking: </b>Parking is free in a small lot with about 10 spaces but almost always full. There are no time restrictions but overnight parking is not allowed &#x28;closed 9PM-6AM&#x29;. More parking is available on the street.</p>
      <p><b>Facilities: </b>No facilities.</p>
      <p><b>Contact Info: </b>City of Emeryville, 510-596-4300</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Point_Emery,_Emeryville.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Emery%20Point%20beach,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="152" station_class="water_trail" title="Berkeley South Sailing Basin" zone="530" modtime="1612493142520" modby="bask0099" edits_since="1608765240210" chart_title="South Sailing Basin" >
  <marker lat="37.863" lng="-122.31226"/>
  <tide_station>36</tide_station>
  <city>Berkeley</city>
  <details><![CDATA[
      <p><b>Overview: </b>The3 low floating docks are good launch spots for paddles into the Bay. The eastern docks are used mainly by kayakers and windsurfers. Because of its location and typical conditions &#x28;from sheltered to exposed, with wind blowing you to shore&#x29; it is also a prime spot for rescue practice. It does get muddy at low tide. The low float docks are for non-motorized craft only. There are a couple other places to launch besides the docks. The windsurfers have created a path through the rip rap beside the former site of Hs Lordships restaurant &#x28;closed in 2018&#x29;. There is a nice beach opposite the Strawbale Hut.</p>
      <p><b>Parking: </b>Free with no time restrictions but no overnight parking &#x28;closed between 11PM and 9AM&#x29; allowed. There is a loading and rigging area. The parking lot has been recently repaved and painted. The parking lot at the former Hs Lordships restaurant is now gated and locked.</p>
      <p><b>Facilities: </b>New restrooms in the parking lot. There is a drinking fountain. Snack bar and bait shop are located across the street from Cal Adventures.</p>
      <p><b>Address: </b>Foot of University Ave. in Berkeley</p>
      <p><b>Contact Info: </b>Cal Adventures, 510-462-4000<br>City of Berkeley, 510-981-2489<br>Harbormaster, 510-981-6740</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/berkeley-marina-small-boat-launch/">Bay Area Water Trail - Berkeley Marina Small Boat Launch</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ci.berkeley.ca.us/marina">http://www.ci.berkeley.ca.us/marina</a></p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Berkeley_Beach_west_o_%20Cal_Adven.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide. Use the dock in this situation. Beach west of docks</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Berkeley%20Marina,%20His%20%20Lordships,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide. Beach west of docks</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526495600720-152-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Berkeley low float, sm craft dock</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526495600721-152-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Berkeley, beach at strawbale hut</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526495600722-152-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>His Lordships path, April, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528487079732-152-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Parking Lot by Cal Adventures, facing West</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528487079733-152-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>New bathrooms at Berkeley marina, 6-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="153" station_class="water_trail" title="Emeryville Marina" zone="530" modtime="1612492339078" modby="bask0099" edits_since="1526499972671" >
  <marker lat="37.83834" lng="-122.31307"/>
  <current_station>113</current_station>
  <city>Emeryville</city>
  <details><![CDATA[
      <p><b>Overview: </b>Good protected launch for paddles into the Bay. Use of the ramp is free. It has a high freeboard dock but there is a little firm mud area right beside it that works too. The windsurf ramp is outside the breakwater and about 100yds from the parking lot. This is also the launch for the famous Ashby Shoal breakfasts on a negative tide Sunday morning in spring.</p>
      <p><b>Parking: </b>Plenty of spaces with a loading area by the ramp. Parking there is free. There may be a charge for overnight parking.</p>
      <p><b>Facilities: </b>Facilities include restrooms, chandlery and nearby restaurants.</p>
      <p><b>Contact Info: </b>Emeryville Marina, 510-596-4340<br>Harbormaster, 510-654-3716</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.emeryvillemarina.com/">Emeryville Marina</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/emeryville-marina/">Bay Area Water Trail - Emeryville Marina</a></p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Emeryville_Windsurf_Ramp.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/EmeryvilleWindsurferRamp+4.2ft.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 4.2 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526499972671-153-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Emeryville Marina launch ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526499972672-153-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Ashby Shoal breakfast</span>
  ]]></details>
</station>
  <station station_type="launch" xid="154" title="Oakland Middle Harbor Shoreline Park" zone="531" chart_title="Middle Harbor Park S" modtime="1657212490572" modby="petolino" edits_since="1528074491637" >
  <marker lat="37.80153" lng="-122.32442"/>
  <tide_station>261</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>A small park with access to the bay. It is very muddy at all but high tide. Owned and operated by the Port of Oakland.</p>
      <p><b>Parking: </b>Available but limited at this south end of Middle Harbor. Park open dawn to dusk every day.</p>
      <p><b>Facilities: </b>Restrooms at the tower.</p>
      <p><b>Address: </b>Enter at 2777 Middle Harbor Rd.</p>
      <p><b>Contact Info: </b>Port of Oakland, 510-627-1634 &#x28;M-F, 9AM-5PM&#x29;</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.portofoakland.com/port/seaport/middle-harbor">http://www.portofoakland.com/port/seaport/middle-harbor</a></p>
      <p><img class="details_img" src="images/new/MiddleHarborParkBeach+4ft.jpg" height="300" width="400">
      <br><span class='details_caption'>South view at +4 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528059171973-154-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Middle harbor Park, south end, low tide 5</span>
  ]]></details>
</station>
  <station station_type="launch" xid="155" title="California Canoe and Kayak, Oakland" zone="531" modtime="1620496163855" modby="petolino" edits_since="1620342374357" chart_title="C.C.K." >
  <marker lat="37.79413" lng="-122.27628"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>California Canoe and Kayak on Jack London Square. They offer kayak rentals and retail and have a low float dock with access to the Oakland estuary which is available for launching until dark. Paddling in the Oakland Estuary is usually calm. Summer afternoons can be breezy and there is shipping traffic to the west.</p>
      <p><b>Parking: </b>Metered parking is on the street &#x28;2 hour limit and 3 blocks away&#x29; or in a pay parking structure fairly close to the dock. &#x28;&#x24;1.50/hour&#x29; To unload boats stop at the foot of Franklin, unload fast, and take the car to the parking lot. The chains are down until 11AM to allow unloading next to the dock.</p>
      <p><b>Facilities: </b>Public bathrooms are located in the parking structure, at the fishing pier and in the harbor office.</p>
      <p><b>Address: </b>409 Water Street</p>
      <p><b>Contact Info: </b>Port of Oakland, 510-272-1100<br>City of Oakland &#x28;managing agency&#x29;, 510-238-3612<br>CCK, 510-893-7833</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.calkayak.com/">California Canoe and Kayak</a></p>
      <p><img class="details_img" src="images/new/CCKRamp.jpg" height="302" width="400">
  ]]></details>
</station>
  <station station_type="launch" xid="156" title="Jack London Square Public Dock, Oakland" zone="531" modtime="1526501117305" modby="bask0099" chart_title="Jack London Sq" >
  <marker lat="37.79437" lng="-122.27768"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>On Jack London Square, end of Broadway. The public dock has high freeboard and is often crowded with large power vessels. There is also a set of stone steps that go into the water that might work at high tide only because of the rip rap at the bottom of the steps.</p>
      <p><b>Parking: </b>Pay parking structure very close to the dock.</p>
      <p><b>Facilities: </b>Public bathrooms are located in the parking structure and at the harbor office .</p>
      <p><b>Address: </b>Foot of Broadway.</p>
      <p><b>Contact Info: </b>Port of Oakland, 510-272-1100<br>City of Oakland, 510-238-3612</p>
      <p><img class="details_img" src="images/new/JackLondonSqPublicDock.jpg" height="299" width="400">
      <br><span class='details_caption'>Public dock at foot of Broadway</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526501117305-156-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jack London Sq. foot of Broadway, 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526501117306-156-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jack London stairs at Briadway, 0&#x27; tide, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526501117307-156-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jack London Sq. public dock, crowded</span>
  ]]></details>
</station>
  <station station_type="launch" xid="157" station_class="water_trail" title="Estuary Park (formerly JLAC)" zone="531" modtime="1530224980734" modby="petolino" edits_since="1526505917515" chart_title="Estuary Park" >
  <marker lat="37.79047" lng="-122.26601"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from the Jack London Aquatic Center dock into the Oakland estuary. This formerly nice low dock is poorly maintained as is the whole area. There is also a funky concrete launch ramp. This area is not scheduled for an upgrade until 2027&#x21; From here cruise the Estuary or paddle around Alameda Island &#x28;14 miles&#x29;. The Estuary is generally calm with afternoon westerly breezes.</p>
      <p><b>Parking: </b>Parking is free. Launching is free.</p>
      <p><b>Facilities: </b>Restrooms &#x28;disgusting&#x29;.</p>
      <p><b>Address: </b>115 Embarcadero East</p>
      <p><b>Contact Info: </b>Oakland Parks and Rec, 510-444-3807<br>City of Oakland, 510-238-3612</p>
      <p><img class="details_img" src="images/new/EstuaryParkRamp-Oakland.jpg" height="300" width="400">
      <br><span class='details_caption'>Boat Ramp</span>
      <p><img class="details_img" src="images/new/JLAC.jpg" height="300" width="400">
      <br><span class='details_caption'>Low Dock</span>
  ]]></details>
</station>
  <station station_type="launch" xid="158" title="Middle Harbor Park" zone="531" chart_title="Middle Harbor Park N" modtime="1657212616418" modby="petolino" edits_since="1528220434948" >
  <marker lat="37.806715" lng="-122.322314"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>This park provides access to the central Bay. There is busy commercial shipping traffic right outside. Look left and right. Park is owned and operated by the Port of Oakland. Even at low tide there is firm sand to launch/land on. Over time Middle Harbor has filled and silted in. This process is ongoing and planned.</p>
      <p><b>Parking: </b>Plenty of free parking. Open 8:00 AM - dusk. Launch at high tide only. Otherwise it is about 300 yds from the parking lot to where you can launch along a level paved sidewalk. Bring wheels.</p>
      <p><b>Facilities: </b>Facilities include bathrooms, drinking fountains, lawns, picnic areas etc.</p>
      <p><b>Address: </b>2777 Middle Harbor Rd in Oakland</p>
      <p><b>Contact Info: </b>Port of Oakland, 510-627-1634, M-F, 9AM-5PM</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.portofoakland.com/port/seaport/middle-harbor">http://www.portofoakland.com/port/seaport/middle-harbor</a></p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Middle%20Harbor%20Park4.JPG" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528059081326-158-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Middle harbor Park low tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="159" station_class="water_trail" title="Tidewater Boating Center" zone="531" modtime="1527976399400" modby="bask0099" edits_since="1526512919039" >
  <marker lat="37.761392" lng="-122.223161"/>
  <tide_station>259</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch is from new low float docks for non-motorized craft only. It is 50-100 yds from parking to the dock. The park office has wheels for kayakers. This is protected Estuary paddling. You can go west to Estuary Park &#x28;3 miles&#x29; or go south into San Leandro Bay to look at birds. Bring binoculars. This site is the home of Oakland Strokes so expect to find the place crawling with kids.</p>
      <p><b>Parking: </b>Plenty of free parking. Open 8AM-5PM.</p>
      <p><b>Facilities: </b>Facilities include public restrooms, drinking fountains, 2 picnic tables, 2 BBQs and benches along Bay Trail. Everything is well maintained.</p>
      <p><b>Address: </b>4675 Tidewater Ave. Oakland</p>
      <p><b>Contact Info: </b>East Bay Regional Parks, 510-544-2558 or 510-544-2553 or 888-327-2757<br>Oakland Strokes, 510-926-4100</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/tidewater/">Bay Area Water Trail - Tidewater</a></p>
      <p><img class="details_img" src="images/new/TidewaterBoathouse.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527976399400-159-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tidewater boathouse dock</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527976399401-159-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tidewater boathouse, office</span>
  ]]></details>
</station>
  <station station_type="launch" xid="160" title="Arrowhead Marsh Kayak Launch at Elmhurst Creek and Damon Slough" zone="531" modtime="1639523250780" modby="petolino" edits_since="1635892983623" chart_title="Arrowhead Marsh" >
  <marker lat="37.743969" lng="-122.206333"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>These two sloughs provide access to San Leandro Bay. At Elmhurst Creek launch from the creek bank beside the foot bridge over Elmhurst Creek. It is about 15 yds from parking to creek. It is steep but short. Curfew is from 10PM to 5AM. Mud at low tide. Best at +4&#x2019; tide. Damon Slough also winds around the Coliseum. Explore and see what&#x27;s what. The launch at Damon Slough is from the mud bank. Arrowhead Marsh is sensitive bird habitat. Be respectful and bring binoculars.</p>
      <p><b>Parking: </b>Parking at Elmhurst is free beside the road in the dirt and there&#x27;s not much of it. At Damon Slough there is parking in a paved lot for about 20 cars. Whether overnight parking is allowed or not is not indicated at either site.</p>
      <p><b>Facilities: </b>No facilities at either site.</p>
      <p><b>Address: </b>For Damon Slough take 66th Ave &#x28;turns into Zhone Way&#x29; and turn left on Oakport St. Elmhurst is beside the bridge over the creek at Edgewater Dr.</p>
      <p><b>Contact Info: </b>East Bay Regional Park District, 510-635-0135</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Elmhurst%20Creek,%20Arrowhead%20Marsh,%20Oakland.jpg" height="299" width="400">
      <br><span class='details_caption'>Elmhurst Creek launch at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526514116689-160-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Damon Slough at 0&#x27; tide, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635892983623-160-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Elmhurst Creek, high tide, 11-2021</span>
  ]]></details>
</station>
  <station station_type="launch" xid="161" title="Shoreline Center, MLK Jr. Regional Shoreline" zone="531" modtime="1635893864159" modby="bask0099" edits_since="0" chart_title="Shoreline Center" >
  <marker lat="37.741583" lng="-122.215972"/>
  <tide_station>260</tide_station>
  <city>Oakland</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a low float dock for non-motorized water craft that is in place during &#x201C;the season&#x201D;. As of 11-2021 the dock is detached from the gangway and therefore closed.</p>
      <p><b>Parking: </b>Free parking and plenty of it.</p>
      <p><b>Facilities: </b>Facilities include bathrooms, BBQ pits, picnic tables and wind protection.</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Shoreline%20Center%20dock,%20Doolittle%20Dr.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Doolittle%20Dr%20shoreline%20Center%20low%20float%20dock,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635893864159-161-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Shoreline Center, wrecked dock, 11-2021</span>
  ]]></details>
</station>
  <station station_type="launch" xid="162" title="Grand Street Boat Ramp" zone="531" modtime="1528313364403" modby="bask0099" edits_since="0" chart_title="Grand Street Ramp" >
  <marker lat="37.77822" lng="-122.25145"/>
  <tide_station>260</tide_station>
  <city>Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>City of Alameda launch ramp into the Oakland estuary.</p>
      <p><b>Parking: </b>Free.</p>
      <p><b>Facilities: </b>Restrooms, small picnic area.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528313364403-162-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Grand Street Ramp Alameda 1</span>
  ]]></details>
</station>
  <station station_type="launch" xid="163" station_class="water_trail" title="Robert Crown Memorial State Beach" zone="531" modtime="1604602663723" modby="petolino" edits_since="1604091512085" chart_title="Robert Crown Beach" >
  <marker lat="37.766186" lng="-122.271738"/>
  <tide_station>260</tide_station>
  <city>Alameda_Island</city>
  <details><![CDATA[
      <p><b>Overview: </b>688 Central Ave. on Alameda Island. Launch from a sandy beach. The best spot is down by the windsurfers hut. At low tide the firm sand beach extends out quite a ways</p>
      <p><b>Parking: </b>Parking is free on the street and fee parking during the &#x22;season&#x22; in the park parking lots.</p>
      <p><b>Facilities: </b>Porta potties, picnic tables and occasional drinking fountains.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/crown-beach/">Bay Area Water Trail - Crown Beach</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604091512085-163-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Crown Beach, Alameda, 7&#x27; tide, Dec 2017</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604091512086-163-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Crown Beach at windsurfers hut</span>
  ]]></details>
</station>
  <station station_type="launch" xid="164" station_class="water_trail" title="Alameda, Encinal Boat Ramp" zone="531" modtime="1615082391298" modby="bask0099" edits_since="1528490600146" chart_title="Encinal Ramp" >
  <marker lat="37.76947" lng="-122.29073"/>
  <tide_station>3</tide_station>
  <city>Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>Free launching from the boat ramp into San Francisco Bay or from the beach into a protected enclosed basin. A good practice area. Encinal is also a good place to put in for the 14 mile circumnavigation of Alameda Island. On an ebb tide you could consider crossing to San Francisco. It gets windy in the afternoon. The dock by the ramp is relatively new and high freeboard. It is ADA accessible.</p>
      <p><b>Parking: </b>Ample free parking. Distance car to water varies. The sign at the street says the gates are unlocked 2 hours before sunrise until 2 hours after sunset. The gate does not look like it has been used in a while. Park curfew is 10PM to 5AM.</p>
      <p><b>Facilities: </b>There are two clean, well maintained bathrooms. There is a shower behind the bathrooms and drinking fountains as well as a hose for washing off gear. There are also several picnic tables. There are fenced off areas for Stacked Adventures &#x28;rents kayaks&#x29;, Okalani Outrigger Canoe club and a small boat sailing organization. There is a rigging area beside the bathrooms and the distance to the beach is 20-30 yards.</p>
      <p><b>Address: </b>Use 157 Central Ave, Alameda, CA. The road you want will be a left across from that address and beside the high school. It looks like you are going down a private road. Go to the end.</p>
      <p><b>Contact Info: </b>Alameda Parks and Rec, 510-747-7529<br>Stacked Adventures outfitter, 415-294-1972<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/encinal-beach/">Bay Area Water Trail - Encinal Beach</a></p>
      <p><img class="details_img" src="images/encinal-bch1.jpg" height="300" width="400">
      <br><span class='details_caption'>The beach area &#x28;ramp is to the left&#x29;.</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Encinal%20launch%20ramp,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Ramp and dock at zero tide.</span>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Encinal%20Beach2.JPG" height="299" width="400">
      <br><span class='details_caption'>Beach at zero tide.</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Encinal%20Beach,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Beach at 7-foot tide..</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615082391298-164-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615082391299-164-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
  ]]></details>
</station>
  <station station_type="launch" xid="165" station_class="water_trail" title="Robert Crown Memorial State Beach (Crown Beach)" zone="531" modtime="1608765330701" modby="petolino" edits_since="1606936366380" chart_title="Crown Beach" >
  <marker lat="37.76311" lng="-122.27285"/>
  <tide_station>5</tide_station>
  <city>Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>A nice sandy beach on Alameda&#x27;s south side. Kayak rentals available at Boardsports. The best place to park and launch is south by the windsurfers&#x27; hut. This is a State Beach operated by East Bay Regional Parks. Park closed 10PM -5AM.</p>
      <p><b>Parking: </b>Seasonal fee parking. May-September, &#x24;5/ vehicle. entrance is at the corner of Otis and Westline Dr on Alameda Island.</p>
      <p><b>Facilities: </b>Restrooms and changing rooms are at the north end of the parking lot. There are picnic areas.</p>
      <p><b>Contact Info: </b>Park office, 510-544-4522. Boardsports, 415-385-1224</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/crown_beach">East Bay Regional Parks - Crown Memorial State Beach</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/crown-beach/">Bay Area Water Trail - Crown Beach</a></p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Crown%20Beach%20at%20windsurfers%20hut.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Crown%20Beach,%20Alameda,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="166" title="Doolittle Drive, Airport Channel Launch Ramp" zone="531" modtime="1635893651266" modby="bask0099" edits_since="1526531052280" chart_title="Airport Channel Ramp" >
  <marker lat="37.73899" lng="-122.21392"/>
  <tide_station>257</tide_station>
  <city>Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>Free public boat ramp. At low tide, the water is very shallow and the channel is narrow. Curfew is 10PM-5AM. The dock and gangway were recently improved. This is a popular jet ski launch. It gets windy here and the park facilities are hunkered down behind berms and trees. Once you get away from shore it howls. As of 11-2-21 the ramp is closed for automobile use. It is still OK for kayaks however.</p>
      <p><b>Parking: </b>Free with a large number of spaces. No overnight parking.</p>
      <p><b>Facilities: </b>Restrooms, a few picnic tables.</p>
      <p><b>Contact Info: </b>East Bay Regional Parks, 510-635-0135</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Airport%20Channel%20ramp,%20Doolittle%20dr.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/Alameda,%207'%20tides/Doolittle%20Dr.%20launch%20ramp,%207'%20tide,%20Dec%202017.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide, note new docks and gangways</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635893651266-166-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Airport Channel ramp closed sign 11-2021</span>
  ]]></details>
</station>
  <station station_type="launch" xid="167" title="San Leandro Marina" zone="531" modtime="1530151120595" modby="bask0099" edits_since="1528491476884" >
  <marker lat="37.69547" lng="-122.18763"/>
  <tide_station>352</tide_station>
  <city>San_Leandro</city>
  <details><![CDATA[
      <p><b>Overview: </b>The public ramp charges &#x24;10 to launch paid at an iron ranger. The sign says cars with trailers and no tag will be ticketed. The dock is deteriorated just like the rest of the marina. The marina is so badly silted in that boats are warned that leaving or entering at low tide may not be possible. They can&#x27;t afford to have it dredged. Nonetheless it still works for kayaks at all tides.</p>
      <p><b>Parking: </b>Free and plenty of it as the marina is over half empty.</p>
      <p><b>Facilities: </b>Restrooms by the launch ramp. There is a hotel, the Marina Inn, right across the street from the regular launch ramp.</p>
      <p><b>Address: </b>Take the Marina blvd off ramp from Hwy 880 and go to the end.</p>
      <p><b>Contact Info: </b>Harbormaster, 510-577-3488. The marina office is open 8AM-4PM M-Th and by appt Fri and Sat. Closed Sun.<br>San Leandro Rec Dept. 510-577-3462</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.san-leandro.ca.us/depts/pw/marina/marinafacilities.asp">San Leandro Marina</a></p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/San%20Leandro%20Marina%20launch%20ramp.jpg" height="299" width="400">
      <br><span class='details_caption'>Regular boat launch ramp at zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='168' title="San Lorenzo Creek" zone="531">
    <marker lat="37.67209" lng="-122.15964"/>
    <tide_station>337</tide_station>
    <city>Hayward</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Public shoreline. Launch from the creek bank.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="169" station_class="water_trail" title="Eden Landing Ecological Reserve" zone="531" modtime="1530127358746" modby="petolino" edits_since="1528489477434" chart_title="Eden Landing" >
  <marker lat="37.61874" lng="-122.124028"/>
  <tide_station>337</tide_station>
  <city>Hayward</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public boat launch on Mt. Eden Creek which is a meandering creek through recovering salt ponds. Bring binoculars for birds. It is 1.7 miles to the bay. The gates to the park and to the launch area are open sunrise to sunset.</p>
      <p><b>Parking: </b>Free with spaces for 22 cars. The parking lot is 1/4 mile from the launch and there is no parking, only loading, at the launch. However, there are three ADA parking spots at the launch ramp.</p>
      <p><b>Facilities: </b>Concrete ramp with low float that sits in mud at low tide so that water comes over the end. There is also a low float ADA dock with a LEGO-type kayak launch. There is an astro turf loading and rigging area next to the concrete ramp. There is one porta potty in the parking area &#x28;1/4 mile from the ramps&#x29;</p>
      <p><b>Address: </b>From Hwy 92 exit at Clearwater &#x28;just east of the San Mateo Bridge&#x29; and go south to the end.</p>
      <p><b>Contact Info: </b>CA Dept of Fish and Wildlife, 707-944-5500<br>Manager of the Reserve, 415-454-8050</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/eden-landing/">Bay Area Water Trail - Eden Landing</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528489477434-169-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>WSKers at Eden Landing opening day, May 6, 2016</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528489477435-169-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Eden Landing launches at low tide, 6-7-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528489477436-169-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Eden landing ramp at low tide, 6-7-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="170" title="Dumbarton Bridge East Fishing Pier" zone="531" modtime="1528233173797" modby="bask0099" edits_since="0" chart_title="Dumbarton Bridge E. Pier" >
  <marker lat="37.51111" lng="-122.11071"/>
  <tide_station>103</tide_station>
  <city>Fremont</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public shoreline managed by the US Fish and Wildlife Service. Pebble beach, at high tide only.</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Dumbarton%20Bridge,%20looking%20north.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='171' title="Newark Slough" zone="531">
    <marker lat="37.52877" lng="-122.06328"/>
    <tide_station>244</tide_station>
    <city>Fremont</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Access to Newark Slough and the South Bay.It gets very muddy at low tide.
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="172" title="Jarvis Landing in Newark Slough" zone="531" modtime="1528234252735" modby="bask0099" edits_since="0" chart_title="Jarvis Landing" >
  <marker lat="37.528611" lng="-122.062944"/>
  <tide_station>244</tide_station>
  <city>Newark</city>
  <details><![CDATA[
      <p><b>Overview: </b>No facilities by the ramp however bathrooms and a nature center are located at the visitors center &#x28;open 10AM-5PM&#x29;. High tide only.</p>
      <p><b>Parking: </b>Parking is free by the funky concrete launch ramp located at the corner of Thorton Ave. and Marshlands Rd.</p>
      <p><b>Facilities: </b>None. Go to the visitors center for amenities.</p>
      <p><img class="details_img" src="images/Alameda,%20Zero%20Tide/Jarvis%20Landing%20ramp.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528234252735-172-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jarvis Landing, 9&#x27; tide,</span>
  ]]></details>
</station>
  <station station_type="launch" xid='173' title="Livermore, Lake Del Valle"  zone='530' chart_title="Lake Del Valle" >
    <marker lat="37.58628" lng="-121.70362"/>
    <city>Livermore</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Lake del Valle is a nice spot for flat water paddling. There are, however, motorboats on the lake. 
        There is a seasonal boat inspection at the entrance station to keep invasive mussels out of the water. Make sure your boat is clean 
        and check the East Bay Regional Park website for details.
        <p><b>Parking: </b>Day use and launching fee.
        <p><b>Facilities: </b>Restrooms, picnic tables, boat rental. 
        <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/del_valle">East Bay Regional Parks -Lake del Valle</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="174" title="Pinole, Bay Front Park" zone="530" modtime="1527737781587" modby="petolino" edits_since="1527653220812" chart_title="Bay Front Park" >
  <marker lat="38.01287" lng="-122.29538"/>
  <tide_station>166</tide_station>
  <city>Pinole</city>
  <details><![CDATA[
      <p><b>Overview: </b>Bay Front Park is operated by the City of Pinole. It has a pebble beach that gets severely muddy at low tide. It also has a small ramp into Pinole Creek that is usable at +5&#x27; tides, but at +2&#x27; to +3&#x27;, the water level will be well below the end of the ramp, and the mud is knee-deep. Even at a +5&#x27; tide there will be about 25 ft of muck to wade through to get to the water. In 2018 there is a massive construction project going on with the sewer treatment plant. This impacts the parking and the bathrooms.</p>
      <p><b>Parking: </b>Currently there is 2-hour parking, M-F, in the area to the left of the water treatment plant. There is only space for about 2 cars at the little launch ramp.<br></p>
      <p><b>Facilities: </b>2 porta potties in the parking lot. There are also a couple of picnic tables with BBQs near the south-facing beach.</p>
      <p><b>Address: </b>Foot of Tennent Av. in Pinole.</p>
      <p><b>Contact Info: </b>City of Pinole, 510-724-9000</p>
      <p><img class="details_img" src="images/7foot/Contra%20Costa,%207'%20tides/Bay%20Front%20Park,%20Pinole4,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Bayfront beach at +7 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527653220812-174-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bayfront Beach, 4.5&#x27; tide, 5-29-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527653220813-174-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bayfront park, Pinole, beach at 0.5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527653220814-174-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Launch ramp, 4.5&#x27; tide, 5-29-18. Note construction in background</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527653220815-174-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bayfront park, ramp, 0.5&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="175" title="Vallejo, formerly Brinkman&apos;s Marina" zone="530" modtime="1605639386670" modby="bask0099" edits_since="1604602773874" chart_title="Brinkman&#39;s Marina" >
  <marker lat="38.096571" lng="-122.25723"/>
  <current_station>175</current_station>
  <city>Vallejo</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public launch ramp, across from historic shipyards. Watch out for the Vallejo Ferry. The dock is high freeboard. Mud at less than 1&#x27; tide. Beginning 11-9-2020 thru sometime in 2021 the site will be undergoing remediation. Construction work will be going on Mon.-Fri., 7AM-6PM. Best to go there on weekends.</p>
      <p><b>Parking: </b>It is unclear how the construction will impact parking. No fee. Area for rigging by ramp. Lot is closed and locked at dusk. No overnight parking.</p>
      <p><b>Facilities: </b>Restrooms, OK. About 50&#x27; to the ramp.</p>
      <p><b>Address: </b>Operated by the City of Vallejo</p>
      <p><b>Contact Info: </b>For more info about the construction/remediation contact Asha.Setty@dtsc.ca.gov<br></p>
      <p><b>Links: </b><a target="tp_details" href="https://www.envirostor.dtsc.ca.gov/">https://www.envirostor.dtsc.ca.gov</a></p>
      <p><img class="details_img" src="images/Brinkmans1.jpg" height="238" width="400">
      <br><span class='details_caption'>mid-tide</span>
      <p><img class="details_img" src="images/Solano%2c%20Zero%20Tide/Brinkman%27s%20Marina%2c%20right%20ramp.JPG" height="298" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526344508079-175-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Brinkmans on a .5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526344508080-175-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Brinkmans, 4&#x27; tide, May 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605639386670-175-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Vallejo ramp at 7&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid='176' title="Vallejo, California Maritime Academy" zone="530" chart_title="California Maritime Academy" >
    <marker lat="38.06812" lng="-122.23122"/>
    <current_station>65</current_station>
    <city>Vallejo</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Private ramp. Not clear if this is open to the public. 
        <p><b>Parking: </b>Fee parking.
        <p><b>Facilities: </b>None.
		  <p><img class='details_img' src="images/Solano, Zero Tide/maritime Academy ramp, January 2011.JPG" alt="maritime Academy ramp, January 2011"/>
  		  <br><span class='details_caption'>Picture taken at zero tide</span>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="177" title="Benicia, Matthew Turner Shipyard Park" zone="530" modtime="1526617434770" modby="bask0099" chart_title="Matthew Turner Shipyard" >
  <marker lat="38.0621" lng="-122.17904"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from pebble beach. The site also has the remains of the Matthew Turner Shipyard &#x28;i.e. slabs of concrete and a the remains of a seawall at the shoreline&#x29;. From here you can visit the rest of the Benicia shoreline or go to Port Costa for lunch or to Vallejo for a workout.</p>
      <p><b>Parking: </b>Free parking for about 10 cars in small parking lot. No overnight parking. Park is closed sunset to sunrise.</p>
      <p><b>Facilities: </b>Porta potty which is clean. Also, picnic tables and grassy area. No running water. No camping.</p>
      <p><b>Address: </b>Foot of West 12th St.</p>
      <p><b>Contact Info: </b>City of Benicia Parks and Community Services, 707-746-4285</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526357279741-177-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Matthew Turner Park, .5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526357279742-177-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Matthew Turner Park, 4&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="178" station_class="water_trail" title="Benicia, West 9th Street boat ramp" zone="530" modtime="1526345379185" modby="bask0099" chart_title="West 9th St Ramp" >
  <marker lat="38.05813" lng="-122.17441"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public launch ramp with floating docks that are high freeboard. The nearby beach park is called Alverez 9th Street Park. It has a wide sloping paved with a few stairs to a nice white sand beach. it is about 100 yds from the parking lot. Both the ramp and the beach are usable at any tide. The ramp sticks out into the Strait so there are tidal currents. Pay attention. From here go to Benicia, Port Costa, Vallejo or Glen Cove.</p>
      <p><b>Parking: </b>Ample free parking. Rig in the parking lot. No overnight parking. Although it is a 24 hour launch ramp the parking area closes at dusk opens at sunrise.</p>
      <p><b>Facilities: </b>Restrooms that are well maintained about 100&#x27; from ramp. Drinking fountain by the restrooms. There is a nearby park &#x28;in the same parking lot&#x29; with a few picnic tables and a wide concrete ramp to a beach.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/west-ninth-street-boat-launch/">Bay Area Water Trail - West Ninth Street</a></p>
      <p><img class="details_img" src="images/Solano,%20Zero%20Tide/9th%20St%20ramp.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/9thStBeach-Benicia+4.5ft.jpg" height="299" width="400">
      <br><span class='details_caption'>North of boat ramp. Picture taken at +4.5 ft</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526345379185-178-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>9th st, Benicia, 4&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="179" title="Benicia, First Street" zone="530" modtime="1605639794178" modby="bask0099" edits_since="1605639541188" chart_title="First St" >
  <marker lat="38.04418" lng="-122.16269"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from sand/pebble beach. Gets a bit muddy at low tide. There is a flat put-in beach at the turn-around and a set of stairs to a little beach inside the breakwater. The beach is subject to tidal currents but the beach inside the breakwater is more protected. Wind blows up river in the afternoon. From here go to Port Costa, Glen Cove or upriver.</p>
      <p><b>Parking: </b>Park free along the street and on the &#x22;spit&#x22;. There is a 3 hour limit &#x28;which is rarely enforced&#x29; and no overnight parking is allowed but generally parking on the city streets overnight is OK</p>
      <p><b>Facilities: </b>Restrooms in the yellow building on the spit &#x28;clean and well maintained&#x29; and drinking fountain, picnic table. See&#x27;s Chocolate at the Train Station.</p>
      <p><b>Address: </b>First Street</p>
      <p><b>Contact Info: </b>City of Benicia, 707-746-4200</p>
      <p><img class="details_img" src="images/new/MainSt-Benicia+4.5ft.jpg" height="298" width="400">
      <br><span class='details_caption'>Picture taken at +4.5 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526346150068-179-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>1st St Benicia, beach, .5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526346150069-179-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>1st St Benicia beach, 4&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605639541188-179-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>First Street inside breakwater at 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605639794178-179-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia, First St at 7&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="180" title="Benicia Marina" zone="530" modtime="1526617520081" modby="bask0099" >
  <marker lat="38.04468" lng="-122.1535"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sheltered launch into Carquinez Straits. There are 2 places to launch. One from the fuel dock by the harbormasters office at the end of E. B St. and one from the public launch ramp at the end of E. 5th St. Inside the marina is sheltered but outside is subject to summer, up-river wind and tidal currents. Plan accordingly. From here go to Eckley Pier, Port Costa, Vallejo or other sites in Benicia.</p>
      <p><b>Parking: </b>Get a permit and pay the &#x24;5 fee at the harbormaster&#x27;s office. Or park for free on the street. Park overnight on the street for free. There is a gravel parking lot near the harbormaster&#x27;s office that allows 72 hour parking for free.</p>
      <p><b>Facilities: </b>Restrooms and a small store at the harbormaster&#x27;s office. The bathrooms at the launch ramp are locked.</p>
      <p><b>Address: </b>266 East B St, Benicia</p>
      <p><b>Contact Info: </b>City of Benicia, 707-745-2628</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.beniciamarina.net/">http://www.beniciamarina.net</a></p>
      <p><img class="details_img" src="images/Solano,%20Zero%20Tide/Benicia%20marina%20ramp.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/new/BeniciaMarinaRamp2+4.5ft.jpg" height="295" width="400">
      <br><span class='details_caption'>Picture taken at 4.5 ft tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="181" title="Carquinez Strait Regional Shoreline (Eckley Pier)" zone="530" modtime="1527738319903" modby="petolino" edits_since="1527651801145" chart_title="Eckley Pier" >
  <marker lat="38.05387" lng="-122.20192"/>
  <current_station>65</current_station>
  <city>Crockett</city>
  <details><![CDATA[
      <p><b>Overview: </b>Waterfront park with two pebble beaches for launching onto Carquinez Straits. The west beach is closer and has fewer bricks. The east beach is another 20 yds and has gazillions of bricks. There is interesting wreckage to check out in the water right there. Also, there are warning signs about break-ins about every 50 feet. Do not leave your boat on the railroad tracks or your valuables in the car.</p>
      <p><b>Parking: </b>Free. Four loading spaces &#x28;10 minutes&#x29; about 70 yds from the pier. There are 2 dozen more a little further up the hill with no time restrictions and 2 dozen more even further up the hill in a dirt area. During the summer the gate at the road is open from 8AM to 8PM. Curfew is 10PM to 5AM.</p>
      <p><b>Facilities: </b>Pit toilet that in May of 2018 was out of order. There is a large grassy area with picnic tables right near the pier and another one up the road a piece.</p>
      <p><b>Address: </b>5700 Eckley Rd., Crockett. Take the Pomona St exit from Hwy 80 just south of the Carquinez Bridge and drive east on Pomona St. until you get to the staging area.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/parks/carquinez">East Bay Regional Parks - Carquinez Strat Regional Shoreline</a></p>
      <p><img class="details_img" src="images/eckleypier1.jpg" height="300" width="400">
      <br><span class='details_caption'>Mid tide at west beach</span>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Eckley%20Pier,%20west%20beach.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide at west beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527553346348-181-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Eckley Pier, beach east of pier at low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527651801145-181-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Eckley Pier east beach, 4.7&#x27; tide, 5-29-18</span>
  ]]></details>
</station>
  <station station_type="launch" xid="182" title="Port Costa" zone="530" modtime="1605639618555" modby="bask0099" edits_since="1526617626761" >
  <marker lat="38.04777" lng="-122.18341"/>
  <current_station>65</current_station>
  <city>Port_Costa</city>
  <details><![CDATA[
      <p><b>Overview: </b>Public shore with a pebble beach. At the west end of the parking lot you will find a dirt trail that crosses the railroad tracks. Be careful when crossing the railroad tracks. This little beach is usable at all tides. At high tide it narrows down to about 6&#x27; wide. From here paddle across the river &#x28;or come from&#x29; Benicia. This is the side of the river with stronger currents so check the tides before launching and go with the flow.</p>
      <p><b>Parking: </b>Ample free parking.</p>
      <p><b>Facilities: </b>Restrooms are at the Warehouse restaurant and bar. The Warehouse is a good reason to come to Port Costa. 250 kinds of beer and pretty good food. M-Th, 3PM-12AM&#x3B; Fri, 12N-2AM&#x3B; S/Sun, 10AM-2AM.</p>
      <p><b>Address: </b>Warehouse Cafe, 5 Canyon Lake Dr.</p>
      <p><b>Contact Info: </b>Warehouse Cafe, 510-787-1827</p>
      <p><img class="details_img" src="images/Contra%20Costa,%20Zero%20Tide/Port%20Costa.JPG" height="298" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605639618555-182-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Port Costa, beach at 7&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="183" station_class="water_trail" title="Martinez Marina" zone="530" modtime="1530224938318" modby="petolino" edits_since="1529596755847" >
  <marker lat="38.02592" lng="-122.13734"/>
  <current_station>65</current_station>
  <city>Martinez</city>
  <details><![CDATA[
      <p><b>Overview: </b>The Martinez Marina is a very good launch spot for paddling in Carquinez Strait and to the Mothball Fleet &#x28;or what&#x27;s left of it&#x29;. There are boat ramps and docks to launch from. A posting says the launch fee is &#x24;10, but this only applies if you park with a trailer, or occupy the launch ramp with a vehicle, otherwise it is free. Check local wind conditions because it can blow pretty hard through Carquinez Strait. there is a marsh with a nice lagoon just west of the marina that is a great bird hang-out. One can also paddle west to Port Costa or across the Strait to Benicia</p>
      <p><b>Parking: </b>Ample free parking. Overnight parking allowed with a permit from the Harbormistress. There is a loading zone beside the ramp.</p>
      <p><b>Facilities: </b>Clean restrooms which are open 8:30AM-4:30PM. The baitshop &#x28;with food&#x29; is open 6AM to 5PM.</p>
      <p><b>Address: </b>7 North Court St, Martinez</p>
      <p><b>Contact Info: </b>Harbormistress, Olivia Ortega, 925-313-0942</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.martinez-marina.com/">http://www.martinez-marina.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529596755847-183-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Martinez launch ramps</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529596755848-183-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Martinez Marina picnic table, 4&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="184" title="Belden's Landing" zone="530" modtime="1526397872525" modby="bask0099" >
  <marker lat="38.18836" lng="-121.97616"/>
  <tide_station>220</tide_station>
  <city>Suisun_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>Belden&#x27;s Landing has a double launch ramp with a high float dock. Explore the Grizzly wildlife area. Bring binoculars. Head to the left &#x28;east&#x29; to the Salinity Control Project &#x28;with a public dock&#x29; on Montezuma Slough or head right &#x28;west&#x29; toward Suisun City.</p>
      <p><b>Parking: </b>Launch fee is for trailered boats. Car-topped boats are free. There is, however, a &#x24;6/day parking fee. Launch is open 24 hours.</p>
      <p><b>Facilities: </b>Restrooms and picnic tables.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.solanocounty.com/parks">http://www.solanocounty.com/parks</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.solanocounty.com/depts/rm/countypark/beldensldg.asp">http://www.solanocounty.com/depts/rm/countypark/beldensldg.asp</a></p>
      <p><img class="details_img" src="images/Solano,%20Zero%20Tide/Belden's%20Landing.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="185" station_class="water_trail" title="Suisun City Public Boat Ramp" zone="530" modtime="1526617874983" modby="bask0099" chart_title="Suisun City Boat Ramp" >
  <marker lat="38.23289" lng="-122.03868"/>
  <tide_station>399</tide_station>
  <city>Suisun_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>2 Ramps and floating docks &#x28;high freeboard&#x29;. One ramp is for launching and one for retrieving. It gets busy. Waterfront dining in town and a nature center nearby. . There is an area for rigging. This is a good place to start an exploration of the Suisun sloughs or run a shuttle and head to Belden&#x27;s Landing.</p>
      <p><b>Parking: </b>Launching is free but &#x24;5/day to park. Overnight is OK.</p>
      <p><b>Facilities: </b>Restrooms, ADA and fairly well maintained. Picnic tables.</p>
      <p><b>Contact Info: </b>Harbormaster, 707-429-2628. Hours are 8:30AM-5PM daily. email at marina@suisun.com</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.suisun.com/departments/recreation-community-services/marina/">Suisun City Marina</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/suisun-city-marina/">Bay Area Water Trail - Suisun City Marina</a></p>
      <p><img class="details_img" src="images/Solano,%20Zero%20Tide/Suisun%20Marina%20ramp.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526396655445-185-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>SuisunMarina ramp, 2018</span>
  ]]></details>
</station>
  <station station_type="launch" xid="186" station_class="water_trail" title="Downtown Suisun City" zone="530" modtime="1527545064278" modby="bask0099" edits_since="1526618020014" >
  <marker lat="38.23862" lng="-122.039185"/>
  <tide_station>399</tide_station>
  <city>Suisun_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>Ramp and floating dock&#x3B; nearby waterfront dining. The dock is the municipal dock, shared with visiting boats and is high freeboard. Conditions are very calm. The only place to go is down the slough toward the Carquinez Straits or to Belden&#x27;s Landing. Or just meander in the sloughs. Bring binoculars. Birding is good.</p>
      <p><b>Parking: </b>Free. On the street or in the large public parking lot between Main St. and the turning basin. Loading area is on Solano. No overnight parking.</p>
      <p><b>Facilities: </b>The public bathroom is at the NW corner of the turning basin &#x28;1/4th mile from the dock&#x29;. There are numerous dining opportunities. Overnight accomodations at the Barkissimo Yacht B&#x26;B at the dock &#x28;510-619-8081&#x29; or at the Hampton Inn &#x28;707-429-0900&#x29;. There may be a kayak outfitter here on weekends during the summer.</p>
      <p><b>Address: </b>Downtown Suisun. Corner of Kellogg and Solano.</p>
      <p><b>Contact Info: </b>Harbormaster, Gus Barkas, 707-429-2628 or gbarkas@suisun.com</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/downtown-suisun-city/">Bay Area Water Trail - Downtown Suisun City</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.suisun.com/departments/recreation-community-services/marina">http://www.suisun.com/departments/recreation-community-services/marina</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526360296334-186-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Suisun, Downtown, loading area for dock, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526360296335-186-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Suisun city turning basin dock and Barkissimo Yacht B&#x26;B</span>
  ]]></details>
</station>
  <station station_type="launch" xid="187" station_class="water_trail" title="Pittsburg Marina" zone="530" modtime="1530225339454" modby="petolino" edits_since="1530224917582" >
  <marker lat="38.035623" lng="-121.882983"/>
  <current_station>202</current_station>
  <city>Pittsburg</city>
  <details><![CDATA[
      <p><b>Overview: </b>Busy free public boat ramp for motorized boats - opens onto river. The launch is protected but then you are right on the river so attention to tides and currents is necessary. The dock is high freeboard. Jet skis use this site. Be aware. There is a new E-Z dock kayak launch right next to the harbormaster&#x27;s office &#x28;which is on a floating dock&#x29;. There is also a low freeboard area suitable for kayaks on their guest dock. They ask that kayaks not be left on the dock but rather tied alongside the dock.</p>
      <p><b>Parking: </b>Parking by the ramp for motorized boats is free but is only for trailered vehicles. Cars must park further away in a different parking lot. The parking for the kayak launch is also free and about 100+ yds from the dock. There is no designated loading area.</p>
      <p><b>Facilities: </b>There is a single bathroom in the building beside the parking lot. If it is locked get a key from the harbormaster. There are kayaks for rent from the harbormaster. There is a restaurant in the building next to the parking lot.</p>
      <p><b>Address: </b>51 Marina Blvd. in Pittsburg. There are 3 basins. The harbormaster and the kayak launch are in Basin 1.</p>
      <p><b>Contact Info: </b>925-439-4958</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.pittsburgmarina.com/">http://www.pittsburgmarina.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526411490801-187-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pittsburg launch ramp for motorized boats, 4-29-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529597935788-187-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pittsburg kayak launch</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529597935789-187-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pittsburg marina guest dock low spot for kayaks</span>
  ]]></details>
</station>
 <station station_type="launch" xid="188" station_class="water_trail" title="Antioch Marina" zone="530" modtime="1635116201128" modby="petolino" edits_since="1635116111057" >
  <marker lat="38.018906" lng="-121.818153"/>
  <current_station>28</current_station>
  <city>Antioch</city>
  <details><![CDATA[
      <p><b>Overview: </b>The Gateway to the Delta. Inside the marina is protected but once outside there are currents and significant wind on summer afternoons. There is a kayak launch beside the concrete boat launch ramps. This is out of the way of boat traffic. Delta Kayak Adventures rents kayaks from the dock beside the harbormaster&#x27;s office &#x28;925-642-5764&#x29;. There are two kayak launch floats there. The harbormaster will let you through the gate. Note that the harbormaster&#x27;s office is open Tues-Sat, 8AM-4PM.Generally speaking, this marina is very kayak friendly.</p>
      <p><b>Parking: </b>Free.</p>
      <p><b>Facilities: </b>Bathrooms, water, picnic area, close to Amtrak station. No launch fee. Secure kayak storage is available for &#x24;30/month.</p>
      <p><b>Address: </b>5 Marina Plaza, Antioch. At the foot of L street</p>
      <p><b>Contact Info: </b>Harbormaster: 925-779-6957<br>Delta Kayak Adventures: 925-642-5764</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.antioch.ca.us/antioch-marina">www.antiochmarina@antiochca.gov</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/antioch-marina/">Bay Area Water Trail - Antioch Marina</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526410509579-188-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Antioch kayak launch, 4-29-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632449772075-188-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Antioch kayak launch, 9-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632449772076-188-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Antioch kayak launch, 9-23-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632449772077-188-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Antioch old public kayak launch</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632449772078-188-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Antioch sign</span>
  ]]></details>
</station>
 <station station_type="launch" xid="189" title="Antioch Historical Ramp" zone="530" modtime="1526410746881" modby="bask0099" chart_title="Antioch Ramp" >
  <marker lat="38.017236" lng="-121.802911"/>
  <current_station>28</current_station>
  <city>Antioch</city>
  <details><![CDATA[
      <p><b>Overview: </b>Old Antioch Ramp. From Hwy 4, exit at Lone Tree and go north. This jogs left and turns into A St. Right on 6th and left on McElheny. You will pass the Red Caboose, a biker bar. Launch from one lane ramp with floating dock. This is the habitat of jet skis.</p>
      <p><b>Parking: </b>Free. Trailered cars can park for 72 hours. Curfew 9PM-5AM. If you inhale deeply you can get high in the parking lot.</p>
      <p><b>Facilities: </b>None.</p>
      <p><img class="details_img" src="images/ant.jpg" height="299" width="400">
  ]]></details>
</station>
  <station station_type="launch" xid="190" title="Sherman Island, Sacramento County Regional Park" zone="530" modtime="1527055027881" modby="petolino" edits_since="1527051982176" chart_title="Sherman Island" >
  <marker lat="38.0563" lng="-121.78569"/>
  <current_station>360</current_station>
  <city>Antioch</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is reputed to be a world class windsurfing and kite boarding site. Expect lots of wind and lots of kiteboarders. There is a beach and small launch ramp that face south and are protected from the wind. Hours are sunrise to sunset. There is a campground host who will probably be out windsurfing himself.</p>
      <p><b>Parking: </b>Available but pretty limited.</p>
      <p><b>Facilities: </b>Restrooms, picnic shelters. Camping is &#x24;12.50/night for RVs only. No tent camping. Day use fee is &#x24;5/car and &#x24;3 to launch non-motorized craft.</p>
      <p><b>Address: </b>From Hwy 160 head west on Sherman Island Rd to the end.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/Parks/SacramentoRiverandDelta/Pages/ShermanIsland.aspx">http://www.regionalparks.saccounty.net/Parks/SacramentoRiverandDelta/Pages/ShermanIsland.aspx</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527051876117-190-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sherman Island, beach by ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527051876118-190-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sherman Isl ramp</span>
  ]]></details>
</station>
  <station station_type="launch" xid='191' title="Delta Meadows State Park" zone="530" chart_title="Delta Meadows SP" >
    <marker lat="38.25100" lng="-121.50656"/>
    <tide_station>243</tide_station>
    <city>Walnut_Grove</city>
    <details>
      <![CDATA[<p><b>Overview: </b> park/ramp is closed - road is gated off although people with 4x4s drive around it. Nearest launch is Wimpey's Marina. 
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="192" title="Cosumnes River Preserve" zone="530" modtime="1528318150531" modby="bask0099" edits_since="1528314895953" >
  <marker lat="38.26586" lng="-121.44057"/>
  <tide_station>243</tide_station>
  <city>Thornton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Cosumnes River Preserve is a preserve, not a park, and is manned primarily by volunteers so not everything happens like clockwork. Hours are sunrise to sunset. The dock is 200 yds from the parking lot. Bring wheels or you can borrow some from the visitor center. From here you can run a shuttle and head to the Mokelumne River and go downstream &#x28;to Wimpys or New Hope&#x29; or you can paddle around the preserve and look at birds. Bring binoculars. Sandhill Cranes hang out here in winter. There are also hiking paths around the preserve in case paddling isn&#x27;t enough. Note: the dock is low float and has a ladder in case you fall in. Very few docks in the Bay area have ladders--an important safety feature.</p>
      <p><b>Parking: </b>Two lots with plenty of parking. No overnight parking allowed.</p>
      <p><b>Facilities: </b>Visitor Center with bathrooms, a large deck, and exhibits of history, flora and fauna. Try to come when they are open &#x28;that&#x27;s when the bathrooms are open&#x29;. S/S, 9AM-5PM and M-F during business hours sometimes.</p>
      <p><b>Address: </b>13501 Franklin Blvd. Go north on Hwy 5 and then east on Twin Cities Rd. Turn right on Franklin go till you see the sign.</p>
      <p><b>Contact Info: </b>916-684-2816<br>or info@consumnes.org</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.cosumnes.org">http://www.cosumnes.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528314895953-192-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cosumnes canoe dock, Jan. 2009007</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528314895954-192-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cosumnes canoe dock, Jan. 2009006</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528314895955-192-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cosumnes canoe dock, Jan. 2009001</span>
  ]]></details>
</station>
  <station station_type="launch" xid='193' title="Lake Tahoe, Meeks Bay" chart_title="Meeks Bay" >
    <marker lat="39.036668" lng="-120.12169"/>
    <city>South_Lake_Tahoe</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Beach on Lake Tahoe's west shore.
        <p><b>Parking: </b>Day use fee.
        <p><b>Facilities: </b>Restrooms, camping available.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='194' title="Lake Tahoe, Baldwin Beach" chart_title="Baldwin Beach" >
    <marker lat="38.94331" lng="-120.06898"/>
    <city>South_Lake_Tahoe</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Beach on Lake Tahoe's south shore.
        <p><b>Parking: </b>Day use fee.
        <p><b>Facilities: </b>Restrooms, camping available.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="195" title="Pacifica, Linda Mar Beach" zone="545" chart_title="Linda Mar Beach" modtime="1670615183748" modby="petolino" edits_since="0" >
  <marker lat="37.59676" lng="-122.50513"/>
  <tide_station>265</tide_station>
  <city>Pacifica</city>
  <details><![CDATA[
      <p><b>Overview: </b>Linda Mar usually has moderate to large spilling surf and is popular with kayaks and board surfers. It is also a good launch spot for a coastal paddle south to Half Moon Bay.</p>
      <p><b>Parking: </b>&#x24;3 for less than 3 hrs and &#x24;6 for more than 4 hrs</p>
      <p><b>Facilities: </b>Restrooms.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.cityofpacifica.org/about/parking_for_linda_mar_beach.asp">City of Pacifica</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Linda-Mar-Pacifica-Surf-Report/819/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="196" title="Fitzgerald Marine Reserve" zone="545" modtime="1530999853428" modby="bask0099" edits_since="0" chart_title="Fitzgerald Reserve" >
  <marker lat="37.5242" lng="-122.51777"/>
  <tide_station>283</tide_station>
  <city>Half_Moon_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>This site can be a launch or destination or an out-and-back. You can come here from either Linda Mar or Montara Beach. Finding the path for safe landing is tricky if you have not been here before. It is somewhat protected put-in, best used in smaller conditions. An outer reef provides some protection, but at low tide, the rocks are a popular haul-out spot for seals, so this site is best used at higher tides. The best path out onto the ocean is to head diagonally to the northwest. On bigger days the ocean outside this spot has numerous boomers. Exercise caution. Depending on the height of the tide you may be launching from a sand beach, from gravel or from rocks. The conditions are very affected by the tide. Lower tide means choppy conditions. Unless you have the skills you might not want to paddle over the reef. If you do have the skills rock gardening is fun&#x21; Heading south, round Pillar Point and land in the harbor. You did run a shuttle didn&#x27;t you&#x3F;<p>This location is a marine reserve. Do not flush the seals. Only smaller groups of kayakers &#x28;less than 8&#x29; are tolerated by the rangers.</p>
      <p><b>Parking: </b>Free. However you do need wheels to get to the end of the point from the parking lot and then you need to take your boat down &#x28;and up&#x29; stairs, over a creek and around rocks. Wear sturdy shoes that can get wet. Rig in the parking lot. There are about 50 spaces in the parking lot. It is 30-50 yds from the parking lot to the beach. Hours are 8AM-sunset. No overnight parking.</p>
      <p><b>Facilities: </b>Restrooms and a drinking fountain nearby. No camping.</p>
      <p><b>Address: </b>Ranger station and parking lot are located at 200 Nevada St in Moss Beach</p>
      <p><b>Contact Info: </b>Ranger Station, 650-728-3584</p>
      <p><b>Links: </b><a target="tp_details" href="http://parks.smcgov.org/fitzgerald-marine-reserve">http://parks.smcgov.org/fitzgerald-marine-reserve</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid='197' title="Pillar Point Portage" zone="545">
    <marker lat="37.49566" lng="-122.49509"/>
    <tide_station>283</tide_station>
    <city>Half_Moon_Bay</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The portage is a shortcut to Pillar Point reef and Mavericks, avoiding a paddle through Princeton Harbor. 
        <p><b>Parking: </b>Limited free parking available.
        <p><b>Facilities: </b>Restrooms (?)
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="198" title="Pillar Point Harbor, far west end" zone="545" chart_title="Pillar Pt Harbor W" modtime="1657144065738" modby="petolino" edits_since="1535990308774" >
  <marker lat="37.502071" lng="-122.492706"/>
  <tide_station>283</tide_station>
  <city>El_Granada</city>
  <details><![CDATA[
      <p><b>Overview: </b>Protected sandy beach near the decrepit old pier. Good meeting spot for coastal paddles and on Pillar Point reef.</p>
      <p><b>Parking: </b>Very limited street parking.</p>
      <p><b>Facilities: </b>none</p>
      <p><b>Address: </b>End of Princeton Ave.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535990308774-198-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Princton end of Princton St.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535990308775-198-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>End of Princton St</span>
  ]]></details>
</station>
  <station station_type="launch" xid='199' title="Half Moon Bay Marina/Pillar Point Harbor" zone="545" chart_title="Half Moon Bay Marina" >
    <marker lat="37.502955" lng="-122.478059"/>
    <tide_station>283</tide_station>
    <city>Half_Moon_Bay</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The Pillar Point Harbor provides a very protected launch spot on a wild stretch of coast. Cruise the harbor or paddle to the outside. 
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>Restrooms. 
        <p><b>Links: </b><a target="tp_details" href="http://www.smharbor.com/pillarpoint/">Pillar Point Harbor</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='200' title="Half Moon Bay, Miramar Beach" zone="545" chart_title="Miramar Beach" >
    <marker lat="37.495830" lng="-122.462784"/>
    <tide_station>283</tide_station>
    <city>Half Moon Bay</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This is an advanced launch location which often has large plunging surf. Best conditions are at low tide, when an offshore reef gives some limited protection from the full ocean conditions. Kayak access to the beach from the street is via a concrete staircase at the north end of Mirada Street. 
        <p><b>Parking: </b>Street parking.
        <p><b>Facilities: </b>Restrooms near the Coastal Trail on Magellan Ave.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="201" title="Pigeon Point Lighthouse" zone="560" modtime="1537377862016" modby="petolino" edits_since="1535993438946" chart_title="Pigeon Pt Lighthouse" >
  <marker lat="37.18269" lng="-122.39257"/>
  <tide_station>12</tide_station>
  <city>Davenport</city>
  <details><![CDATA[
      <p><b>Overview: </b>One of the more protected launch locations along this stretch of the coast. There is usually only small surf even when the ocean conditions are bigger. If paddling south from this location, be aware that a strong northwest wind often develops later in the day, which may make the return trip strenuous. This area may be closed off to protect elephant seals that sometimes use this beach. The Pigeon Point Hostel is only steps away from the launch site. The beach is sand. Access to the south beach is down 50, well maintained, concrete steps. Path starts by the kiosk at the road. Access to the north beach is via an informal, steep and dangerous, but very well used, path to the right of the parking lot. It is about 4 miles &#x28;north&#x29; to Bean Hollow.</p>
      <p><b>Parking: </b>About 25 spots along the road. About a 100 yd carry to the beach. There is no loading zone. Parking is free from 8AM to sunset with no overnight parking allowed except for guests at the hostel. This is a popular tourist destination so parking can be tight.</p>
      <p><b>Facilities: </b>Restrooms about 100 yds from the beach &#x28;open 8am-sunset&#x29;. Maintenance is OK. There is also a drinking fountain and picnic area. There is a hostel for overnight stays at the lighthouse. Not too far away is the Highway 1 Brewery &#x28;south on Hwy 1&#x29;.</p>
      <p><b>Address: </b>210 Pigeon Point Rd &#x28;off Hwy 1&#x29;</p>
      <p><b>Contact Info: </b>Pigeon Point Lighthouse, 650-879-2120<br>Pigeon Point Hostel, 650-879-0633</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=533">http://www.parks.ca.gov/&#x3F;page_id&#x3D;533</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.norcalhostels.org/pigeon">http://www.norcalhostels.org/pigeon</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526929984686-201-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pigeon Pt 1ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535991331223-201-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pigeon Pt south beach, 4.5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535991331224-201-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pigeon Pt south beach and stairs</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535991331225-201-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pigeon Pt north beach access</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535991331226-201-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pigeon Pt north beach, 4.5&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="202" title="Franklin Point, Whitehouse Creek Beach" zone="560" modtime="1526935430184" modby="petolino" edits_since="1526932903549" chart_title="Franklin Pt" >
  <marker lat="37.14582" lng="-122.34689"/>
  <tide_station>12</tide_station>
  <city>Davenport</city>
  <details><![CDATA[
      <p><b>Overview: </b>Relatively protected beach with good access to the Franklin Point rock gardens &#x28;some of the best along this section of coast&#x29;. Bring wheels for transporting the kayak to and from the parking area. Launch to the right of the offshore rock that is centered in the cove. Rock gardens are to the north. Avoid heading south because of protected sea lion and elephant breeding area at A&#xF1;o Nuevo and kayak chomping white sharks.</p>
      <p><b>Parking: </b>10 spots are available about 1/4 mile from the beach at Whitehouse Creek Trailhead. It&#x27;s a mostly level walk over grassland. The final few feet down to the beach are via steps that are a little steep. There is no loading area. Parking is free and restricted to 8AM to sunset. Overnight parking not allowed. Beware of car vandalism.</p>
      <p><b>Facilities: </b>None. However the Highway 1 Brewery is just a short drive north. There is a KOA campground and Costanoa Lodge across the highway from the parking location and up Rossi Rd.</p>
      <p><b>Address: </b>Parking is at Highway 1 and Rossi Rd.</p>
      <p><b>Contact Info: </b>Franklin Point is part of A&#xF1;o Nuevo State Reserve and is managed by the CA Dept of Parks and Rec., 650-879-2025<br>KOA, 650-879-7302<br>Costanoa Lodge, 650-879-1100</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.koa.com/campgrounds/santa-cruz-north">http://www.koa.com/campgrounds/santa-cruz-north</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.costanoa.com/">http://www.costanoa.com</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.parks.ca.gov/?page_id=523">http://www.parks.ca.gov/&#x3F;page_id&#x3D;523</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526932903549-202-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Franklin Point - final steps to beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526932903550-202-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Franklin Pt 1 ft tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526932903551-202-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Franklin Pt 1 ft tide</span>
  ]]></details>
</station>
  <station station_type="launch" xid="203" title="Davenport Landing" zone="560" modtime="1670648534230" modby="petolino" edits_since="1537378132466" >
  <marker lat="37.02455" lng="-122.21644"/>
  <tide_station>12</tide_station>
  <city>Davenport</city>
  <details><![CDATA[
      <p><b>Overview: </b>Relatively protected ocean access point. Beware of localism from board surfers. Sandy beach. Surf breaks on the north and south ends of the cove can be challenging. Kayaks tend to gather on the north point and surfers on the south. There are shallow reefs in this area so launch and paddle straight out through a generally well protected deep channel. Consider running shuttle to Santa Cruz harbor &#x28;about 11 miles&#x29; for a great day trip.</p>
      <p><b>Parking: </b>There are about 20 spaces that are free along the road. There is no loading area. It is about 400 ft to the beach. The area is open sunrise to sunset with no overnight parking &#x28;10PM-6AM&#x29; allowed. Beware of car vandalism. Surfers feel they &#x22;own&#x22; the parking on the west side of the road and have been known to vandalize cars parked in &#x22;their&#x22; spaces &#x28;especially cars with kayak racks&#x29;.</p>
      <p><b>Facilities: </b>Clean, well maintained bathrooms that are ADA accessible. Access to the beach is via concrete steps or an ADA ramp.</p>
      <p><b>Address: </b>Davenport Landing is a horseshoe-shaped road about halfway between Davenport and Scott Creek. It becomes one-way just past the beach.</p>
      <p><b>Contact Info: </b>Santa Cruz County Parks<br>831-454-7938 or 831-454-7901</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.scparks.com/Home/Parks/BeachesandCoastalAccess/CoastalAccess.aspx">Coastal Access, Santa Cruz County Parks</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.santacruz.org/Things-to-do/Things-To-Do-Details/ThingGid/82716">https://www.santacruz.org/Things-to-do/Things-To-Do-Details/ThingGid/82716</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Davenport-Landing-Surf-Report/256/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526935211688-203-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Davenport Landing 1ft Tide north</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526935211689-203-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Davenport Landing 1ft Tide south</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535992091081-203-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Davenport, 4&#x27; tide looking north</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535992091082-203-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Davenport, 4&#x27; tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="204" title="Santa Cruz Harbor Launch Ramp" zone="535" modtime="1537378213393" modby="petolino" edits_since="1535992688974" chart_title="Santa Cruz Harbor" >
  <marker lat="36.963875" lng="-122.001098"/>
  <tide_station>362</tide_station>
  <city>Santa_Cruz</city>
  <details><![CDATA[
      <p><b>Overview: </b>The five lane, concrete boat launch is located on the southeast side of the harbor. It is near the harbor mouth and busy with motor boat traffic. Kayaks can launch from the ramp or the adjacent, high-float dock.</p>
      <p><b>Parking: </b>The lot is very large. There is a fee for parking. Parking and launch for kayaks is &#x24;12.50 &#x28;2 kayaks/car&#x29; or &#x24;6/launch for walk-ins. Pay at the harbormasters office. Overnight fee for parking is &#x24;30 &#x28;9PM-3AM&#x29;.</p>
      <p><b>Facilities: </b>The Crow&#x27;s Nest restaurant is located close to the ramp and serves good food. The Kayak Connection &#x28;outfitter&#x29; is located here as well.</p>
      <p><b>Address: </b>135 5th Ave. Santa Cruz</p>
      <p><b>Contact Info: </b>Santa Cruz Harbor office, 831-475-6161<br>Kayak Connection, 831-479-1121</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.santacruzharbor.org/">http://www.santacruzharbor.org/</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.kayakconnection.com/santa-cruz-harbor">http://www.kayakconnection.com/santa-cruz-harbor</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526611898979-204-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz Map</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535992688974-204-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz harbor ramp</span>
  ]]></details>
</station>
  <station station_type="launch" xid="205" title="Stevens Creek Reservoir" modtime="1527263027774" modby="bask0099" edits_since="0" >
  <marker lat="37.29661" lng="-122.0789"/>
  <city>Cupertino</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stevens Creek Reservoir is a popular fishing lake and the water gets pretty warm in summer. Fees: &#x24;6 parking, &#x24;5 launching, &#x24;4 quagga inspection. The park is open from 8AM to sunset from April 15th to October 14th. There is a paved ramp and, at higher water levels, a small, mid-height dock. This reservoir is for non-motorized boats only.</p>
      <p><b>Parking: </b>Parking for about 40 cars. About 400&#x27; from launch. there is a loading area. No overnight parking allowed.</p>
      <p><b>Facilities: </b>1 porta potty that is clean and well maintained. It is about 120 yds from the launch. Picnic area.</p>
      <p><b>Contact Info: </b>Santa Clara Parks, 408-867-3654<br>Park office, 408-867-9959<br>Ranger, 408-489-7380</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sccgov.org/sites/parks/parkfinder/pages/stevenscreek.aspx">http://www.sccgov.org/sites/parks/parkfinder/pages/stevenscreek.aspx</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527263027774-205-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Stevens Creek Res, 3-18.</span>
  ]]></details>
</station>
  <station station_type="launch" xid='206' title="Loch Lomond Reservoir">
    <marker lat="37.11090" lng="-122.06500"/>
    <city>Ben Lomond</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Generally open from March 1 to September 15, but 
        currently closed to all private boats due to Zebra Mussel restrictions. 
        The lake has a substantial boat rental fleet that is available on a first-come, first-served basis.
        <p><b>Parking: </b>Fee parking
        <p><b>Facilities: </b>Restrooms, picnic tables.
        <p><b>Links: </b><a target="tp_details" href="http://www.elkhornslough.org/paddling.htm">Elkhorn Slough Foundation</a><p>
		  ]]>
    </details>
  </station>
<station station_type="launch" xid="207" title="Elkhorn Slough, Kirby Park" zone="535" modtime="1537848774874" modby="bask0099" edits_since="1525885240464" chart_title="Elkhorn Slough" >
  <marker lat="36.83989" lng="-121.74362"/>
  <tide_station>189</tide_station>
  <city>Moss_Landing</city>
  <details><![CDATA[
      <p><b>Overview: </b>Nice launch or destination for paddling on Elkhorn Slough. However as of May 2018 the park is closed for an indefinite period due to road damage during the 2016/17 storms. You can still walk in but it is 1/4 mile.</p>
      <p><b>Parking: </b>As of May 2018, parking is available along the road but break-ins are common.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.santa-cruz.ca.us/wt/recreation/index.html">Loch Lomond Recreation Area</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.mosslandingharbor.dst.ca.us/">http://www.mosslandingharbor.dst.ca.us/</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.elkhornslough.org/faq">http://www.elkhornslough.org/faq</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525885240464-207-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kirby Park_1_LowTide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525885240465-207-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kirby Park_2_LowTide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1537848774874-207-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kirby Park, Jan 14, 2017</span>
  ]]></details>
</station>
<station station_type="launch" xid="208" title="Moss Landing Harbor" zone="535" modtime="1525885899740" modby="bask0099" chart_title="Moss Landing" >
  <marker lat="36.81248" lng="-121.78695"/>
  <tide_station>266</tide_station>
  <city>Moss_Landing</city>
  <details><![CDATA[
      <p><b>Overview: </b>Nice launch or destination for paddling on Elkhorn Slough. Exit the channel to the Pacific for whale watching. Pay attention to predicted currents in the channel. Launch from the ramp or the adjacent beach.</p>
      <p><b>Parking: </b>Available. Spaces for about 20 cars. There is a loading area near the ramp/beach. To park and kayak launch there is a fee of &#x24;11. Launch only for &#x24;6. Paid at iron ranger. There do not appear to be any time or overnight restrictions.</p>
      <p><b>Facilities: </b>Restrooms are old but maintained. Thee is a drinking fountain but no other amenities. There are a couple good restaurants nearby &#x28;Phil&#x27;s Fish Market&#x21;&#x29;. Two outfitters are located here: Monterey Bay Kayaks and Kayak connection</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.elkhornslough.org/paddling.htm">Elkhorn Slough Foundation - Information for Kayakers</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.mosslandingharbor.dst.ca.us">http://www.mosslandingharbor.dst.ca.us</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.montereybaykayaks.com">http://www.montereybaykayaks.com</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.kayakconnection.com">http://www.kayakconnection.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525885899740-208-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Moss Landing Beach_1_Tide_0.5ft</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525885899741-208-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>MossL Landing ramp and dock_Tide_0.5ft</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525885899742-208-bask0099.jpg" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Moss Landing Beach_2_Tide_0.5ft</span>
  ]]></details>
</station>
  <station station_type="launch" xid="209" title="Monterey Bay Kayaks" zone="535" modtime="1670648787100" modby="petolino" edits_since="0" >
  <marker lat="36.60134" lng="-121.88758"/>
  <tide_station>219</tide_station>
  <city>Monterey</city>
  <details><![CDATA[
      <p><b>Overview: </b>Great launch spot in a protected part of Monterey Bay. Paddle along the Monterey waterfront or into the open bay. If you paddle about 1/2 mile south past the breakwater and about 300 yards from the beach, you will encounter extensive kelp beds that the sea otters like to hang out in. Rentals and retail sales are available in the MBK shop.</p>
      <p><b>Parking: </b>Fee parking in nearby parking lot is &#x24;6 for 1/2 day.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.montereybaykayaks.com">Monterey Bay Kayaks</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Monterey-Wall-Surf-Report/9262/">Magic Seaweed Surf Report &#x28;Monterey Wall&#x29;</a></p>
  ]]></details>
</station><station station_type="launch" xid='210' title="Monterey Bay State Beach" zone="535">
    <marker lat="36.604304" lng="-121.869911"/>, 
    <tide_station>219</tide_station>
    <city>Monterey</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This is a great location, where you can select the size of surf you want, and where you are unlikely to encounter territorial board surfers. Starting at Monterey Bay Kayaks near the wharf, follow the shoreline eastward and curve northeastward toward Seaside and Sand City until you find the size surf you want. Due to shielding by the Monterey Peninsula, surf is negligible near the wharf and gets progressively larger as you go along the shore. The number of board surfers is small, and they are friendly if you show good surf etiquette. There tends to be a good “soup zone” of frothy white stuff between the break and shore, where you can hang out and get used to the feel of on-rushing water. Then, go out to the break and practice. A good access point is from Casa Verde Way, a mile east of the wharf from Del Monte Avenue.<p>Turn onto Casa Verde Way from Del Monte Avenue or Highway 1,  going north toward the beach. Immediately past Del Monte Avenue, the road splits into one-way streets; go right (on Surf Way) and proceed to the beach (Tide Avenue).
        <p><b>Parking: </b>Parking is unlimited and free
        <p><b>Links: </b><a target="tp_details" href="http://www.monterey.org/en-us/departments/montereyrecreation/parksandbeaches.aspx">Monterey Beaches</a>
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="211" title="Pacific Grove, Lovers Point" zone="535" chart_title="Lovers Pt" modtime="1670648883092" modby="petolino" edits_since="1527554237383" >
  <marker lat="36.62493" lng="-121.91632"/>
  <tide_station>219</tide_station>
  <city>Pacific_Grove</city>
  <details><![CDATA[
      <p><b>Overview: </b>Lovers Point has a protected sandy beach. Great launch spot for coastal and whale watching trips.</p>
      <p><b>Parking: </b>Limited on-street parking</p>
      <p><b>Facilities: </b>Restrooms nearby.</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Lovers-Point-Surf-Report/8064/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527554237383-211-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lover&#x27;s Point Beach</span>
  ]]></details>
</station>
  <station station_type="launch" xid='212' title="Pacific Grove, Coral Street Beach" zone="535" chart_title="Coral St Beach" >
    <marker lat="36.63533" lng="-121.92673"/>
    <tide_station>219</tide_station>
    <city>Pacific_Grove</city>
    <details>
      <![CDATA[<p><b>Overview: </b>This launch has a rocky entry. It is only recommended for small groups on calm days.
        <p><b>Parking: </b>Limited on-street parking.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='213' title="Carmel, Stillwater Cove" zone="565" chart_title="Stillwater Cove" >
    <marker lat="36.56595" lng="-121.94181"/>
    <tide_station>60</tide_station>
    <city>Carmel</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Stillwater Cove has a sheltered, sandy beach. It is a good lunch stop on longer trips. 
        <p><b>Parking: </b>Limited parking. 17-Mile Drive toll road access.
        <p><b>Facilities: </b>Restrooms, picnic tables.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="214" title="Carmel, Monastery Beach" zone="565" modtime="1598127186117" modby="petolino" edits_since="1598127012869" chart_title="Monastery Beach" >
  <marker lat="36.52268" lng="-121.928"/>
  <tide_station>60</tide_station>
  <city>Carmel</city>
  <details><![CDATA[
      <p><b>Overview: </b>Monastery Beach was once a great launch spot for trips around Point Lobos State Reserve, but paddling is no longer allowed anywhere in the Reserve without a boating permit. Permit holders must launch from Whalers Cove &#x28;within the Reserve&#x29;.<p>Monastery Beach is notorious for big dumping surf, but it is often calm.</p>
      <p><b>Parking: </b>Ample on-street parking.</p>
      <p><b>Facilities: </b>Restrooms.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/?page_id=571">Point Lobos State Natural Reserve</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.parks.ca.gov/pages/571/files/pointlobos.pdf">Point Lobos State Reserve Map</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid="215" title="Point Lobos State Reserve, Whalers Cove" zone="565" modtime="1598127245405" modby="petolino" edits_since="1598126759310" chart_title="Point Lobos Reserve" >
  <marker lat="36.52026" lng="-121.94051"/>
  <tide_station>60</tide_station>
  <city>Carmel</city>
  <details><![CDATA[
      <p><b>Overview: </b>Paddling in the waters of the Point Lobos State Reserve is allowed only when holding a boating permit. Whalers Cove is the only place in the Reserve where launching or landing is permitted.</p>
      <p><b>Parking: </b>Limited, and a permit is required.</p>
      <p><b>Facilities: </b>Restrooms, picnic tables.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/?page_id=571">Point Lobos State Natural Reserve</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.parks.ca.gov/pages/571/files/pointlobos.pdf">Point Lobos State Reserve map</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid='216' title="Malpaso Creek" zone="565">
    <marker lat="36.48127" lng="-121.93829"/>
    <tide_station>60</tide_station>
    <city>Carmel</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Malpaso Creek is a great access point to the Big Sur coast, especially for trips exploring the coast to the south. 
        The beach is protected from NW swells, but the outside is very exposed - as is most of the Big Sur coast.
        <p><b>Parking: </b>Street parking along Yankee Pt. Drive north of Malpaso Creek. A trail leads from the southern bend of Yankee Pt. Drive to the beach.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid="217" title="Andrew Molera State Park" zone="565" chart_title="Andrew Molera SP" modtime="1670649135506" modby="petolino" edits_since="0" >
  <marker lat="36.28082" lng="-121.85906"/>
  <tide_station>60</tide_station>
  <city>Big_Sur</city>
  <details><![CDATA[
      <p><b>Overview: </b>Andrew Molera State Park is one of the few access points to the Big Sur coast. The beach is somewhat protected from NW swells. Access to the beach is through Andrew Molera State Park. It&#x27;s a very long trail from the parking lot or campground to the beach, so bring wheels, but it is well worth the effort.</p>
      <p><b>Parking: </b>State Park day use or camping fee.</p>
      <p><b>Facilities: </b>Restrooms in the campground, camping.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=582">Andrew Molera State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Andrew-Molera-State-Park-Surf-Report/260/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
  <station station_type="launch" xid='218' title="Pfeiffer Beach" zone="565">
    <marker lat="36.23799" lng="-121.81617"/>
    <tide_station>60</tide_station>
    <city>Big_Sur</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Pfeiffer beach provides access to the Big Sur coast. It is not very protected from NW swells, so pick a calm day!
        <p><b>Parking: </b>Day use fee.
        <p><b>Facilities: </b>Restrooms (?)
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='219' title="Garapata State Beach" zone="565">
    <marker lat="36.419044" lng="-121.913424"/>
    <tide_station>60</tide_station>
    <city>Big_Sur</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Long walk to the beach, with stairs at the end. Often has large dumping surf, even on smaller days. This site is best on small days. Strong surf launch skills are recommended. Beach gets smaller at high tide. Good for exploring the Big Sur coast.
        <p><b>Parking: </b>Along the road.
        <p><b>Facilities: </b>none
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='220' title="Mill Creek" zone="565">
    <marker lat="36.00181" lng="-121.50529"/>
    <tide_station>357</tide_station>
    <city>Big_Sur</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Mill Creek provides good access for trips along the Big Sur coast.
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>Restrooms (?)
		  ]]>
    </details>
  </station>
  <station station_type="launch" xid='221' title="San Simeon, Hearst State Memorial Beach" zone="670" chart_title="Hearst State Beach" >
    <marker lat="35.64317" lng="-121.18853"/>
    <tide_station>357</tide_station>
    <city>San_Simeon</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Hearst Memorial State Beach is located in a protected bay, but the surf can still be dumpy. 
        <p><b>Parking: </b>Free.
        <p><b>Facilities: </b>Restrooms. San Simeon campground is a few miles south on Hwy 1.
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid='222' title="Mendocino, Beach" zone="455">
    <marker lat="39.30330" lng="-123.80464"/>
    <tide_station>216</tide_station>
    <city>Mendocino</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Nice picnic spot on trips along the Mendocino Headlands.
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid='223' title="Mouth of Drake's Estero" zone="545">
    <marker lat="38.03573" lng="-122.92655"/>
    <tide_station>99</tide_station>
    <city>Inverness</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Nice lunch spot during trips on Drakes Estero. Check the tides to avoid 
        getting stuck on sand bars or in the mud. Drakes and Limantour Esteros are closed each
        spring for seal pupping season, usually between March 1 and June 30. 
        <p><b>Links: </b><a target="tp_details" href="http://www.nps.gov/pore/">Point Reyes National Seashore</a>
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid='224' title="Tomales Beach" zone="540">
    <marker lat="38.17384" lng="-122.92347"/>
    <tide_station>213</tide_station>
    <city>Inverness</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Nice beach on the west side of Tomales Bay. 
        <p><b>Facilities: </b>Porta-Potties.
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid='225' title="Marshall Beach" zone="540">
    <marker lat="38.16240" lng="-122.91568"/>
    <tide_station>213</tide_station>
    <city>Inverness</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Nice beach on the west side of Tomales Bay.  No running water. 
        <p><b>Facilities: </b>Porta-Potties.
		  ]]>
    </details>
  </station>
<station station_type="destination" xid="226" title="Kirby Cove" zone="530" modtime="1604698303555" modby="bask0099" edits_since="1526008621848" >
  <marker lat="37.82679" lng="-122.49016"/>
  <current_station>284</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Located 1/2 mile out the gate this is a nice spot to land with relatively small surf. Interesting geology: outcrops of folded red ribbon chert. The beach faces south, is steep, and the surf dumps. The easiest landing is at the far west end.</p>
      <p><b>Parking: </b>Unless you have a camping reservation there is no parking. The entrance on Conzelman Rd is gated and locked. Even with parking the distance from the campground to the beach is difficult--about 100yds over a berm and down a set of stairs to the beach. And poison oak...</p>
      <p><b>Facilities: </b>Restrooms, picnic tables, camping with reservations. Spectacular views at night&#x21;</p>
      <p><b>Contact Info: </b>http://www.recreation.gov Click camping and enter Kirby Cove. Or call the Headlands Visitor Center for more info at 415-331-1540.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.recreation.gov/">http://www.recreation.gov</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604698303555-226-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kirby cove west end</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604698303556-226-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kirby cove</span>
  ]]></details>
</station>
  <station station_type="destination" xid="228" title="Point Bonita Arch" zone="545" modtime="1594066175375" modby="petolino" edits_since="0" >
  <marker lat="37.81546" lng="-122.52933"/>
  <tide_station>288</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Paddling through the arch beneath the Pt. Bonita lighthouse is one of the greatest paddling experiences in the Bay area. Alas, it needs to be really calm to do this. Interesting geology: great outcrops of pillow basalt in the cliffs and the arch.<p>WARNING: most of the shoreline of nearby Bonita Cove is now closed to boating within 300 ft. of shore. See links below.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Chief-Ranger-s-memo-signed.pdf">NPS Closure Memo &#x28;see Section 5&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">Closure maps</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="231" title="Rodeo Cove (South End)" zone="545" modtime="1594065931417" modby="petolino" edits_since="0" chart_title="Rodeo Cove S." >
  <marker lat="37.82494" lng="-122.53436"/>
  <current_station>270</current_station>
  <city>Muir_Beach</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sandy beach with relatively small surf. Good lunch spot.<p>WARNING: The waters around nearby Bird Rock are now closed to boating within 300 ft. of shore. See links below.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Chief-Ranger-s-memo-signed.pdf">NPS Closure Memo &#x28;see Section 5&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">Closure map</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="232" title="Red Rock Island" zone="530" modtime="1590941271168" modby="petolino" edits_since="1528076224342" chart_title="Red Rock" >
  <marker lat="37.92986" lng="-122.43114"/>
  <current_station>346</current_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Red Rock is accessible and landable on all sides. There are strong currents flowing past so be mindful of the tide and plan accordingly. It is located right beside the shipping lanes so there are ferries and freighters to watch out for. Red Rock is owned by an ex-pat and has been for sale for years. The island above the high tide line is private property, so don&#x27;t trespass. Depending on the tidal currents it is an easy paddle from the Richmond shoreline. Do not get close to the Chevron Pier or you will get yelled at or maybe arrested. More planning is required to come from Marin.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Address: </b>Red Rock sits just south of the Richmond Bridge. It is about 3 miles from either San Quentin in Marin or Ferry Point in Point Richmond.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528076086950-232-petolino.jpg" height="235" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Approaching from the southeast</span>
  ]]></details>
</station>
  <station station_type="destination" xid='233' title="Riviera de Garbage" zone="530">
    <marker lat="37.96790" lng="-122.39694"/>
    <current_station>307</current_station>
    <city>Richmond</city>
    <details>
      <![CDATA[<p><b>Overview: </b> Rocky beach at former dump site.
        <p><b>Facilities: </b>Picnic table above beach. No restroom.
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid="234" station_class="water_trail" title="Angel Island, West Garrison" zone="530" modtime="1604861274242" modby="petolino" edits_since="1604629426201" chart_title="West Garrison" >
  <marker lat="37.85984" lng="-122.44377"/>
  <current_station>341</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>The West Garrison, or Fort Reynolds, is a good spot for a picnic with a great view and historic buildings. &#x24;3 State Park day use fee.</p>
      <p><b>Facilities: </b>Restrooms, picnic tables.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="235" station_class="water_trail" title="Angel Island, Kayak Camp" zone="530" modtime="1604861354298" modby="petolino" edits_since="1604723475641" chart_title="Kayak Camp" >
  <marker lat="37.86248" lng="-122.44048"/>
  <current_station>341</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>Kayak camp is the best site for camping. It is reached over a steep trail up the hill from the beach, which BASK installed years ago and is still functional. Stash boats above the high tide line in the bushes. Kayak camp can accomodate up to 20 people. Reserve it at 800-444-7275 or at ReserveAmerica.com . &#x24;3 State Park day use fee.</p>
      <p><b>Parking: </b>Ya can&#x27;t drive there.</p>
      <p><b>Facilities: </b>Restrooms a short distance away, water, picnic tables.</p>
      <p><b>Contact Info: </b>CA State Parks camping reservations: 800-444-7275</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.reserveamerica.com/">ReserveAmerica &#x28;camping reservations&#x29;</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604723475641-235-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Kayak Kamp</span>
  ]]></details>
</station>
  <station station_type="destination" xid="236" station_class="water_trail" title="Angel Island, Ayala Cove" zone="530" modtime="1604629648807" modby="bask0099" edits_since="0" chart_title="Ayala Cove" >
  <marker lat="37.86663" lng="-122.43551"/>
  <current_station>338</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is the main visitor center with the ferry dock and boat harbor. Often crowded. &#x24;3 day use fee to be paid at ferry dock. There is a nice protected beach for landing kayaks.</p>
      <p><b>Facilities: </b>Restrooms, picnic tables, snack bar.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
  ]]></details>
</station>
  <station station_type="destination" xid="237" station_class="water_trail" title="Angel Island, China Cove" zone="530" modtime="1606791282719" modby="bask0099" edits_since="1604698209596" chart_title="China Cove" >
  <marker lat="37.87034" lng="-122.42649"/>
  <current_station>338</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>China Cove is the site of the historic immigration station on Angel Island. &#x24;3 day use fee.</p>
      <p><b>Facilities: </b>Restrooms.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=468">Angel Island State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/angel-island-state-park/">Bay Area Water Trail - Angel Island</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604698209596-237-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>China cove, 2020</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606791282719-237-bask0099.jpg" height="532" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Angel Island, Hospital Cove, 1&#x27;tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606791282720-237-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Angel Island, Hospital cove, 5&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="destination" xid="238" title="Sam&apos;s Anchor Cafe, Tiburon" zone="530" modtime="1527445996698" modby="petolino" edits_since="1527385872008" chart_title="Sam&#39;s Cafe" >
  <marker lat="37.8728" lng="-122.45637"/>
  <current_station>338</current_station>
  <city>Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sam&#x27;s Anchor Cafe has a guest dock which is quite high, full of splinters, and deteriorating. Visiting kayaks can be tied off behind the dock or pulled up onto the dock and stashed behind the gangway. Come from Sausalito, Horseshoe Cove or Ferry Point. It is a favorite spot for evening paddles from Sausalito. If you need a place to stay, the very chi-chi Waters Edge Hotel is right next door. This is a busy boating spot with the Corinthian Yacht Club on one side and the Angel Island Ferry on the other. Sam&#x27;s has a new owner so maybe the docks will get upgraded.</p>
      <p><b>Parking: </b>There is a public pay parking lot at the end of the street. Or, if you are lucky there might be a free 2 hour spot on the street. Better to come by kayak.</p>
      <p><b>Facilities: </b>Bathrooms in both the restaurant and on the public dock next to the restaurant. Hours: M-Th, 11Am-11PM&#x3B; Fri, 11AM-12AM, S/S, 9:30AM-11 or 12.</p>
      <p><b>Address: </b>27 Main St. in Tiburon</p>
      <p><b>Contact Info: </b>415-435-4527</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.samscafe.com/">http://www.samscafe.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527385872008-238-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sams gangway 5-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527385872009-238-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sam&#x27;s dock, 3-21-13 002</span>
  ]]></details>
</station>
  <station station_type="destination" xid="239" title="Glen Cove Marina" zone="530" modtime="1526618268932" modby="bask0099" chart_title="Glen Cove" >
  <marker lat="38.06841" lng="-122.2139"/>
  <current_station>65</current_station>
  <city>Vallejo</city>
  <details><![CDATA[
      <p><b>Overview: </b>This private marina doesn&#x27;t offer a lot in the way of launch sites for hand held boats. Ask permission to launch from the guest dock. This is a nice stopping place for lunch &#x28;BYO&#x29;. Although there is no formal campground they have also been known to allow kayakers to camp on their lawn&#x21;&#x21; Make friends and ask about it. Come here from Vallejo or Benicia.</p>
      <p><b>Parking: </b>There are about 20 spaces beside and behind the harbormaster&#x27;s building. Free.</p>
      <p><b>Facilities: </b>Restrooms are in the marina office building and are open when harbormaster&#x27;s office is open &#x28;9AM-5PM maybe&#x29;. Boat storage is available. Inquire at the marina office.</p>
      <p><b>Address: </b>2000 Glen Cove Marina Rd.</p>
      <p><b>Contact Info: </b>harbormaster, 707-552-3236</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.glencovemarina.net">http://www.glencovemarina.net</a></p>
      <p><img class="details_img" src="images/Solano,%20Zero%20Tide/Glen%20cove%20marina,%20dock.JPG" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526358333157-239-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen cove Marina, 4&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526358333158-239-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen cove Marina dock, 4&#x27; tide</span>
  ]]></details>
</station>
  <station station_type="destination" xid="240" title="San Francisco, Pier 1.5" zone="530" modtime="1528314128687" modby="bask0099" edits_since="0" chart_title="Pier 1.5" >
  <marker lat="37.79767" lng="-122.39446"/>
  <current_station>247</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Pier 1 1/2 is a city dock &#x28;high freeboard&#x29; which permits use of human powered vessels 24 hours, 7 days per week. Good place to visit the Ferry Building. For security reasons it is advisable to leave someone behind to watch the boats. The long range plan includes having a low float dock for kayakers at the rear of the large float. Note: during winter storms it has gotten rough enough here to rip out the large dock&#x21;</p>
      <p><b>Parking: </b>None</p>
      <p><b>Facilities: </b>Bathroom in the building. Nice restaurant with a deck. Right next door to the Ferry Building &#x28;bring money&#x29;.</p>
      <p><b>Address: </b>Pier 1 1/2 on the Embarcadero. Owned by the Port of San Francisco.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528314128687-240-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 1.5 in SF</span>
  ]]></details>
</station>
  <station station_type="destination" xid="241" title="San Francisco, Crane Cove Park" zone="531" modtime="1614462957564" modby="petolino" edits_since="1609779664675" chart_title="Crane Cove" >
  <marker lat="37.763598" lng="-122.387044"/>
  <tide_station>315</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Protected pocket beach. Opened 9-2020. Easy paddle from Islais Creek or Pier 52. Good spot for a picnic. Water quality may be questionable after heavy rain with run off. Pier 70 is an active Port facility pier so be careful of boat traffic and stay north and west of the buoys to reach the beach. There is a path from the street for boat dropoff at 18th St. and Illinois. The park is very popular with locals and is quite crowded on weekends.</p>
      <p><b>Parking: </b>There is a small parking lot at 19th St. and Illinois. Otherwise, forget it.</p>
      <p><b>Facilities: </b>Will include a boat house, water, bathrooms etc. Currently there are porta potties and a wash station. There is a nice lawn for picnics. Other facilities may be completed in 2021.</p>
      <p><b>Address: </b>18th St. and Illinois. Beside Pier 70</p>
      <p><b>Contact Info: </b>Port of San Francisco</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604266950578-241-bask0099.jpg" height="266" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Crane Cove beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604266950579-241-bask0099.jpg" height="478" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Crane cove water access</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1609779664675-241-bask0099.jpg" height="266" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Crane cove park beach</span>
  ]]></details>
</station>
  <station station_type="launch" xid="242" station_class="water_trail" title="Mission Creek Kayak Launch Dock" zone="531" modtime="1528077051399" modby="petolino" edits_since="1527975891356" chart_title="Mission Creek Launch" >
  <marker lat="37.771778" lng="-122.397028"/>
  <tide_station>315</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from the low float dock. UCSF has a boat house here. Unload on the street and then good luck finding a place to put the car. From here tour the waterfront or stop here for a rest stop after putting in somewhere else more convenient. The dock is open from 6AM-10PM. Note: There is a sewer overflow and storm drain outfall right next to the dock. After heavy storms the water quality might not be so good. Don&#x27;t fall in.</p>
      <p><b>Parking: </b>Metered parking is limited and on the street.</p>
      <p><b>Facilities: </b>There are bathrooms and drinking fountain at the west end of the park as well as a grassy area for a picnic and a sand volleyball court. The bathrooms are open 8AM-7PM.</p>
      <p><b>Address: </b>Mission Creek Park, 451 Berry St. Under the freeway</p>
      <p><b>Contact Info: </b>Mission Bay Parks, 415-543-9063</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/mission-creek/">Bay Area Water Trail - Mission Creek</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.missionbayparks.com/">http://www.missionbayparks.com</a></p>
      <p><img class="details_img" src="images/San%20Francisco,%20Zero%20Tide/Mission_Creek_0Tide.jpg" height="299" width="400">
      <br><span class='details_caption'>Picture taken at zero tide</span>
      <p><img class="details_img" src="images/7foot/San%20Francisco,%207'%20tides/Mission%20Creek%20dock,%207'%20tide.jpg" height="300" width="400">
      <br><span class='details_caption'>Picture taken at 7-foot tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527974284586-242-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mission Creek</span>
  ]]></details>
</station>
  <station station_type="launch" xid="243" station_class="water_trail" title="South Beach Harbor (AKA Pier 40)" zone="531" modtime="1604861536585" modby="petolino" edits_since="1604786556576" chart_title="South Beach Harbor" >
  <marker lat="37.781861" lng="-122.387639"/>
  <tide_station>315</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>The old City Kayak dock is gone. The only launch possibility is beside the locked gate to the south side docks. This is a fairly high freeboard dock.</p>
      <p><b>Parking: </b>Parking is free and limited to about 30 cars.</p>
      <p><b>Facilities: </b>Public bathroom. City Kayak operates out of the building and provides kayak storage as well as guided trips.</p>
      <p><b>Address: </b>Embarcadero at Townsend</p>
      <p><b>Contact Info: </b>Port of San Francisco.</p>
      <p><b>Links: </b><a target="tp_details" href="http://sfbaywatertrail.org/trailhead/pier-40/">Bay Area Water Trail - Pier 40</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://citykayak.com">City Kayak</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528388421870-243-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Parking at Pier 40</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604786556576-243-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pier 40 11-2020</span>
  ]]></details>
</station>
  <station station_type="destination" xid='244' title="Pillar Point Reef" zone="545">
    <marker lat="37.49441" lng="-122.49769"/>
    <tide_station>283</tide_station>
    <city>Half_Moon_Bay</city>
    <details>
      <![CDATA[<p><b>Overview: </b>Great surfing spot! It tends to have smaller surf on the reef and larger breaks outside the reef near Sail and Mushroom Rocks.
		  ]]>
    </details>
  </station>
  <station station_type="destination" xid="245" title="Yellow Bluff" zone="530" modtime="1527878011786" modby="petolino" edits_since="1527793800461" >
  <marker lat="37.8366" lng="-122.47155"/>
  <current_station>133</current_station>
  <city>Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>On strong ebbs, big standing waves form downstream of the rocky point. There is a large eddy along the shore. It&#x27;s like a merry-go-round for kayakers. If you didn&#x27;t come to play, hug the shore.</p>
      <p><b>Parking: </b>If you just came to play, park at Horseshoe Cove.</p>
      <p><b>Facilities: </b>Presidio Yacht Club &#x28;PYC&#x29; serves beer for afterward.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527793800461-245-bask0099.jpg" height="261" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Playtime at Yellow Bluff</span>
  ]]></details>
</station>
  <station station_type="destination" xid='246' title="Lake Tahoe, Fannette Island, Emerald Bay" chart_title="Fannette Island" >
    <marker lat="38.95416" lng="-120.10065"/>
    <city>South_Lake_Tahoe</city>
    <details>
      <![CDATA[<p><b>Overview: </b>The only landing spot is in the shallows 
        that face Vikingsholm Castle. Requires moving through bowling ball sized rocks 
        and dismounting boat in ankle to knee deep water.  Pull boat up onto shore 
        afterwards because wakes by power boats can cause damage if left in the water.
         
        <p>It is a 3.5 mile paddle, each way, from Baldwin Beach to the south. Rental SOT 
        kayaks are available (season permitting) at the shore South of Vikingsholm Castle 
        (requires hiking down and back up).
        <p><b>Facilities: </b>None.
		  ]]>
    </details>
  </station>
<station station_type="meeting" xid="247" title="The Women&apos;s Building (monthly BASK General Meetings)" zone="530" modtime="1527363095577" modby="petolino" edits_since="1526078650017" >
  <marker lat="37.761575" lng="-122.422758"/>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>The monthly BASK General Meeting occurs on the last Wednesday of the month, 6:30 to 9:30 PM, at the Women&#x27;s Building, 3543 18th St., San Francisco. We do not meet in November or December.<p>For more information on next meeting, check the Main Page of BASK website.<p><b>Public Transit: </b>Take BART to the 16th Street Station--it&#x27;s a short three block walk and takes about 5 minutes.</p>
      <p><b>Parking: </b>By special arrangement during the school year, we can park in the Mission High School lot on the west side of Dolores Street between 17th and 18th Streets &#x28;see marker on map&#x29;. The parking driveway takes you up a ramp to an elevated parking slab behind a chain link fence. It is a two block walk to the Women&#x27;s Building. We suggest you put something that says BASK on your dashboard. <b><i>The lot will be locked at 10 PM</i></b> so make sure you are out well before then. <b><i>This lot is open only on nights when school is in session - closed on school holidays and during summer break.</i></b> Check the BASK home page before arriving.</p>
      <p><b>Address: </b>The Women&#x27;s Building, 3543 18th St., Mission District, San Francisco. We meet in the ground floor auditorium, just to the right of the main entrance.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.womensbuilding.org/">The Women&#x27;s Building</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.bask.org/">BASK</a></p>
      <p><img class="details_img" src="images/WomensBuildingPix.jpg" height="165" width="400">
  ]]></details>
</station>
<station station_type="launch" xid="248" title="Glen Cove Waterfront Park in Vallejo" zone="530" modtime="1527983490802" modby="bask0099" edits_since="1526359077698" chart_title="Glen Cove Park" >
  <marker lat="38.068224" lng="-122.20742"/>
  <current_station>65</current_station>
  <city>Vallejo</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a sand and small gravel beach that, at low tide, exposes to mud. The site is in a bight right on the Carquinez Strait so it blows upstream on summer afternoons. The far east end of the beach is flat sandstone. This might be a better destination than launch because of the limited parking and distance from parking to the beach and the stairs. Interestingly, this park is on the Bay Trail, the Ridge Trail and the Delta Trail.</p>
      <p><b>Parking: </b>Parking is on the dead end at the gate entering the park. It is about 200 yds to the old concrete steps leading down to the beach. Parking is free. No overnight parking allowed.</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Address: </b>From highway 780 heading to Benicia take the Glen Cove off ramp. Turn left on Regatta and right on Whitesides and go to the end.</p>
      <p><b>Contact Info: </b>Greater Vallejo Recreation district, 707-648-4600</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.gvrd.org">http://www.gvrd.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525482436746-248-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen Cove Waterfront Park at a very low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525482436747-248-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen cove beach at 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1525482637984-248-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen Cove, stairs to beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526359077698-248-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen cove Park 4&#x27; Tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526359077699-248-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Glen cove Park, .5&#x27; Tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="249" title="Santa Cruz harbor kayak launch, F" zone="535" modtime="1526612382856" modby="bask0099" chart_title="Kayak Launch F" >
  <marker lat="36.967591" lng="-122.003554"/>
  <tide_station>362</tide_station>
  <city>Santa_Cruz</city>
  <details><![CDATA[
      <p><b>Overview: </b>There are two kayak launches on the west side of Santa Cruz Harbor. This is for the northern one and it has a small platform which will accommodate one boat at a time. Parking is nearby. From here explore the harbor or go out to explore the coast.</p>
      <p><b>Parking: </b>The parking lot is about 30-40 yds from the launch. There is no loading area. The fee is &#x24;12.50 for an auto with up to 2 kayaks and &#x24;6 for each additional kayak. There is an iron ranger that takes cash or credit cards. there are no time restrictions but overnight parking is not allowed</p>
      <p><b>Facilities: </b>There are bathrooms about 550 ft from the dock and about 100 ft from the parking lot. they are ADA and clean and well maintained but do not appear to be open around the clock.</p>
      <p><b>Contact Info: </b>Santa Cruz harbor,</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.santacruzharbor.org/">http://www.santacruzharbor.org/</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526612101848-249-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz, Dock F</span>
  ]]></details>
</station>
<station station_type="meeting" xid="250" title="Mission High Parking Lot" zone="530" modtime="1527361795664" modby="petolino" edits_since="1526078441314" >
  <marker lat="37.762635" lng="-122.426341"/>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>By special arrangement during the school year, we can park in the Mission High School lot on the west side of Dolores Street between 17th and 18th Streets. The parking driveway takes you up a ramp to an elevated parking slab behind a chain link fence. It is a two block walk to the Women&#x27;s Building. We suggest you put something that says BASK on your dashboard. The lot will be locked at 10 PM so make sure you are out well before then.</p>
      <p><b>Parking: </b>Free. <b><i>Open only on nights when school is in session - closed on school holidays and during summer break.</i></b> Check the BASK home page before arriving. Gates are open until 10 PM.</p>
  ]]></details>
</station>
<station station_type="meeting" xid="251" title="16th St. Mission BART Station" zone="530" modtime="1526079679139" modby="petolino" >
  <marker lat="37.764925" lng="-122.419904"/>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Convenient public transportation to BASK General Meetings.  The Women&#x27;s Building is about four blocks to the southwest &#x28;see marker on map&#x29;.</p>
      <p><b>Links: </b><a target="tp_details" href="http://m.bart.gov/schedules/bystation">BART Schedules</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="253" title="Jim Hench Memorial Kayak Launch" zone="530" modtime="1615937922537" modby="petolino" edits_since="1615915797874" chart_title="Jim Hench Launch" >
  <marker lat="38.299726" lng="-122.284055"/>
  <tide_station>131</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>This wide concrete launch for kayaks and canoes is under the 1st St bridge. The ramp itself is often clogged with debris. From here you can go up river to Trancas Park &#x28;3 miles&#x29; or downriver to Cuttings Wharf &#x28;6 miles&#x29;</p>
      <p><b>Parking: </b>There is free parking for 1 car only on Soscol Ave. There is also parking for one car to unload. It is about 100&#x27; down a gently sloping concrete path to the ramp.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Address: </b>Corner of 1st St and Soscol Ave. in downtown Napa</p>
      <p><b>Contact Info: </b>City of Napa Parks and Rec. 707-257-9234</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.cityofnapa.org/Facilities/Facility/Details/Jim-Hench-Memorial-Kayak-Launch-25">https://www.cityofnapa.org/Facilities/Facility/Details/Jim-Hench-Memorial-Kayak-Launch-25</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526326762142-253-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jim Hench ramp, 3-28-18, 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526326762143-253-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Jum Hench ramp, Napa, 2015</span>
  ]]></details>
</station>
<station station_type="launch" xid="254" title="Santa Cruz Harbor Kayak Launch A" zone="535" modtime="1535992816692" modby="bask0099" edits_since="1526614071914" chart_title="Kayak Launch A" >
  <marker lat="36.964801" lng="-122.00333"/>
  <tide_station>362</tide_station>
  <city>Santa_Cruz</city>
  <details><![CDATA[
      <p><b>Overview: </b>The dock is a lego type dock designed for kayaks. Kayak storage is located at the top of the gangway. From here explore the harbor or head out to the coast.</p>
      <p><b>Parking: </b>Plenty of parking but quite a ways from the dock along a walkway often congested with tourists. Fees are &#x24;12.50 for an auto with up to 2 kayaks and &#x24;6 for each additional kayak &#x28;how would they know&#x3F;&#x3F;&#x29;. There is an iron ranger that takes cash or credit cards. No overnight parking allowed. Otherwise there are no time restrictions.</p>
      <p><b>Facilities: </b>Bathrooms are located about 550 ft from the dock &#x28;100 ft from parking lot&#x29;. They are clean and well maintained. Aldo&#x27;s restaurant is right next door. Kayak storage is also available here, call the harbor office for more details, 831-475-6161. There is a 1 1/2 year wait for a slot and the fee is &#x24;60/month.</p>
      <p><b>Address: </b>Off Edgewater Dr.</p>
      <p><b>Contact Info: </b>Harbor office, 831-475-6161</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526614071914-254-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz harbor, 2007</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526614071915-254-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526614071916-254-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz Map</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526614071917-254-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Santa Cruz Dock A</span>
  ]]></details>
</station>
<station station_type="launch" xid="255" title="Westpoint Marina, Redwood City" zone="531" modtime="1539724882840" modby="bask0099" edits_since="1539568684544" chart_title="Westpoint Marina" >
  <marker lat="37.511719" lng="-122.195091"/>
  <tide_station>322</tide_station>
  <city>Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>This new private marina has both a concrete launch ramp and a &#x22;kayak launch&#x22;. The owner does not want non-motorized boats using the concrete ramp so use the kayak launch. 101 Surf Sports is the outfitter located here and they have space to launch too. From here explore Bair Island, Redwood City or Westpoint Slough and Bedwell Park.</p>
      <p><b>Parking: </b>There is plenty of parking. Hours are 9AM-6PM. No overnight parking allowed.</p>
      <p><b>Facilities: </b>Bathrooms are about 80 yds from the launch. They are clean and well maintained. 101 Surf Sports is located here &#x28;open Wed-Sun, 10AM-3PM&#x29;. Kayak storage is available at 101 Surf Sports for &#x24;60/mo.</p>
      <p><b>Address: </b>1529 Seaport Blvd. Redwood City</p>
      <p><b>Contact Info: </b>Mark Sanders, owner, 650-224-3250 or 650-701-0545<br>101 Surf Sports, 650-618-6282</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526658128654-255-bask0099.jpg" height="225" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Marina contact info</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526658128655-255-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Marina Kayak Launch Low Tide 1</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526658128656-255-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Marina Kayak Launch Low Tide 2</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1539568684544-255-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Marina Ramp Low Tide 2</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1539724882840-255-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Westpoint Marina Ramp High Tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="258" title="San Francisco Marina - West End" zone="530" modtime="1529607637180" modby="bask0099" edits_since="1526935591646" chart_title="SF Marina West End" >
  <marker lat="37.806458" lng="-122.447484"/>
  <current_station>133</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>This unknown launch spot has a set of stone steps that lead down to a beach at lower tides. At higher tides the water comes right up to the steps. There is space to unload right next to the steps. This is the furthest back spot in the marina and it is very protected. You do still need to face the wind, currents, boat traffic etc once you exit the marina.</p>
      <p><b>Parking: </b>There is a large, free parking lot that is supposed to be for the Palace of Fine Arts very close to the launch. There is also free parking along Yacht Club Dr. There are no posted time restrictions but no overnight parking is allowed. Possibly crowded during events at the Palace but mostly it&#x27;s pretty empty.</p>
      <p><b>Facilities: </b>Public Restrooms just to the west across the lawn &#x28;about 50 yds&#x29;. It is open 8AM-8PM in summer and 8AM-5:30PM in winter. Bathrooms are ADA and there is a drinking fountain outside. The Dynamo Donut and Coffee is located right next to the water &#x28;open Fri-Sun, 8AM-4PM&#x29;. No other amenities. There is grass for picnics or to just sit around.</p>
      <p><b>Address: </b>Yacht Club Drive off of Marina Blvd. Next to the St Francis YC.</p>
      <p><b>Contact Info: </b>Dynamo donut, 415-920-1978<br>Harbormaster, 415-831-6322<br>City of SF, Parks and Rec, 415-554-4000<br></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526779139954-258-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>SF Marina at west end, 3-2018, hi tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529607637180-258-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Stone steps at -1.5&#x27; tide, 6-16-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529607637181-258-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>West marina, -1.5&#x27; tide, 6-16-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="259" title="Baker Beach" zone="530" modtime="1633905809034" modby="bask0099" edits_since="1526781332859" >
  <marker lat="37.791946" lng="-122.483926"/>
  <current_station>133</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>This site has a sand beach that is usable at all tides. There are several paths from the parking lot to the beach. The surf dumps here and the size depends on the a variety of factors. The beach faces northwest, which is where the swell and the wind usually comes from. You will find tourists and happy dogs running on the beach. This is a somewhat advanced launch &#x28;ya need surf skills&#x29; as well as destination.</p>
      <p><b>Parking: </b>The lot is large and free. It closes one hour after sunset. No overnight parking is allowed. It is about 15-20 yds from the parking lot to the beach. There is space for unloading beside the paths that go to the beach.</p>
      <p><b>Facilities: </b>There are bathrooms at the rear of the parking lot that are clean and maintained. There is a picnic area with tables and with BBQs that is currently &#x28;4/2018&#x29; being renovated. There is running water available.</p>
      <p><b>Address: </b>Outside the Gate. Take Gibson Rd from Lincoln Blvd and go to &#x22;Day Use Area&#x22;</p>
      <p><b>Contact Info: </b>GGNRA, 415-561-4323 or 415-331-1540 &#x28;Visitor Center at the Headlands in Marin&#x29;</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526781332859-259-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Baker Beach 0 tide, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526781332860-259-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Baker Beach dumping surf, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526781332861-259-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Baker beach surf at 0 tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633905809034-259-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Baker Beach at high tide, 10/21</span>
  ]]></details>
</station>
<station station_type="launch" xid="260" title="Benicia State Recreation Area" zone="530" modtime="1527565758754" modby="bask0099" edits_since="1526617434770" chart_title="Benicia Recreation" >
  <marker lat="38.068692" lng="-122.184206"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>This site provides access onto Carquinez Strait. The best launch used to be the remains of an asphalt ramp that went through the tule reeds to the water. The remains are still there but better are several informal paths to the water that don&#x27;t require dragging over tule reeds. The distance you must carry your boat is about 20 yds and it is flat. There is room for rigging in the parking lot. You will find the shoreline muddy at low tide. This site is very protected from wind, however, once you leave the usual conditions of brisk summer winds &#x28;from the west&#x29; and currents due to the river apply.</p>
      <p><b>Parking: </b>There is a good sized parking lot with about 30 spaces. There is a &#x24;6 day use fee payable at and iron ranger. the lot is gated and open from 8AM to sunset.</p>
      <p><b>Facilities: </b>The location is on the Bay Trail and is well used by hikers, bikers and dog walkers. There are 2 porta potties. From here paddle east to Benicia or across the river to Port Costa or West to Vallejo.</p>
      <p><b>Address: </b>1 State Park Rd. At the west end of town. Exit Military West from Hwy 780. It is an immediate right onto West K St and another immediate right into the parking lot.</p>
      <p><b>Contact Info: </b>City of Benicia Parks and Community Services, 707-746-4285 or try, 707-648-1911 for a ranger.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=476">http://www.parks.ca.gov/&#x3F;page_id&#x3D;476</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527565758754-177-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia State Rec Area, east end, 4-12-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527565758755-177-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia State Rec Area, middle, 4-12-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527565758756-177-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia State rec Area, west launch 1, 4-12-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="264" title="China Beach, San Francisco" zone="530" modtime="1633905974545" modby="bask0099" edits_since="1526935820683" chart_title="China Beach" >
  <marker lat="37.787877" lng="-122.49165"/>
  <current_station>133</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>&#x22;Destination&#x22; because of the difficult access. There are over 100 stair steps to the beach. Young studly surfers do it all the time. There is also a long, employees only driveway that goes down the hill to a decrepit rusting building that houses the surf rescue guys&#x27; stuff. If you wind up swimming to the Farallones they will come and get you. The beach is sand and usable at all tides. The beach faces NW which is where the wind and swell usually come from.</p>
      <p><b>Parking: </b>If you drive, there is free parking for 38 cars. Overnight prohibition is not posted so who knows. This is a residential neighborhood. The park closes at sunset.</p>
      <p><b>Facilities: </b>There are three barely-maintained porta potties about 30 yds up the driveway from the beach. There is a picnic area with BBQ. No running water.</p>
      <p><b>Address: </b>End of Seacliff Dr. in San Francisco</p>
      <p><b>Contact Info: </b>GGNRA, 41-561-4323<br>Headlands Visitor Center 4150331-1540</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526917571309-264-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>China Beach 0 tide, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526917571310-264-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>China Beach west view, 0 tide, 3-24-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526923936323-264-petolino.jpg" height="266" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>China Beach from the water</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633905974545-264-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>China Beach at high tide, 10/21</span>
  ]]></details>
</station>
<station station_type="launch" xid="265" title="Greyhound Rock County Park" zone="560" modtime="1526941384970" modby="petolino" edits_since="1526936579910" chart_title="Greyhound Rock Park" >
  <marker lat="37.079975" lng="-122.265437"/>
  <tide_station>12</tide_station>
  <city>Davenport</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sand beach. The path from the parking lot is about 300 yds down a steep path to the beach. It is paved most of the way with a small set of washed out steps at the end. There is spring seepage in a couple places that make it slippery. This is a well protected cove to launch once you make it to the beach. Launch on the south side of Greyhound Rock. The north side is rocky and covers a shallow reef.</p>
      <p><b>Parking: </b>50+ spaces in a large parking lot. It is .12 miles to the beach. Parking is free from sunrise to sunset with no overnight parking allowed.</p>
      <p><b>Facilities: </b>There are pit toilets at the parking area which are sometimes dirty and unkept. There is a picnic area but no other amenities.</p>
      <p><b>Address: </b>3564 Highway 1, 1.2 miles south of Waddell Creek State Beach</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.scparks.com/Home/Parks/BeachesandCoastalAccess/CoastalAccess.aspx">Coastal Access, Santa Cruz County Parks</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.californiabeaches.com/beach/greyhound-rock-coastal-access">http://www.californiabeaches.com/beach/greyhound-rock-coastal-access</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526936579910-265-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Greyhound Rock - top of path to beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526936579911-265-bask0099.jpg" height="225" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Greyhound Rock at 1 ft tide north</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526936579912-265-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Greyhound Rock beach view</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526936579913-265-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Greyhound Rock at 1 ft tide south</span>
  ]]></details>
</station>
<station station_type="launch" xid="266" title="Waddell Creek State Beach" zone="560" chart_title="Waddell Creek Beach" modtime="1670648399359" modby="petolino" edits_since="1526941523705" >
  <marker lat="37.096756" lng="-122.280334"/>
  <tide_station>12</tide_station>
  <city>Davenport</city>
  <details><![CDATA[
      <p><b>Overview: </b>Waddell Beach is part of Big Basin Redwood State Park and is supposed to be a world class windsurfing and kiteboarding spot. Hmm, northwest wind blows all the time they say.</p>
      <p><b>Parking: </b>Over 30 spaces in a large lot. There is no loading area but it is free. The lot is open 8AM to sunset with no overnight parking allowed. It&#x27;s about a 200 ft carry to the beach.</p>
      <p><b>Facilities: </b>There are pit toilets in the parking lot &#x28;about 200 ft from the beach&#x29;. Maintenance is so-so. There are no other amenities.</p>
      <p><b>Address: </b>3640 Highway 1</p>
      <p><b>Contact Info: </b>Big Basin State Park, 831-427-2288</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=863">Rancho Del Oso, Big Basin State Park</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Waddell-Creek-Surf-Report/3742/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526937529960-266-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Waddell Beach 1 ft tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="267" title="Mono Lake, Navy Beach" modtime="1526969367263" modby="petolino" edits_since="1526951394962" chart_title="Mono Lake" >
  <marker lat="37.940828" lng="-119.019967"/>
  <city>Lee_Vining</city>
  <details><![CDATA[
      <p><b>Overview: </b>Gravel beach. You must stay one mile away from Paoha Island and Negrit Island from April 1 to August &#x21; due to nesting season. Osprey nest on the tufa towers along the shoreline. You must stay 250 yds away from active nests &#x28;usually April 1-September&#x29;. If you have not paddled on Mono Lake, GO&#x21; It is weird and spectacular. It is an alkaline lake so your kayak, gear and you will be coated with mineral deposits. Afternoon winds coming off the Sierra Nevada can ve significant during summer and fall. thunderstorms are also common in the late summer. Check with the Visitor Center for current conditions. DO visit the Visitor Center. They know all kinds of stuff about the flora, fauna, geology, hiking conditions, and are generally informative and cool.</p>
      <p><b>Parking: </b>There is parking for about 12 cars in the parking lot which is about 250 ft from the beach depending on the lake level. It is free and overnight parking is allowed.</p>
      <p><b>Facilities: </b>Zero. There is camping along Hwy 120 between Lee Vining and Tioga Pass. There is a kayak outfitter, Caldera Kayaks.</p>
      <p><b>Address: </b>Navy Beach is located at the end of Navy Beach Rd. You will have a map won&#x27;t you&#x3F;</p>
      <p><b>Contact Info: </b>Visitor Center, 760-647-3044<br>Mono Lake Committee, 760-647-6595<br>Caldera Kayaks, 760-934-1691</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.fs.usda.gov/recarea/inyo/recarea/?recid=20620">http://www.fs.usda.gov/recarea/inyo/recarea/&#x3F;recid&#x3D;20620</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.monolake.org/">http://www.monolake.org</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.calderakayak.com/">http://www.calderakayak.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1526951394962-267-bask0099.jpg" height="225" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mono - Navy Beach</span>
  ]]></details>
</station>
<station station_type="launch" xid="268" title="Benicia/Martinez Bridge" zone="530" modtime="1527011320972" modby="bask0099" edits_since="0" >
  <marker lat="38.047384" lng="-122.12818"/>
  <current_station>65</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is the best spot to launch to explore around what&#x27;s left of the ghostly Mothball Fleet which is anchored only a mile away. Plan to launch near the end of the flood and return on the ebb. The Navy warns that for your own safety you must stay at least 100 feet away from the ships. Try to go when they are off duty. The launch is a micro beach that is immediately adjacent to the bridge tower. To get there you must carry your boat across the road &#x28;speeding trucks&#x29;, the railroad tracks &#x28;slow moving but very long trains&#x29; and down rip rap boulders &#x28;possible broken legs&#x29;. It&#x27;s not as bad as it sounds. Currents at both flood and ebb tides are significant.</p>
      <p><b>Parking: </b>Parking is free in a small lot that fisherpeople use on the opposite side of the road from the water. It is supposed to be limited to 4 hours and no overnight parking is allowed.</p>
      <p><b>Facilities: </b>There is a porta potty in the parking lot. Otherwise, nada.</p>
      <p><b>Address: </b>Under the bridge on Bayshore Rd. near the corner of Oak Rd.</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527011320972-268-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia Martinez bridge, .5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527011320973-268-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia Martinez bridge, 4&#x27; tide, May 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527011320974-268-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia Martinez bridge, parking</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527011320975-268-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Benicia Martinez Bridge sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="269" title="Paoha Island in Mono Lake" modtime="1527012808494" modby="bask0099" edits_since="0" chart_title="Paoha Island" >
  <marker lat="38.003076" lng="-119.037133"/>
  <city>Lee_Vining</city>
  <details><![CDATA[
      <p><b>Overview: </b>This island offers great views of the surrounding lake &#x28;i.e. caldera&#x29; and mountains. There are volcanic steam vents &#x28;to be avoided but admired&#x29;. The beaches &#x28;south and east&#x29; are gravel. You must stay one mile away from the island during bird nesting season &#x28;April 1- August 1&#x29;. In hiking around the island you may discover the remains of an old spa resort. Camping is allowed here. Launch from Navy Beach.</p>
      <p><b>Parking: </b>Park at Navy Beach.</p>
      <p><b>Facilities: </b>None.</p>
      <p><b>Contact Info: </b>Visitor Center, 760-647-3044<br>Mono Lake Committee, 760-647-6595<br>Caldera Kayaks, 760-934-1691</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.fs.usda.gov/recarea/inyo/recarea/?recid=20620">http://www.fs.usda.gov/recarea/inyo/recarea/&#x3F;recid&#x3D;20620</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.monolake.org">http://www.monolake.org</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.calderakayak.com">http://www.calderakayak.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527012808494-269-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mono - Paoha Island South Side</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527012808495-269-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mono - Paoha Is volcanic steam</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527012808496-269-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mono - Navy Beach, parking and launch</span>
  ]]></details>
</station>
<station station_type="destination" xid="270" title="River Heritage Center, Petaluma" modtime="1527034940015" modby="petolino" edits_since="1527017424088" chart_title="River Heritage" >
  <marker lat="38.233803" lng="-122.632755"/>
  <tide_station>429</tide_station>
  <city>Petaluma</city>
  <details><![CDATA[
      <p><b>Overview: </b>The River Heritage Center has a funky and wobbly set of docks behind the barn with five stair steps that go down to them. The site is operated by the Friends of the Petaluma River. The Heritage Center access is supposed to be open dawn to dusk and the road in is gated but it doesn&#x27;t appear that the gate has been closed anytime recently. They hold river focused events periodically and give boat rides to the public on Sundays, 10AM-1PM. This is a better Destination than Launch. Come on Sunday and see the exhibits in the barn.</p>
      <p><b>Parking: </b>Parking is free but limited to about 12 cars. It is a LONG walk to the barn and the dock.</p>
      <p><b>Facilities: </b>There are 2 porta potties that are not well maintained.</p>
      <p><b>Address: </b>Access is via Steamer Landing Park at 100 East D St.</p>
      <p><b>Contact Info: </b>Friends of the Petaluma River, 707-763-7756</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.friendsofthepetalumariver.org/">http://www.friendsofthepetalumariver.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527017371282-270-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Yearsley heritage center dock and stairs, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527017371283-270-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Yearsley Heritage center dock, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527017371284-270-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>River Heritage center&#x27;s dock at low tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="271" title="Sandy Beach Park, Rio Vista" zone="530" modtime="1528233516870" modby="bask0099" edits_since="1527035087309" chart_title="Sandy Beach Park" >
  <marker lat="38.139777" lng="-121.694913"/>
  <current_station>360</current_station>
  <city>Rio_Vista</city>
  <details><![CDATA[
      <p><b>Overview: </b>This fully developed park has two launch ramps and a white sand beach. There is space for loading and unloading. The beach is down a gentle slope from the parking area and day use picnic area. The ramp is open 24 hour/day. Be aware that it is windy on summer afternoons &#x28;wind blows upriver&#x29; and there is current.</p>
      <p><b>Parking: </b>Lots of it and close to the ramp. &#x24;6/day use and parking. Overnight parking is available, check with the harbormaster.</p>
      <p><b>Facilities: </b>Camping, restrooms near the ramp, picnic area and BBQs. In the camping area three cars are allowed per site with a max of 10 people. There is a campground host. Overflow parking is no problem. This park also has a secure storage facility for boats. It costs &#x24;45/mo for trailered boats. The picnic area &#x28;day use&#x29; is open 8AM-6PM daily.</p>
      <p><b>Address: </b>2333 Beach Dr in Rio Vista</p>
      <p><b>Contact Info: </b>Park office, 707-374-2097</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.solanocounty.com/depts/rm/countypark/sandybeach.asp">http://www.solanocounty.com/depts/rm/countypark/sandybeach.asp</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527020471120-271-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sandy Beach launch ramp 4-29-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528233516870-271-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sandy Beach Park beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528233516871-271-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sandy Beach path from beach</span>
  ]]></details>
</station>
<station station_type="launch" xid="272" title="Rio Vista Municipal Boat Launch" zone="530" modtime="1609778437727" modby="bask0099" edits_since="1527055143417" chart_title="Rio Vista Launch" >
  <marker lat="38.154568" lng="-121.690053"/>
  <current_station>360</current_station>
  <city>Rio_Vista</city>
  <details><![CDATA[
      <p><b>Overview: </b>The ramp is closed during its renovation and is scheduled to reopen early in 2021. There is a double ramp with a &#x24;10 launch fee that is paid at an iron ranger. It takes cash or credit cards. By parking on the street or in the Park &#x26; Ride lot one could probably avoid the launch fee. Keep in mind that there are brisk up-river winds in summer. From here you can paddle to Brannan Island State Park or take a short jaunt to Sandy Beach Park</p>
      <p><b>Parking: </b>Lots of parking close to the launch ramp. Six spaces for non-trailered vehicles but there is plenty of additional parking in the adjacent Park &#x26; Ride lot.</p>
      <p><b>Facilities: </b>There are bathrooms &#x28;maintenance is so-so&#x29;, drinking fountain, and benches along the river. This site is only about a block from the main street of town and eating opportunities.</p>
      <p><b>Address: </b>Foot of Montezuma St or Front Street behind City Hall</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.riovistacity.com/boat-launchpicnic-area">http://www.riovistacity.com/boat-launchpicnic-area</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527046073496-272-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rio Vista public ramp and parking lot, 4-29-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527046073497-272-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rio Vista, public ramp, 4-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="273" title="Lake Solano County Park and Campground" modtime="1527047869497" modby="bask0099" edits_since="0" chart_title="Lake Solano Park" >
  <marker lat="38.492974" lng="-122.028509"/>
  <city>Winters</city>
  <details><![CDATA[
      <p><b>Overview: </b>Lake Solano is part of Putah Creek. This lake is for non-motorized boats only. It has a concrete launch ramp with a mud beach beside it. There is a rigging area near the ramp &#x28;which has a high float dock&#x29;. This is lake paddling. One side arm has a fabulous fig tree where you can pick ripe figs from your boat. There is no fee to launch, just for parking. It is possible to rent boats and you can borrow a waterproof Canoe Guide that points out interesting sights.</p>
      <p><b>Parking: </b>There are two lots, one is upper and one is lower. The parking fee is &#x24;6/day. No overnight parking is allowed at the lake.</p>
      <p><b>Facilities: </b>There are bathrooms, somewhat maintained, drinking fountain, picnic area and BBQ. There is also a hose for washing boats. Campground is right across the street and charges &#x24;25/day &#x28;&#x24;13/day for seniors&#x29;.</p>
      <p><b>Address: </b>8685 Pleasant Valley Rd, Winters</p>
      <p><b>Contact Info: </b>Lake Solano County Park, 530-795-2990</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.co.solano.ca.us/depts/rm/countypark/lakesolano.asp">http://www.co.solano.ca.us/depts/rm/countypark/lakesolano.asp</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527047869497-273-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lake Solano launch, 3-5-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="274" title="Brannan Island State Recreation Area" zone="530" modtime="1527055474798" modby="petolino" edits_since="1527055434271" chart_title="Brannan Island Recreation" >
  <marker lat="38.115386" lng="-121.688712"/>
  <current_station>360</current_station>
  <city>Rio_Vista</city>
  <details><![CDATA[
      <p><b>Overview: </b>This park has a ten-lane ramp &#x28;yes, 10 lanes&#x21;&#x29;. This is a busy place in summer. There is a bike-in/kayak-in campsite near the launch ramps. Although it is windy in summer the launch faces south onto Threemile Slough and is somewhat protected from wind. It is 8.4 miles to Sugar Barge Marina on Bethel Island, 8.7 miles to Big Break, 8.9 miles to Sherman Island and 5 miles to the ramp in Rio Vista. There is a fee to enter. Day use is sunrise to sunset. The published fee schedules are quite extensive and complex depending on what you want. Call to find out. Although it is a state park it is managed by American Land and Leisure.</p>
      <p><b>Parking: </b>Plenty near the boat launch as well as at the campsites.</p>
      <p><b>Facilities: </b>Brannan Island Recreation Area is a fully developed park and campground. Besides camping it has day use areas with picnic facilities etc etc. Bathrooms with showers are located near the ramps as is the Campground Host. You can also rent a little cabin here.</p>
      <p><b>Address: </b>17645 highway 160, Rio Vista</p>
      <p><b>Contact Info: </b>Park office, 916-777-6671</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.americanll.com/brannan-island-sra">http://www.americanll.com/brannan-island-sra</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.parks.ca.gov/?page_id=487">http://www.parks.ca.gov/&#x3F;page_id&#x3D;487</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527050428808-274-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Delta launches, Brannan Isl.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527050428809-274-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Delta launches, sherman and Brannan Isl.</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527050428810-274-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Delta launches, Brannan Isl.</span>
  ]]></details>
</station>
<station station_type="launch" xid="275" title="Whitehouse Pool Park" zone="540" modtime="1529332005792" modby="bask0099" edits_since="1527121836016" >
  <marker lat="38.062864" lng="-122.816921"/>
  <tide_station>179</tide_station>
  <city>Point_Reyes_Station</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch from the mud bank. Best at high tide but OK at low tide too. An informal path leads to the water. From here paddle north to the Giacomini wetlands &#x28;bring binoculars&#x29; or up the creek as far as the tide will take you. This location is quite protected from the usual north wind.</p>
      <p><b>Parking: </b>Dirt lot for about 50 cars about 20-30 yds from the put-in. Parking is free and open 4AM-9PM with no overnight parking allowed.</p>
      <p><b>Facilities: </b>Porta potty and a picnic table.</p>
      <p><b>Address: </b>On Sir Francis Drake Blvd at the south end of Tomales Bay</p>
      <p><b>Contact Info: </b>Marin County Parks, 415-473-6387</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.marincounty.org/depts/pk/divisions/parks/whitehouse-pool">http://www.marincounty.org/depts/pk/divisions/parks/whitehouse-pool</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090182194-275-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Whitehouse pool sign, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090182195-275-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Whitehouse pool at 0 tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529332005792-275-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Whitehouse Pool at 4.7&#x27; tide, 6-17-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="276" title="Keys Creek Fishing Access" zone="540" modtime="1529331628619" modby="bask0099" edits_since="1527090899602" chart_title="Keys Creek Access" >
  <marker lat="38.226183" lng="-122.916469"/>
  <tide_station>40</tide_station>
  <city>Tomales</city>
  <details><![CDATA[
      <p><b>Overview: </b>The launch is over a mud bank/beach. The mud is firm. There are several informal paths through the trees to the creek. Once upon a time this creek went all the way to Tomales village. Not so now but you can go up Walker Creek. On high tide, see how far you can get. It&#x27;s pretty. Or you can paddle to &#x28;or from&#x29; Nick&#x27;s Cove in Tomales Bay.</p>
      <p><b>Parking: </b>There are 12-15 spots in a dirt lot. The lot floods when it rains. It is free. The posted time is sunrise to sunset with no overnight parking allowed.</p>
      <p><b>Facilities: </b>Porta potty which is clean and maintained. Picnic area.</p>
      <p><b>Address: </b>Off Shoreline Hwy &#x28;Hwy 1&#x29; between Tomales village and Tomales Bay</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090899602-276-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Keys Creek beach at low tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090899603-276-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Keys Creek launch at low tide, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090899604-276-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Keys Creek Fishing Access, sign</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527090899605-276-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Keys Creek sign, 3-23-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1529331628619-276-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Keyes Creek fishing access, 4&#x27;tide, 6-17-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="277" title="Rodeo Beach, Marin Headlands" zone="545" chart_title="Marin Headlands" modtime="1670615888152" modby="petolino" edits_since="1527479344327" >
  <marker lat="37.832085" lng="-122.539332"/>
  <current_station>270</current_station>
  <city>Mill_Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>The sand beach is usable at all tides. There are 4 access point to the beach--2 sets of stairs, one dirt ramp and one bridge over the lagoon. At the far south end of the beach &#x28;not accessible by car&#x29; the surf is much lower and it is a nice place to stop for lunch. If you paddle from here into the Bay you will enjoy tunnels and arches &#x28;wear your helmet&#x29;. This is a surfing beach. You need surf skills. It is a very popular place with board surfers. Know and practice surf etiquette.</p>
      <p><b>Parking: </b>There is a large parking lot that is often full on weekends. There are rigging areas by each of the access points. Parking is free with no time restrictions. Nothing is posted about overnight parking.</p>
      <p><b>Facilities: </b>Bathrooms with outdoor showers are located in the parking lot. There is a drinking fountain and a picnic area with BBQ.</p>
      <p><b>Address: </b>From Alexander Rd. take Bunker Rd to the Headlands. Veer left onto Mitchell Rd and go to the end.</p>
      <p><b>Contact Info: </b>GGNRA, 415-561-4323<br>Headlands Visitor Center, 415-331-1540</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Marin-County-Surf-Report/307/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527092508886-277-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rodeo Beach, 4-4-18, zero tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527092508887-277-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rodeo Beach, 3-3-2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527092508888-277-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rodeo Beach dirt path, 3-3-2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527092508889-277-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rodeo Beach stairs, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527479344327-277-bask0099.jpg" height="269" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Time to go home...</span>
  ]]></details>
</station>
<station station_type="destination" xid="278" title="Dipsea Cafe, Mill Valley" zone="530" modtime="1527201951490" modby="petolino" edits_since="1527184152458" chart_title="Dipsea Cafe" >
  <marker lat="37.879792" lng="-122.523314"/>
  <tide_station>367</tide_station>
  <city>Mill_Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide eating opportunity. Come here from Richardson Bay. Get out under the bridge. Stop to eat, and leave before the tide drops. If time and tide allow, head up the creek to explore. There is also the possibility of launching from the creek bank in the Dipsea parking lot. Did I say--High Tide Only&#x21; The Dipsea is open 7AM-3PM.</p>
      <p><b>Parking: </b>Park wherever you put in.</p>
      <p><b>Facilities: </b>Dipsea is one of Marin&#x27;s legendary cafes. They have bathrooms and good basic food.</p>
      <p><b>Address: </b>200 Shoreline Hwy, Mill Valley</p>
      <p><b>Contact Info: </b>Dipsea Cafe, 415-381-0298</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527184152458-278-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Dipsea Cafe, low tide, 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527184152459-278-bask0099.jpg" height="535" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Dipsea Cafe at high tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527184152460-278-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Under the bridge at low tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="279" title="Blackies Pasture, Tiburon" zone="530" modtime="1527185374258" modby="bask0099" edits_since="1527185337530" chart_title="Blackies Pasture" >
  <marker lat="37.895198" lng="-122.49023"/>
  <tide_station>367</tide_station>
  <city>Belvedere_Tiburon</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide launch into Richardson Bay. The beach is sand at high tide and sucking mud at low tide. From here you can go to Sausalito to tour the houseboats or to upper Richardson Bay. The real attraction are the birds so bring binoculars. This section of Bay is closed from October to March to protect migrating birds from the likes of us.</p>
      <p><b>Parking: </b>Parking is free and the lot is large. The park is popular with dog walkers, hikers and bikers and, therefore, busy. There are no time restrictions posted.</p>
      <p><b>Facilities: </b>Bathrooms and drinking fountains are about 100 yds away.</p>
      <p><b>Address: </b>Tiburon Blvd between Reed Ranch Rd and Trestle Glen Blvd</p>
      <p><b>Contact Info: </b>City of Tiburon, 415-435-3373<br>Tiburon Peninsula Foundation, 415-499-6387</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.tiburonpeninsulafoundation.org/">http://www.tiburonpeninsulafoundation.org</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527185337530-279-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Blackies Pasture beach, hi tide, Mar 2018</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527185337531-279-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Blackies Pasture, low tide, Tiburon</span>
  ]]></details>
</station>
<station station_type="destination" xid="280" title="3rd Street Bridge Beach, Napa" zone="530" modtime="1527194709628" modby="bask0099" edits_since="0" chart_title="3rd St Bridge Beach" >
  <marker lat="38.298406" lng="-122.283382"/>
  <tide_station>231</tide_station>
  <city>Napa</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a nice sand beach at all tides where you can stop for lunch or to rest. The building up behind is undergoing a major reconstruction so there is no access from the road or the bridge at present &#x28;2018&#x29;.</p>
      <p><b>Parking: </b>None</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Address: </b>3rd Street bridge, northeast side, downtown Napa</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527194709628-280-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>3rd St. Napa, 7&#x27; tide, 3-28-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="281" title="Strawberry Cove Park, Strawberry" zone="530" modtime="1527221519047" modby="petolino" edits_since="1527221019249" chart_title="Strawberry Cove Park" >
  <marker lat="37.888713" lng="-122.512806"/>
  <tide_station>367</tide_station>
  <city>Mill_Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>The spot to launch on high tides is 20-30 yds beyond the workout area. Launch at a high ebbing tide at the mouth of Belloc Lagoon which is sensitive bird habitat. Bring binoculars but resist going in there. Besides it is wicked mud. Although not subject to closure, migrating birds abound from October to March so be respectful. The launch area is pebbles and firm mud which gets softer as the tide recedes. From here explore upper Richardson Bay or head south for a houseboat tour in Sausalito.</p>
      <p><b>Parking: </b>About 20 spots on the street.</p>
      <p><b>Facilities: </b>Drinking fountain, benches, picnic tables and a workout area but no bathrooms.</p>
      <p><b>Address: </b>106 Seminary Dr across the street from the Strawberry Shores Apartments.</p>
      <p><b>Contact Info: </b>Strawberry Recreation Dept., 415-383-6494</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527221019249-281-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Strawberry Cove Park, lagoon entrance, high tide, 3-3-18</span>
  ]]></details>
</station>
<station station_type="launch" xid="282" title="Lexington Reservoir, Los Gatos" modtime="1527280014475" modby="petolino" edits_since="1527264168504" chart_title="Lexington Reservoir" >
  <marker lat="37.199835" lng="-121.98625"/>
  <city>Los_Gatos</city>
  <details><![CDATA[
      <p><b>Overview: </b>This park has a launch ramp for non-motorized boats only. There is a low dock at higher water levels, a dirt ramp that is usable at all water levels and a gravel beach. Fees are: &#x24;6 parking, &#x24;5 launching, &#x24;4 quagga inspection. The park is open from 8AM to sunset.</p>
      <p><b>Parking: </b>There are over 30 spaces about 100 yds from the launch with a loading area. No overnight parking allowed.</p>
      <p><b>Facilities: </b>There is a porta potty about 100 yds from the launch with multiple units that are maintained. There is a picnic area. No camping.</p>
      <p><b>Address: </b>Alma Bridge Rd in Los Gatos. 0.3 miles south of the dam.</p>
      <p><b>Contact Info: </b>Ranger &#x28;c&#x29;, 408-334-3990<br>Parks office, 408-356-2729</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sccgov.org/sites/parks/parkfinder/pages/lexington-reservoir.aspx">http://www.sccgov.org/sites/parks/parkfinder/pages/lexington-reservoir.aspx</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527264168504-282-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lexington Res ramp, 3-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1527264168505-282-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lexington Res. 3-18</span>
  ]]></details>
</station>
<station station_type="destination" xid="283" title="Brooks Island Regional Preserve" zone="530" modtime="1528050016134" modby="bask0099" edits_since="0" chart_title="Brooks Island Preserve" >
  <marker lat="37.898324" lng="-122.357308"/>
  <tide_station>331</tide_station>
  <city>Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>Brooks Island belongs to East Bay Regional Parks and is a very sensitive bird preserve. You can go there only on naturalist guided tours. BASK has done this several times and the visits are worth every bit of the trouble. Especially if you can schedule it in spring when the flowers are blooming.</p>
      <p><b>Parking: </b>Launch from Vincent Park.</p>
      <p><b>Facilities: </b>No food or water so bring your own and be prepared to pack out trash. There is a bathroom by the caretakers residence.</p>
      <p><b>Address: </b>Island is just south of the Richmond Harbor.</p>
      <p><b>Contact Info: </b>To schedule a tour, 1-888-327-2757 option 2</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ebparks.org/register">for scheduled tours</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ebparks.org/parks/brooks_island">Brooks Island</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1528050016134-283-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Brooks Island from the top in spring</span>
  ]]></details>
</station>
<station station_type="launch" xid="284" title="Tower Park Marina" zone="530" modtime="1635116425239" modby="petolino" edits_since="1634070514118" >
  <marker lat="38.109038" lng="-121.499541"/>
  <tide_station>410</tide_station>
  <city>Lodi</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is a friendly marina where you can launch to head down the river or land after launching at New Hope/Wimpy&#x27;s. This is a river so plan on going with the flow. It is flat water and beautiful. One significant risk factor is water hyacinth which can block the entire waterway and may require portaging. Like most places in the Delta, they charge to launch. From here to Sugar Barge on Bethel Island is 15 miles. There is a concrete ramp a well as a sand beach. The dock is high freeboard</p>
      <p><b>Parking: </b>Plenty, available in the marina. It is right at the launch site. there is a place to load and unload. It costs &#x24;5. Overnight parking is OK.</p>
      <p><b>Facilities: </b>Tower Marina has kayak rentals and a little store with food and drinks as well as a restaurant.. They are camping facilities &#x28;or cabins&#x29; if you need them at Yogi Bear&#x27;s Jellystone Park &#x28;845-255-5193&#x29;. There is a regular bathroom next to the launch area.</p>
      <p><b>Address: </b>14900 W. Hwy 12 &#x28;near Lodi&#x29;. On Little Potato Slough.</p>
      <p><b>Contact Info: </b>209-283-1589</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.towerpark-marina.com/">http://www.towerpark-marina.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634070514118-284-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>tower park marina, dock</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634070514119-284-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>tower park marina, beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634070514120-284-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>tower park marina, deck</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634070514121-284-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>ttower perk marina, ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="285" title="New Hope Marina/ Wimpys Marina" zone="530" modtime="1612721505212" modby="bask0099" edits_since="1612199184615" chart_title="New Hope Marina" >
  <marker lat="38.228245" lng="-121.490934"/>
  <tide_station>243</tide_station>
  <city>Walnut_Grove</city>
  <details><![CDATA[
      <p><b>Overview: </b>After launching from the Cosumnes Preserve this is the place to take out. It is 5.5 miles one way and being a river you will run a shuttle. New Hope Marina and Wimpy&#x27;s Marina are right next to each other and both have launch ramps. From here to Tower Park Marina is 11 miles. Wimpys is very kayak friendly. From here destinations include Delta Meadows, and the Mokelumne river both north and south forks. The area is affected by tides so plan accordingly.</p>
      <p><b>Parking: </b>Available for &#x24;5</p>
      <p><b>Facilities: </b>Wimpy&#x27;s has a restaurant with great food. Camping is available if you have an RV. During 2020 they are undergoing some construction. There is a porta potty. Pre-COVID, when the restaurant was open, regular bathrooms were available.</p>
      <p><b>Address: </b>New Hope, 13945 W. Walnut Grove Rd<br>Located 3 miles west of Hwy 5 &#x28;Thornton offramp&#x29;.</p>
      <p><b>Contact Info: </b>New Hope Marina, 209-210-4485</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1612721505212-285-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Wimpys prota potties and loading area</span>
  ]]></details>
</station>
<station station_type="launch" xid="286" title="Sugar Barge Resort" zone="530" modtime="1633406176659" modby="bask0099" edits_since="1606695552641" >
  <marker lat="38.026848" lng="-121.612749"/>
  <tide_station>13</tide_station>
  <city>Bethel_Island</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sugar Barge has a ramp and a restaurant. They charge &#x24;10 to launch a kayak. They also rent kayaks. This is a great place to launch &#x28;and come back to&#x29; in winter to look at birds--sandhill cranes and tundra swans hang out here. It is 9.5 miles from here to Brannan Island State Park. 15 miles from Tower Park at Terminous.</p>
      <p><b>Parking: </b>Available near the ramp.</p>
      <p><b>Facilities: </b>Restaurant opens at 11AM on weekends &#x28;lunch and dinner&#x29;. It&#x27;s a nice place to sit while waiting for the tule fog to lift in winter. During the pandemic they are open for take-out. They have kayaks for rent.</p>
      <p><b>Address: </b>1440 Sugar Barge Rd on Bethel Island</p>
      <p><b>Contact Info: </b>925-684-9075 or 800-799-4100</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sugarbarge.com/">rvsugarbarge@comcast.net</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633406176659-286-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sugar barge ramp</span>
  ]]></details>
</station>
<station station_type="destination" xid="287" title="Treasure Island, Clipper Cove Beach" zone="530" modtime="1605393933614" modby="bask0099" edits_since="1530225999905" chart_title="Clipper Cove Beach" >
  <marker lat="37.813178" lng="-122.369664"/>
  <current_station>432</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Sandy beach. Currently &#x28;11-2020&#x29; the north end is closed for construction. Beach faces east and is protected from wind and rough water.</p>
      <p><b>Facilities: </b>There are stairs that lead up to bathrooms that may or may not be open during the pandemic.</p>
  ]]></details>
</station>
<station station_type="launch" xid="288" title="Oyster Point Marina, Launch Ramp" zone="531" modtime="1530226567366" modby="petolino" edits_since="1530138835198" chart_title="Oyster Pt Marina" >
  <marker lat="37.662551" lng="-122.374966"/>
  <tide_station>270</tide_station>
  <city>South_San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>The ramp is mainly for motorized boat but can also be used by kayakers. 30-40 yds south is another concrete ramp through the rip rap that was designed for windsurfers but is usable by any hand carried boat. It does get windy here. Consider trips heading north as the SF airport is just to the south.</p>
      <p><b>Parking: </b>Free parking. Marina is open from 5:30AM-10:30PM. There is a loading area next to the ramp.</p>
      <p><b>Facilities: </b>The marina has bathrooms and offers kayak storage which is located by the harbormaster&#x27;s office. There is a ferry landing inside the marina so be mindful of arriving and exiting ferries.</p>
      <p><b>Address: </b>95 Harbormaster Rd. South San Francisco</p>
      <p><b>Contact Info: </b>Harbormaster, 415-952-0808 or 650-871-7344. Hours are 9-4PM M-F.<br>San Mateo Co. Harbor District, 650-726-4723<br></p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smharbor.com/oyster-point-marina-park">http://www.smharbor.com/oyster-point-marina-park</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530138835198-288-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Oyster Point boat launch, 7&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530138835199-288-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Oyster Point, Windsurfers launch 0 tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="289" title="San Leandro Marina, informal ramp beside El Torito" zone="531" modtime="1530226730837" modby="petolino" edits_since="1530150815890" chart_title="San Leandro Marina" >
  <marker lat="37.699884" lng="-122.190956"/>
  <tide_station>352</tide_station>
  <city>San_Leandro</city>
  <details><![CDATA[
      <p><b>Overview: </b>This very wide concrete ramp is usable at high tides only. At low tide there is a great deal of mud.</p>
      <p><b>Parking: </b>Free in the parking lot beside El Torito and immediately adjacent to the ramp.</p>
      <p><b>Facilities: </b>El Torito restaurant. You might be able to sneak into El Torito to use the bathroom but don&#x27;t count on it.</p>
      <p><b>Address: </b>To the right off Monarch Bay Dr. as you approach the marina.</p>
      <p><b>Contact Info: </b>Harbormaster, 510-577-3488. The marina office is open 8AM-4PM M-Th and by appt Fri and Sat. Closed Sun.<br>San Leandro Rec Dept. 510-577-3462</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.ci.san-leandro.ca.us/depts/pw/marina/marinafacilities.asp">http://www.ci.san-leandro.ca.us/depts/pw/marina/marinafacilities.asp</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530150815890-289-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>San Leandro ramp next to El Torito, 2&#x27; tide, 6-7-18</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530150815891-289-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>San Leandro Marina ramp zero tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="290" title="Tiscornia Park, American River Parkway" modtime="1615953339493" modby="petolino" edits_since="1615948102055" chart_title="Tiscornia Park" >
  <marker lat="38.598199" lng="-121.506668"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>Tiscornia Park has a long sandy beach and is located at the confluence of the American and Sacramento Rivers. Land here after paddling the Parkway or launch here for trips down the Sacramento River. The take-out will be on river left just below the Hwy 5 bridge. This is also a good landing spot if you are going down the Sacramento River. There is a now-defunct launch ramp. There is a bridge inside the park that goes to Discovery Park.</p>
      <p><b>Parking: </b>There are three separate parking bays for about 40 spaces. The distance from parking to the water is 60-80 yds depending on where you park. The park is open 6AM-8PM. There is an entry fee.</p>
      <p><b>Facilities: </b>Bathrooms, picnic area, BBQ, drinking fountain.</p>
      <p><b>Address: </b>195 Jibboom St. Sacramento</p>
      <p><b>Contact Info: </b>916-808-6060 or 916-808-6068</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.cityofsacramento.org/ParksandRec/Parks/Park-Directory/Central-City/Tiscornia-Park">https://www.cityofsacramento.org/ParksandRec/Parks/Park-Directory/Central-City/Tiscornia-Park</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948102055-290-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Discovery Park and Tiscornia parks, aerial view</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948102056-290-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tiscornia sand beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948102057-290-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tiscornia beach path</span>
  ]]></details>
</station>
<station station_type="launch" xid="291" title="Discovery Park, Sacramento River" modtime="1615953493507" modby="petolino" edits_since="1615948609466" chart_title="Discovery Park" >
  <marker lat="38.600581" lng="-121.509128"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a large concrete launch ramp . This is a good place to either begin or end trips on the Sacramento River. It is also an easy round trip up river to the Virgin Sturgeon, a salty-sea-dog bar on the river. Tie your boat to the dock, go have a drink, and then casually float back to your car. The launch fee is &#x24;8 for a car with a kayak and &#x24;3 for each additional kayak. The launch ramp is in a small side slough just off the Sacramento River.</p>
      <p><b>Parking: </b>Parking is ample. The entry fee is &#x24;5 per car plus &#x24;3 per kayak. The park is open 6AM-8PM.</p>
      <p><b>Facilities: </b>Bathrooms, drinking fountains, picnic tables, BBQ. No camping.</p>
      <p><b>Address: </b>1600 Garden Highway, Sacramento</p>
      <p><b>Contact Info: </b>Sacramento County Regional Parks</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/Parks/Pages/DiscoveryPark.aspx">http://www.regionalparks.saccounty.net/Parks/Pages/DiscoveryPark.aspx</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948609466-291-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Discovery Park ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948609467-291-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Discovery Park bathroom art</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615948609468-291-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Discovery Park sign with prices, March 2021</span>
  ]]></details>
</station>
<station station_type="launch" xid="292" title="Howe River Access, American River Parkway" modtime="1531253383233" modby="petolino" edits_since="1531244840610" chart_title="Howe River Access" >
  <marker lat="38.559819" lng="-121.404589"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is both a concrete launch ramp and a cobble/sand beach. Good take out if running the lower American River. It is 13 miles down from Sunrise and 5.7 miles down from Riverbend. The take-out is on river left above the Howe Ave. bridge. If you go downriver from here you can take out at Paradise Beach &#x28;looong carry&#x29; or Tiscornia Park &#x28;7.8 miles&#x29;.</p>
      <p><b>Parking: </b>There is ample parking. Entry fee is &#x24;5 per car plus &#x24;3 per kayak. If it is hot try to park under the Howe Ave. bridge in the shade.</p>
      <p><b>Facilities: </b>Bathrooms, no water, no camping</p>
      <p><b>Address: </b>7971 La Riviera Dr. Sacramento</p>
      <p><b>Contact Info: </b>Sacramento County Regional Park, 916-875-6961</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/documents/howe_avenue_access_map.pdf">Map</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/pages/HoweAveriverAccess.aspx">Info</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="293" title="Watt Avenue Access, American River Parkway" modtime="1531244966561" modby="petolino" edits_since="1531081738355" chart_title="Watt Ave Access" >
  <marker lat="38.565584" lng="-121.384779"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a concrete boat launch as well as several cobble/sand beaches. Good take-out if running the lower Sacramento. As you approach the Watt Ave. bridge from upriver, plan to take out below the bridge. Stay left of center until you are through the &#x22;rapids&#x22;, then hook to the left to get to the beach. Go a little further to take out at the boat ramp and avoid a carry. It is 10.75 miles downriver from Upper sunrise and 4.3 miles downriver from Riverbend.</p>
      <p><b>Parking: </b>There is ample parking. Try to get under the bridge if it is hot. Entry fee is &#x24;5/car plus &#x24;3/kayak.</p>
      <p><b>Facilities: </b>Bathrooms. No water, no camping.</p>
      <p><b>Address: </b>8703 La Riviera Dr., Sacramento</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/documents/watt_avenue_access_map.pdf">Map</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/pages/wattavenueaccess.aspx">Info</a></p>
  ]]></details>
</station>
<station station_type="destination" xid="294" title="San Juan Rapids at Rossmoor Bar, American River Parkway" modtime="1531245062585" modby="petolino" edits_since="1531081083605" chart_title="San Juan Rapids" >
  <marker lat="38.63049" lng="-121.289051"/>
  <city>Fair_Oaks</city>
  <details><![CDATA[
      <p><b>Overview: </b>Paddling through San Juan Rapid is a thrill depending on the water level. In summer it is mild and fun.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/documents/rossmoor_bar_map.pdf">Map</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530840333205-294-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>SJ Rapids-2</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530840333206-294-bask0099.jpg" height="261" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>San Juan Rapid, Doug H.</span>
  ]]></details>
</station>
<station station_type="launch" xid="295" title="Upper Sunrise Put-in, American River Parkway" modtime="1531245124408" modby="petolino" edits_since="1531243974854" chart_title="Upper Sunrise" >
  <marker lat="38.636379" lng="-121.26394"/>
  <city>Gold_River</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a concrete launch ramp. Great place to launch for lower American River paddle. Travel downriver on Class l water, with one Class ll &#x28;San Juan&#x29; rapid. The first 2 miles down river is ripply water, a few bridges, and on hot summer days, crowded with tubers and floaters. Arrive early to avoid the carnival. From here it is 7 miles downriver to Riverbend Park.</p>
      <p><b>Parking: </b>Ample parking but it&#x27;s good to arrive early on hot summer days. Drive to launch and drop boats in staging area. Entry fee is &#x24;5/car plus &#x24;3/kayak.</p>
      <p><b>Facilities: </b>Bathrooms. No picnic area, no drinking water, no camping.</p>
      <p><b>Contact Info: </b>916-875-6971</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.dbw.parks.ca.gov/boatingfacilities/details/1228">http://www.dbw.parks.ca.gov/boatingfacilities/details/1228</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="296" title="Lower Sunrise Put-In, American River Parkway" modtime="1531245162304" modby="petolino" edits_since="1531244030317" chart_title="Lower Sunrise" >
  <marker lat="38.632233" lng="-121.270598"/>
  <city>Rancho_Cordova</city>
  <details><![CDATA[
      <p><b>Overview: </b>Lower Sunrise put-in is more popular than Upper Sunrise so plan on getting there early. 6.5 miles to Riverbend Park. The first two miles downriver are Class l with a single Class ll &#x28;San Juan&#x29; rapid.</p>
      <p><b>Parking: </b>Ample parking. Entry fee is &#x24;5/car plus &#x24;3/kayak. Open sunrise to sunset.</p>
      <p><b>Facilities: </b>Bathrooms but no drinking water, no picnic area and no camping.</p>
      <p><b>Contact Info: </b>916-875-6961</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.dbw.parks.ca.gov/boatingfacilities/details/1227">http://www.dbw.parks.ca.gov/boatingfacilities/details/1227</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.regionalparks.saccounty.net/Parks/Pages/SunriseRecAreasUpperandLower.aspx">http://www.regionalparks.saccounty.net/Parks/Pages/SunriseRecAreasUpperandLower.aspx</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="297" title="Riverbend Park, American River Parkway, Sacramento" modtime="1531245260095" modby="petolino" edits_since="1531244050894" chart_title="Riverbend Park" >
  <marker lat="38.595361" lng="-121.331212"/>
  <city>Carmichael</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is the first take-out location if paddling the American River from Upper or Lower Sunrise put-ins. Great picnic spot for mid-paddle break if continuing downriver. Note: there are a few intermediate take-out locations along the river, but not advised because of low-patrol and car break-ins. If continuing downriver from here, go down the main channel &#x28;river left&#x29; after the footbridge, as the right channel has many strainers. There&#x27;s a cute little rapid &#x28;Arden Rapid&#x29; just below the bridge, non-technical, just relax and avoid the one big rock in the middle. From here it is 4.3 miles to the Watt Ave. take-out.</p>
      <p><b>Parking: </b>Ample parking. If taking out, there is a long carry uphill to the parking and picnic area. This can be avoided by paddling the 4.3 miles downriver to Watt Ave. Entry fee is &#x24;5/car plus &#x24;3/kayak.</p>
      <p><b>Facilities: </b>Bathrooms and drinking fountain. Large picnic area. No camping.</p>
      <p><b>Address: </b>2300 Rod Beaudry Dr, Sacramento</p>
      <p><b>Contact Info: </b>916-875-7275</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/documents/river_bend_park_map.pdf">Map</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/pages/riverbendpark.aspx">Info</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="298" title="Nimbus Flat, Lake Natoma" modtime="1531245368974" modby="petolino" edits_since="1531244068429" chart_title="Nimbus Flat" >
  <marker lat="38.634738" lng="-121.217005"/>
  <city>Rancho_Cordova</city>
  <details><![CDATA[
      <p><b>Overview: </b>Concrete boat ramp or cobble/sand beach. Lake Natoma offers 14 miles &#x28;round trip&#x29; of powerboat-free paddling. Sloughs on the north side of the lake provide quiet access to wildlife. Paddling east you&#x27;ll reach three bridges: Folsom Crossing, the iconic Rainbow Bridge, and the Iron Footbridge. Beyond that you&#x27;ll be in a steep canyon with current, depending on flow out of Folsom dam. Note: at the top of the canyon there is a sign indicating the Folsom Prison property--Do Not Cross the Line.</p>
      <p><b>Parking: </b>There is ample parking with a &#x24;10 fee. A CA state &#x22;Poppy&#x22; pass is good here. Park is open sunrise to sunset.</p>
      <p><b>Facilities: </b>Bathrooms, picnic area, no camping. Site is adjacent to the Sac State Aquatic Center where rental boats are available.</p>
      <p><b>Address: </b>7806 Folsom Auburn Road.</p>
      <p><b>Contact Info: </b>916-988-0205</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/pages/500/files/FLSRA_trail_map_lake_natoma.pdf">Lake Natoma trail map</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530908636463-298-bask0099.jpg" height="243" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lake Natoma-2-2</span>
  ]]></details>
</station>
<station station_type="launch" xid="299" title="Willow Creek, Lake Natoma" modtime="1531245440928" modby="petolino" edits_since="1531244079702" chart_title="Willow Creek" >
  <marker lat="38.648832" lng="-121.189788"/>
  <city>Folsom</city>
  <details><![CDATA[
      <p><b>Overview: </b>Concrete boat ramp or cobble/sand beach. Lake Natoma provides 14 mile of lake paddling. Go east to the three bridges--Folsom Crossing, Rainbow Bridge and the Iron Footbridge. East of there the canyon narrows and there may be current depending on water release from Folsom dam. When you get to the Folsom Prison sign, STOP and turn around.</p>
      <p><b>Parking: </b>Ample parking. &#x24;10 fee applies unless you have a CA state &#x22;Poppy&#x22; pass. Park is open sunrise to sunset &#x28;7AM-7PM&#x29;.</p>
      <p><b>Facilities: </b>Willow Creek access is serviced by CCK which has weekend boat rentals. Pit toilets, picnic area, no camping.</p>
      <p><b>Contact Info: </b>916-988-0205</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/pages/500/files/FLSRA_trail_map_lake_natoma.pdf">Lake Natoma trail map</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530909276820-299-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lake Natoma-3</span>
  ]]></details>
</station>
<station station_type="launch" xid="301" title="Englebright Lake, Joe Miller Launch Ramp" modtime="1531244455468" modby="petolino" edits_since="1531244111861" chart_title="Englebright Lake" >
  <marker lat="39.239328" lng="-121.260195"/>
  <city>Smartsville</city>
  <details><![CDATA[
      <p><b>Overview: </b>The Joe Miller concrete ramp is by the Skipper&#x27;s Cove Marina. Englebright Lake is the dammed portion of the Yuba River. It has steep canyons with occasional waterfalls in winter and spring. The best time to enjoy this lake is late winter and early spring, before the power boats venture out. At the east end, Point Defiance, there is a fork. Go north to find more campsites before the river narrows to unnavigable. Land at Point Defiance and hike the one-mile trail to the Bridgeport Covered Bridge, the longest single-span covered bridge in America. There is another ramp by the Army Corps headquarters on Englebright Dam Rd.</p>
      <p><b>Parking: </b>There is ample parking at both boat launches. Parking and camp fees apply. Day use fee is &#x24;5 and camping fee is &#x24;20.</p>
      <p><b>Facilities: </b>There are 110 campsites. Bring your own water. Camping is dispersed around the lake. Campsites have pit toilets, picnic tables and campfire rings.</p>
      <p><b>Address: </b>Englebright Lake is located 21 miles east of Marysville off Hwy 20 on Mooney Flat Rd.</p>
      <p><b>Contact Info: </b>Skipper&#x27;s Cove Marina, 530-432-6302<br>Army Corps of Engineers, 530-432-6427 &#x28;8AM-4PM&#x29;</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.englebrightlake.com/map.htm">http://www.englebrightlake.com/map.htm</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.englebrightlake.com/">http://www.englebrightlake.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530915094907-301-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Englebright kayak camp</span>
  ]]></details>
</station>
<station station_type="launch" xid="302" title="Lake Clementine, near Auburn" modtime="1531244598059" modby="petolino" edits_since="1531244129718" chart_title="Lake Clementine" >
  <marker lat="38.935905" lng="-121.023869"/>
  <city>Auburn</city>
  <details><![CDATA[
      <p><b>Overview: </b>Lake Clementine is the dammed portion of the North Fork of the American River &#x28;above Folsom Lake&#x29;. The launch ramp is just above the Lake Clementine Dam. This area is called Lower Lake Clementine. The Lake is surrounded by steep canyon walls. Best enjoyed in autumn, winter and spring before the ski-boat crowd arrives. Power boats are restricted to a circumscribed path in a counter-clockwise direction so they are easily avoided. Come here for relaxed paddling and kayak camping. There is another put-in further up the canyon called Upper Clementine Beach which is open seasonally.</p>
      <p><b>Parking: </b>Parking is limited and gets used up quickly by boats/trailers in warmer weather. This benefits kayakers because boat traffic is limited by parking. Day use fee is &#x24;10 and &#x24;38/night for camping. CA park pass gets you in for free but does not cover camping. It is open 8AM-sunset year around.</p>
      <p><b>Facilities: </b>13 boat-in campsites &#x28;first come, first served&#x29; that are interspersed around the lake. They have pit toilets, picnic tables and fire rings. Bring your own water.</p>
      <p><b>Address: </b>Lake Clementine Rd is off the Auburn-Foresthill Rd about 2 miles from Auburn.</p>
      <p><b>Contact Info: </b>530-885-4527</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=1141">http://www.parks.ca.gov/&#x3F;page_id&#x3D;1141</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1530998231567-302-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
  ]]></details>
</station>
<station station_type="launch" xid="303" title="Sailor Bar Park, American River Parkway, Fair Oaks" modtime="1531244143701" modby="petolino" edits_since="1531003091073" chart_title="Sailor Bar Park" >
  <marker lat="38.634192" lng="-121.233824"/>
  <city>Gold_River</city>
  <details><![CDATA[
      <p><b>Overview: </b>This launch ramp is at the top of the American River Parkway and just a bit below the dam. From here head down river, after you&#x27;ve run a shuttle of course, to wherever you want to go downstream. This is a busy site in summer.</p>
      <p><b>Parking: </b>About 15 spaces near the launch ramp and a large parking area very nearby. Fees are &#x24;5/car and &#x24;3/kayak. There is a rigging area by the ramp. Road and parking are gravel &#x28;i.e. mud in winter&#x29;. Hours are sunrise to sunset year around.</p>
      <p><b>Facilities: </b>Bathrooms in the large lot.</p>
      <p><b>Address: </b>4253 Illinois Ave, Fair Oaks &#x28;park entrance&#x29;. Ramp is at the end of Illinois Ave.</p>
      <p><b>Contact Info: </b>916-875-6971</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.regionalparks.saccounty.net/parks/pages/mapsailorbar.aspx">http://www.regionalparks.saccounty.net/parks/pages/mapsailorbar.aspx</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="304" title="Pillar Point Harbor Launch Ramp" zone="545" chart_title="Pillar Pt Harbor E" modtime="1657144179192" modby="petolino" edits_since="1537378595032" >
  <marker lat="37.502321" lng="-122.477474"/>
  <tide_station>283</tide_station>
  <city>Half_Moon_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>6 lane concrete launch ramp next to a protected white sand beach in the outer harbor. Explore the harbor or head out the mouth for coastal exploration. Watch out for Mavericks.</p>
      <p><b>Parking: </b>Lots of parking. There is a &#x24;14 launch fee payable at an iron ranger that is mainly for parking in the adjacent lot. There is a 20 minute limit loading zone. The distance from the loading zone to the beach is about 20 yds.</p>
      <p><b>Facilities: </b>Bathroom is clean and well-maintained. Water at fish cleaning station.</p>
      <p><b>Contact Info: </b>Harbormaster, 650-726-4382, 7:30AM-4PM, M-F.<br>harbormaster@smharbor.com</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smharbor.com/pillar-point-harbor-650-726-4382">http://www.smharbor.com/pillar-point-harbor-650-726-4382</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535989174312-304-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pillar Pt beach by ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535989174313-304-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Pillar Pt ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="305" title="Half Moon Bay Yacht Club, Pillar Point Harbor" zone="545" modtime="1537377622429" modby="petolino" edits_since="1535990091864" chart_title="Half Moon Bay Yacht Club" >
  <marker lat="37.502799" lng="-122.490898"/>
  <tide_station>283</tide_station>
  <city>Half_Moon_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>Site of the old CCK shop. There is a white sand beach with a small ramp behind the yacht club. This is the outer harbor and the quickest way out to the coast either via the harbor mouth or by portage at the west end of the harbor.</p>
      <p><b>Parking: </b>Very limited and on the street.</p>
      <p><b>Facilities: </b>Site now houses Mavericks Paddlesports shop. If you&#x27;re nice you might get them or the YC to let you use their restroom. Otherwise there are no facilities.</p>
      <p><b>Address: </b>214 Princeton Ave.</p>
      <p><b>Contact Info: </b>Mavericks Paddlesports, 650-563-4251<br>Harbormaster, 650-726-4382</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.smharbor.com/pillar-point-harbor-650-726-4382">http://www.smharbor.com/pillar-point-harbor-650-726-4382</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535990091864-305-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>HMB YC beach</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535990091865-305-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>HMB YC ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="306" title="Bean Hollow State Beach" zone="545" modtime="1535994460873" modby="bask0099" edits_since="0" >
  <marker lat="37.225961" lng="-122.409718"/>
  <tide_station>12</tide_station>
  <city>Pescadero</city>
  <details><![CDATA[
      <p><b>Overview: </b>Beautiful cove with white sand beach. During rough weather this cove has high surf and can close out. When calm it is a great launch.</p>
      <p><b>Parking: </b>Plenty and has the usual State Park &#x24;10 parking fee. Park is open 8AM to sunset.</p>
      <p><b>Address: </b>11000 Cabrillo Hwy. On Hwy 1 about 4 miles north of Pigeon Point and 17 miles south of Half Moon Bay.</p>
      <p><b>Contact Info: </b>650-726-8819</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.parks.ca.gov/?page_id=527">http://www.parks.ca.gov/&#x3F;page_id&#x3D;527</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535994460873-306-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bean Hollow, 4.5&#x27; tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1535994460874-306-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Bean Hollow, calm day at high tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="307" title="Warm Water Cove" zone="531" modtime="1604861671728" modby="petolino" edits_since="1604785773086" >
  <marker lat="37.754638" lng="-122.383649"/>
  <tide_station>176</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Location is at the foot of 24th St. The high tide launch is immediately to the left &#x28;i.e. northwest corner&#x29; as you enter the park. There is major mud at all other tides. From here paddle to Islais Creek or the SF waterfront. Or, go east to Alameda Island. Keep an eye open for ships. There is also a landable beach at the south end of the park.</p>
      <p><b>Parking: </b>Free and on the street. Break-ins occur so don&#x27;t leave anything valuable in the car.</p>
      <p><b>Facilities: </b>None. There are picnic tables and a bench or two and two cats that the neighbors feed.</p>
      <p><b>Address: </b>Foot of 24th St. in San Francisco.</p>
      <p><b>Contact Info: </b>San Francisco City Park</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.sfparksalliance.org/our-parks/parks/warm-water-cove">San Francisco Parks Alliance</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1537828724926-307-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Warm Water Cove at low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1537828724927-307-bask0099.jpg" height="299" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Warm Water Cove at high tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604785773086-307-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Warm Water Park, 2nd beach. 11-2020</span>
  ]]></details>
</station>
<station station_type="launch" xid="308" title="San Francisco, Heron&apos;s Head Park" zone="531" modtime="1604864059450" modby="petolino" edits_since="1604794619057" chart_title="Heron&#39;s Head Park" >
  <marker lat="37.73886" lng="-122.37379"/>
  <tide_station>176</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Heron&#x27;s Head Park was renovated in 2012. There is a nice hard packed pebble/sand/mud beach to the left of the trail about 300 yds from the parking lot. This is also called Lash Lighter Basin. Cargo ships come in here so be cautious. The park has a long trail out to the spit which goes along a restored meadow/grassland/marsh. There is a native plant nursery by the park entrance. From here tour the SF shoreline to the north, go to Candlestick Park to the south or just around the corner to India Basin.</p>
      <p><b>Parking: </b>Free parking for about 20 cars.</p>
      <p><b>Facilities: </b>Bathroom by the parking lot.</p>
      <p><b>Address: </b>Corner of Jennings and Cargo Way in Hunters Point. It is very close to India Basin Park.</p>
      <p><b>Contact Info: </b>Port of San Francisco, 415-274-0400</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1604794619057-308-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Heron&#x27;s Head park, Nov. 2020</span>
  ]]></details>
</station>
<station station_type="launch" xid="311" title="Blu Harbor Marina, Redwood City" zone="531" modtime="1606695669922" modby="petolino" edits_since="1605657629740" chart_title="Blu Harbor Marina" >
  <marker lat="37.50012" lng="-122.223455"/>
  <tide_station>322</tide_station>
  <city>Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>Blu Harbor Marina is at the site of the former Pete&#x27;s Harbor. There is a low dock with a straight ramp from the parking area. The site is open during daylight hours. The access spot is between the dock and the rubble bank. The photo was taken at a 5-1/2&#x27; tide so it could be tight at low tide.</p>
      <p><b>Parking: </b>About a dozen spaces not reserved for tenants.</p>
      <p><b>Facilities: </b>Bathroom is not obvious. There is a hose bib for washing gear.</p>
      <p><b>Address: </b>1 Blu Harbor Blvd. in Redwood city</p>
      <p><b>Contact Info: </b>Office: 650-395-9650 &#x28;8:30AM-5PM&#x29;</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1605657629740-311-bask0099.jpg" height="534" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Blu Harbor kayak launch, 11-2020</span>
  ]]></details>
</station>
<station station_type="launch" xid="312" title="Cooley Landing Park" zone="531" modtime="1633562101574" modby="bask0099" edits_since="1606686832683" >
  <marker lat="37.47628" lng="-122.122"/>
  <tide_station>276</tide_station>
  <city>East_Palo_Alto</city>
  <details><![CDATA[
      <p><b>Overview: </b>High tide water access spots are to the south and also behind the education center. At low tide there is lots of mud. Park is fairly new and part of Ravenswood Open Space Preserve.</p>
      <p><b>Parking: </b>There are two parking areas. One just to the left as you enter the park and the other in front of the education center.</p>
      <p><b>Facilities: </b>Bathrooms and drinking fountain in the education center. Picnic area,</p>
      <p><b>Address: </b>East end of Bay Rd in East Palo Alto</p>
      <p><b>Contact Info: </b>City of East Palo Alto, Parks and Rec. 650-853-3100</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606238427192-312-bask0099.jpg" height="350" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cooley Landing</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606686832683-312-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Low tide at gravel put-in</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633562101574-312-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>9.5&#x27; tide</span>
  ]]></details>
</station>
<station station_type="launch" xid="313" title="Stinson Beach" zone="545" modtime="1670616395659" modby="petolino" edits_since="1606695748816" >
  <marker lat="37.89746" lng="-122.641298"/>
  <tide_station>42</tide_station>
  <city>Stinson_Beach</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stinson Beach is a 3 mile long beach. Water is shallow and the surf can be mild or wild. At low tide it spills. It is famous with tourists and locals alike. There is abundant parking. The carry from the parking lot to the water is less than 100 yds over flat ground. They warn of shark attacks at this site.</p>
      <p><b>Parking: </b>Abundant in several parking lots. entrance opens at 9AM every day.</p>
      <p><b>Facilities: </b>Clean, well maintained bathrooms with changing rooms and drinking fountains. Outdoor shower at the central bathroom. There are picnic areas with BBQ grills.</p>
      <p><b>Address: </b>Park entrance is at the north end of town, off Shoreline Highway and is labeled with a sign that says Stinson Beach Federal Park.</p>
      <p><b>Links: </b><a target="tp_details" href="https://magicseaweed.com/Stinson-Beach-Surf-Report/4216/">Magic Seaweed Surf Report</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606240144499-313-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>looking south, low tide</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606240144500-313-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606240144501-313-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>two kayakers</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606240144502-313-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Warning Sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="314" title="Rio del Mar Beach, Aptos" zone="535" modtime="1606695823343" modby="petolino" edits_since="1606688681660" chart_title="Rio del Mar Beach" >
  <marker lat="36.968632" lng="-121.903601"/>
  <tide_station>362</tide_station>
  <city>Aptos</city>
  <details><![CDATA[
      <p><b>Overview: </b>Roughly 100 yds from parking to the water. Paddle to look at the cement ship, the SS Palo Alto. Sand beach with gentle surf.</p>
      <p><b>Parking: </b>There are about 75 spots in the parking lot.</p>
      <p><b>Facilities: </b>Bathrooms with an outside shower</p>
      <p><b>Address: </b>201 State Park Dr. in Aptos</p>
      <p><b>Contact Info: </b>831-685-6500</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606688498214-314-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rio del Mar with cement ship</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1606688498215-314-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Rio del Mar Beach parking</span>
  ]]></details>
</station>
<station station_type="launch" xid="315" title="Treasure Island ramp, south end in Clipper Cove" zone="530" modtime="1614463210242" modby="petolino" edits_since="1614463144066" chart_title="Treasure Island Ramp" >
  <marker lat="37.818088" lng="-122.366178"/>
  <current_station>432</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is a small, funky ramp at the jog in Clipper Cove Way. this ramp is quite close to the Treasure Island Sailing Center.</p>
      <p><b>Parking: </b>There is space to stop and drop off a boat, but parking is very limited to non-existent. Maybe at the winery across the street&#x3F;</p>
      <p><b>Facilities: </b>None, although maybe the winery has a bathroom.</p>
      <p><b>Address: </b>Clipper Cove Way on Treasure Island</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1609780576851-315-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Treasure Island ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1609780576852-315-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Treasure island ramp 2</span>
  ]]></details>
</station>
<station station_type="launch" xid="316" title="Wimpy&apos;s" zone="530" modtime="1609783463515" modby="bask0099" edits_since="1609782306932" >
  <marker lat="38.226858" lng="-121.491187"/>
  <tide_station>243</tide_station>
  <city>Walnut_Grove</city>
  <details><![CDATA[
      <p><b>Overview: </b>Wimpy&#x27;s is a restaurant that has a launch ramp with some parking available. The ramp is being renovated &#x28;2020&#x29; but is normally open 24 hours a day. There is a &#x24;5 launch fee.</p>
      <p><b>Parking: </b>Lots in front of the restaurant. About a dozen spaces by the ramp however this area is being converted to other uses.</p>
      <p><b>Facilities: </b>Food, drink and bathrooms in the restaurant. There is a porta potty available too.</p>
      <p><b>Address: </b>14001 W. Walnut Grove Rd. at the foot of Charles Street. Location is 3 miles west of Hwy 5 &#x28;Thorton offramp&#x29;</p>
      <p><b>Contact Info: </b>209-794-2774</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.wimpysmarina.com/">https://www.wimpysmarina.com</a></p>
  ]]></details>
</station>
<station station_type="destination" xid="317" title="Shipwreck Beach" zone="530" modtime="1612493661303" modby="bask0099" edits_since="1612493553525" >
  <marker lat="38.024004" lng="-121.804602"/>
  <current_station>453</current_station>
  <city>Antioch</city>
  <details><![CDATA[
      <p><b>Overview: </b>This little cove with a beach is sandwiched between a couple sunken hulls of historic sailing ships. It is less than a mile from Antioch across the San Joaquin River on Kimball Island.</p>
      <p><b>Parking: </b>NA</p>
      <p><b>Facilities: </b>None</p>
      <p><b>Address: </b>NA</p>
      <p><b>Contact Info: </b>None</p>
  ]]></details>
</station>
<station station_type="launch" xid="318" title="Garcia Bend City Park, Sacramento" modtime="1620497032312" modby="petolino" edits_since="1615958423870" chart_title="Garcia Bend Park" >
  <marker lat="38.478422" lng="-121.542278"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>Garcia Bend Park is a local neighborhood park. To get to the concrete boat ramp, drive up and over the levee. There is a high dock on the right side. It is in a small pocket off the Sacramento River. There is a loading area for three cars at the top of the ramp. There is a fee to launch.</p>
      <p><b>Parking: </b>There is ample parking.</p>
      <p><b>Facilities: </b>Bathrooms. Picnic area, BBQ</p>
      <p><b>Address: </b>7654 Pocket Rd., Sacramento</p>
      <p><b>Contact Info: </b>Sacramento City Parks and Recreation</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615950331392-318-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Garcia Bend ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615950331393-318-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Garcia Bend bathroom art</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615950331394-318-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Garcia Bend picnic area</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1615950331395-318-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Garcia Bend ramp fee sign, 3-2021</span>
  ]]></details>
</station>
<station station_type="launch" xid="319" title="Buckley Cove Park Launch Ramp" zone="530" modtime="1632344788625" modby="bask0099" edits_since="0" chart_title="Buckley Cove Ramp" >
  <marker lat="37.976432" lng="-121.374929"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>There are 3 ramps, one is very low freeboard for disabled access.</p>
      <p><b>Parking: </b>Lots of parking. &#x24;3/vehicle for day use. 6AM-7PM. Overnight parking is OK but there is no camping.</p>
      <p><b>Facilities: </b>Bathrooms are old and rusty but clean and well maintained.</p>
      <p><b>Address: </b>4911 Buckley Cove Way, Stockton. On the San Joaquin River</p>
      <p><b>Contact Info: </b>209-474-2082 or 209-937-8539</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632344788625-319-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Buckley Cove Park Ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632344788626-319-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Buckley Cove rates sign, 9-21</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632344788627-319-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Buckley Cove low float dock</span>
  ]]></details>
</station>
<station station_type="launch" xid="320" title="Basin Street Boat Launch, Noyo Harbor" zone="455" modtime="1635116664328" modby="petolino" edits_since="1632353630100" chart_title="Basin Street Boat Launch" >
  <marker lat="39.426666" lng="-123.798586"/>
  <tide_station>253</tide_station>
  <city>Fort_Bragg</city>
  <details><![CDATA[
      <p><b>Overview: </b>Launch is a concrete ramp with docks on either side. There is ample room for staging kayaks.</p>
      <p><b>Parking: </b>54 full pull-through trailer sized parking spots. &#x24;5 fee to park but no where to put the money.</p>
      <p><b>Facilities: </b>Porta Potty which is reasonably clean. There is no picnic area and no seating but some grass.</p>
      <p><b>Address: </b>Basin Street is on the south side of the Noyo River and just down the road from Liquid Fusion.</p>
      <p><b>Contact Info: </b>Noyo Harbor District, 707-964-4718</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632353630100-320-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Noyo Harbor launch ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632353630101-320-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Noyo Harbor sign, 9-2021</span>
  ]]></details>
</station>
<station station_type="launch" xid="321" title="Dos Reis Park and Campground" zone="530" modtime="1635116852352" modby="petolino" edits_since="1632849600189" chart_title="Dos Reis Park" >
  <marker lat="37.831576" lng="-121.311555"/>
  <current_station>360</current_station>
  <city>Lathrop</city>
  <details><![CDATA[
      <p><b>Overview: </b>Dos Reis Park has a very nice campground as well as a concrete launch ramp. There is some sand along the shore for landing depending on river height. The park is open sunrise to sunset. This could be a destination as well as a launch. Tent camping is permitted on weekends only. Reservations are necessary. RV camping costs &#x24;35/night and tent camping is &#x24;25/night. There is an on site campground host.</p>
      <p><b>Parking: </b>The parking lot is huge. Day use fee is &#x24;5 on weekdays and &#x24;6 on weekends and holidays.. Overnight parking is not allowed unless camping.</p>
      <p><b>Facilities: </b>Picnic tables and BBQs. The bathroom is a regular bathroom and there are showers for the campers. There is a drinking fountain. There is no facility for boat storage.</p>
      <p><b>Address: </b>890 Dos Reis Rd in Lathrop</p>
      <p><b>Contact Info: </b>San Joaquin County Parks, 209-953-8800 or 209-331-7400</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sjparks.com">http://www.sjparks.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632849600189-321-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>ramp with sand at left</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632849600190-321-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Dos Reis ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="322" title="Mossdale Crossing Regional Park" zone="530" modtime="1635116999390" modby="petolino" edits_since="1635116924791" chart_title="Mossdale Crossing Regional" >
  <marker lat="37.786932" lng="-121.306843"/>
  <current_station>360</current_station>
  <city>Lathrop</city>
  <details><![CDATA[
      <p><b>Overview: </b>Mossdale Crossing has a concrete launch ramp accessible from the top of the levee. There is no clear spot to rig kayaks by the ramp. There is an on-site host. The park is open sunrise to sunset. The park location is next to I5 on the south side of Lathrop and on the San Joaquin river.</p>
      <p><b>Parking: </b>Parking lot is huge, especially for trailered boats. Cost is &#x24;5 on weekdays and &#x24;6 on weekends and holidays. No overnight parking is allowed. There are two ADA parking spots at the top of the ramp.</p>
      <p><b>Facilities: </b>Regular bathrooms are by the parking lot which is about 40-50 yds from the launch ramp. There are several picnic tables with BBQ by the parking lot. Boat storage is not an option.</p>
      <p><b>Address: </b>19091 S. Manthey Rd. Lathrop</p>
      <p><b>Contact Info: </b>San Joaquin County Parks, 209-953-8800 or 209-331-7400</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.sjparks.com/">http://www.sjparks.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632851852698-322-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mossdale ramp with water hyacinth</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632851852699-322-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mossdale ramp with sand</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632851852700-322-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Mossdale Landing Park, launch ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="323" title="Morelli Park and Launch Ramp" zone="530" modtime="1635117065246" modby="petolino" edits_since="1632853186606" chart_title="Morelli Ramp" >
  <marker lat="37.952703" lng="-121.306539"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Morelli Park is located on the Stockton Deep Water Channel and under the I5 bridge. There are two ramps. Rigging can take place next to the ramps. During 2021 and 2022 there is no fee to enter or park. Normally it is &#x24;8. Security must be a problem as there are several signs of warning.</p>
      <p><b>Parking: </b>There are many spaces adjacent to the ramp. The lot is open 5AM-10PM with no overnight parking allowed.</p>
      <p><b>Facilities: </b>The bathroom is defunct and locked. There are two picnic tables.</p>
      <p><b>Address: </b>1025 W. Weber Ave. Stockton</p>
      <p><b>Contact Info: </b>City of Stockton, 209-462-4200</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1632853186606-323-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
  ]]></details>
</station>
<station station_type="launch" xid="324" title="Russo&apos;s landing" zone="530" modtime="1635117121327" modby="petolino" edits_since="1633562919416" >
  <marker lat="38.033978" lng="-121.621392"/>
  <tide_station>13</tide_station>
  <city>Bethel_Island</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a concrete launch ramp with space to rig your boat on the levee beside the ramp. Cost to launch a kayak is &#x24;10. This includes parking.</p>
      <p><b>Parking: </b>There is some parking on top of the levee next to the ramp. Overnight parking is OK.</p>
      <p><b>Facilities: </b>Very clean bathrooms below the harbormasters office. Not far from the launch ramp. Tthere is a covered picnic area that can accomodate about 100 people. There is a camping area next to the picnic area. Camping is &#x24;35/night but will go up to &#x24;45/night in 2022. There is a restaurant &#x28;Boyd&#x27;s Harbor Restaruant&#x29; within walking distance down the levee.</p>
      <p><b>Address: </b>3995 Willow Rd. Bethel Island</p>
      <p><b>Contact Info: </b>925-684-2024</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633562919416-324-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Russo&#x27;s</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633562919417-324-bask0099.jpg" height="200" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Russo&#x27;s marina, Bethel Island</span>
  ]]></details>
</station>
<station station_type="launch" xid="326" title="Sunset Harbor Marina" zone="530" modtime="1635117237630" modby="petolino" edits_since="1635117186110" >
  <marker lat="38.011902" lng="-121.639846"/>
  <tide_station>13</tide_station>
  <city>Oakley</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a launch ramp with a high dock. Rigging takes place beside the ramp. There is a &#x24;10 fee to launch kayaks.</p>
      <p><b>Parking: </b>There is lots of parking in a large dirt lot, not far from the ramp.</p>
      <p><b>Facilities: </b>There is a bathroom &#x28;with showers&#x29; which is a fair distance from the ramp. There is a picnic area which consists of grass only. Camping appears to be for RVs and is at the site.</p>
      <p><b>Address: </b>3040 Dutch Slough Rd</p>
      <p><b>Contact Info: </b>925-684-3522 or 925-453-9431</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.sunsetharbordelta.com/">https://www.sunsetharbordelta.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633564811535-326-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sunset marina looking up ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633564811536-326-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sunset Harbor sign</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633564811537-326-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Sunset Marina ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="327" title="Piper Point Marina, Bethel Island" zone="530" modtime="1635117544045" modby="petolino" edits_since="1635117493086" chart_title="Piper Pt Marina" >
  <marker lat="38.0356" lng="-121.624396"/>
  <tide_station>13</tide_station>
  <city>Bethel_Island</city>
  <details><![CDATA[
      <p><b>Overview: </b>Piper Point marina has a concrete launch ramp and charges &#x24;5 to launch kayaks. It is located on Franks Tract State Recreation Area behind a barrier island that keeps out the water hyacinth. Rigging is possible on top of the levee and next to the ramp.</p>
      <p><b>Parking: </b>Parking is free and overnight is allowed.</p>
      <p><b>Facilities: </b>There are four very clean, regular bathrooms located under the harbormasters office. There is camping across the street for tent and RV. It costs &#x24;35/night. It is not clear if the public can use the campsites.</p>
      <p><b>Address: </b>3861 N. Willow Rd, Bethel Island, CA 94511</p>
      <p><b>Contact Info: </b>925-684-2174, piperpointmarina@gmail.com</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.piperpointmarina.com/">http://www.piperpointmarina.com/</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633624546923-327-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Piper Point marina ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633624546924-327-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Piper Point Marina sign</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1633624546925-327-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Piper Point low dock</span>
  ]]></details>
</station>
<station station_type="launch" xid="328" title="Discovery Bay Marina, Discovery Bay" zone="530" modtime="1635117689437" modby="petolino" edits_since="1635117665318" chart_title="Discovery Bay Marina" >
  <marker lat="37.905665" lng="-121.587137"/>
  <tide_station>13</tide_station>
  <city>Discovery_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>The marina has a concrete launch ramp. The &#x22;walk-in&#x22; fee for kayaks is &#x24;5. There is a loading/unloading/rigging area. The floats are of medium height from the water. The shoreline is rocky. There is grass which is accessibe from the docks. There is no camping at this site. Nearest camping is at Orwood.</p>
      <p><b>Parking: </b>Plenty with a short walk to the ramp. Hours are during daylight &#x28;8AM-5PM&#x29;.</p>
      <p><b>Facilities: </b>There is a porta potty near the ramp. There are regular restrooms a short walk away near the harbormaster&#x27;s office. Very clean. There is a store with snacks and drinks &#x28;Boardwalk Grill&#x29;. No picnic area but a nice grassy area beside the parking area.</p>
      <p><b>Address: </b>5901 Marina Rd. Corner of Marina Rd and Western Farms Ranch Rd.</p>
      <p><b>Contact Info: </b>925-634-5928</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.discoverybayyachtharbor.com/">http://www.discoverybayyachtharbor.com</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="329" title="Lazy M Marina" zone="530" modtime="1635117748589" modby="petolino" edits_since="1633817480573" >
  <marker lat="37.837568" lng="-121.603613"/>
  <tide_station>44</tide_station>
  <city>Discovery_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a concrete ramp and the fee is &#x24;10 for launch and parking. This is very near the Clifton Court forebay with access to the Delta sloughs via Italian Slough and Old River.</p>
      <p><b>Parking: </b>Plenty in a dirt lot that is a short walk to the ramp. There is a loading and unloading area. Overnight is probably OK.</p>
      <p><b>Facilities: </b>There is a regular bathroom. There is no picnic area. There is a store for snacks and drinks. There is a nice covered patio. No camping at this site.</p>
      <p><b>Address: </b>5050 Clifton Ct. Rd, Byron</p>
      <p><b>Contact Info: </b>Dee Mygrant, 925-634-4555</p>
  ]]></details>
</station>
<station station_type="destination" xid="330" title="Orwood Resort" zone="530" modtime="1635117838045" modby="petolino" edits_since="1633818677067" >
  <marker lat="37.938872" lng="-121.611773"/>
  <current_station>360</current_station>
  <city>Brentwood</city>
  <details><![CDATA[
      <p><b>Overview: </b>The ramp is concrete with a medium high dock. However, launching is not allowed due to insurance. Landing is OK. There is an area to unload. It is not clear if there is a fee to land. To launch it is &#x24;20 on weekends. The shoreline is rocky but there is a swimming beach at the resort. There is camping on site.</p>
      <p><b>Parking: </b>Lots, and close to the ramp. Restricted to daylight hours.</p>
      <p><b>Facilities: </b>There is a full service restaurant &#x28;breakfast, lunch, and dinner&#x29; and store with snack items. Call to reserve a campsite and find out the cost. Bathrooms are behind the restaurant and are regular and clean.</p>
      <p><b>Address: </b>4451 Orwood Rd. near Discovery Bay</p>
      <p><b>Contact Info: </b>925-634-6812</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.orwoodresort.com/">https://www.orwoodresort.com</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="331" title="Tracy Oasis Marina, Tracy" zone="530" modtime="1635117947503" modby="petolino" edits_since="1633819728906" chart_title="Tracy Oasis Marina" >
  <marker lat="37.819064" lng="-121.460388"/>
  <tide_station>13</tide_station>
  <city>Tracy</city>
  <details><![CDATA[
      <p><b>Overview: </b>There is a concrete ramp with a nearby rigging area. The dock is medium height. There is no beach. The ramp fee is &#x24;8 for regular people and &#x24;6 for seniors. Parking is &#x24;5. The ramp is open during daylight hours. From here paddle Old River.</p>
      <p><b>Parking: </b>Plenty across the road.</p>
      <p><b>Facilities: </b>There is a porta potty. A regular restroom is under construction. It is close to the ramp. Kinda clean. There is no picnic area. There is a store with snacks and drinks. There is no camping on site.</p>
      <p><b>Address: </b>12450 W. Grimes Rd. Tracy</p>
      <p><b>Contact Info: </b>Korinne Flowers, 209-835-3182</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.tracyoasismarina.com/">https://www.tracyoasismarina.com</a></p>
  ]]></details>
</station>
<station station_type="launch" xid="332" title="B &amp; W Resort" zone="530" modtime="1635118038534" modby="petolino" edits_since="1634071570548" chart_title="B W Resort" >
  <marker lat="38.127039" lng="-121.580076"/>
  <current_station>360</current_station>
  <city>4CG9+RX_Isleton</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is a busy family owned marina and resort. The boat launch seems to serve primarily power fishing boats. It has two long high freeboard docks and a concrete boat ramp. There is a rigging area near the ramp. There is camping nearby at the Lighthouse Resort down the road &#x28;916-777-5511&#x29;.</p>
      <p><b>Parking: </b>Large parking lot. Launch is free but &#x24;6 to park. Overnight parking is &#x24;6. Pay at an iron ranger.</p>
      <p><b>Facilities: </b>Regular bathrooms in the parking lot and at the convenience store. Maintenance is OK. There is boat storage across the street.</p>
      <p><b>Address: </b>964 Brannan Island Rd.</p>
      <p><b>Contact Info: </b>916-777-6161</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.bandwresort.net/">https://www.bandwresort.net</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634071570548-332-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>B &#x26; W ramp, Oct. 2021</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634071570549-332-bask0099.jpg" height="267" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>B &#x26; W ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1634071570550-332-bask0099.jpg" height="301" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>B &#x26;</span>
  ]]></details>
</station>
<station station_type="launch" xid="333" title="Korth&apos;s Pirates Lair Marina" zone="530" modtime="1635118225076" modby="petolino" edits_since="1635028431070" chart_title="Korth&#39;s Pirates Lair" >
  <marker lat="38.097911" lng="-121.568711"/>
  <current_station>360</current_station>
  <city>Isleton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Korth&#x27;s is at the junction of the San Joaquin and Mokelumne rivers. There is a concrete ramp with plenty of parking &#x28;across the street&#x29;. Weekdays are uncrowded. Not so on weekends. &#x24;10 fee to launch.</p>
      <p><b>Parking: </b>Launch fee includes parking. &#x24;5 extra to park overnight.</p>
      <p><b>Facilities: </b>Restaurant, lawn area with picnic tables and BBQs. There are regular bathrooms</p>
      <p><b>Address: </b>169 W. Brannan Island Rd., Isleton. Located off Highway 12 on Brannan/Andrus Island</p>
      <p><b>Contact Info: </b>Tom Tate, harbormaster, 916-777-6464<br>korthsmarina@gmail.com<br>1-888-776-6464</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.korthspirateslair.com">https://www.korthspirateslair.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635028431070-333-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Korth&#x27;s Pirates Lair ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635028431071-333-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Korth&#x27;s sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="334" title="Lighthouse Marina" zone="530" modtime="1635118275372" modby="petolino" edits_since="1635030025674" >
  <marker lat="38.10544" lng="-121.570811"/>
  <current_station>360</current_station>
  <city>Isleton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Llghthouse Marina has a concrete launch ramp that is free. There is a high dock with nearby space to rig boats.</p>
      <p><b>Parking: </b>Parking is along the road. It is adequate for a weekday but probably very crowded on weekends. &#x24;5 for parking.</p>
      <p><b>Facilities: </b>There is a restaurant. 916-777-4007. There is an adjoining campground.</p>
      <p><b>Address: </b>151 Brannan Island Rd., Isleton</p>
      <p><b>Contact Info: </b>916-777-5511<br>info@lighthouseresortandmarina.com</p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635030025674-334-bask0099.jpg" height="282" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lighthouse marina aerial photo</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635030025675-334-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lighthouse marina ramp and dock</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1635030025676-334-bask0099.jpg" height="533" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Lighthouse sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="335" title="Miller Park Launch Ramp" modtime="1639522057531" modby="petolino" edits_since="1636586006340" chart_title="Miller Park Ramp" >
  <marker lat="38.564597" lng="-121.517848"/>
  <city>Sacramento</city>
  <details><![CDATA[
      <p><b>Overview: </b>The launch ramp is part of the Sacramento Marina but is separate from it. Besides a concrete ramp it has a small sand beach. The ramp is wide with sand at the bottom.</p>
      <p><b>Parking: </b>There is a large parking lot with plenty of spaces that seem designed for trailered boats. There is a loading area adjacent to the ramp. There is a pay machine in the parking lot. &#x24;15 during the summer. &#x24;10 from fall to spring</p>
      <p><b>Facilities: </b>There is a single ADA porta potty in the parking lot. Picnic areas are located in the main park which is nearby.</p>
      <p><b>Address: </b>2710 Ramp Way, Sacramento</p>
      <p><b>Contact Info: </b>sacrecreation@cityofsacramento.org or 916-808-5712<br></p>
      <p><b>Links: </b><a target="tp_details" href="https://www.cityofsacramento.org/ParksandRec/Parks/Park-Directory/Land-Park/Miller-Regional-Park">https://www.cityofsacramento.org/ParksandRec/Parks/Park-Directory/Land-Park/Miller-Regional-Park</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1636586006340-335-bask0099.jpg" height="292" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1636586006341-335-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Miller Ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="336" title="Clarksburg Launch Ramp" modtime="1639522236569" modby="petolino" edits_since="1636587422641" chart_title="Clarksburg Ramp" >
  <marker lat="38.384252" lng="-121.520153"/>
  <city>Clarksburg</city>
  <details><![CDATA[
      <p><b>Overview: </b>This site is dedicated to the launching of boats. There is a concrete ramp but no beach. There is no dock. There is space to rig in the parking lot. Not crowded on weekdays in fall. Very busy on weekends in summer.</p>
      <p><b>Parking: </b>Lots of parking, mostly for boat trailers. It appears to be free.</p>
      <p><b>Facilities: </b>One porta potty in the parking lot. There is a picnic area. No overnight camping, and overnight parking is not allowed.</p>
      <p><b>Address: </b>38125 S. River Rd., Clarksburg. About 1.5 miles south of Clarksburg</p>
      <p><b>Contact Info: </b>Yolo County Parks, 530-406-4880</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.yolocounty.org/government/general-government-departments/parks/parks-information/clarksburg-boat-launch">https://www.yolocounty.org/government/general-government-departments/parks/parks-information/clarksburg-boat-launch</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1636587422641-336-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Clarksburg ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1636587422642-336-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Cllarksburg, top of ramp</span>
  ]]></details>
</station>
<station station_type="launch" xid="337" title="Tiki Lagoon Resort and Marina" zone="530" modtime="1638229696040" modby="bask0099" edits_since="0" chart_title="Tiki Lagoon Marina" >
  <marker lat="37.97972" lng="-121.474012"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Tiki Lagoon has a concrete ramp. There is a campground across the street for both RVs and tents. Cost is &#x24;25/night for 1 tent</p>
      <p><b>Parking: </b>Huge parking lot with &#x24;8 fee to park and launch, Mon-Thur. &#x24;12 Friday-Sunday</p>
      <p><b>Facilities: </b>Bathrooms are in the restaurant. Picnic tables and BBQ.</p>
      <p><b>Address: </b>12988 W. McDonald Rd. Stockton</p>
      <p><b>Contact Info: </b>209-941-8975</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.tikilagoon.com">https://www.tikilagoon.com</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638229696040-337-bask0099.jpg" height="310" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638229696041-337-bask0099.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Tiki Lagoon ramp2</span>
  ]]></details>
</station>
<station station_type="launch" xid="338" title="Turner Cut Resort" zone="530" modtime="1639522395624" modby="petolino" edits_since="1638230176645" >
  <marker lat="37.982374" lng="-121.472989"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Turner Cut has a concrete launch ramp. Cost is &#x24;10 to launch and park. There is a RV campground across the street. Office hours are 9AM-4PM, and they are closed Tuesday and Wednesday.</p>
      <p><b>Parking: </b>Large parking lot across the street.</p>
      <p><b>Facilities: </b>Bathrooms are located in the campground, and there is an outdoor shower.</p>
      <p><b>Address: </b>12888 Neugebauer Rd., Stockton</p>
      <p><b>Contact Info: </b>209-265-4129, info@turnercutresort.com</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.turnercutresort.com/">https://www.turnercutresort.com/</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230176645-338-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Turner Cut sign at campground</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230176646-338-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Turner Cut Resort ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230176647-338-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Turner Cut Resort sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="339" title="Windmill Cove Resort and Marina" zone="530" modtime="1639522494455" modby="petolino" edits_since="1638230992495" chart_title="Windmill Cove Marina" >
  <marker lat="37.994597" lng="-121.418926"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Windmill Cove has a concrete launch ramp with a &#x24;15 fee to launch and park.</p>
      <p><b>Parking: </b>Large dirt parking lot adjacent to the ramp.</p>
      <p><b>Facilities: </b>Bathrooms are kept locked. There is a very nice picnic area and a nearby bar and grill. There is a tent camping site with picnic tables and BBQ but no running water or bathrooms.</p>
      <p><b>Address: </b>7600 Windmill Cove Rd. Stockton</p>
      <p><b>Contact Info: </b>209-469-9300 The restaurant is 209-938-9192. info@windmillcove.com</p>
      <p><b>Links: </b><a target="tp_details" href="https://windmillcove.com/">https://windmillcove.com/</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230992495-339-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windmill cove rate sign</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230992496-339-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windmill cove camp sites</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638230992497-339-bask0099.jpg" height="370" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Windmill cove, map</span>
  ]]></details>
</station>
<station station_type="launch" xid="340" title="Paradise Point Marina" zone="530" modtime="1639522738407" modby="petolino" edits_since="1639522705767" chart_title="Paradise Pt Marina" >
  <marker lat="38.046509" lng="-121.418121"/>
  <tide_station>13</tide_station>
  <city>Stockton</city>
  <details><![CDATA[
      <p><b>Overview: </b>Paradise Point Marina has a two-lane concrete ramp that is open all day, every day. The cost to launch is &#x24;10.</p>
      <p><b>Parking: </b>Plenty of parking with overnight parking allowed. Overnight parking is &#x24;10.</p>
      <p><b>Facilities: </b>There is a regular bathroom in the lower parking lot. There is a picnic area and store for snacks</p>
      <p><b>Address: </b>8095 N. Rio Blanco Rd., Stockton</p>
      <p><b>Contact Info: </b>209-952-1000, jessica@bridgebayboats.com</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.paradisemarina.com/">https://www.paradisemarina.com/</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638231593715-340-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Paradise Point marina office</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638231593716-340-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Paradise Point ramp</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638231593717-340-bask0099.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Paradise Point picnic area</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1638231593718-340-bask0099.jpg" height="400" width="300" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Paradise Point marina sign</span>
  ]]></details>
</station>
<station station_type="launch" xid="341" title="Hogback Island Access" zone="530" modtime="1639525457826" modby="petolino" edits_since="1639522946205" >
  <marker lat="38.214077" lng="-121.605888"/>
  <tide_station>243</tide_station>
  <city>697V+JJ_Walker_Landing</city>
  <details><![CDATA[
      <p><b>Overview: </b>Hogback has a 2 lane boat launch. It is open sunrise to sunset year around. It is located on an inlet just off the river.</p>
      <p><b>Parking: </b>There is plenty of parking. &#x24;5/vehicle</p>
      <p><b>Facilities: </b>4 Porta potties. Nice large, grassy picnic area and BBQs</p>
      <p><b>Address: </b>14900 Grand Island Rd., on Steamboat Slough.</p>
      <p><b>Contact Info: </b>County of Sacramento, Dept. of Regional Parks and Open Space. 916-875-7275</p>
      <p><b>Links: </b><a target="tp_details" href="https://regionalparks.saccounty.net/Parks/SacramentoRiverandDelta/Pages/HogbackIsland.aspx">https://regionalparks.saccounty.net/Parks/SacramentoRiverandDelta/Pages/HogbackIsland.aspx</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1639525457826-341-petolino.jpg" height="300" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hogback Island picnic area</span>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1639525457827-341-petolino.jpg" height="268" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>Hogback Island ramp</span>
  ]]></details>
</station>
<station station_type="destination" xid="342" title="Wreck of the USS Thompson (&quot;South Bay Wreck&quot;)" zone="531" modtime="1650150260486" modby="petolino" edits_since="1650138953292" chart_title="USS Thompson Wreck" >
  <marker lat="37.5532" lng="-122.1576"/>
  <tide_station>390</tide_station>
  <city>HR3R+7X_Hayward</city>
  <details><![CDATA[
      <p><b>Overview: </b>Navy destroyer sunk for target practice in 1944. Best seen at lower tides.</p>
      <p><b>Links: </b><a target="tp_details" href="https://en.wikipedia.org/wiki/USS_Thompson_(DD-305)">https://en.wikipedia.org/wiki/USS_Thompson_&#x28;DD-305&#x29;</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1650150260486-342-petolino.jpg" height="221" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>South Bay Wreck at zero tide</span>
  ]]></details>
</station>
<station station_type="nogo" xid="343" title="Bodega Bay Marine Lab" zone="540" modtime="1670953055349" modby="petolino" edits_since="1668124414896" >
  <outline>
    <coord lat='38.3167682' lng='-123.0710364'/>
    <coord lat='38.3155223' lng='-123.0694915'/>
    <coord lat='38.3160274' lng='-123.0686761'/>
    <coord lat='38.3168355' lng='-123.0693413'/>
    <coord lat='38.3172396' lng='-123.0703069'/>
    <coord lat='38.3172396' lng='-123.0707146'/>
  </outline>
  <marker lat="38.31724" lng="-123.070307"/>
  <tide_station>41</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Kayakers have been asked by the UC Marine Lab not to land there to avoid upsetting experiments.</p>
  ]]></details>
</station>

<station station_type="nogo" xid="345" title="Bird Rock (Tomales Point)" zone="540" modtime="1670953084509" modby="petolino" edits_since="1668125307049" >
  <outline>
    <coord lat='38.2310954' lng='-122.9947117'/>
    <coord lat='38.2304886' lng='-122.9954628'/>
    <coord lat='38.229039' lng='-122.9948405'/>
    <coord lat='38.228449' lng='-122.9929737'/>
    <coord lat='38.2294941' lng='-122.9923514'/>
    <coord lat='38.2307751' lng='-122.9928235'/>
  </outline>
  <marker lat="38.231095" lng="-122.994712"/>
  <tide_station>420</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Closed year round to visitor use. We assume this just means no landing.<p>Bird species which use this rock include storm petrels, rhinoceros aucklets, and brown pelicans.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm">Point Reyes Superintendent&#x27;s Compendium</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="347" title="Hog and Duck Islands (seasonal)" zone="540" modtime="1671040982388" modby="petolino" edits_since="1670953113237" >
  <outline>
    <coord lat='38.19773924756621' lng='-122.93537096931152'/>
    <coord lat='38.19784671928216' lng='-122.93572768728254'/>
    <coord lat='38.19772653755815' lng='-122.93600930370485'/>
    <coord lat='38.19715742664352' lng='-122.93505979814759'/>
    <coord lat='38.19688126512992' lng='-122.93472990299416'/>
    <coord lat='38.19652078626255' lng='-122.93461458650818'/>
    <coord lat='38.1959095' lng='-122.9340031'/>
    <coord lat='38.19630154002767' lng='-122.93382610489348'/>
    <coord lat='38.19640469751253' lng='-122.93403581458051'/>
    <coord lat='38.19657530874391' lng='-122.9341382364937'/>
    <coord lat='38.19680691864198' lng='-122.93411777518821'/>
    <coord lat='38.197050914948335' lng='-122.93422169271774'/>
    <coord lat='38.19726909432162' lng='-122.93430078280335'/>
    <coord lat='38.19749306324208' lng='-122.93433230978697'/>
    <coord lat='38.197721331489404' lng='-122.93411707116395'/>
    <coord lat='38.19787437899259' lng='-122.93407646931153'/>
    <coord lat='38.19795796455761' lng='-122.9340998666398'/>
    <coord lat='38.197940371181254' lng='-122.93430565428494'/>
    <coord lat='38.19793469482259' lng='-122.93451874603271'/>
    <coord lat='38.197817324426914' lng='-122.93478274281887'/>
    <coord lat='38.1977438834471' lng='-122.93493351632338'/>
    <coord lat='38.19769573700196' lng='-122.93511647605743'/>
  </outline>
  <marker lat="38.197958" lng="-122.9341"/>
  <tide_station>40</tide_station>
  <city>53X8+59_Nicks_Cove</city>
  <details><![CDATA[
      <p><b>Overview: </b>The east side of Hog Island, including the spit, and the northwest side of Duck &#x28;a.k.a. Piglet&#x29; Island are closed year round to protect harbor seals.<p>In addition, both islands are closed in their entirety from March 1 to July 30 to protect sea bird colonies.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/learn/news/newsreleases_20210301_springwildlifeprotectionclosures21.htm">https://www.nps.gov/pore/learn/news/newsreleases_20210301_springwildlifeprotectionclosures21.htm</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/learn/management/upload/lawsandpolicies_compendium_hogislandmap.pdf">NPS Hog Island map</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/upload/sitebulletin_boatingguide.pdf">NPS/State Parks Tomales Bay Boating Guide</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/kayak.htm">NPS kayaking guide</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm">Superintendent&#x27;s Compendium</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="348" title="Pelican Point" zone="540" modtime="1670953127294" modby="petolino" edits_since="1668116319290" >
  <outline>
    <coord lat='38.1869158' lng='-122.9334043'/>
    <coord lat='38.1869116' lng='-122.9334526'/>
    <coord lat='38.1862328' lng='-122.9322134'/>
    <coord lat='38.1874766' lng='-122.9319398'/>
  </outline>
  <marker lat="38.187477" lng="-122.93194"/>
  <tide_station>40</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Closed for &#x28;you guessed it&#x29; pelicans.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/upload/sitebulletin_boatingguide.pdf">NPS/State Parks Tomales Bay Boating Guide</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/kayak.htm">NPS kayaking guide</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="349" title="Point Reyes Beach (seasonal)" zone="540" modtime="1671041020268" modby="petolino" edits_since="1670953149948" >
  <outline>
    <coord lat='38.1192354' lng='-122.9581358'/>
    <coord lat='38.1201132' lng='-122.9613973'/>
    <coord lat='38.0792494' lng='-122.9786493'/>
    <coord lat='38.0781684' lng='-122.9745294'/>
  </outline>
  <marker lat="38.120113" lng="-122.961397"/>
  <tide_station>99</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>The beach is closed for snowy plover protection on weekends and federal holidays from Memorial Day weekend through Labor Day weekend. Closed area is between the North Beach parking lot and the mouth of Abbotts Lagoon.<p>Aside from the closures, note that this beach area has strong undertows and dumping waves. Not recommended for landing or launching.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/closures.htm">Closures at Point Reyes &#x28;NPS&#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="350" title="Drakes Estero and Limantour Estero (seasonal)" zone="545" modtime="1671041041275" modby="petolino" edits_since="1670952166740" >
  <outline>
    <coord lat='38.078463' lng='-122.957638'/>
    <coord lat='38.063274' lng='-122.9598896'/>
    <coord lat='38.0532207' lng='-122.9516709'/>
    <coord lat='38.0564976' lng='-122.9643298'/>
    <coord lat='38.0323704' lng='-122.9465658'/>
    <coord lat='38.0276379' lng='-122.8868277'/>
    <coord lat='38.0383195' lng='-122.8907759'/>
    <coord lat='38.0336962' lng='-122.8976598'/>
    <coord lat='38.0338075' lng='-122.9069338'/>
    <coord lat='38.0444646' lng='-122.9021318'/>
    <coord lat='38.0534753' lng='-122.909867'/>
    <coord lat='38.0343201' lng='-122.9154666'/>
    <coord lat='38.0363749' lng='-122.9294829'/>
    <coord lat='38.0465408' lng='-122.9364629'/>
    <coord lat='38.0706573' lng='-122.9157456'/>
    <coord lat='38.0754636' lng='-122.9233218'/>
    <coord lat='38.0636474' lng='-122.9296957'/>
    <coord lat='38.0815616' lng='-122.9308349'/>
    <coord lat='38.0854217' lng='-122.9343779'/>
    <coord lat='38.0778213' lng='-122.9420186'/>
    <coord lat='38.0635313' lng='-122.9493128'/>
    <coord lat='38.0736661' lng='-122.9531311'/>
  </outline>
  <marker lat="38.085422" lng="-122.934378"/>
  <tide_station>99</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Drakes Estero and Limantour Estero are closed during the seal pupping season from March 1 through June 30.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/kayak.htm">https://www.nps.gov/pore/planyourvisit/kayak.htm</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/planyourvisit/upload/map_seal_protection_closures_esteros.pdf">https://www.nps.gov/pore/planyourvisit/upload/map_seal_protection_closures_esteros.pdf</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="351" title="Drake&apos;s Beach (seasonal)" zone="545" modtime="1671041101474" modby="petolino" edits_since="1670953320043" >
  <outline>
    <coord lat='38.026994004120645' lng='-122.96251041398315'/>
    <coord lat='38.02446698503786' lng='-122.96785416792271'/>
    <coord lat='38.02172220651852' lng='-122.97192092636948'/>
    <coord lat='38.01950456050383' lng='-122.97511280569016'/>
    <coord lat='38.01805418627941' lng='-122.97649009658272'/>
    <coord lat='38.01653618336755' lng='-122.97726652903975'/>
    <coord lat='38.01549150911539' lng='-122.97855790363019'/>
    <coord lat='38.014446821720476' lng='-122.97954883280767'/>
    <coord lat='38.01312188471991' lng='-122.98022426187322'/>
    <coord lat='38.011120704547594' lng='-122.98154338344725'/>
    <coord lat='38.00852797873856' lng='-122.98304764163403'/>
    <coord lat='38.00735541144615' lng='-122.98420850862568'/>
    <coord lat='38.00118933479831' lng='-122.9849419622976'/>
    <coord lat='38.00023670565338' lng='-122.98391393120527'/>
    <coord lat='37.99786372598293' lng='-122.98383006289698'/>
    <coord lat='37.997852308549255' lng='-122.9830615290329'/>
    <coord lat='38.00051988534983' lng='-122.98251305059361'/>
    <coord lat='38.00149657569939' lng='-122.98376703414155'/>
    <coord lat='38.004802671801194' lng='-122.98318508477831'/>
    <coord lat='38.00911539367103' lng='-122.98142023932394'/>
    <coord lat='38.01341266376185' lng='-122.97780428592314'/>
    <coord lat='38.01956968420128' lng='-122.972341885907'/>
    <coord lat='38.022986121320685' lng='-122.96755028639053'/>
    <coord lat='38.02619947301462' lng='-122.96164240388846'/>
  </outline>
  <marker lat="38.026994" lng="-122.96251"/>
  <tide_station>99</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>Drakes Beach elephant seal pupping area, as delineated by signs at the westernmost end of Drakes Beach, is closed to all entry at all times of the year.<p>In addition, all of Drakes Beach, from the bluff near the southwest end of the parking lot to the year-round closed area at the westernmost end, is closed December 15 through March 31 to protect elephant seals.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm">Point Reyes Superintendent&#x27;s Compendium</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/learn/management/upload/lawsandpolicies_compendium_map_elephant_seal_protection_closures.pdf">Elephant seal closures map</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="353" title="Point Resistance Rock" zone="545" modtime="1670952180906" modby="petolino" edits_since="1668120433291" >
  <outline>
    <coord lat='37.998051648080796' lng='-122.82810958583114'/>
    <coord lat='37.99843957076279' lng='-122.82799156863449'/>
    <coord lat='37.99878725692418' lng='-122.82800940386127'/>
    <coord lat='37.999360057556814' lng='-122.82846767017301'/>
    <coord lat='37.99943326232688' lng='-122.82863847692958'/>
    <coord lat='37.99952203456019' lng='-122.82919637640468'/>
    <coord lat='37.99934448998616' lng='-122.82984547098629'/>
    <coord lat='37.99892176307991' lng='-122.83027462442867'/>
    <coord lat='37.998555144901225' lng='-122.8304261849329'/>
    <coord lat='37.99804953441504' lng='-122.8303358193135'/>
    <coord lat='37.99777292783968' lng='-122.83007018495277'/>
    <coord lat='37.997583056345015' lng='-122.82963574556797'/>
    <coord lat='37.9975758' lng='-122.8291258'/>
    <coord lat='37.99778321204566' lng='-122.82836439568756'/>
  </outline>
  <marker lat="37.999522" lng="-122.829196"/>
  <tide_station>99</tide_station>
  <city>X5XC+R8_Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>CA DFW Special Closure: stay at least 300 feet away from the rock, year-round. Note that the rock is less than 300 feet from shore at one point, so you do have to go around it.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/North-Central-California#27286590-point-resistance-rock-special-closure">https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/North-Central-California&#x23;27286590-point-resistance-rock-special-closure</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="354" title="Chimney Rock Fish Dock (seasonal)" zone="545" modtime="1671041153809" modby="petolino" edits_since="1670953359859" >
  <outline>
    <coord lat='37.9962825' lng='-122.9780251'/>
    <coord lat='37.9959824' lng='-122.9781002'/>
    <coord lat='37.9957202' lng='-122.9776871'/>
    <coord lat='37.995678' lng='-122.97714'/>
    <coord lat='37.9962445' lng='-122.9773223'/>
    <coord lat='37.9962783' lng='-122.9774296'/>
    <coord lat='37.9962487' lng='-122.9778159'/>
  </outline>
  <marker lat="37.996283" lng="-122.978025"/>
  <tide_station>99</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Closed December 15 to March 31 for elephant seals.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies.htm#CP_JUMP_113440">NPS Point Reyes laws &#x26; policies</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="356" title="Point Reyes Headlands" zone="545" modtime="1670952151346" modby="petolino" edits_since="1668119819368" >
  <outline>
    <coord lat='37.9961288601981' lng='-123.02533149719238'/>
    <coord lat='37.995289799448145' lng='-123.02558703025252'/>
    <coord lat='37.9945635069504' lng='-123.02498822977813'/>
    <coord lat='37.99396279167853' lng='-123.02366887530617'/>
    <coord lat='37.99403043272046' lng='-123.0219093461924'/>
    <coord lat='37.99411498393516' lng='-123.02128707370095'/>
    <coord lat='37.994251851832765' lng='-123.0208683013916'/>
    <coord lat='37.99367531655445' lng='-123.01976357898049'/>
    <coord lat='37.993290262556194' lng='-123.01728596778568'/>
    <coord lat='37.99282868596996' lng='-123.0167077948517'/>
    <coord lat='37.99129010180578' lng='-123.01664373270296'/>
    <coord lat='37.99111875925491' lng='-123.01523760882296'/>
    <coord lat='37.991135670176874' lng='-123.01174000826754'/>
    <coord lat='37.99142019446873' lng='-123.00816431786605'/>
    <coord lat='37.99056069664298' lng='-123.00562457171358'/>
    <coord lat='37.99029546273834' lng='-123.00001453353289'/>
    <coord lat='37.988959839641154' lng='-122.99502937834504'/>
    <coord lat='37.98935371657232' lng='-122.99184134177241'/>
    <coord lat='37.99023680368327' lng='-122.99041664545963'/>
    <coord lat='37.988871296708545' lng='-122.98576203965943'/>
    <coord lat='37.98941246085657' lng='-122.98041907930177'/>
    <coord lat='37.989051036108954' lng='-122.97688707018601'/>
    <coord lat='37.986909543209165' lng='-122.97350429181037'/>
    <coord lat='37.987064515971994' lng='-122.97001702146764'/>
    <coord lat='37.987531898359414' lng='-122.9684926520372'/>
    <coord lat='37.98672351213716' lng='-122.96331189755378'/>
    <coord lat='37.98983333333334' lng='-122.96333333333334'/>
    <coord lat='37.99073922973724' lng='-122.96988582550875'/>
    <coord lat='37.9904273622443' lng='-122.97218973446108'/>
    <coord lat='37.99091972772274' lng='-122.97297812228668'/>
    <coord lat='37.991870634326865' lng='-122.97305292443875'/>
    <coord lat='37.99262247678885' lng='-122.97388923995872'/>
    <coord lat='37.99327744655205' lng='-122.98545471686406'/>
    <coord lat='37.993052739137994' lng='-122.98642014049283'/>
    <coord lat='37.9935503041588' lng='-122.98654858660433'/>
    <coord lat='37.994005631626926' lng='-122.98814053084767'/>
    <coord lat='37.99481559598252' lng='-122.99018327057641'/>
    <coord lat='37.99435037545316' lng='-122.99339775820334'/>
    <coord lat='37.99352325270498' lng='-122.99410614114925'/>
    <coord lat='37.99352325270498' lng='-122.99479278665706'/>
    <coord lat='37.99443442983036' lng='-122.99587847696978'/>
    <coord lat='37.99457788028136' lng='-122.99789132309722'/>
    <coord lat='37.994339933960454' lng='-123.00062116184225'/>
    <coord lat='37.99366099773242' lng='-123.00307669760302'/>
    <coord lat='37.993723464258004' lng='-123.00515534642014'/>
    <coord lat='37.9946936941233' lng='-123.00594386534482'/>
    <coord lat='37.995484170788565' lng='-123.00696310402509'/>
    <coord lat='37.99600386494836' lng='-123.00851881286385'/>
    <coord lat='37.9957794637348' lng='-123.01239196121972'/>
    <coord lat='37.99432523035773' lng='-123.0144506768404'/>
    <coord lat='37.99442668984063' lng='-123.01650935449219'/>
    <coord lat='37.995373611786185' lng='-123.0209296'/>
    <coord lat='37.99515802588434' lng='-123.02177721196767'/>
    <coord lat='37.99487478798704' lng='-123.02331146134392'/>
    <coord lat='37.99517153953814' lng='-123.02392559705063'/>
    <coord lat='37.99584030873127' lng='-123.02419641582807'/>
  </outline>
  <marker lat="37.996129" lng="-123.025331"/>
  <tide_station>99</tide_station>
  <city>Inverness</city>
  <details><![CDATA[
      <p><b>Overview: </b>There are two overlapping restricted areas covering the Point Reyes Headlands:<p>1&#x29; A California Fish 7 Wildlife Special Closure, from shore to 1000 feet out, from Chimney Rock nearly to the Point Reyes Lighthouse.<p>2&#x29; A NPS closure, from shore to 300 feet out, between Chimney Rock and the Point Reyes Lighthouse.<p>Boating is prohibited year-round in both areas.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/North-Central-California#27286587-point-reyes-headlands-special-closure">CA Marine Protected Areas</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm">NPS Superintendent&#x27;s Compendium</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="357" title="Marin Islands State Marine Park" zone="530" modtime="1671212427940" modby="petolino" edits_since="1670953382979" >
  <outline>
    <coord lat='37.97543782795843' lng='-122.47481720821229'/>
    <coord lat='37.975293507066894' lng='-122.47486617315568'/>
    <coord lat='37.975174557878155' lng='-122.47496878191207'/>
    <coord lat='37.975034876989675' lng='-122.47498102286721'/>
    <coord lat='37.97503051283258' lng='-122.47531512856428'/>
    <coord lat='37.97509803470617' lng='-122.47572433578627'/>
    <coord lat='37.97503023886828' lng='-122.47589750861387'/>
    <coord lat='37.97489168408012' lng='-122.47615371599998'/>
    <coord lat='37.97468547006487' lng='-122.4764099221827'/>
    <coord lat='37.9743068700528' lng='-122.47681504286982'/>
    <coord lat='37.971030248610404' lng='-122.47686762763318'/>
    <coord lat='37.9710658159988' lng='-122.47199478915034'/>
    <coord lat='37.97489675529996' lng='-122.47200588129046'/>
    <coord lat='37.97488380536479' lng='-122.4693077617265'/>
    <coord lat='37.96824649490481' lng='-122.46933210288464'/>
    <coord lat='37.968277229314644' lng='-122.47671490894487'/>
    <coord lat='37.96626270878125' lng='-122.47671530899459'/>
    <coord lat='37.962167191557654' lng='-122.46568693914793'/>
    <coord lat='37.96342169904233' lng='-122.46474361346486'/>
    <coord lat='37.96501447331097' lng='-122.46028109945084'/>
    <coord lat='37.96748649731139' lng='-122.46200844069644'/>
    <coord lat='37.97036955609209' lng='-122.45897343157468'/>
    <coord lat='37.971851839411784' lng='-122.45879521874599'/>
    <coord lat='37.97327899986829' lng='-122.45717098711667'/>
    <coord lat='37.97554557964263' lng='-122.45644142626462'/>
  </outline>
  <marker lat="37.975546" lng="-122.456441"/>
  <current_station>307</current_station>
  <city>XGGV+6C_San_Rafael</city>
  <details><![CDATA[
      <p><b>Overview: </b>Boating is prohibited within the Park year-round.<p>This prohibited area encompasses a surprisingly large expanse of water surrounding both islands and extending to the north and east of the islands. See the map link in the DFW Marine Protected Areas website referenced below. Although we couldn&#x27;t find a precise definition of this area, we&#x27;ve made an attempt to copy its boundaries from the DFW map onto our map.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/San-Francisco-Bay#26757431-marin-islands-state-marine-park">Marine Protected Areas &#x28;CA DFW&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.fws.gov/refuge/marin-islands">https://www.fws.gov/refuge/marin-islands</a></p>
  ]]></details>
</station>


<station station_type="nogo" xid="360" title="Stormy Stack" zone="545" modtime="1670952194794" modby="petolino" edits_since="1668125820110" >
  <outline>
    <coord lat='37.9480173' lng='-122.7866164'/>
    <coord lat='37.9475435' lng='-122.7870026'/>
    <coord lat='37.9472051' lng='-122.7873567'/>
    <coord lat='37.9465029' lng='-122.7873888'/>
    <coord lat='37.9461052' lng='-122.7867773'/>
    <coord lat='37.9460206' lng='-122.7858546'/>
    <coord lat='37.9463421' lng='-122.7849212'/>
    <coord lat='37.9466844' lng='-122.7844711'/>
    <coord lat='37.9478689' lng='-122.7844068'/>
    <coord lat='37.948495' lng='-122.7854582'/>
  </outline>
  <marker lat="37.948495" lng="-122.785458"/>
  <tide_station>99</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>California DFW Special Closure area. Stay at least 300 feet from shore.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/North-Central-California#27286591-double-pointstormy-stack-rock-special-closure">CA DFW Marine Protected Areas</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="361" title="San Quentin State Prison" zone="530" modtime="1670953449012" modby="petolino" edits_since="1669927974216" >
  <outline>
    <coord lat='37.9394355' lng='-122.4948142'/>
    <coord lat='37.93965795371074' lng='-122.49684146020752'/>
    <coord lat='37.94081114067044' lng='-122.49762420173083'/>
    <coord lat='37.94215289659169' lng='-122.49914682323517'/>
    <coord lat='37.941523253764196' lng='-122.4996897435724'/>
    <coord lat='37.941477423007306' lng='-122.49921763385201'/>
    <coord lat='37.941427117459135' lng='-122.49902209471361'/>
    <coord lat='37.940988532907554' lng='-122.4986607823773'/>
    <coord lat='37.94064445355588' lng='-122.49815842341081'/>
    <coord lat='37.939768706226445' lng='-122.4976863546242'/>
    <coord lat='37.93940063539366' lng='-122.49746641348497'/>
    <coord lat='37.93918728920621' lng='-122.49717750829312'/>
    <coord lat='37.939060367433555' lng='-122.49668934625241'/>
    <coord lat='37.939022290859015' lng='-122.49619045537564'/>
    <coord lat='37.938972448913326' lng='-122.49557616048853'/>
    <coord lat='37.93879452377634' lng='-122.49544375887206'/>
    <coord lat='37.938667417833926' lng='-122.49526600059572'/>
    <coord lat='37.93822528136783' lng='-122.49402129376236'/>
    <coord lat='37.938054560483394' lng='-122.4934331880728'/>
    <coord lat='37.93804488660031' lng='-122.49294146213282'/>
    <coord lat='37.93774593359297' lng='-122.4920881991624'/>
    <coord lat='37.93708684474709' lng='-122.49120593907821'/>
    <coord lat='37.93682695175259' lng='-122.49051115256417'/>
    <coord lat='37.936682497231196' lng='-122.4897713433096'/>
    <coord lat='37.93665896672995' lng='-122.4891572311043'/>
    <coord lat='37.93669272907319' lng='-122.48887794878591'/>
    <coord lat='37.93682397038267' lng='-122.4885456874489'/>
    <coord lat='37.93714128405831' lng='-122.48803606773608'/>
    <coord lat='37.93730226390981' lng='-122.48780521630856'/>
    <coord lat='37.93757001640979' lng='-122.4874717412237'/>
    <coord lat='37.938019565255644' lng='-122.48706491953956'/>
    <coord lat='37.93826495062661' lng='-122.48694153792488'/>
    <coord lat='37.93856742605244' lng='-122.48680466877488'/>
    <coord lat='37.93891225638105' lng='-122.48664649493324'/>
    <coord lat='37.93922885740272' lng='-122.48645515893212'/>
    <coord lat='37.93950628549904' lng='-122.48585811401598'/>
    <coord lat='37.939654359980764' lng='-122.48559525753252'/>
    <coord lat='37.93987164326686' lng='-122.48490562692356'/>
    <coord lat='37.94019592601777' lng='-122.48406862274196'/>
    <coord lat='37.94045470943355' lng='-122.48384774314006'/>
    <coord lat='37.9408227942171' lng='-122.48386434337334'/>
    <coord lat='37.9412462' lng='-122.4842355'/>
    <coord lat='37.94104948822459' lng='-122.48460029455008'/>
    <coord lat='37.940531248803566' lng='-122.48475050987385'/>
    <coord lat='37.93954551834025' lng='-122.48713230370484'/>
    <coord lat='37.93831432167958' lng='-122.48770094379756'/>
    <coord lat='37.937133887014355' lng='-122.48927805767211'/>
    <coord lat='37.93727351404111' lng='-122.49035094108588'/>
    <coord lat='37.9377516' lng='-122.4911878'/>
    <coord lat='37.93851733067321' lng='-122.49159553491822'/>
    <coord lat='37.938904480373395' lng='-122.49161699812745'/>
    <coord lat='37.9393593214756' lng='-122.49189595396727'/>
  </outline>
  <marker lat="37.942153" lng="-122.499147"/>
  <tide_station>304</tide_station>
  <city>San_Quentin</city>
  <details><![CDATA[
      <p><b>Overview: </b>Although we couldn&#x27;t find an online reference for this restriction, it would be wise to stay away from the beach and riprap immediately in front of the State Prison. Keep offshore &#x28;100 feet&#x3F;&#x29;.<p>There&#x27;s a very nice public beach just to the east &#x28;San Quentin Beach&#x29;, and a smaller beach &#x28;Windsurfer&#x29; to the west. You can land at either of these instead.</p>
  ]]></details>
</station>



<station station_type="nogo" xid="365" title="Brooks Island" zone="530" modtime="1670953402731" modby="petolino" edits_since="1666997237831" >
  <outline>
    <coord lat='37.9005114' lng='-122.3652527'/>
    <coord lat='37.8996309' lng='-122.3624417'/>
    <coord lat='37.8999188' lng='-122.3621842'/>
    <coord lat='37.8977345' lng='-122.3578069'/>
    <coord lat='37.8953978' lng='-122.3575279'/>
    <coord lat='37.8948772' lng='-122.3561868'/>
    <coord lat='37.8948454' lng='-122.3550871'/>
    <coord lat='37.8947121' lng='-122.3542449'/>
    <coord lat='37.894657' lng='-122.3530969'/>
    <coord lat='37.8940792' lng='-122.35145'/>
    <coord lat='37.8942464' lng='-122.3514554'/>
    <coord lat='37.8955756' lng='-122.3520026'/>
    <coord lat='37.8968371' lng='-122.3530218'/>
    <coord lat='37.8993262' lng='-122.3554251'/>
    <coord lat='37.9010532' lng='-122.3579571'/>
    <coord lat='37.9003421' lng='-122.3576138'/>
    <coord lat='37.8996309' lng='-122.3586008'/>
    <coord lat='37.900122' lng='-122.3603818'/>
    <coord lat='37.9001728' lng='-122.362077'/>
    <coord lat='37.9017982' lng='-122.3735783'/>
    <coord lat='37.9037961' lng='-122.39171'/>
    <coord lat='37.9036268' lng='-122.3916671'/>
    <coord lat='37.9013749' lng='-122.3733208'/>
    <coord lat='37.8999865' lng='-122.3708317'/>
    <coord lat='37.9010702' lng='-122.370542'/>
  </outline>
  <marker lat="37.903796" lng="-122.39171"/>
  <current_station>301</current_station>
  <details><![CDATA[
      <p><b>Overview: </b>No landing. Presumably this includes getting stuck in the mud which encircles it. From the website: &#x22;Access to Brooks Island Regional Preserve is by reservation only&#x22;. The island, particularly the northwest breakwater, is usually inhabited by many birds. Please stay offshore so that they are not disturbed &#x28;otherwise additional restrictions are likely&#x29;.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ebparks.org/parks/brooks-island#maps">https://www.ebparks.org/parks/brooks-island&#x23;maps</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="366" title="Richardson Bay (seasonal)" zone="530" modtime="1671040343740" modby="petolino" edits_since="1670952223258" >
  <outline>
    <coord lat='37.8942711' lng='-122.5001751'/>
    <coord lat='37.8768278' lng='-122.4932228'/>
    <coord lat='37.8734402' lng='-122.4839531'/>
    <coord lat='37.8839749' lng='-122.4722801'/>
    <coord lat='37.8872265' lng='-122.4755846'/>
    <coord lat='37.8890554' lng='-122.478932'/>
    <coord lat='37.8898683' lng='-122.4812923'/>
    <coord lat='37.8906473' lng='-122.4836526'/>
    <coord lat='37.8932889' lng='-122.4865709'/>
    <coord lat='37.8951516' lng='-122.4878154'/>
    <coord lat='37.8954902' lng='-122.490562'/>
    <coord lat='37.8944404' lng='-122.4933086'/>
  </outline>
  <marker lat="37.89549" lng="-122.490562"/>
  <tide_station>367</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>The Richardson Bay Audubon Center and Sanctuary waters are closed to boat traffic and in-water activities including kayaking and paddle boarding from October 1st through March 31st each winter. Seasonal buoys mark the outer corners.</p>
      <p><b>Links: </b><a target="tp_details" href="https://richardsonbay.audubon.org/conservation/sanctuary-boat-closure">https://richardsonbay.audubon.org/conservation/sanctuary-boat-closure</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="367" title="Coast Guard Station Golden Gate" zone="530" modtime="1670952456129" modby="petolino" edits_since="1668122583130" >
  <outline>
    <coord lat='37.8329427' lng='-122.4777229'/>
    <coord lat='37.8324808' lng='-122.4777175'/>
    <coord lat='37.8322944' lng='-122.4773849'/>
    <coord lat='37.8323537' lng='-122.4770148'/>
    <coord lat='37.8325698' lng='-122.4768378'/>
    <coord lat='37.8329596' lng='-122.4773098'/>
  </outline>
  <marker lat="37.83296" lng="-122.47731"/>
  <current_station>131</current_station>
  <details><![CDATA[
      <p><b>Overview: </b>The docks are closed to the public. Don&#x27;t get in their way&#x21;</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">GGNRA Superintendent&#x27;s Compendium Exhibits &#x28;see Exhibit 2&#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="368" title="Rodeo Lagoon and inlet" zone="530" modtime="1670952578984" modby="petolino" edits_since="1669832958345" >
  <outline>
    <coord lat='37.8317783' lng='-122.5393523'/>
    <coord lat='37.8314139' lng='-122.5374104'/>
    <coord lat='37.8310326' lng='-122.5362087'/>
    <coord lat='37.829609' lng='-122.5347711'/>
    <coord lat='37.8290158' lng='-122.5336875'/>
    <coord lat='37.831075' lng='-122.525673'/>
    <coord lat='37.8326511' lng='-122.5266279'/>
    <coord lat='37.8315834' lng='-122.5368954'/>
    <coord lat='37.8319054' lng='-122.5395454'/>
  </outline>
  <marker lat="37.832651" lng="-122.526628"/>
  <tide_station>288</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Lagoon and its seasonal inlet are off limits.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-signed.pdf">GGNRA Superintendent&#x27;s Compendium &#x28;see 36 CFR &#xA7;1.5&#x28;a&#x29;&#x28;2&#x29;&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">GGNRA Superintendent&#x27;s Compendium Exhibits &#x28;see Exhibit 3A &#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="369" title="Alcatraz Island (seasonal)" zone="530" modtime="1671040472594" modby="petolino" edits_since="1670952348401" >
  <outline>
    <coord lat='37.8291469' lng='-122.4255524'/>
    <coord lat='37.8278253' lng='-122.4266676'/>
    <coord lat='37.8263677' lng='-122.425466'/>
    <coord lat='37.8254864' lng='-122.4241356'/>
    <coord lat='37.8245033' lng='-122.4226336'/>
    <coord lat='37.8244694' lng='-122.4213032'/>
    <coord lat='37.8245711' lng='-122.4202303'/>
    <coord lat='37.8259949' lng='-122.4193291'/>
    <coord lat='37.826944' lng='-122.4198441'/>
    <coord lat='37.8280626' lng='-122.4211315'/>
    <coord lat='37.828774' lng='-122.4227632'/>
    <coord lat='37.8290113' lng='-122.4232779'/>
    <coord lat='37.8291807' lng='-122.4245653'/>
  </outline>
  <marker lat="37.829181" lng="-122.424565"/>
  <current_station>16</current_station>
  <details><![CDATA[
      <p><b>Overview: </b>Seasonal closure: stay at least 300 feet from shore Feb. 1 to Sept. 30.<p>Landing is not allowed on the island at any time.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-signed.pdf">GGNRA Superintendent&#x27;s Compendium</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="370" title="Bird Rock" zone="545" modtime="1670952596848" modby="petolino" edits_since="1668123590241" >
  <outline>
    <coord lat='37.82517812224949' lng='-122.53708459366652'/>
    <coord lat='37.82509607833707' lng='-122.53730701570007'/>
    <coord lat='37.825074119953726' lng='-122.53789868561633'/>
    <coord lat='37.824687887267' lng='-122.53848336384581'/>
    <coord lat='37.82425568092209' lng='-122.53883741543578'/>
    <coord lat='37.82382347204598' lng='-122.53889105961608'/>
    <coord lat='37.82312006787513' lng='-122.53851555035399'/>
    <coord lat='37.82264146394' lng='-122.53770583906683'/>
    <coord lat='37.82264996887609' lng='-122.53725514117777'/>
    <coord lat='37.823052269528546' lng='-122.53657363102721'/>
    <coord lat='37.82310311829431' lng='-122.5362839524536'/>
    <coord lat='37.823123769087026' lng='-122.53594593509237'/>
    <coord lat='37.82336583635946' lng='-122.53531835720824'/>
    <coord lat='37.824594622364614' lng='-122.53528965026247'/>
    <coord lat='37.8249632341676' lng='-122.53547417891886'/>
    <coord lat='37.82509036745833' lng='-122.5356349371964'/>
    <coord lat='37.825200523316546' lng='-122.53588187981272'/>
    <coord lat='37.82531929443782' lng='-122.53627856337928'/>
    <coord lat='37.825331869043055' lng='-122.5365556558197'/>
  </outline>
  <marker lat="37.825332" lng="-122.536556"/>
  <tide_station>288</tide_station>
  <city>RFG7+49_Tamalpais-Homestead_Valley</city>
  <details><![CDATA[
      <p><b>Overview: </b>Bird Rock: All waters within 300 ft. of Bird Rock are closed to boating for the protection of nesting and roosting seabirds and sensitive intertidal areas.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">GGNRA Superintendent&#x27;s Compendium Exhibits &#x28;see Exhibit 6 &#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="371" title="Golden Gate Bridge" zone="530" modtime="1670952492017" modby="petolino" edits_since="1668041776363" >
  <outline>
    <coord lat='37.81124630065886' lng='-122.47732236388016'/>
    <coord lat='37.8110425198459' lng='-122.4779607296257'/>
    <coord lat='37.81073415402611' lng='-122.47794207919627'/>
    <coord lat='37.81053306535285' lng='-122.47779979708481'/>
    <coord lat='37.811036526284056' lng='-122.47690930369187'/>
    <coord lat='37.81122232647479' lng='-122.47696294787217'/>
  </outline>
  <outline>
    <coord lat='37.81448873733341' lng='-122.47769250872422'/>
    <coord lat='37.81442880449069' lng='-122.4774189234047'/>
    <coord lat='37.81411471823199' lng='-122.4771210231107'/>
    <coord lat='37.8137815266891' lng='-122.4773116350441'/>
    <coord lat='37.813643679757654' lng='-122.47766032221604'/>
    <coord lat='37.81360172629262' lng='-122.47800364496995'/>
    <coord lat='37.81366165980677' lng='-122.47827723028946'/>
    <coord lat='37.81378152668907' lng='-122.47850253584672'/>
    <coord lat='37.81404433474035' lng='-122.4786547388235'/>
    <coord lat='37.814254998971656' lng='-122.47855081560898'/>
    <coord lat='37.81435802208971' lng='-122.47842907905579'/>
    <coord lat='37.81444184806541' lng='-122.47796251313906'/>
  </outline>
  <outline>
    <coord lat='37.82530696231715' lng='-122.47968466582083'/>
    <coord lat='37.82565288938275' lng='-122.47972973729503'/>
    <coord lat='37.82578335685811' lng='-122.4786895662763'/>
    <coord lat='37.82552568472096' lng='-122.47868420185827'/>
    <coord lat='37.82521108379879' lng='-122.47886659207128'/>
    <coord lat='37.82514516724517' lng='-122.47939766945623'/>
  </outline>
  <marker lat="37.825783" lng="-122.47869"/>
  <current_station>131</current_station>
  <city>RGGC+8G_Sausalito</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stay at least 25 yards away from all piers, abutments, fenders, and pilings.<p>In addition, if the Homeland Security National Threat Level reaches either Elevated or Imminent, DHS forbids loitering below the bridge or boating near the shoreline of Fort Point or Fort Baker. See link below.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.govinfo.gov/content/pkg/CFR-2012-title33-vol2/pdf/CFR-2012-title33-vol2-sec165-1190.pdf">Security zones. See &#xA7;165.1187</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/2021-GOGA-Superintendent-s-Compendium.pdf">Homeland Security Elevated/Imminent Rules. See pg 12.</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="372" title="Bonita Cove" zone="530" modtime="1670952548401" modby="petolino" edits_since="1669832684331" >
  <outline>
    <coord lat='37.816233113070425' lng='-122.5283985685089'/>
    <coord lat='37.81656365995786' lng='-122.52747052418975'/>
    <coord lat='37.81690952681475' lng='-122.52773824556809'/>
    <coord lat='37.81722229354881' lng='-122.52762478923644'/>
    <coord lat='37.81788583270674' lng='-122.52782457577972'/>
    <coord lat='37.81828600010634' lng='-122.52804269621357'/>
    <coord lat='37.818487582975074' lng='-122.52823763596801'/>
    <coord lat='37.81858685083219' lng='-122.52839691214241'/>
    <coord lat='37.8187563486979' lng='-122.52841308604965'/>
    <coord lat='37.81890287255283' lng='-122.5282537292221'/>
    <coord lat='37.81939203455446' lng='-122.52797654078454'/>
    <coord lat='37.81964325377496' lng='-122.52795688466563'/>
    <coord lat='37.81986904742727' lng='-122.52798014390258'/>
    <coord lat='37.82011289682671' lng='-122.52755918495056'/>
    <coord lat='37.82027161655909' lng='-122.52742224442748'/>
    <coord lat='37.82030625947871' lng='-122.52715642696533'/>
    <coord lat='37.82006945139181' lng='-122.52655042737612'/>
    <coord lat='37.82011482673723' lng='-122.52587192761688'/>
    <coord lat='37.820339417460026' lng='-122.52546959626464'/>
    <coord lat='37.820580957663324' lng='-122.52502434956817'/>
    <coord lat='37.82104284813189' lng='-122.52450400101928'/>
    <coord lat='37.821500498222434' lng='-122.52445572125701'/>
    <coord lat='37.82166817972029' lng='-122.52426018890682'/>
    <coord lat='37.82176745946479' lng='-122.52408021199493'/>
    <coord lat='37.822458164229836' lng='-122.52314143883972'/>
    <coord lat='37.8227589' lng='-122.5241635'/>
    <coord lat='37.822713073985355' lng='-122.5245973113404'/>
    <coord lat='37.822506225123625' lng='-122.52480581602408'/>
    <coord lat='37.8226189091507' lng='-122.52500394539406'/>
    <coord lat='37.822638369042906' lng='-122.52541665203202'/>
    <coord lat='37.82258406509133' lng='-122.52560906322937'/>
    <coord lat='37.822412978553125' lng='-122.52557889200114'/>
    <coord lat='37.82230969102358' lng='-122.52552726322682'/>
    <coord lat='37.82214284193568' lng='-122.52535225275871'/>
    <coord lat='37.82201836731267' lng='-122.52566003965124'/>
    <coord lat='37.82181285331506' lng='-122.5258504879288'/>
    <coord lat='37.82155780991272' lng='-122.5257200666819'/>
    <coord lat='37.821379041200366' lng='-122.52578276468313'/>
    <coord lat='37.82119100356231' lng='-122.52591888903447'/>
    <coord lat='37.82121325281171' lng='-122.52629842456635'/>
    <coord lat='37.82104057622748' lng='-122.52640437390687'/>
    <coord lat='37.82122384999501' lng='-122.52673562883605'/>
    <coord lat='37.821117915497176' lng='-122.52805261476499'/>
    <coord lat='37.82070051807481' lng='-122.52839996749785'/>
    <coord lat='37.82056279676729' lng='-122.52868294484404'/>
    <coord lat='37.82013265252209' lng='-122.52906112618038'/>
    <coord lat='37.81977031138912' lng='-122.52916571468049'/>
    <coord lat='37.81948851862038' lng='-122.52910401573719'/>
    <coord lat='37.81927452738519' lng='-122.52938563880923'/>
    <coord lat='37.81879993182354' lng='-122.52949290978698'/>
    <coord lat='37.81848423894154' lng='-122.52950633168994'/>
    <coord lat='37.81813040722675' lng='-122.52957876175925'/>
    <coord lat='37.817954557533035' lng='-122.52922204030735'/>
    <coord lat='37.81777975948993' lng='-122.52895516763307'/>
    <coord lat='37.81750325617644' lng='-122.5287848558197'/>
    <coord lat='37.817293473997296' lng='-122.52873792192837'/>
    <coord lat='37.817176921767405' lng='-122.5289592085532'/>
    <coord lat='37.81706247354948' lng='-122.52910137420503'/>
    <coord lat='37.81665686278278' lng='-122.52884521216328'/>
    <coord lat='37.81644618873395' lng='-122.52879826451158'/>
    <coord lat='37.81617740049851' lng='-122.52860781173224'/>
  </outline>
  <marker lat="37.822759" lng="-122.524163"/>
  <tide_station>288</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>Because seals. Point Bonita Cove and tide pools and marine area 300 ft. offshore are closed to boating due to marine mammal habitat and haul-out area.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-signed.pdf">GGNRA Superintendent&#x27;s Compendium &#x28;see 36 CFR &#xA7;1.5&#x28;a&#x29;&#x28;2&#x29;&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">GGNRA Superintendent&#x27;s Compendium Exhibits &#x28;see Exhibit 6 &#x29;</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="374" title="Yerba Buena Coast Guard Station" zone="531" modtime="1670952314394" modby="petolino" edits_since="1668126228974" >
  <outline>
    <coord lat='37.807500000000005' lng='-122.3622222222222'/>
    <coord lat='37.807500000000005' lng='-122.35972222222222'/>
    <coord lat='37.8136111111111' lng='-122.35972222222222'/>
    <coord lat='37.81243933564957' lng='-122.36129140416573'/>
    <coord lat='37.81072508660496' lng='-122.36161600411371'/>
    <coord lat='37.80906168528742' lng='-122.3612753896237'/>
  </outline>
  <marker lat="37.813611" lng="-122.359722"/>
  <tide_station>450</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stay out of the indicated area.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.govregs.com/regulations/title33_chapterII_part334_section334.1065">https://www.govregs.com/regulations/title33_chapterII_part334_section334.1065</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="375" title="Crissy Field Wildlife Protection Area" zone="530" modtime="1670952395929" modby="petolino" edits_since="1667430739772" >
  <outline>
    <coord lat='37.806093004495025' lng='-122.46355624864538'/>
    <coord lat='37.80642686789096' lng='-122.46428227409754'/>
    <coord lat='37.80667952436578' lng='-122.46499154896414'/>
    <coord lat='37.80680928591072' lng='-122.46564300725896'/>
    <coord lat='37.80697034231373' lng='-122.46602388093908'/>
    <coord lat='37.80720092799521' lng='-122.46646132629239'/>
    <coord lat='37.80743817525555' lng='-122.46704076337411'/>
    <coord lat='37.80759263822067' lng='-122.46762456706075'/>
    <coord lat='37.807696283677984' lng='-122.46819540175541'/>
    <coord lat='37.80774015435747' lng='-122.46823575722074'/>
    <coord lat='37.808193760564' lng='-122.46850413276832'/>
    <coord lat='37.808360498770455' lng='-122.46867390344579'/>
    <coord lat='37.80878090437006' lng='-122.46927895724458'/>
    <coord lat='37.808940667036204' lng='-122.4695440453996'/>
    <coord lat='37.80903437617147' lng='-122.46948929498632'/>
    <coord lat='37.809271715175335' lng='-122.47006865213353'/>
    <coord lat='37.8085182247054' lng='-122.4706033387695'/>
    <coord lat='37.80788255120342' lng='-122.46973688656708'/>
    <coord lat='37.80752021057099' lng='-122.46934389975586'/>
    <coord lat='37.80713243909471' lng='-122.46901528962599'/>
    <coord lat='37.80675420163954' lng='-122.46886906368024'/>
    <coord lat='37.80639291728245' lng='-122.46867992406949'/>
    <coord lat='37.80637655904448' lng='-122.46857566446133'/>
    <coord lat='37.80636751998339' lng='-122.46847737571875'/>
    <coord lat='37.80641547050829' lng='-122.46840545371396'/>
    <coord lat='37.806443684086744' lng='-122.46831853069301'/>
    <coord lat='37.80644222913033' lng='-122.46822624322157'/>
    <coord lat='37.80641521745285' lng='-122.46805289490932'/>
    <coord lat='37.80634370257642' lng='-122.46789295653357'/>
    <coord lat='37.806276425895504' lng='-122.46777593376231'/>
    <coord lat='37.806157816206344' lng='-122.46772220697162'/>
    <coord lat='37.80608049824856' lng='-122.46764438161735'/>
    <coord lat='37.8060074186012' lng='-122.46755046318388'/>
    <coord lat='37.80598201949136' lng='-122.46749275549519'/>
    <coord lat='37.80548191947964' lng='-122.46664111717345'/>
    <coord lat='37.805651486912005' lng='-122.46632860476956'/>
    <coord lat='37.80490343357045' lng='-122.46454087314945'/>
    <coord lat='37.805354115043016' lng='-122.46400297290593'/>
  </outline>
  <marker lat="37.809272" lng="-122.470069"/>
  <tide_station>350</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Closed to all vessels, including kayaks. From Torpedo Wharf eastward a little less than 1/2 mile, 300 feet offshore. See area on the map.<p>Note: the NPS map &#x28;see Exhibit 63 in link below&#x29; labels this area with &#x22;Seasonal Restriction July 1 - May 15&#x22;, but that apparently refers to unleashed dogs on the beach. As far as we can tell, the boating restriction is in effect year-round.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/goga/learn/management/lawsandpolicies.htm">GGNRA Laws and Policies</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/2021-GOGA-Superintendent-s-Compendium.pdf">Compendium 2021. See 36 CFR &#xA7;1.5&#x28;a&#x29;&#x28;2&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.nps.gov/goga/learn/management/upload/508_2020-GOGA-Compendium-Exhibits_sm.pdf">See Exhibit 63 in this document</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="376" title="Farallon Islands" zone="545" modtime="1670952629865" modby="petolino" edits_since="1668123697969" >
  <outline>
    <coord lat='37.70368391607428' lng='-123.00602551530491'/>
    <coord lat='37.7039895009298' lng='-123.00555344651829'/>
    <coord lat='37.70395767497606' lng='-123.0046033859253'/>
    <coord lat='37.703940698065395' lng='-123.00331592559814'/>
    <coord lat='37.70406802480054' lng='-123.00304234027863'/>
    <coord lat='37.70413401103109' lng='-123.00288027620655'/>
    <coord lat='37.70409813582329' lng='-123.00273966974514'/>
    <coord lat='37.704060138775404' lng='-123.00258565339341'/>
    <coord lat='37.703992332075025' lng='-123.00250864601192'/>
    <coord lat='37.70384807919293' lng='-123.002518422214'/>
    <coord lat='37.70368257996117' lng='-123.00257695395018'/>
    <coord lat='37.7036338650101' lng='-123.00257856546847'/>
    <coord lat='37.7035311905731' lng='-123.00259929720436'/>
    <coord lat='37.703167618391326' lng='-123.00286951775064'/>
    <coord lat='37.70290519061678' lng='-123.00310655032533'/>
    <coord lat='37.70263002896352' lng='-123.0035474283851'/>
    <coord lat='37.70234320575255' lng='-123.00397147171785'/>
    <coord lat='37.70209882282109' lng='-123.00462081740602'/>
    <coord lat='37.70192994332373' lng='-123.00457534409047'/>
    <coord lat='37.70199875702963' lng='-123.0042938407824'/>
    <coord lat='37.7018953203225' lng='-123.00411332989755'/>
    <coord lat='37.70194467953474' lng='-123.00383625949769'/>
    <coord lat='37.70165449141381' lng='-123.00384886903174'/>
    <coord lat='37.70142722213428' lng='-123.0038303293904'/>
    <coord lat='37.70129332902138' lng='-123.00395126444283'/>
    <coord lat='37.70121229518627' lng='-123.0042360489878'/>
    <coord lat='37.70104020248575' lng='-123.00412094897915'/>
    <coord lat='37.70083415455344' lng='-123.00404876479247'/>
    <coord lat='37.70074947869708' lng='-123.00392111368768'/>
    <coord lat='37.70080062378884' lng='-123.00379346264063'/>
    <coord lat='37.70071016165935' lng='-123.00371327845212'/>
    <coord lat='37.70060696620198' lng='-123.0036545521347'/>
    <coord lat='37.70069849754496' lng='-123.00342616445282'/>
    <coord lat='37.70084045479221' lng='-123.00337022404935'/>
    <coord lat='37.70087307084801' lng='-123.00324833817469'/>
    <coord lat='37.70073964753805' lng='-123.00314869774238'/>
    <coord lat='37.7007408466794' lng='-123.00305596249639'/>
    <coord lat='37.700694757691444' lng='-123.00297740856078'/>
    <coord lat='37.700459492210506' lng='-123.00305614894958'/>
    <coord lat='37.70027394857909' lng='-123.00309551902089'/>
    <coord lat='37.70014358269574' lng='-123.00300614315108'/>
    <coord lat='37.70019723782387' lng='-123.00284712355196'/>
    <coord lat='37.70036124834012' lng='-123.00281684970763'/>
    <coord lat='37.700219740092756' lng='-123.00269528722069'/>
    <coord lat='37.700222542616174' lng='-123.00250398762802'/>
    <coord lat='37.700522455232665' lng='-123.00269892563315'/>
    <coord lat='37.700635613128284' lng='-123.00263100748292'/>
    <coord lat='37.700577551630936' lng='-123.0025219929376'/>
    <coord lat='37.700357521634004' lng='-123.00245675701997'/>
    <coord lat='37.70021779547476' lng='-123.0024295036474'/>
    <coord lat='37.700213891345534' lng='-123.00233787737365'/>
    <coord lat='37.70053574096807' lng='-123.00224334371487'/>
    <coord lat='37.70067381486308' lng='-123.00220917017823'/>
    <coord lat='37.700738353009626' lng='-123.00213094781529'/>
    <coord lat='37.70070631615974' lng='-123.00197501654813'/>
    <coord lat='37.700679011122915' lng='-123.00185287755811'/>
    <coord lat='37.70069174436654' lng='-123.00174022477948'/>
    <coord lat='37.7008308426115' lng='-123.00180710586076'/>
    <coord lat='37.7008530319299' lng='-123.00177509349668'/>
    <coord lat='37.7008676072896' lng='-123.00173666213462'/>
    <coord lat='37.70078504726505' lng='-123.00171196460724'/>
    <coord lat='37.700861799861556' lng='-123.0016037261887'/>
    <coord lat='37.70088226462808' lng='-123.00157047127993'/>
    <coord lat='37.70086639748469' lng='-123.00151694533527'/>
    <coord lat='37.7008466653222' lng='-123.00147468608701'/>
    <coord lat='37.70080385124906' lng='-123.00147229806852'/>
    <coord lat='37.700833333333335' lng='-123.00116666666666'/>
    <coord lat='37.700833333333335' lng='-123.00116666666666'/>
    <coord lat='37.700811265946506' lng='-123.00008775589583'/>
    <coord lat='37.70012715523245' lng='-122.99891229699742'/>
    <coord lat='37.6993631509246' lng='-122.99824710916172'/>
    <coord lat='37.69812908509839' lng='-122.99876377937959'/>
    <coord lat='37.69717324744627' lng='-122.99863903735194'/>
    <coord lat='37.69716666666667' lng='-122.99966666666667'/>
    <coord lat='37.69709462893574' lng='-122.99958250615147'/>
    <coord lat='37.69705169077375' lng='-122.99954930973759'/>
    <coord lat='37.69700660122403' lng='-122.99953013625324'/>
    <coord lat='37.696996018742574' lng='-122.99960194399924'/>
    <coord lat='37.69693556089002' lng='-122.99960640504518'/>
    <coord lat='37.69687418399326' lng='-122.99956940802257'/>
    <coord lat='37.69682408211717' lng='-122.99958792299982'/>
    <coord lat='37.69684106065768' lng='-122.99965766043421'/>
    <coord lat='37.69686876948552' lng='-122.99974354483791'/>
    <coord lat='37.69682467700919' lng='-122.99976087576208'/>
    <coord lat='37.696780584530316' lng='-122.99977820666562'/>
    <coord lat='37.696854461472064' lng='-122.99981308816668'/>
    <coord lat='37.69692833840355' lng='-122.99984796973722'/>
    <coord lat='37.697046469762604' lng='-122.99992314582352'/>
    <coord lat='37.69721568069351' lng='-123.00012697270417'/>
    <coord lat='37.69732692267597' lng='-123.000166664194'/>
    <coord lat='37.697367451558655' lng='-123.0002275282946'/>
    <coord lat='37.69733436591792' lng='-123.00033219978567'/>
    <coord lat='37.69725261694816' lng='-123.00033535588913'/>
    <coord lat='37.69715817361081' lng='-123.00028440481069'/>
    <coord lat='37.697026059521704' lng='-123.0002857514495'/>
    <coord lat='37.69698600733073' lng='-123.00022741038329'/>
    <coord lat='37.696974593234145' lng='-123.0001583522117'/>
    <coord lat='37.696600404675415' lng='-122.99992882403056'/>
    <coord lat='37.69649641054552' lng='-122.99990468397745'/>
    <coord lat='37.696299034024904' lng='-122.99973302277247'/>
    <coord lat='37.6962233247944' lng='-122.99969768059213'/>
    <coord lat='37.696162124505165' lng='-122.99972024263963'/>
    <coord lat='37.696066966803244' lng='-122.99977767330014'/>
    <coord lat='37.696033741896855' lng='-122.99979471434636'/>
    <coord lat='37.69600296817516' lng='-122.99981080758552'/>
    <coord lat='37.695976969603606' lng='-122.9999100492488'/>
    <coord lat='37.69597458194777' lng='-123.00003477183682'/>
    <coord lat='37.695935185864954' lng='-123.00010249748043'/>
    <coord lat='37.695909120768285' lng='-123.00013904244898'/>
    <coord lat='37.695878810932015' lng='-123.00024800690333'/>
    <coord lat='37.69581618511138' lng='-123.00033414110075'/>
    <coord lat='37.69588426538513' lng='-123.00041679578493'/>
    <coord lat='37.69596083498761' lng='-123.00049945062972'/>
    <coord lat='37.69606728260057' lng='-123.00055747217343'/>
    <coord lat='37.69613161387208' lng='-123.00067351560554'/>
    <coord lat='37.69628574452395' lng='-123.00076076380894'/>
    <coord lat='37.696285213995594' lng='-123.00080444606796'/>
    <coord lat='37.69625947510124' lng='-123.00082923531238'/>
    <coord lat='37.69611900029411' lng='-123.00076959356181'/>
    <coord lat='37.69605937489945' lng='-123.00072099734601'/>
    <coord lat='37.69593193461545' lng='-123.00060818644677'/>
    <coord lat='37.69573875154768' lng='-123.00051691245937'/>
    <coord lat='37.69565701666422' lng='-123.00050614416098'/>
    <coord lat='37.69558006929714' lng='-123.0005168531904'/>
    <coord lat='37.69553310623179' lng='-123.0005356186564'/>
    <coord lat='37.69546293287686' lng='-123.00060669213399'/>
    <coord lat='37.6954002555179' lng='-123.00064222877126'/>
    <coord lat='37.69541136400076' lng='-123.00076728539457'/>
    <coord lat='37.69537234867166' lng='-123.00079494496329'/>
    <coord lat='37.6953556262116' lng='-123.00079639944092'/>
    <coord lat='37.695326966251635' lng='-123.0008091934522'/>
    <coord lat='37.69466666666667' lng='-123.00116666666666'/>
    <coord lat='37.69466666666667' lng='-123.00116666666666'/>
    <coord lat='37.69462000501657' lng='-123.00193932948257'/>
    <coord lat='37.69352305360207' lng='-123.00161807158871'/>
    <coord lat='37.69271655709021' lng='-123.00285198818872'/>
    <coord lat='37.692309048376785' lng='-123.00416090618799'/>
    <coord lat='37.69266434037311' lng='-123.00504684285119'/>
    <coord lat='37.69348761849928' lng='-123.0053921845189'/>
    <coord lat='37.69453333952147' lng='-123.00398924481104'/>
    <coord lat='37.694824262051206' lng='-123.00280262514428'/>
    <coord lat='37.69552114377358' lng='-123.00436976409688'/>
    <coord lat='37.69597951723707' lng='-123.00512218762665'/>
    <coord lat='37.696149211811466' lng='-123.00606426352917'/>
    <coord lat='37.69650579307563' lng='-123.0065386456183'/>
    <coord lat='37.69677659164416' lng='-123.0073555154123'/>
    <coord lat='37.696884327178715' lng='-123.00848241876255'/>
    <coord lat='37.69669094311361' lng='-123.00905117477112'/>
    <coord lat='37.696657096370735' lng='-123.00984495079827'/>
    <coord lat='37.69623914028186' lng='-123.01002737115513'/>
    <coord lat='37.69592738004616' lng='-123.01057440061349'/>
    <coord lat='37.69596252919288' lng='-123.01147370057329'/>
    <coord lat='37.69606088424648' lng='-123.01220532048123'/>
    <coord lat='37.696470480131076' lng='-123.01286458969116'/>
    <coord lat='37.69692890154686' lng='-123.01342248916626'/>
    <coord lat='37.69748919053911' lng='-123.01355123519897'/>
    <coord lat='37.697940609404704' lng='-123.0142062206411'/>
    <coord lat='37.69908514203565' lng='-123.0145812034607'/>
    <coord lat='37.699736665125506' lng='-123.01485534738194'/>
    <coord lat='37.70049264386397' lng='-123.01475266251728'/>
    <coord lat='37.701458411897384' lng='-123.0138335698087'/>
    <coord lat='37.70162600067325' lng='-123.01323793314835'/>
    <coord lat='37.701521670405285' lng='-123.0127155310053'/>
    <coord lat='37.701140412973295' lng='-123.01216145933674'/>
    <coord lat='37.70111403165838' lng='-123.01171735454541'/>
    <coord lat='37.70082655836445' lng='-123.01098983604709'/>
    <coord lat='37.70066195356308' lng='-123.01013465951573'/>
    <coord lat='37.7002884440242' lng='-123.0097698790897'/>
    <coord lat='37.70003377735051' lng='-123.00935145448338'/>
    <coord lat='37.69986283390529' lng='-123.00890731935064'/>
    <coord lat='37.699582691540776' lng='-123.0081590206449'/>
    <coord lat='37.70008471075524' lng='-123.00754901002537'/>
    <coord lat='37.70020355523018' lng='-123.00666924546849'/>
    <coord lat='37.70077244272562' lng='-123.00642279250101'/>
    <coord lat='37.7015854618987' lng='-123.00618452089724'/>
    <coord lat='37.70219154722047' lng='-123.0061025758358'/>
    <coord lat='37.7031765572856' lng='-123.00638395437643'/>
  </outline>
  <outline>
    <coord lat='37.76825458598968' lng='-123.10058940728085'/>
    <coord lat='37.767957747395215' lng='-123.10138334114926'/>
    <coord lat='37.76768635106614' lng='-123.10175885041134'/>
    <coord lat='37.76707990142651' lng='-123.10204319949513'/>
    <coord lat='37.766275163668105' lng='-123.10146325386536'/>
    <coord lat='37.76574414201875' lng='-123.1000207789697'/>
    <coord lat='37.765269183572904' lng='-123.0997525580682'/>
    <coord lat='37.76462459223188' lng='-123.10034264405148'/>
    <coord lat='37.76394154484108' lng='-123.10015512521053'/>
    <coord lat='37.76352007284337' lng='-123.09934935781854'/>
    <coord lat='37.76323361282824' lng='-123.09810031731503'/>
    <coord lat='37.76344565406143' lng='-123.0974458583154'/>
    <coord lat='37.76413266348146' lng='-123.09702743370907'/>
    <coord lat='37.7647687776249' lng='-123.09731711228268'/>
    <coord lat='37.76499777737721' lng='-123.0974995024957'/>
    <coord lat='37.76518436924373' lng='-123.09738148529904'/>
    <coord lat='37.765608439916896' lng='-123.09707034905331'/>
    <coord lat='37.76608339618399' lng='-123.09708107788937'/>
    <coord lat='37.766600755789774' lng='-123.09716690857785'/>
    <coord lat='37.76743583749598' lng='-123.09763467826362'/>
    <coord lat='37.76804574345783' lng='-123.09773199988038'/>
    <coord lat='37.76848425322587' lng='-123.09813738225981'/>
    <coord lat='37.76882669806776' lng='-123.0987819036438'/>
    <coord lat='37.76881361354742' lng='-123.09951373337888'/>
  </outline>
  <outline>
    <coord lat='37.7649129627368' lng='-123.09374440987484'/>
    <coord lat='37.764183552814266' lng='-123.09389461357968'/>
    <coord lat='37.76372554755843' lng='-123.09469927628415'/>
    <coord lat='37.76378491877011' lng='-123.09553612549679'/>
    <coord lat='37.76417080887311' lng='-123.0961532158193'/>
    <coord lat='37.76468396272188' lng='-123.09642661888974'/>
    <coord lat='37.765048666114765' lng='-123.09634078820126'/>
    <coord lat='37.76553210737518' lng='-123.09567560036557'/>
    <coord lat='37.765940567778365' lng='-123.09560383455187'/>
    <coord lat='37.76640568619953' lng='-123.09510697205441'/>
    <coord lat='37.76649049912807' lng='-123.09434522469418'/>
    <coord lat='37.76619015153057' lng='-123.09372583535755'/>
    <coord lat='37.765543692299836' lng='-123.09341905043013'/>
  </outline>
  <outline>
    <coord lat='37.77571810254246' lng='-123.10723276094446'/>
    <coord lat='37.775498817476574' lng='-123.10810312094642'/>
    <coord lat='37.775073997775394' lng='-123.10906948247822'/>
    <coord lat='37.77445952602603' lng='-123.10981169032907'/>
    <coord lat='37.77400467326113' lng='-123.11048681583524'/>
    <coord lat='37.773341864415826' lng='-123.11114969754196'/>
    <coord lat='37.77134891954007' lng='-123.11156812214828'/>
    <coord lat='37.76993450045563' lng='-123.11148405075073'/>
    <coord lat='37.768792511494055' lng='-123.11049953280651'/>
    <coord lat='37.76815614500589' lng='-123.10910579775515'/>
    <coord lat='37.76812617161364' lng='-123.10696545147873'/>
    <coord lat='37.768762251408354' lng='-123.10492697262741'/>
    <coord lat='37.770331224842444' lng='-123.10354295277573'/>
    <coord lat='37.771891684318234' lng='-123.10332837605453'/>
    <coord lat='37.77262101821496' lng='-123.10337129139877'/>
    <coord lat='37.77418063825225' lng='-123.10365152116925'/>
    <coord lat='37.775003365054395' lng='-123.10440070405927'/>
    <coord lat='37.77550921249766' lng='-123.10537939272173'/>
    <coord lat='37.77570899060003' lng='-123.10620232801861'/>
  </outline>
  <marker lat="37.775718" lng="-123.107233"/>
  <tide_station>395</tide_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Mostly you have to stay 300&#x26;apos&#x3B; or 1000&#x26;apos&#x3B; away from the islands, but there are a few hundred feet of shoreline where boating is allowed close in on South Farallon only. Part of the South Farallon closed area shown on our map is closed only part of the year. See &#x22;Special Closures&#x22; in the MPA descriptions page linked below. Although it doesn&#x27;t say so in the MPA document, landing in the not-closed-to-boating area is probably prohibited by some other regulation.<p>And there&#x27;s a 5 kt speed limit within 1000&#x27; of any of the islands. If you&#x27;re a strong enough paddler to get out there and back, speeding tickets may be a concern.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/North-Central-California#27342599-southeast-farallon-island-special-closure">CA Dept. of Fish and Wildlife MPA descriptions</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.wildlife.ca.gov/OceanSportfishMap">CA Dept. of Fish and Wildlife Ocean Sport Fishing map</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="377" title="Bay Bridge" zone="530" modtime="1670952292554" modby="petolino" edits_since="1667592250952" >
  <outline>
    <coord lat='37.790879998595805' lng='-122.3853929263565'/>
    <coord lat='37.7912980454596' lng='-122.38595208620656'/>
    <coord lat='37.791088198163436' lng='-122.38637848502212'/>
    <coord lat='37.79069714483368' lng='-122.38665088238449'/>
    <coord lat='37.79019001062056' lng='-122.38600882984542'/>
    <coord lat='37.790286471620206' lng='-122.3856450540039'/>
    <coord lat='37.79051129300522' lng='-122.38527222695083'/>
  </outline>
  <outline>
    <coord lat='37.79575186360729' lng='-122.380139673882'/>
    <coord lat='37.79525267641703' lng='-122.38025056873582'/>
    <coord lat='37.795168032013265' lng='-122.38070531844248'/>
    <coord lat='37.79543851631918' lng='-122.3811115578296'/>
    <coord lat='37.79587761244023' lng='-122.38115601243403'/>
    <coord lat='37.796063518008694' lng='-122.38064612277502'/>
  </outline>
  <outline>
    <coord lat='37.80039845332495' lng='-122.37512599477996'/>
    <coord lat='37.800404939431104' lng='-122.37484012585729'/>
    <coord lat='37.80053919334649' lng='-122.37459540367126'/>
    <coord lat='37.800871205277375' lng='-122.37453116170833'/>
    <coord lat='37.80117394106628' lng='-122.37480338951453'/>
    <coord lat='37.801184210568636' lng='-122.37545703393072'/>
    <coord lat='37.80081123727113' lng='-122.37561114005109'/>
  </outline>
  <outline>
    <coord lat='37.80577189011307' lng='-122.37039131946713'/>
    <coord lat='37.80547479755552' lng='-122.37029772856779'/>
    <coord lat='37.80523503662549' lng='-122.3699570880229'/>
    <coord lat='37.80528298887377' lng='-122.3695601210887'/>
    <coord lat='37.805723548697664' lng='-122.3693804130847'/>
    <coord lat='37.80595213968509' lng='-122.36971717498166'/>
    <coord lat='37.80607183032772' lng='-122.3701885342598'/>
  </outline>
  <outline>
    <coord lat='37.81588879240794' lng='-122.35845075026339'/>
    <coord lat='37.81526881819378' lng='-122.35801757350748'/>
    <coord lat='37.81496915666002' lng='-122.35819459930246'/>
    <coord lat='37.81497514990264' lng='-122.3587766386587'/>
    <coord lat='37.8155158641982' lng='-122.3591373957712'/>
    <coord lat='37.815928780756806' lng='-122.35901379346079'/>
  </outline>
  <outline>
    <coord lat='37.81769778353788' lng='-122.3536614159423'/>
    <coord lat='37.8175164196481' lng='-122.35323092139541'/>
    <coord lat='37.81786558794408' lng='-122.35291307962714'/>
    <coord lat='37.81869861131332' lng='-122.35325908459006'/>
    <coord lat='37.81875126958922' lng='-122.35362810385863'/>
    <coord lat='37.818475384939624' lng='-122.35385315845961'/>
  </outline>
  <outline>
    <coord lat='37.81953893379375' lng='-122.34432722500267'/>
    <coord lat='37.819199309520386' lng='-122.34465388065864'/>
    <coord lat='37.81939910092307' lng='-122.34496148915485'/>
    <coord lat='37.82023964395377' lng='-122.34502132678652'/>
    <coord lat='37.82051232098713' lng='-122.34476975477422'/>
    <coord lat='37.82022822864654' lng='-122.34446929308896'/>
  </outline>
  <outline>
    <coord lat='37.82116580988274' lng='-122.33189077588746'/>
    <coord lat='37.82127367911945' lng='-122.33113707515427'/>
    <coord lat='37.822283725868466' lng='-122.33141452074051'/>
    <coord lat='37.822217528215916' lng='-122.33205439063737'/>
  </outline>
  <outline>
    <coord lat='37.798574163084595' lng='-122.37732677377019'/>
    <coord lat='37.79823130786761' lng='-122.37722396850586'/>
    <coord lat='37.79794656375315' lng='-122.37749218940735'/>
    <coord lat='37.79765099298791' lng='-122.37787126220022'/>
    <coord lat='37.797790542354726' lng='-122.37830171227944'/>
    <coord lat='37.79811396134803' lng='-122.37853523583165'/>
    <coord lat='37.79846326339048' lng='-122.37820922053609'/>
    <coord lat='37.798642353441956' lng='-122.37778160693505'/>
  </outline>
  <marker lat="37.822284" lng="-122.331415"/>
  <current_station>40</current_station>
  <city>San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stay at least 25 yards away from all piers, abutments, fenders, and pilings.<p>Note: for illustrative purposes, the shaded area on the map shows only a few of the pilings of the East Span, but you get the idea: stay 25 yards away from all of them.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.govinfo.gov/content/pkg/CFR-2012-title33-vol2/pdf/CFR-2012-title33-vol2-sec165-1190.pdf">Coast Guard/DHS security zones. See &#xA7;165.1187</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="378" title="Oakland Airport" zone="531" modtime="1670952656856" modby="petolino" edits_since="1668033137478" >
  <outline>
    <coord lat='37.72638888888889' lng='-122.25000000000001'/>
    <coord lat='37.727777777777774' lng='-122.25138888888891'/>
    <coord lat='37.726111111111116' lng='-122.25333333333333'/>
    <coord lat='37.723333333333336' lng='-122.25305555555558'/>
    <coord lat='37.69833333333332' lng='-122.21805555555555'/>
    <coord lat='37.697500000000005' lng='-122.21333333333334'/>
    <coord lat='37.698055555555555' lng='-122.21222222222222'/>
    <coord lat='37.69305555555555' lng='-122.205'/>
    <coord lat='37.69611111111111' lng='-122.2022222222222'/>
    <coord lat='37.700833333333335' lng='-122.20944444444444'/>
    <coord lat='37.702222222222225' lng='-122.2088888888889'/>
    <coord lat='37.70972222222223' lng='-122.20833333333336'/>
    <coord lat='37.71104320999943' lng='-122.20179541269937'/>
    <coord lat='37.71289637076341' lng='-122.20261364017797'/>
    <coord lat='37.71129367611903' lng='-122.20971787404011'/>
    <coord lat='37.71057857426672' lng='-122.21051768051889'/>
    <coord lat='37.709184445345436' lng='-122.2118753557688'/>
    <coord lat='37.70173778044277' lng='-122.21123728620643'/>
    <coord lat='37.6991767095278' lng='-122.21399644217401'/>
    <coord lat='37.699576553101565' lng='-122.21666339544338'/>
    <coord lat='37.72371120350801' lng='-122.25065575431789'/>
    <coord lat='37.724389111083816' lng='-122.25125892756262'/>
    <coord lat='37.725134906280445' lng='-122.25143295483458'/>
    <coord lat='37.72603344986942' lng='-122.25052336443363'/>
  </outline>
  <marker lat="37.727778" lng="-122.251389"/>
  <tide_station>352</tide_station>
  <city>PPHX+4C_Alameda</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stay at least 200 yards from shore. The OAK security zone is marked with small white buoys that have orange reflective striping and the words &#x201C;security zone&#x201D; emblazoned upon them. The orange diamond on each buoy indicates no entry.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.govinfo.gov/content/pkg/FR-2004-06-21/pdf/FR-2004-06-21.pdf">Federal Register Vol 69 No 118 - see pg 34280</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="379" title="Egg Rock/Devil&apos;s Slide" zone="545" modtime="1670952739903" modby="petolino" edits_since="1668096217637" >
  <outline>
    <coord lat='37.57861738978253' lng='-122.52206575415886'/>
    <coord lat='37.57831612633938' lng='-122.52266693626908'/>
    <coord lat='37.57797478450219' lng='-122.52288406696536'/>
    <coord lat='37.577609919789786' lng='-122.52291083335876'/>
    <coord lat='37.577182002605056' lng='-122.52263709905536'/>
    <coord lat='37.57682972005683' lng='-122.52251836947906'/>
    <coord lat='37.57545237752183' lng='-122.52028468386331'/>
    <coord lat='37.57564543503603' lng='-122.51968561508853'/>
    <coord lat='37.57578747223569' lng='-122.51942986714428'/>
    <coord lat='37.57607154712937' lng='-122.51927242033655'/>
    <coord lat='37.576163523071195' lng='-122.51908627116394'/>
    <coord lat='37.57619221783155' lng='-122.51896188652981'/>
    <coord lat='37.57620390630682' lng='-122.51881604415027'/>
    <coord lat='37.576116747073556' lng='-122.51859945763823'/>
    <coord lat='37.576078476702726' lng='-122.51833794425262'/>
    <coord lat='37.576308047734635' lng='-122.51820115322239'/>
    <coord lat='37.57666515435601' lng='-122.5180133976227'/>
    <coord lat='37.57705943805469' lng='-122.51795764796725'/>
    <coord lat='37.57750474002066' lng='-122.51799846095487'/>
    <coord lat='37.57786816219518' lng='-122.51814446241768'/>
    <coord lat='37.57803381670213' lng='-122.51807168485645'/>
    <coord lat='37.57852159444479' lng='-122.51799805891415'/>
    <coord lat='37.579' lng='-122.518'/>
  </outline>
  <marker lat="37.579" lng="-122.518"/>
  <tide_station>283</tide_station>
  <city>Pacifica</city>
  <details><![CDATA[
      <p><b>Overview: </b>Special Closure. To protect nesting birds, the entire area between the rocks and the shore, as well as the area within 300 feet of the rocks, is closed to all boating year-round.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/?page_id=27721">Pillar Point SMCA, Montara SMR and Egg &#x28;Devil&#x27;s Slide&#x29; Rock to Devil&#x27;s Slide Special Closure</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1661475716887-379-melissa.jpg" height="279" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>egg rock</span>
  ]]></details>
</station>

<station station_type="nogo" xid="381" title="Bair Island State Marine Park" zone="531" modtime="1670952766800" modby="petolino" edits_since="1669845945085" >
  <outline>
    <coord lat='37.5276807' lng='-122.2417098'/>
    <coord lat='37.526867' lng='-122.2425683'/>
    <coord lat='37.525046141061836' lng='-122.24323346250893'/>
    <coord lat='37.52363370882745' lng='-122.24269699259033'/>
    <coord lat='37.5229189' lng='-122.2400792'/>
    <coord lat='37.522067991557606' lng='-122.2385342255577'/>
    <coord lat='37.5208767' lng='-122.2375901'/>
    <coord lat='37.5184941' lng='-122.2376759'/>
    <coord lat='37.517336781799536' lng='-122.23664592781721'/>
    <coord lat='37.5168602363342' lng='-122.23570180793457'/>
    <coord lat='37.519106776666426' lng='-122.2358306005249'/>
    <coord lat='37.5212171' lng='-122.234071'/>
    <coord lat='37.5214213' lng='-122.2312386'/>
    <coord lat='37.5189706' lng='-122.2296937'/>
    <coord lat='37.5234805' lng='-122.2251019'/>
    <coord lat='37.5232593' lng='-122.221969'/>
    <coord lat='37.5212852' lng='-122.2213682'/>
    <coord lat='37.5193791' lng='-122.2223981'/>
    <coord lat='37.5182218' lng='-122.2217115'/>
    <coord lat='37.518426' lng='-122.2192224'/>
    <coord lat='37.5196514' lng='-122.2195228'/>
    <coord lat='37.5205704' lng='-122.2201666'/>
    <coord lat='37.5227828' lng='-122.2210249'/>
    <coord lat='37.5238039' lng='-122.2180208'/>
    <coord lat='37.5255737' lng='-122.2176775'/>
    <coord lat='37.5274116' lng='-122.2146734'/>
    <coord lat='37.5262629' lng='-122.2106178'/>
    <coord lat='37.5242633' lng='-122.2070345'/>
    <coord lat='37.5323972' lng='-122.1978724'/>
    <coord lat='37.5341839' lng='-122.2008549'/>
    <coord lat='37.5352731' lng='-122.1993956'/>
    <coord lat='37.5379958' lng='-122.2050816'/>
    <coord lat='37.5402758' lng='-122.2033435'/>
    <coord lat='37.5426914' lng='-122.2224411'/>
    <coord lat='37.5423172' lng='-122.2243723'/>
    <coord lat='37.5385199' lng='-122.2273333'/>
    <coord lat='37.5331771' lng='-122.2298223'/>
    <coord lat='37.5295696' lng='-122.2362167'/>
    <coord lat='37.5285316' lng='-122.2405511'/>
  </outline>
  <outline>
    <coord lat='37.5164001' lng='-122.2375477'/>
    <coord lat='37.5089791' lng='-122.2381056'/>
    <coord lat='37.5053704' lng='-122.2279776'/>
    <coord lat='37.502034' lng='-122.2266901'/>
    <coord lat='37.501285' lng='-122.2251023'/>
    <coord lat='37.5171489' lng='-122.2207678'/>
    <coord lat='37.5187488' lng='-122.2236002'/>
    <coord lat='37.5198039' lng='-122.2241152'/>
    <coord lat='37.5219823' lng='-122.2228707'/>
    <coord lat='37.5223568' lng='-122.2232569'/>
    <coord lat='37.5219823' lng='-122.2255314'/>
    <coord lat='37.5172851' lng='-122.229308'/>
    <coord lat='37.517183' lng='-122.2301663'/>
    <coord lat='37.5204507' lng='-122.2320546'/>
    <coord lat='37.5194295' lng='-122.234372'/>
    <coord lat='37.5159916' lng='-122.233857'/>
    <coord lat='37.5153448' lng='-122.234887'/>
  </outline>
  <marker lat="37.542691" lng="-122.222441"/>
  <tide_station>322</tide_station>
  <city>GQVH+32_Redwood_City</city>
  <details><![CDATA[
      <p><b>Overview: </b>The area shown on the map is closed to boating year-round.<p>Note that Corkscrew Slough, Redwood Creek, and Steinberger Slough are <b>not</b> part of the closed area.<p>See the map link in the DFW Marine Protected Areas website referenced below. Although we couldn&#x27;t find a precise definition of this area, we&#x27;ve made an attempt to copy its boundaries from the DFW map onto our map.<p>The &#x22;Places to Visit&#x22; link below also says that this area is closed Feb 15 through May 20 every year, but since it&#x27;s also closed to boating year-round, I guess that point is moot.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/San-Francisco-Bay#26762436-bair-island-state-marine-park">Marine Protected Areas &#x28;CA DFW&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://wildlife.ca.gov/Lands/Places-to-Visit/Bair-Island-ER">Places to Visit &#x28;CA DFW&#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="383" title="Mowry Slough (seasonal)" zone="531" modtime="1671040605881" modby="petolino" edits_since="1670952810696" >
  <outline>
    <coord lat='37.4907874' lng='-122.0539013'/>
    <coord lat='37.4923027' lng='-122.0437304'/>
    <coord lat='37.4924048' lng='-122.0415417'/>
    <coord lat='37.4917238' lng='-122.0381943'/>
    <coord lat='37.4905831' lng='-122.0354263'/>
    <coord lat='37.4894594' lng='-122.0343319'/>
    <coord lat='37.486627' lng='-122.033347'/>
    <coord lat='37.4830404' lng='-122.0328943'/>
    <coord lat='37.480946' lng='-122.0320574'/>
    <coord lat='37.4778809' lng='-122.0299117'/>
    <coord lat='37.477183' lng='-122.027175'/>
    <coord lat='37.4772848' lng='-122.0258991'/>
    <coord lat='37.4788685' lng='-122.0244185'/>
    <coord lat='37.4802308' lng='-122.0242468'/>
    <coord lat='37.4821379' lng='-122.0243541'/>
    <coord lat='37.4831766' lng='-122.0236246'/>
    <coord lat='37.4835341' lng='-122.0239893'/>
    <coord lat='37.4824444' lng='-122.0249764'/>
    <coord lat='37.4805203' lng='-122.0248477'/>
    <coord lat='37.4785961' lng='-122.0250622'/>
    <coord lat='37.4776084' lng='-122.0263711'/>
    <coord lat='37.4775403' lng='-122.0277015'/>
    <coord lat='37.4779831' lng='-122.0290104'/>
    <coord lat='37.4810822' lng='-122.0316497'/>
    <coord lat='37.4837555' lng='-122.0323793'/>
    <coord lat='37.4860371' lng='-122.0324651'/>
    <coord lat='37.4893232' lng='-122.0330659'/>
    <coord lat='37.4920473' lng='-122.0350186'/>
    <coord lat='37.4933072' lng='-122.0413271'/>
    <coord lat='37.4927794' lng='-122.0526353'/>
  </outline>
  <marker lat="37.493307" lng="-122.041327"/>
  <tide_station>225</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>According to the unofficial OhRanger website, Mowry Slough is closed from March 15 to June 15 to protect sensitive wildlife species. We couldn&#x27;t find anything more authoritative about this, so check with Don Edwards NWR officials before paddling there. If you find anything out, please let us know.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.fws.gov/refuge/don-edwards-san-francisco-bay">Don Edwards National Wildlife Refuge</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ohranger.com/don-edwards-san-francisco-bay-nwr">OhRanger &#x28;Don Edwards NWR&#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="384" title="Mallard Slough aka Coyote Creek (seasonal)" zone="531" modtime="1671040630249" modby="petolino" edits_since="1670952827679" >
  <outline>
    <coord lat='37.461097' lng='-121.9662692'/>
    <coord lat='37.4612333' lng='-121.9656898'/>
    <coord lat='37.4611481' lng='-121.9646169'/>
    <coord lat='37.4608586' lng='-121.964059'/>
    <coord lat='37.4604668' lng='-121.9638981'/>
    <coord lat='37.4598621' lng='-121.9641449'/>
    <coord lat='37.459249' lng='-121.9650997'/>
    <coord lat='37.458591' lng='-121.967064'/>
    <coord lat='37.4579885' lng='-121.9678678'/>
    <coord lat='37.4551951' lng='-121.9679751'/>
    <coord lat='37.453926' lng='-121.9675781'/>
    <coord lat='37.452862' lng='-121.966131'/>
    <coord lat='37.4523163' lng='-121.9666232'/>
    <coord lat='37.4515072' lng='-121.9680502'/>
    <coord lat='37.4498718' lng='-121.9684579'/>
    <coord lat='37.4486794' lng='-121.9682433'/>
    <coord lat='37.4480661' lng='-121.9672777'/>
    <coord lat='37.4476402' lng='-121.965604'/>
    <coord lat='37.4466777' lng='-121.9654002'/>
    <coord lat='37.444008' lng='-121.961769'/>
    <coord lat='37.4342151' lng='-121.9542636'/>
    <coord lat='37.4337124' lng='-121.9533946'/>
    <coord lat='37.4339254' lng='-121.9531049'/>
    <coord lat='37.4407831' lng='-121.9580509'/>
    <coord lat='37.4442586' lng='-121.9610979'/>
    <coord lat='37.4465585' lng='-121.9646062'/>
    <coord lat='37.4475636' lng='-121.964692'/>
    <coord lat='37.4481513' lng='-121.9653036'/>
    <coord lat='37.4487475' lng='-121.9674172'/>
    <coord lat='37.4493693' lng='-121.967739'/>
    <coord lat='37.4503829' lng='-121.967782'/>
    <coord lat='37.4511665' lng='-121.9671275'/>
    <coord lat='37.4520523' lng='-121.9657864'/>
    <coord lat='37.452921' lng='-121.9656147'/>
    <coord lat='37.4534491' lng='-121.9658508'/>
    <coord lat='37.4547522' lng='-121.9672348'/>
    <coord lat='37.4575372' lng='-121.9672562'/>
    <coord lat='37.4578693' lng='-121.9669987'/>
    <coord lat='37.4583973' lng='-121.9654216'/>
    <coord lat='37.4592916' lng='-121.9636084'/>
    <coord lat='37.4602454' lng='-121.9632651'/>
    <coord lat='37.4615398' lng='-121.9638659'/>
    <coord lat='37.4616931' lng='-121.9660761'/>
  </outline>
  <marker lat="37.461693" lng="-121.966076"/>
  <tide_station>84</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>According to the unofficial OhRanger website, Mallard Slough is closed from Mar. 1 through Aug. 31 to protect sensitive wildlife species. We couldn&#x27;t find anything more authoritative about this, so check with Don Edwards NWR officials before paddling there. If you find anything out, please let us know.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.fws.gov/refuge/don-edwards-san-francisco-bay">Don Edwards National Wildlife Refuge</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="http://www.ohranger.com/don-edwards-san-francisco-bay-nwr">OhRanger &#x28;Don Edwards NWR&#x29;</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="386" title="Año Nuevo State Marine Reserve" zone="560" modtime="1670383853144" modby="petolino" edits_since="1670367112823" >
  <outline>
    <coord lat='37.13613606422407' lng='-122.35014283231882'/>
    <coord lat='37.10008930285789' lng='-122.35003325029261'/>
    <coord lat='37.10004426432145' lng='-122.31791693242789'/>
    <coord lat='37.117078233901' lng='-122.31808129981536'/>
    <coord lat='37.11447137125554' lng='-122.32624637780178'/>
    <coord lat='37.11243584987596' lng='-122.32912422999824'/>
    <coord lat='37.114241012015306' lng='-122.3296087039518'/>
    <coord lat='37.11627740076978' lng='-122.33076515220104'/>
    <coord lat='37.11760334192375' lng='-122.33279349193062'/>
    <coord lat='37.11777444489971' lng='-122.33508946284736'/>
    <coord lat='37.11740232885759' lng='-122.33671427933008'/>
    <coord lat='37.11774457266199' lng='-122.33731502140981'/>
    <coord lat='37.11944267865029' lng='-122.33789205551147'/>
    <coord lat='37.120460710928825' lng='-122.33813645228828'/>
    <coord lat='37.1209050926508' lng='-122.33848749902668'/>
    <coord lat='37.12080752242666' lng='-122.33934924650721'/>
    <coord lat='37.12123293890566' lng='-122.33843173914319'/>
    <coord lat='37.12407076545946' lng='-122.33747126445259'/>
    <coord lat='37.128210995179074' lng='-122.33674170360054'/>
    <coord lat='37.13225867713353' lng='-122.33657848413205'/>
    <coord lat='37.13610108078574' lng='-122.33783151289254'/>
  </outline>
  <marker lat="37.136136" lng="-122.350143"/>
  <tide_station>12</tide_station>
  <city>4JPX+FW_Pescadero</city>
  <details><![CDATA[
      <p><b>Overview: </b>Boating is not prohibited as far as we can tell, but the coastline within the area shown on the map is marked &#x22;closed to public&#x22; and &#x22;restricted access&#x22; in the park brochure map. Keep away from these areas, and keep away from the island itself. On our map we show the boundaries of the State Marine Reserve, but excluding the waters offshore of beaches which appear to be open to the public.<p>Don&#x27;t disturb the elephant seals. The is a heavily-visited State Marine Reserve, so your actions will be under scrutiny.<p>This park hasn&#x27;t seen much use from BASKers since 1990, when a great white shark took a bite out of a kayak &#x28;the paddler was unharmed&#x29;. Since then it has become a very popular destination for land-based elephant seal watching. If you&#x27;re planning to paddle here, it might be wise to contact park authorities to check on current restrictions. Let us know what you find out.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/pages/523/files/Ano%20Nuevo%20Final%20Web%20Layout031122_remediated.pdf">A&#xF1;o Nuevo Park brochure</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/Central-California#27250541-ao-nuevo-state-marine-reserve">Marine Protected Areas &#x28;CA DFW&#x29;</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1661221949525-386-melissa.jpg" height="559" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>ano nuevo</span>
  ]]></details>
</station>

<station station_type="nogo" xid="388" title="Wilder Ranch State Park" zone="560" modtime="1671226006985" modby="petolino" edits_since="1671225843033" >
  <outline>
    <coord lat='36.95361718391295' lng='-122.08011356931152'/>
    <coord lat='36.95320134503248' lng='-122.08077337380548'/>
    <coord lat='36.9528198' lng='-122.0806607'/>
    <coord lat='36.95329139656321' lng='-122.07996332640296'/>
    <coord lat='36.95303205814646' lng='-122.07852297166404'/>
    <coord lat='36.952635520073414' lng='-122.0768680535312'/>
    <coord lat='36.9520825' lng='-122.0762619'/>
    <coord lat='36.952957' lng='-122.0763906'/>
    <coord lat='36.953207794381775' lng='-122.07733206450953'/>
    <coord lat='36.95345858098908' lng='-122.07831645070472'/>
  </outline>
  <outline>
    <coord lat='36.966122823395885' lng='-122.12418058164553'/>
    <coord lat='36.9656664048181' lng='-122.12549997544728'/>
    <coord lat='36.96497528594148' lng='-122.12583779998587'/>
    <coord lat='36.96466135025227' lng='-122.12613270500363'/>
    <coord lat='36.96430774584109' lng='-122.12655083345591'/>
    <coord lat='36.96481083847564' lng='-122.12706305471804'/>
    <coord lat='36.96504523822967' lng='-122.12721187991649'/>
    <coord lat='36.96503960930679' lng='-122.1280902675104'/>
    <coord lat='36.96540540483908' lng='-122.12865819847696'/>
    <coord lat='36.96597693444919' lng='-122.12896864278551'/>
    <coord lat='36.96643414235388' lng='-122.12903803236493'/>
    <coord lat='36.967234231079' lng='-122.1308240510357'/>
    <coord lat='36.96711996718431' lng='-122.13164951115068'/>
    <coord lat='36.967820053096254' lng='-122.13308651123253'/>
    <coord lat='36.96749147732293' lng='-122.1340085329399'/>
    <coord lat='36.96707433671614' lng='-122.13443636340321'/>
    <coord lat='36.96726094622168' lng='-122.13505382057002'/>
    <coord lat='36.96791621182954' lng='-122.13513845152143'/>
    <coord lat='36.968338137310276' lng='-122.1345906800617'/>
    <coord lat='36.96882863787305' lng='-122.13449351585125'/>
    <coord lat='36.968809103740874' lng='-122.13475041083298'/>
    <coord lat='36.96817238785011' lng='-122.13502876117957'/>
    <coord lat='36.96798569919308' lng='-122.13567725407442'/>
    <coord lat='36.96799616545337' lng='-122.1359502366406'/>
    <coord lat='36.96811122688722' lng='-122.1359854777643'/>
    <coord lat='36.96823486034111' lng='-122.13592415932254'/>
    <coord lat='36.96836211773401' lng='-122.13514706154965'/>
    <coord lat='36.96832222295044' lng='-122.13596856126368'/>
    <coord lat='36.96847090991221' lng='-122.13614633152821'/>
    <coord lat='36.96862396812982' lng='-122.13610619279113'/>
    <coord lat='36.96877702602627' lng='-122.13575491702132'/>
    <coord lat='36.968928846950746' lng='-122.13596431678627'/>
    <coord lat='36.96923248902708' lng='-122.13587886023087'/>
    <coord lat='36.96965613766838' lng='-122.13545544322852'/>
    <coord lat='36.96987653351531' lng='-122.13532956406634'/>
    <coord lat='36.970079785683694' lng='-122.13533243059454'/>
    <coord lat='36.97037914418829' lng='-122.13568148887957'/>
    <coord lat='36.97054135286078' lng='-122.13618075344155'/>
    <coord lat='36.97086642405412' lng='-122.13629378212882'/>
    <coord lat='36.97112292120858' lng='-122.13657847371242'/>
    <coord lat='36.97145376489463' lng='-122.13651485739871'/>
    <coord lat='36.971503469576284' lng='-122.13624165002756'/>
    <coord lat='36.97174603583684' lng='-122.13625007416071'/>
    <coord lat='36.971810741544665' lng='-122.13649721557229'/>
    <coord lat='36.97184973167238' lng='-122.1368704213454'/>
    <coord lat='36.97193199699422' lng='-122.1371179426969'/>
    <coord lat='36.972032817073746' lng='-122.13711535403671'/>
    <coord lat='36.972125065559446' lng='-122.13703766342228'/>
    <coord lat='36.97222635199376' lng='-122.13712918809212'/>
    <coord lat='36.972343848811946' lng='-122.13721487647535'/>
    <coord lat='36.97263120417389' lng='-122.13726870920173'/>
    <coord lat='36.97292713031663' lng='-122.13784825683116'/>
    <coord lat='36.973261836969336' lng='-122.13809540398897'/>
    <coord lat='36.97360704674869' lng='-122.13840941627011'/>
    <coord lat='36.973625365974264' lng='-122.13866834673925'/>
    <coord lat='36.9736779704456' lng='-122.13881998903909'/>
    <coord lat='36.973744608306994' lng='-122.13885371164557'/>
    <coord lat='36.97383696032563' lng='-122.13885524778067'/>
    <coord lat='36.9739616646496' lng='-122.13896560864603'/>
    <coord lat='36.974063659573964' lng='-122.13935472427862'/>
    <coord lat='36.97407136877675' lng='-122.13959363665903'/>
    <coord lat='36.97412964360703' lng='-122.13971741020686'/>
    <coord lat='36.97424130486224' lng='-122.13975562692781'/>
    <coord lat='36.97454153524479' lng='-122.13956853768867'/>
    <coord lat='36.97492747832233' lng='-122.13999835753697'/>
    <coord lat='36.9752619917284' lng='-122.14057838587011'/>
    <coord lat='36.97538985309072' lng='-122.14018958418619'/>
  </outline>
  <marker lat="36.97539" lng="-122.14019"/>
  <tide_station>362</tide_station>
  <city>XVG5+5W_Gordola</city>
  <details><![CDATA[
      <p><b>Overview: </b>The indicated coastline is marked &#x22;Closed to the Public&#x22; on the park brochure map. Note that this includes two areas separated by 2-1/2 miles: from Red, White, and Blue Beach to Four Mile Beach, and Wilder Beach Natural Preserve.<p>Many of the beaches on the seven-mile stretch of coastline which extends northwestward from Red, White, and Blue to Scott Creek are now part of Coast Dairies State Park, also administered by Wilder Ranch. We know of no access restrictions here at this time.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/pages/549/files/wilderranchspweblayout2015.pdf">Wilder Ranch State Park brochure</a></p>
  ]]></details>
</station>



<station station_type="nogo" xid="390" title="Elkhorn Slough" zone="535" modtime="1670952990262" modby="petolino" edits_since="1660781924993" >
  <outline>
    <coord lat='36.8379682' lng='-121.7401765'/>
    <coord lat='36.8345335' lng='-121.7386744'/>
    <coord lat='36.8308581' lng='-121.738417'/>
    <coord lat='36.8196249' lng='-121.7430947'/>
    <coord lat='36.8152274' lng='-121.7463992'/>
    <coord lat='36.813269' lng='-121.7489312'/>
    <coord lat='36.8126849' lng='-121.7509912'/>
    <coord lat='36.812307' lng='-121.7591451'/>
    <coord lat='36.8115855' lng='-121.7623637'/>
    <coord lat='36.8116198' lng='-121.7639945'/>
    <coord lat='36.8124788' lng='-121.7655395'/>
    <coord lat='36.8142654' lng='-121.7665265'/>
    <coord lat='36.8144028' lng='-121.7670844'/>
    <coord lat='36.8121008' lng='-121.7694447'/>
    <coord lat='36.8116885' lng='-121.7720626'/>
    <coord lat='36.8101424' lng='-121.7717622'/>
    <coord lat='36.8107952' lng='-121.7577718'/>
    <coord lat='36.7980814' lng='-121.7508624'/>
    <coord lat='36.7995247' lng='-121.7305205'/>
    <coord lat='36.8060271' lng='-121.7270336'/>
    <coord lat='36.8110177' lng='-121.7305849'/>
    <coord lat='36.8146341' lng='-121.7319904'/>
    <coord lat='36.8106703' lng='-121.7374997'/>
    <coord lat='36.8169341' lng='-121.738023'/>
    <coord lat='36.8225107' lng='-121.7311643'/>
    <coord lat='36.8296902' lng='-121.7342542'/>
    <coord lat='36.8363196' lng='-121.732795'/>
    <coord lat='36.8394795' lng='-121.7342971'/>
    <coord lat='36.8425705' lng='-121.7413781'/>
    <coord lat='36.8402351' lng='-121.7428372'/>
  </outline>
  <outline>
    <coord lat='36.81047166470372' lng='-121.78478651045076'/>
    <coord lat='36.81065105301682' lng='-121.7846432788712'/>
    <coord lat='36.81087925578096' lng='-121.78425918483853'/>
    <coord lat='36.811622622941584' lng='-121.7830776621983'/>
    <coord lat='36.812054607908074' lng='-121.78226358689676'/>
    <coord lat='36.81273654210179' lng='-121.78086127962104'/>
    <coord lat='36.812923967114195' lng='-121.78032239167408'/>
    <coord lat='36.81306062606721' lng='-121.78002075993079'/>
    <coord lat='36.81321446341861' lng='-121.77979422883605'/>
    <coord lat='36.813096095261535' lng='-121.77914417468466'/>
    <coord lat='36.81307985505756' lng='-121.77807885887411'/>
    <coord lat='36.813080784445894' lng='-121.77758217063904'/>
    <coord lat='36.81314089768609' lng='-121.77706183020524'/>
    <coord lat='36.813282614964216' lng='-121.7758253348352'/>
    <coord lat='36.813432916563606' lng='-121.7755222441803'/>
    <coord lat='36.81367772478545' lng='-121.77518425406323'/>
    <coord lat='36.813619750424074' lng='-121.77467193406592'/>
    <coord lat='36.81371101264435' lng='-121.7739115186221'/>
    <coord lat='36.813735168548874' lng='-121.77344011423676'/>
    <coord lat='36.813724965905166' lng='-121.7732047441803'/>
    <coord lat='36.8199177' lng='-121.7718637'/>
    <coord lat='36.82337017658887' lng='-121.77381627301635'/>
    <coord lat='36.823353' lng='-121.778301'/>
    <coord lat='36.82177279891555' lng='-121.78339725501102'/>
    <coord lat='36.82154949809824' lng='-121.78442184320069'/>
    <coord lat='36.821188779449926' lng='-121.78490998413085'/>
    <coord lat='36.82087216511917' lng='-121.7851326616109'/>
    <coord lat='36.82045248484687' lng='-121.78554845428158'/>
    <coord lat='36.81985871089859' lng='-121.78540088218647'/>
    <coord lat='36.819385177483305' lng='-121.78566100370482'/>
    <coord lat='36.81829209624652' lng='-121.78577898452505'/>
    <coord lat='36.812011253637465' lng='-121.78568238759416'/>
    <coord lat='36.81143580242453' lng='-121.7853497792733'/>
  </outline>
  <marker lat="36.842571" lng="-121.741378"/>
  <tide_station>118</tide_station>
  <city>Watsonville</city>
  <details><![CDATA[
      <p><b>Overview: </b>Kayaks and other watercraft are allowed only in the main channel of the slough. Stay out of the areas shown in red, which are copied from a map on the Elkhorn Slough Foundation website &#x28;see link below&#x29;.<p>Launching or landing is allowed only at the beach on the west end of the Slough near Monterey Bay Kayaks, and at Kirby Park at the northeast end of the Slough. Don&#x27;t get out of your boat anywhere else.<p>There is a lot of wildlife in the area and as with all the coast a no-disturb distance is mandated, but hard to do when sea otters are popping up near you. Be particularly mindful of wildlife on the shore from Moss Landing State Beach &#x28;across from the MBK beach&#x29;.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.elkhornslough.org/wp/wp-content/uploads/2015/06/elkhornslough_watercraft_map_700w.jpg">https://www.elkhornslough.org/wp/wp-content/uploads/2015/06/elkhornslough_watercraft_map_700w.jpg</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.parks.ca.gov/?page_id=27205">https://www.parks.ca.gov/&#x3F;page_id&#x3D;27205</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="392" title="Miller&apos;s Rocks (seasonal)" zone="545" modtime="1671041183825" modby="petolino" edits_since="1670952120531" >
  <outline>
    <coord lat='37.9848002' lng='-122.8117604'/>
    <coord lat='37.9828891' lng='-122.8130264'/>
    <coord lat='37.9811301' lng='-122.8130908'/>
    <coord lat='37.9800138' lng='-122.8107519'/>
    <coord lat='37.9809441' lng='-122.8083701'/>
    <coord lat='37.9831597' lng='-122.8093357'/>
    <coord lat='37.98502' lng='-122.81146'/>
  </outline>
  <marker lat="37.98502" lng="-122.81146"/>
  <tide_station>99</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>The rocks are closed for seabird nesting March 1 to July 30. It&#x27;s unclear if the ones near the point are included.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm">https://www.nps.gov/pore/learn/management/lawsandpolicies_superintendents_compendium.htm</a></p>
  ]]></details>
</station>



<station station_type="nogo" xid="396" title="Santa Cruz Wharf and Beaches" zone="535" modtime="1670952945230" modby="petolino" edits_since="1668124015290" >
  <outline>
    <coord lat='36.9591044' lng='-122.0173553'/>
    <coord lat='36.9600303' lng='-122.0188037'/>
    <coord lat='36.9599403' lng='-122.0189432'/>
    <coord lat='36.9621306' lng='-122.0222584'/>
    <coord lat='36.96222489905442' lng='-122.02268753862305'/>
    <coord lat='36.960731360598444' lng='-122.02481052689424'/>
    <coord lat='36.95992363192885' lng='-122.02521687160738'/>
    <coord lat='36.95957696954456' lng='-122.02478501712336'/>
    <coord lat='36.96121546655291' lng='-122.02177557415824'/>
    <coord lat='36.9606861' lng='-122.0210782'/>
    <coord lat='36.9605361' lng='-122.0212177'/>
    <coord lat='36.9587314' lng='-122.0185623'/>
    <coord lat='36.9585536' lng='-122.0185087'/>
    <coord lat='36.9583028' lng='-122.0181037'/>
    <coord lat='36.9577734' lng='-122.0179266'/>
    <coord lat='36.957707' lng='-122.0179132'/>
    <coord lat='36.9576856' lng='-122.0177013'/>
    <coord lat='36.9570726' lng='-122.0175216'/>
    <coord lat='36.9573340718866' lng='-122.01680276931152'/>
    <coord lat='36.95782699272653' lng='-122.01710318465577'/>
    <coord lat='36.9578377' lng='-122.0170093'/>
    <coord lat='36.9587829' lng='-122.0173553'/>
    <coord lat='36.9589972' lng='-122.0171461'/>
  </outline>
  <outline>
    <coord lat='36.96190761653558' lng='-122.01414419708892'/>
    <coord lat='36.96100297485343' lng='-122.02333029592658'/>
    <coord lat='36.96214777657503' lng='-122.02250308607599'/>
    <coord lat='36.9632793746893' lng='-122.0184523810237'/>
    <coord lat='36.96372509553973' lng='-122.01488206329148'/>
  </outline>
  <marker lat="36.963725" lng="-122.014882"/>
  <tide_station>362</tide_station>
  <city>Santa_Cruz</city>
  <details><![CDATA[
      <p><b>Overview: </b>Due to heavy beach use there are launch restrictions of when and where you can launch at Cowell, Santa Cruz Beach, and near the Wharf. See link below for details. Landing on the beaches may also be difficult with the heavy beach use. It may also be difficult to unload and park.<p>There are no restrictions at Seabright State Beach on the east side of the San Lorenzo River.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.cityofsantacruz.com/government/city-departments/parks-recreation/parks-beaches-open-spaces/beaches-aquatics">Santa Cruz City Beaches &#x28;see &#x27;Water Craft Launching&#x27; section&#x29;</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="397" title="Capitola Beach" zone="535" modtime="1670952962782" modby="petolino" edits_since="0" >
  <outline>
    <coord lat='36.9710839' lng='-121.9535721'/>
    <coord lat='36.9706982' lng='-121.9535238'/>
    <coord lat='36.9709296' lng='-121.9499886'/>
    <coord lat='36.9719111' lng='-121.9491142'/>
    <coord lat='36.9721125' lng='-121.9492323'/>
    <coord lat='36.9718682' lng='-121.9500155'/>
    <coord lat='36.9713197' lng='-121.950053'/>
    <coord lat='36.9713925' lng='-121.9503481'/>
  </outline>
  <marker lat="36.972113" lng="-121.949232"/>
  <tide_station>362</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>No landing East of the wharf due to swimmers. Perhaps not enforced when empty. Roger Schumann and Jan Shriner&#x26;apos&#x3B;s book. Uncorroborated.</p>
  ]]></details>
</station>
<station station_type="nogo" xid="398" title="Salinas River National Wildlife Refuge" zone="535" modtime="1670953010357" modby="petolino" edits_since="1669941000967" >
  <outline>
    <coord lat='36.7355055' lng='-121.79035'/>
    <coord lat='36.7393573' lng='-121.7953711'/>
    <coord lat='36.742143' lng='-121.7992764'/>
    <coord lat='36.7474388' lng='-121.8032675'/>
    <coord lat='36.7472324' lng='-121.8038683'/>
    <coord lat='36.7413864' lng='-121.7998772'/>
    <coord lat='36.7350928' lng='-121.7907362'/>
  </outline>
  <marker lat="36.747439" lng="-121.803267"/>
  <tide_station>266</tide_station>
  <details><![CDATA[
      <p><b>Overview: </b>The 1999 Schumann/Shriner guidebook linked below says that landing is prohibited on the south bank of the river. We couldn&#x27;t find any more recent info on paddling restrictions in this Refuge - if you do, please let us know.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.fws.gov/refuge/salinas-river">https://www.fws.gov/refuge/salinas-river</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.amazon.com/Guide-Kayaking-Central-Northern-California/dp/0762703822">Guide to Sea Kayaking Central and Northern California</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="399" title="Point Lobos" zone="565" modtime="1670953029390" modby="petolino" edits_since="1667356846671" >
  <outline>
    <coord lat='36.52225877404639' lng='-121.92897977829591'/>
    <coord lat='36.52318191930923' lng='-121.92747069900814'/>
    <coord lat='36.52376018156812' lng='-121.92673408556185'/>
    <coord lat='36.52502015801962' lng='-121.92556123635833'/>
    <coord lat='36.52582258655645' lng='-121.92491042896238'/>
    <coord lat='36.52686641834273' lng='-121.92533250199135'/>
    <coord lat='36.528333333333336' lng='-121.92583333333333'/>
    <coord lat='36.53022126893104' lng='-121.92531697080163'/>
    <coord lat='36.53735074061684' lng='-121.9278047126874'/>
    <coord lat='36.53845412940556' lng='-121.93372703019229'/>
    <coord lat='36.53783347514929' lng='-121.9395635170087'/>
    <coord lat='36.538302307694316' lng='-121.95015047040857'/>
    <coord lat='36.537691836778514' lng='-121.96191000990164'/>
    <coord lat='36.532730129055004' lng='-121.96951842728701'/>
    <coord lat='36.52546286513969' lng='-121.97283209510601'/>
    <coord lat='36.51990101708338' lng='-121.97519150950473'/>
    <coord lat='36.51403938108631' lng='-121.97452704138097'/>
    <coord lat='36.50969767147539' lng='-121.97204486287819'/>
    <coord lat='36.504126902409894' lng='-121.9636366115362'/>
    <coord lat='36.498736516149684' lng='-121.96102054275971'/>
    <coord lat='36.49173102830871' lng='-121.94974612003519'/>
    <coord lat='36.490866288485094' lng='-121.94609841353345'/>
    <coord lat='36.49325001074976' lng='-121.94206237792969'/>
    <coord lat='36.498430646658974' lng='-121.93535165876183'/>
    <coord lat='36.50181732671207' lng='-121.93868294320413'/>
    <coord lat='36.50486499030734' lng='-121.93787811531428'/>
    <coord lat='36.506682884825636' lng='-121.93918676732791'/>
    <coord lat='36.50780267109134' lng='-121.93993123001444'/>
    <coord lat='36.50831753428533' lng='-121.94030439231284'/>
    <coord lat='36.50941629279614' lng='-121.94113663492057'/>
    <coord lat='36.510303102131274' lng='-121.94082702050333'/>
    <coord lat='36.51138692366593' lng='-121.94080863851515'/>
    <coord lat='36.51217488297878' lng='-121.94180195287223'/>
    <coord lat='36.51257805506872' lng='-121.94301622844112'/>
    <coord lat='36.51331545484308' lng='-121.94372826579348'/>
    <coord lat='36.51354850885567' lng='-121.9452383265904'/>
    <coord lat='36.514428505837955' lng='-121.9474004118211'/>
    <coord lat='36.516464551132856' lng='-121.94863496779786'/>
    <coord lat='36.517909871225115' lng='-121.9503968293012'/>
    <coord lat='36.5188723195656' lng='-121.95087154017916'/>
    <coord lat='36.52010745600168' lng='-121.95104855533289'/>
    <coord lat='36.52064635651998' lng='-121.95114512583075'/>
    <coord lat='36.52117230926039' lng='-121.95262583606431'/>
    <coord lat='36.52194833334359' lng='-121.95292657048341'/>
    <coord lat='36.52281085666445' lng='-121.95217556256738'/>
    <coord lat='36.52094881834211' lng='-121.94987962032485'/>
    <coord lat='36.52162148081658' lng='-121.94836144384708'/>
    <coord lat='36.522647548885445' lng='-121.9476452648964'/>
    <coord lat='36.52205695888986' lng='-121.94599970640107'/>
    <coord lat='36.5216732954363' lng='-121.94432471826283'/>
    <coord lat='36.52555334091762' lng='-121.9442862823031'/>
    <coord lat='36.525627131787864' lng='-121.93799656077029'/>
    <coord lat='36.521638456603746' lng='-121.93463411196007'/>
    <coord lat='36.52291431564124' lng='-121.93197862798154'/>
  </outline>
  <marker lat="36.538454" lng="-121.933727"/>
  <tide_station>60</tide_station>
  <city>Carmel-by-the-Sea</city>
  <details><![CDATA[
      <p><b>Overview: </b>Access in the area around Point Lobos is now very restricted, but, as has been our experience in the past, it is extremely hard to get any information about it from the Reserve management.<p>The red area shown on the map is based on a claim by one State Parks employee that paddling is forbidden in an area extending &#x22;about a mile&#x22; outside the entire shoreline of Point Lobos State Natural Reserve. This was communicated to BASK by email in August 2022. This same email, however, suggested launching at Monastery Beach &#x28;the entirety of which is well within the purported one-mile exclusion zone&#x29; and paddling north. We could not find an official map online showing the Reserve boundaries, so we drew the red area one mile out from what looked like the Reserve on Google Maps.<p>The waters offshore of Point Lobos State Natural Reserve &#x28;the park&#x29; lie within Point Lobos State Marine Reserve &#x28;a Marine Protected Area&#x29;. See map below. If you spook any wildlife you may be fined. There are aggressive volunteer observers who are closely watching the shoreline and in radio contact with rangers.<p>Paddling is allowed in Whaler&#x27;s Cove and Bluefish Cove, an area that extends about a half mile in each direction. However, you need a permit &#x28;fee required, plus pay parking&#x29;, you must launch at Whalers Cove, and you can&#x27;t land anywhere but the Whaler&#x27;s Cove launch ramp. This is mainly an accommodation for scuba divers who paddle SOTs to dive sites in Whaler&#x27;s and Bluefish Coves.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.parks.ca.gov/?page_id=571">https://www.parks.ca.gov/&#x3F;page_id&#x3D;571</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.parks.ca.gov/?page_id=28353">https://www.parks.ca.gov/&#x3F;page_id&#x3D;28353</a></p>
      <p><img class="details_img zoomable" src="images/editor_uploads/details/1659590221284-399-melissa.jpg" height="311" width="400" onclick="zoom_img(this)" title="Click to enlarge">
      <br><span class='details_caption'>pt. lobos reserve</span>
  ]]></details>
</station>
<station station_type="nogo" xid="400" title="Richmond Long Wharf Security Zone" zone="530" modtime="1670953421042" modby="petolino" edits_since="1669938928596" >
  <outline>
    <coord lat='37.93116666666666' lng='-122.40130555555558'/>
    <coord lat='37.92827777777777' lng='-122.40197222222223'/>
    <coord lat='37.92411111111111' lng='-122.40997222222224'/>
    <coord lat='37.92975' lng='-122.41541666666667'/>
    <coord lat='37.92858333333333' lng='-122.41763888888886'/>
    <coord lat='37.919777777777774' lng='-122.40911111111113'/>
    <coord lat='37.92066666666667' lng='-122.40763888888891'/>
    <coord lat='37.92213888888888' lng='-122.40658333333334'/>
    <coord lat='37.92283333333333' lng='-122.40727777777781'/>
    <coord lat='37.92736111111111' lng='-122.3991388888889'/>
    <coord lat='37.929944444444445' lng='-122.3981388888889'/>
  </outline>
  <marker lat="37.931167" lng="-122.401306"/>
  <current_station>302</current_station>
  <city>WHJX+FF_Richmond</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.<p>There is a Regulated Navigation Area &#x28;RNA&#x29; southwest of the pier &#x28;not shown here - refer to nautical charts&#x29;. Paddling is not prohibited there, but watch for tugs and tankers activity.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Security Zone &#x28;Code of Federal Regulations &#xA7; 165.1197 a1&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba">RNA &#x28;Code of Federal Regulations &#xA7; 165.1181 c6ii&#x29;</a></p>
  ]]></details>
</station>

<station station_type="destination" xid="402" title="Mavericks" zone="545" modtime="1670615702263" modby="petolino" edits_since="1657145017895" >
  <marker lat="37.491389" lng="-122.508333"/>
  <tide_station>283</tide_station>
  <city>FFRR+HM_El_Granada</city>
  <details><![CDATA[
      <p><b>Overview: </b>This is more a warning than a destination. World famous big wave surf break, active when the swell from winter storms far out at sea reaches the coast. Stay outside of this when it&#x27;s going off&#x21;</p>
      <p><b>Links: </b><a target="tp_details" href="https://en.wikipedia.org/wiki/Mavericks,_California">https://en.wikipedia.org/wiki/Mavericks,_California</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://magicseaweed.com/Mavericks-Half-Moon-Bay-Surf-Report/162/">Magic Seaweed Surf Report</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="404" title="San Francisco Airport" zone="531" modtime="1670952706488" modby="petolino" edits_since="1668034162303" >
  <outline>
    <coord lat='37.60527777777777' lng='-122.37666666666667'/>
    <coord lat='37.6125' lng='-122.37166666666664'/>
    <coord lat='37.60722222222223' lng='-122.35833333333333'/>
    <coord lat='37.60861111111112' lng='-122.35583333333331'/>
    <coord lat='37.60472222222222' lng='-122.34583333333333'/>
    <coord lat='37.61027777777778' lng='-122.34444444444443'/>
    <coord lat='37.61388888888889' lng='-122.35222222222221'/>
    <coord lat='37.61666666666667' lng='-122.35333333333332'/>
    <coord lat='37.622499999999995' lng='-122.36472222222221'/>
    <coord lat='37.627500000000005' lng='-122.3622222222222'/>
    <coord lat='37.632222222222225' lng='-122.36416666666665'/>
    <coord lat='37.63055555555556' lng='-122.37222222222219'/>
    <coord lat='37.640277777777776' lng='-122.38166666666667'/>
    <coord lat='37.63971372641641' lng='-122.38364866203733'/>
    <coord lat='37.6385889704276' lng='-122.38323237667959'/>
    <coord lat='37.63746421319362' lng='-122.38288047596764'/>
    <coord lat='37.637278273240106' lng='-122.38275925627498'/>
    <coord lat='37.63639091467875' lng='-122.38255917271665'/>
    <coord lat='37.636138399260545' lng='-122.38241621829485'/>
    <coord lat='37.635982404647685' lng='-122.3821516226781'/>
    <coord lat='37.635817913406704' lng='-122.38198358751887'/>
    <coord lat='37.63574140492998' lng='-122.3818720269677'/>
    <coord lat='37.635681888920146' lng='-122.38182483957817'/>
    <coord lat='37.63555860827856' lng='-122.38169291678882'/>
    <coord lat='37.63555037633624' lng='-122.38148511379868'/>
    <coord lat='37.63557612913598' lng='-122.38126658192219'/>
    <coord lat='37.635538159792816' lng='-122.38116874954744'/>
    <coord lat='37.63549169408488' lng='-122.38107091728388'/>
    <coord lat='37.63549434527974' lng='-122.38077064677205'/>
    <coord lat='37.635399288191515' lng='-122.38053474970907'/>
    <coord lat='37.6354741568163' lng='-122.38020497525972'/>
    <coord lat='37.63543857284139' lng='-122.3799288448305'/>
    <coord lat='37.63547785609034' lng='-122.37971990645532'/>
    <coord lat='37.63539708993638' lng='-122.37912018993362'/>
    <coord lat='37.635320570715955' lng='-122.37900327261363'/>
    <coord lat='37.63519307362368' lng='-122.37904728793464'/>
    <coord lat='37.63518290874634' lng='-122.37967049552752'/>
    <coord lat='37.63523221348568' lng='-122.38039026261164'/>
    <coord lat='37.635211873243904' lng='-122.38057452272865'/>
    <coord lat='37.63520517459998' lng='-122.38100741581538'/>
    <coord lat='37.635259740950346' lng='-122.38168008382016'/>
    <coord lat='37.635190442023074' lng='-122.38236023049483'/>
    <coord lat='37.63524008150353' lng='-122.38295991125027'/>
    <coord lat='37.63523873903974' lng='-122.38374198266781'/>
    <coord lat='37.635199382427906' lng='-122.38418805703623'/>
    <coord lat='37.63522798966303' lng='-122.38448929275901'/>
    <coord lat='37.63523960349285' lng='-122.38479052864487'/>
    <coord lat='37.63519496058881' lng='-122.38553725846758'/>
    <coord lat='37.635030323340246' lng='-122.38680916362244'/>
    <coord lat='37.63491665902047' lng='-122.38709401294453'/>
    <coord lat='37.63437920937107' lng='-122.387910466586'/>
    <coord lat='37.63408872391046' lng='-122.38822186639779'/>
    <coord lat='37.6337812447869' lng='-122.38851180611788'/>
    <coord lat='37.633565620459024' lng='-122.38861961530883'/>
    <coord lat='37.63355495180222' lng='-122.38874939847048'/>
    <coord lat='37.63342004560324' lng='-122.3888572052368'/>
    <coord lat='37.633183180994926' lng='-122.38892209622686'/>
    <coord lat='37.63119488595596' lng='-122.38893489203194'/>
    <coord lat='37.63089355605594' lng='-122.38883592852673'/>
    <coord lat='37.63034581775197' lng='-122.38841510290897'/>
    <coord lat='37.629679427227835' lng='-122.3876163779969'/>
    <coord lat='37.62938021753512' lng='-122.38710973139942'/>
    <coord lat='37.62911499362356' lng='-122.38660308864965'/>
    <coord lat='37.628955980691124' lng='-122.3861822787566'/>
    <coord lat='37.62888193699301' lng='-122.3858794871947'/>
    <coord lat='37.62881851780947' lng='-122.38565181672273'/>
    <coord lat='37.628829293100175' lng='-122.3853234048918'/>
    <coord lat='37.62889104986389' lng='-122.38502717926427'/>
    <coord lat='37.62924383145685' lng='-122.38383778363463'/>
    <coord lat='37.62975804100336' lng='-122.38235869386685'/>
    <coord lat='37.630123538797264' lng='-122.38146967618616'/>
    <coord lat='37.63032752583398' lng='-122.38065501829641'/>
    <coord lat='37.63041677177334' lng='-122.38025841664533'/>
    <coord lat='37.630463531689635' lng='-122.3797652546556'/>
    <coord lat='37.63053204757799' lng='-122.37967996648601'/>
    <coord lat='37.63066169060225' lng='-122.37959822834978'/>
    <coord lat='37.631301143037994' lng='-122.37937701377719'/>
    <coord lat='37.631500953478394' lng='-122.37921353289656'/>
    <coord lat='37.631543710367396' lng='-122.37898849318111'/>
    <coord lat='37.63142110378628' lng='-122.3787766562681'/>
    <coord lat='37.63105209000022' lng='-122.37821613481431'/>
    <coord lat='37.6307829134873' lng='-122.37792652084174'/>
    <coord lat='37.630333941798085' lng='-122.37768515588624'/>
    <coord lat='37.630269493995755' lng='-122.37762481507157'/>
    <coord lat='37.63019230084055' lng='-122.37758056761074'/>
    <coord lat='37.62974477133838' lng='-122.3776154544803'/>
    <coord lat='37.62960304655651' lng='-122.37752969479865'/>
    <coord lat='37.629464348580825' lng='-122.37729905996629'/>
    <coord lat='37.62929987849887' lng='-122.37696113945273'/>
    <coord lat='37.62929274276486' lng='-122.37685254662418'/>
    <coord lat='37.6293026009402' lng='-122.37676004704603'/>
    <coord lat='37.629369813659395' lng='-122.37654684800536'/>
    <coord lat='37.62938179566318' lng='-122.37639802178813'/>
    <coord lat='37.62894909651639' lng='-122.37558238479374'/>
    <coord lat='37.628815503913444' lng='-122.37545863814536'/>
    <coord lat='37.62871956471669' lng='-122.37532038692127'/>
    <coord lat='37.62874558593954' lng='-122.37509033529773'/>
    <coord lat='37.62883320973628' lng='-122.3746725284801'/>
    <coord lat='37.62877319788776' lng='-122.37446930647312'/>
    <coord lat='37.62860697238298' lng='-122.37427949640929'/>
    <coord lat='37.62827186675561' lng='-122.37412053232424'/>
    <coord lat='37.628172290654426' lng='-122.37400886425647'/>
    <coord lat='37.62814069145455' lng='-122.37391328962562'/>
    <coord lat='37.62809287674637' lng='-122.3738367308034'/>
    <coord lat='37.6279983271087' lng='-122.37328005697248'/>
    <coord lat='37.627996163041104' lng='-122.37281580485315'/>
    <coord lat='37.62803810725884' lng='-122.37265414496775'/>
    <coord lat='37.62820750790599' lng='-122.3722671787451'/>
    <coord lat='37.62832486331945' lng='-122.37210149412614'/>
    <coord lat='37.62846133717724' lng='-122.37201091073928'/>
    <coord lat='37.62854416121735' lng='-122.3718284023701'/>
    <coord lat='37.62856325680299' lng='-122.37162443606381'/>
    <coord lat='37.627281767379976' lng='-122.36853558245355'/>
    <coord lat='37.62897996121147' lng='-122.36728755899973'/>
    <coord lat='37.628195178451215' lng='-122.36529916303218'/>
    <coord lat='37.62679562406732' lng='-122.3649274538851'/>
    <coord lat='37.62148189688587' lng='-122.36830417257026'/>
    <coord lat='37.620915400304895' lng='-122.36812581799947'/>
    <coord lat='37.620484869916034' lng='-122.36760414536882'/>
    <coord lat='37.62064919555755' lng='-122.36669624111622'/>
    <coord lat='37.620575568333834' lng='-122.36553084353352'/>
    <coord lat='37.62000920432862' lng='-122.36473180447308'/>
    <coord lat='37.619250127001266' lng='-122.36446103632906'/>
    <coord lat='37.61896694446148' lng='-122.36419027198085'/>
    <coord lat='37.614865403349675' lng='-122.35473062190712'/>
    <coord lat='37.60924697035062' lng='-122.35864255635302'/>
    <coord lat='37.612331638125504' lng='-122.366543855645'/>
    <coord lat='37.61385063688308' lng='-122.36974233635695'/>
    <coord lat='37.61448572801625' lng='-122.3705376156348'/>
    <coord lat='37.61473604847023' lng='-122.37144155001829'/>
    <coord lat='37.61375426237099' lng='-122.3728603523686'/>
    <coord lat='37.61114068136825' lng='-122.37462240058'/>
    <coord lat='37.60999299816851' lng='-122.37514238178116'/>
    <coord lat='37.60871754494651' lng='-122.37566730707937'/>
    <coord lat='37.60837524748541' lng='-122.3763081117173'/>
    <coord lat='37.607894756835094' lng='-122.37698878404585'/>
    <coord lat='37.60734186977102' lng='-122.3772343008935'/>
    <coord lat='37.60678018057324' lng='-122.3772103798353'/>
    <coord lat='37.60654082044124' lng='-122.37776323945019'/>
    <coord lat='37.60633414636743' lng='-122.37835385004068'/>
    <coord lat='37.6057849293009' lng='-122.37850508784703'/>
    <coord lat='37.60529856598648' lng='-122.37794940192539'/>
  </outline>
  <marker lat="37.640278" lng="-122.381667"/>
  <tide_station>369</tide_station>
  <city>JJR9+48_South_San_Francisco</city>
  <details><![CDATA[
      <p><b>Overview: </b>Stay at least 200 yards from shore. The SFO security zone is marked with small white buoys that have orange reflective striping and the words &#x201C;security zone&#x201D; emblazoned upon them. The orange diamond on each buoy indicates no entry.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.govinfo.gov/content/pkg/FR-2004-06-21/pdf/FR-2004-06-21.pdf">Federal Register Vol 69 No 118 - see pg 34280</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="406" title="Albany Mudflats State Marine Park" zone="530" modtime="1670952260402" modby="petolino" edits_since="1669823436164" >
  <outline>
    <coord lat='37.89101995282184' lng='-122.32330739612775'/>
    <coord lat='37.890435815115' lng='-122.32311177307201'/>
    <coord lat='37.890194548385274' lng='-122.32300323392109'/>
    <coord lat='37.8899702156747' lng='-122.322851780248'/>
    <coord lat='37.889986666953035' lng='-122.32200994585747'/>
    <coord lat='37.889935361897614' lng='-122.31983773721224'/>
    <coord lat='37.89046826880008' lng='-122.3188671487938'/>
    <coord lat='37.890683916350284' lng='-122.3181350849934'/>
    <coord lat='37.890941894689846' lng='-122.31739228705821'/>
    <coord lat='37.89093236816221' lng='-122.31629865277141'/>
    <coord lat='37.89125064701791' lng='-122.31616106199114'/>
    <coord lat='37.89170439703969' lng='-122.3161844030008'/>
    <coord lat='37.89172288262955' lng='-122.31397399078443'/>
    <coord lat='37.890685682892034' lng='-122.31263042760834'/>
    <coord lat='37.890378753490175' lng='-122.31215177428908'/>
    <coord lat='37.89029196625833' lng='-122.31186624206217'/>
    <coord lat='37.89010568979783' lng='-122.31186235207795'/>
    <coord lat='37.88977547247963' lng='-122.31168338151204'/>
    <coord lat='37.889644232297336' lng='-122.31156342056994'/>
    <coord lat='37.88966460641377' lng='-122.31144190068295'/>
    <coord lat='37.88978235257994' lng='-122.31137938926946'/>
    <coord lat='37.89000514404183' lng='-122.31142066327429'/>
    <coord lat='37.890044305382006' lng='-122.31136373624095'/>
    <coord lat='37.890034249663685' lng='-122.31128967414772'/>
    <coord lat='37.88963470670425' lng='-122.31111905321058'/>
    <coord lat='37.88919917670825' lng='-122.31039053582862'/>
    <coord lat='37.88882688292844' lng='-122.31016575531645'/>
    <coord lat='37.888598399649375' lng='-122.30988170521918'/>
    <coord lat='37.88833174665414' lng='-122.30966994357786'/>
    <coord lat='37.88823443922028' lng='-122.30953328465009'/>
    <coord lat='37.8883233388684' lng='-122.30951462825958'/>
    <coord lat='37.88853713444584' lng='-122.30965550380098'/>
    <coord lat='37.888767864466686' lng='-122.30973200698223'/>
    <coord lat='37.888966839069475' lng='-122.30957387634884'/>
    <coord lat='37.88913194470304' lng='-122.30954449128454'/>
    <coord lat='37.88950448259351' lng='-122.30942695096921'/>
    <coord lat='37.89075759136547' lng='-122.30917040736571'/>
    <coord lat='37.891968326941615' lng='-122.30919007890972'/>
    <coord lat='37.89238317404974' lng='-122.30934922624013'/>
    <coord lat='37.89304353481534' lng='-122.30971044226358'/>
    <coord lat='37.89361012972552' lng='-122.30976340167493'/>
    <coord lat='37.89405819059644' lng='-122.31011677129615'/>
    <coord lat='37.89451404650497' lng='-122.31030852958104'/>
    <coord lat='37.89496856180647' lng='-122.31084225868048'/>
    <coord lat='37.895230045535136' lng='-122.31104688534117'/>
    <coord lat='37.89540686378274' lng='-122.31129442869222'/>
    <coord lat='37.89593927292552' lng='-122.31140249966917'/>
    <coord lat='37.89608222597252' lng='-122.31161786049046'/>
    <coord lat='37.8963244831688' lng='-122.31163769395174'/>
    <coord lat='37.89648207652953' lng='-122.31176481617277'/>
    <coord lat='37.896644868828204' lng='-122.31174011094537'/>
    <coord lat='37.89672492886294' lng='-122.31223787262209'/>
    <coord lat='37.89688430451504' lng='-122.31265186967414'/>
    <coord lat='37.89506560113637' lng='-122.32273807936697'/>
    <coord lat='37.89510440321361' lng='-122.32106473044892'/>
    <coord lat='37.8910851682362' lng='-122.32102200444152'/>
  </outline>
  <marker lat="37.896884" lng="-122.312652"/>
  <tide_station>293</tide_station>
  <city>VMWP+QW_Albany</city>
  <details><![CDATA[
      <p><b>Overview: </b>Boating is prohibited within the Park year-round.<p>See the map link in the DFW Marine Protected Areas website referenced below. Although we couldn&#x27;t find a precise definition of this area, we&#x27;ve made an attempt to copy its boundaries from the DFW map onto our map.</p>
      <p><b>Links: </b><a target="tp_details" href="https://wildlife.ca.gov/Conservation/Marine/MPAs/Network/San-Francisco-Bay#26760433-albany-mudflats-state-marine-park">Marine Protected Areas &#x28;CA DFW&#x29;</a></p>
  ]]></details>
</station>

<station station_type="nogo" xid="408" title="Conoco-Philips Security Zone" zone="530" modtime="1670953211908" modby="petolino" edits_since="1669938588307" >
  <outline>
    <coord lat='38.05166666666666' lng='-122.259'/>
    <coord lat='38.05575' lng='-122.25994444444447'/>
    <coord lat='38.05605555555555' lng='-122.25827777777779'/>
    <coord lat='38.05808333333333' lng='-122.25883333333336'/>
    <coord lat='38.0566111111111' lng='-122.2655'/>
    <coord lat='38.054666666666655' lng='-122.26477777777777'/>
    <coord lat='38.055166666666665' lng='-122.26255555555555'/>
    <coord lat='38.051111111111105' lng='-122.26166666666664'/>
  </outline>
  <marker lat="38.058083" lng="-122.258833"/>
  <current_station>92</current_station>
  <city>3P5R+6F_Vallejo</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Code of Federal Regulations &#xA7; 165.1197 a2</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="409" title="Shell Terminal Security Zone" zone="530" modtime="1670953274284" modby="petolino" edits_since="1669938671491" >
  <outline>
    <coord lat='38.027722222222216' lng='-122.1278611111111'/>
    <coord lat='38.031666666666666' lng='-122.12861111111108'/>
    <coord lat='38.032472222222225' lng='-122.12719444444444'/>
    <coord lat='38.03408333333333' lng='-122.12850000000002'/>
    <coord lat='38.03041666666667' lng='-122.13575'/>
    <coord lat='38.028805555555564' lng='-122.13450000000003'/>
    <coord lat='38.030583333333325' lng='-122.13069444444444'/>
    <coord lat='38.02675' lng='-122.12988888888891'/>
  </outline>
  <marker lat="38.034083" lng="-122.1285"/>
  <current_station>48</current_station>
  <city>2VMC+JJ_Martinez</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Code of Federal Regulations &#xA7; 165.1197 a3</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="410" title="Amorco Pier Security Zone" zone="530" modtime="1670953241667" modby="petolino" edits_since="1669939368851" >
  <outline>
    <coord lat='38.034194444444445' lng='-122.11997222222222'/>
    <coord lat='38.03488888888889' lng='-122.12191666666666'/>
    <coord lat='38.03552777777778' lng='-122.12080555555553'/>
    <coord lat='38.036944444444444' lng='-122.12205555555556'/>
    <coord lat='38.034916666666675' lng='-122.12663888888889'/>
    <coord lat='38.03347222222222' lng='-122.12530555555554'/>
    <coord lat='38.03383333333333' lng='-122.12424999999996'/>
    <coord lat='38.03194444444444' lng='-122.11972222222222'/>
  </outline>
  <marker lat="38.036944" lng="-122.122056"/>
  <current_station>48</current_station>
  <city>2VPH+Q5_Martinez</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Code of Federal Regulations &#xA7; 165.1197 a4</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="411" title="Valero Security Zone" zone="530" modtime="1670953261508" modby="petolino" edits_since="1669939476411" >
  <outline>
    <coord lat='38.04377777777777' lng='-122.1309722222222'/>
    <coord lat='38.042972222222225' lng='-122.13025000000002'/>
    <coord lat='38.04558333333333' lng='-122.12636111111111'/>
    <coord lat='38.04666666666667' lng='-122.12719444444444'/>
    <coord lat='38.04658333333334' lng='-122.1283611111111'/>
  </outline>
  <marker lat="38.046667" lng="-122.127194"/>
  <current_station>31</current_station>
  <city>Benicia</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Code of Federal Regulations &#xA7; 165.1197 a5</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="412" title="Avon Pier Security Zone" zone="530" modtime="1670953227996" modby="petolino" edits_since="1669939864577" >
  <outline>
    <coord lat='38.04645305210758' lng='-122.08807736248441'/>
    <coord lat='38.04730330166688' lng='-122.08846535962054'/>
    <coord lat='38.04764661141424' lng='-122.08816671197717'/>
    <coord lat='38.04833333333333' lng='-122.08874999999999'/>
    <coord lat='38.04883333333333' lng='-122.08780555555556'/>
    <coord lat='38.05058333333333' lng='-122.08872222222222'/>
    <coord lat='38.04863888888889' lng='-122.09516666666666'/>
    <coord lat='38.046888888888894' lng='-122.09422222222221'/>
    <coord lat='38.04788888888888' lng='-122.09102777777778'/>
    <coord lat='38.046182407140684' lng='-122.08948045370313'/>
    <coord lat='38.04623324070294' lng='-122.08877890939047'/>
  </outline>
  <marker lat="38.050583" lng="-122.088722"/>
  <current_station>32</current_station>
  <city>3W26+6G_Martinez</city>
  <details><![CDATA[
      <p><b>Overview: </b>U.S. Coast Guard Security Zone. Stay back 100 yards from the pier.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ecfr.gov/current/title-33/chapter-I/subchapter-P/part-165/subpart-F/subject-group-ECFR69309028f4312ba/section-165.1197">Code of Federal Regulations &#xA7; 165.1197 a6</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="413" title="Cowell Ranch State Beach" zone="545" modtime="1670952847661" modby="petolino" edits_since="1670278987417" >
  <outline>
    <coord lat='37.41312613805305' lng='-122.43445429093916'/>
    <coord lat='37.40979356160889' lng='-122.43082047076516'/>
    <coord lat='37.405809270441345' lng='-122.4300338560744'/>
    <coord lat='37.40340813776385' lng='-122.42766657703707'/>
    <coord lat='37.399957529250884' lng='-122.42425147546791'/>
    <coord lat='37.393157248567505' lng='-122.42357253159336'/>
    <coord lat='37.39307357908586' lng='-122.42136917187969'/>
    <coord lat='37.39531189036145' lng='-122.42133489252944'/>
    <coord lat='37.39731759851428' lng='-122.42217612012095'/>
    <coord lat='37.39907057310812' lng='-122.42229642378487'/>
    <coord lat='37.40032214158358' lng='-122.42252828625888'/>
    <coord lat='37.402004814882005' lng='-122.42345964904146'/>
    <coord lat='37.40301664127313' lng='-122.42486953941938'/>
    <coord lat='37.40478392036227' lng='-122.42626119351615'/>
    <coord lat='37.406213017906985' lng='-122.42687125197293'/>
    <coord lat='37.40815542737021' lng='-122.42676629449471'/>
    <coord lat='37.40996148084584' lng='-122.42640383325762'/>
    <coord lat='37.410642632809605' lng='-122.42823009278203'/>
    <coord lat='37.41200551485677' lng='-122.42971307470143'/>
    <coord lat='37.41403922068834' lng='-122.43142383209361'/>
    <coord lat='37.416470684204356' lng='-122.43330082956757'/>
    <coord lat='37.41901608386842' lng='-122.43413690636531'/>
    <coord lat='37.41973799320523' lng='-122.43486587790713'/>
    <coord lat='37.42001680925568' lng='-122.4358094373453'/>
    <coord lat='37.41672485809534' lng='-122.4359043091686'/>
  </outline>
  <marker lat="37.420017" lng="-122.435809"/>
  <tide_station>283</tide_station>
  <city>CHC7+2M_Half_Moon_Bay</city>
  <details><![CDATA[
      <p><b>Overview: </b>The beaches below the Cowell-Purisima Trail are closed to protect harbor seal habitat - see link below. We couldn&#x27;t find a map of the State Park boundary, so the area shown on the map is just a guess.</p>
      <p><b>Links: </b><a target="tp_details" href="http://www.coastsidestateparks.org/cowell-ranch-state-beach">Cowell Ranch State Beach</a></p>
  ]]></details>
</station>
<station station_type="nogo" xid="414" title="Don Edwards National Wildlife Refuge salt ponds" zone="531" modtime="1671218267405" modby="petolino" edits_since="1671215628954" >
  <outline>
    <coord lat='37.42834804311995' lng='-122.06704722192383'/>
    <coord lat='37.42684954781596' lng='-122.05813759937098'/>
    <coord lat='37.42637247736917' lng='-122.04917665903628'/>
    <coord lat='37.42742864114064' lng='-122.0439237313768'/>
    <coord lat='37.42698484365782' lng='-122.03489419501383'/>
    <coord lat='37.43566119532267' lng='-122.0282400974854'/>
    <coord lat='37.438824351280964' lng='-122.02985440954285'/>
    <coord lat='37.44089708872157' lng='-122.03112549978474'/>
    <coord lat='37.4398349313936' lng='-122.03368412726476'/>
    <coord lat='37.43959050339493' lng='-122.03624271007016'/>
    <coord lat='37.44133875157455' lng='-122.03961089681229'/>
    <coord lat='37.44478840958281' lng='-122.04132411705989'/>
    <coord lat='37.44732660049518' lng='-122.0402873252342'/>
    <coord lat='37.44817823148019' lng='-122.03684002543255'/>
    <coord lat='37.44664500249241' lng='-122.03236237894069'/>
    <coord lat='37.449609051023394' lng='-122.03097458114065'/>
    <coord lat='37.450903768200895' lng='-122.0342219599857'/>
    <coord lat='37.45083559944573' lng='-122.037984380431'/>
    <coord lat='37.45069917867827' lng='-122.04035939092664'/>
    <coord lat='37.44701853489304' lng='-122.04934530532995'/>
    <coord lat='37.44742511490497' lng='-122.05289806153087'/>
    <coord lat='37.44632975539787' lng='-122.05777242785749'/>
    <coord lat='37.44495635429928' lng='-122.05996809823183'/>
    <coord lat='37.44509767398128' lng='-122.06300492055144'/>
    <coord lat='37.448597007134914' lng='-122.06682697250089'/>
    <coord lat='37.45005202493793' lng='-122.06893260696118'/>
    <coord lat='37.448292364456506' lng='-122.0731613449954'/>
    <coord lat='37.44857679283949' lng='-122.07687502058376'/>
    <coord lat='37.45009907909548' lng='-122.08653405351178'/>
    <coord lat='37.44896636293075' lng='-122.08912117374385'/>
    <coord lat='37.445883241749755' lng='-122.08794339892671'/>
    <coord lat='37.44326025023991' lng='-122.08833398938357'/>
    <coord lat='37.439513141868815' lng='-122.09048774674521'/>
    <coord lat='37.435561644215085' lng='-122.09771231899'/>
  </outline>
  <outline>
    <coord lat='37.43904755775999' lng='-122.00036173283355'/>
    <coord lat='37.43680513656635' lng='-121.9927681057679'/>
    <coord lat='37.43435819272187' lng='-121.99375771964202'/>
    <coord lat='37.43119801027983' lng='-121.98910644384732'/>
    <coord lat='37.42865289642201' lng='-121.98309423977791'/>
    <coord lat='37.42638028704341' lng='-121.98120216309505'/>
    <coord lat='37.42047184393725' lng='-121.98102322332406'/>
    <coord lat='37.41881150824617' lng='-121.98538495037748'/>
    <coord lat='37.41837784481225' lng='-121.99386637091729'/>
    <coord lat='37.42104561183681' lng='-121.99835629095901'/>
    <coord lat='37.42272030747652' lng='-121.9997001307939'/>
    <coord lat='37.42521296880742' lng='-122.00001404849914'/>
    <coord lat='37.43000291177118' lng='-122.00581933124289'/>
    <coord lat='37.43208489033309' lng='-122.0051553230668'/>
    <coord lat='37.43389424484173' lng='-122.00586460708323'/>
    <coord lat='37.435215129064616' lng='-122.01308398372102'/>
    <coord lat='37.43308556006642' lng='-122.0220291953028'/>
    <coord lat='37.43731895450008' lng='-122.02660931005299'/>
    <coord lat='37.440870770537124' lng='-122.02758482485002'/>
    <coord lat='37.4428214701029' lng='-122.03134991660475'/>
    <coord lat='37.44161606041063' lng='-122.03537830175385'/>
    <coord lat='37.44313642264263' lng='-122.03803340995367'/>
    <coord lat='37.44505706819093' lng='-122.03852180503081'/>
    <coord lat='37.445887400261086' lng='-122.03677857913854'/>
    <coord lat='37.44454966834824' lng='-122.03312044264717'/>
    <coord lat='37.44557795293813' lng='-122.02879412666874'/>
    <coord lat='37.44974076308321' lng='-122.02824419180563'/>
    <coord lat='37.453154017818676' lng='-122.03104174065024'/>
    <coord lat='37.454386695288164' lng='-122.03761613084455'/>
    <coord lat='37.459775493099116' lng='-122.03251699693108'/>
    <coord lat='37.46114428398735' lng='-122.02733160406427'/>
    <coord lat='37.45988628074987' lng='-122.024051986063'/>
    <coord lat='37.45683856679558' lng='-122.02176861544051'/>
    <coord lat='37.45572357399989' lng='-122.02088454430825'/>
    <coord lat='37.45377546263326' lng='-122.02027731565565'/>
    <coord lat='37.44978325090995' lng='-122.02138668083292'/>
    <coord lat='37.44670477021885' lng='-122.01965729344228'/>
    <coord lat='37.445447031070714' lng='-122.01715165267449'/>
    <coord lat='37.44592019545141' lng='-122.01413484861655'/>
    <coord lat='37.446938433266986' lng='-122.01128964750711'/>
    <coord lat='37.44665797718917' lng='-122.00886080278157'/>
    <coord lat='37.44515086109024' lng='-122.00677539244116'/>
    <coord lat='37.44194010459292' lng='-122.00606337302587'/>
    <coord lat='37.43953978322919' lng='-122.00432829678087'/>
  </outline>
  <outline>
    <coord lat='37.4625278938064' lng='-121.99709850756459'/>
    <coord lat='37.46051027739581' lng='-121.99644569111403'/>
    <coord lat='37.4614774056982' lng='-121.99234285613635'/>
    <coord lat='37.45991692630798' lng='-121.98479864659221'/>
    <coord lat='37.4472810239321' lng='-121.96686519690891'/>
    <coord lat='37.44078324098964' lng='-121.95985041191913'/>
    <coord lat='37.44096362630717' lng='-121.97635283503095'/>
    <coord lat='37.43979290407603' lng='-121.9780807049357'/>
    <coord lat='37.43153452001461' lng='-121.97792020095972'/>
    <coord lat='37.430363884165345' lng='-121.98368170436437'/>
    <coord lat='37.43100530271493' lng='-121.98647662416636'/>
    <coord lat='37.43232825160119' lng='-121.98789830827955'/>
    <coord lat='37.434403772713694' lng='-121.99087665410781'/>
    <coord lat='37.43838756505861' lng='-121.9912802161801'/>
    <coord lat='37.43967620993422' lng='-121.99397577691357'/>
    <coord lat='37.44264929171745' lng='-122.00252554387411'/>
    <coord lat='37.44682314702371' lng='-122.0053774763381'/>
    <coord lat='37.44808331600021' lng='-122.01159642312825'/>
    <coord lat='37.447459257455634' lng='-122.01449581309484'/>
    <coord lat='37.447789035463515' lng='-122.01713769452617'/>
    <coord lat='37.449214510578955' lng='-122.0184586908573'/>
    <coord lat='37.45132138583947' lng='-122.0180630952678'/>
    <coord lat='37.452537011535355' lng='-122.01692855284871'/>
    <coord lat='37.456036637736844' lng='-122.01702544978954'/>
    <coord lat='37.45783287850901' lng='-122.01840998957667'/>
    <coord lat='37.46031043032258' lng='-122.01945127592761'/>
    <coord lat='37.46156378137845' lng='-122.01562218989962'/>
    <coord lat='37.46328037487005' lng='-122.00392286059878'/>
    <coord lat='37.46254393643368' lng='-122.00149315304726'/>
    <coord lat='37.461139074848894' lng='-122.00084028528289'/>
  </outline>
  <outline>
    <coord lat='37.562006222252016' lng='-122.12870268507127'/>
    <coord lat='37.54710367909407' lng='-122.11934511251735'/>
    <coord lat='37.533934913211176' lng='-122.11226455607625'/>
    <coord lat='37.529885425678195' lng='-122.11111642418824'/>
    <coord lat='37.514093117846606' lng='-122.10949456742362'/>
    <coord lat='37.52287421699736' lng='-122.10221004675887'/>
    <coord lat='37.53100541934958' lng='-122.09246992667997'/>
    <coord lat='37.533372515192156' lng='-122.08674255293741'/>
    <coord lat='37.53519463383385' lng='-122.07758153351003'/>
    <coord lat='37.538907351720404' lng='-122.08826487125143'/>
    <coord lat='37.54459920612297' lng='-122.08690221845941'/>
    <coord lat='37.54729657570745' lng='-122.0924062571265'/>
    <coord lat='37.551707151693485' lng='-122.09601653894025'/>
    <coord lat='37.55894766135545' lng='-122.09902356205018'/>
    <coord lat='37.56373867365321' lng='-122.099627617418'/>
    <coord lat='37.56161776986307' lng='-122.10735915936687'/>
    <coord lat='37.56548387960619' lng='-122.10925432726219'/>
    <coord lat='37.56878659372322' lng='-122.11573860094487'/>
    <coord lat='37.56950374365195' lng='-122.12187983489471'/>
    <coord lat='37.56643536800964' lng='-122.12640715768569'/>
  </outline>
  <outline>
    <coord lat='37.499920931273685' lng='-122.10702896118165'/>
    <coord lat='37.50448390180084' lng='-122.1098605960516'/>
    <coord lat='37.50986201319935' lng='-122.11045967712855'/>
    <coord lat='37.52323746531475' lng='-122.09977236054864'/>
    <coord lat='37.530212810926976' lng='-122.09080107143751'/>
    <coord lat='37.53223871471529' lng='-122.08597449888586'/>
    <coord lat='37.53385589687096' lng='-122.07822937588686'/>
    <coord lat='37.537923097114714' lng='-122.0677385171621'/>
    <coord lat='37.535577615945584' lng='-122.06540088972756'/>
    <coord lat='37.521676184210285' lng='-122.06114246147224'/>
    <coord lat='37.519422644994975' lng='-122.06038717089525'/>
    <coord lat='37.517002429069585' lng='-122.06679021691092'/>
    <coord lat='37.51266073351478' lng='-122.06467015893189'/>
    <coord lat='37.512100777463814' lng='-122.06134395605264'/>
    <coord lat='37.51164722167324' lng='-122.06000542210376'/>
    <coord lat='37.513931779089035' lng='-122.05793058379332'/>
    <coord lat='37.513984709942896' lng='-122.05560568417866'/>
    <coord lat='37.511314345497155' lng='-122.05499744976554'/>
    <coord lat='37.508559855996204' lng='-122.05440973696875'/>
    <coord lat='37.50040777035794' lng='-122.05771968656657'/>
    <coord lat='37.49876145944977' lng='-122.05356917989586'/>
    <coord lat='37.496978735536416' lng='-122.05053449071096'/>
    <coord lat='37.49444662515236' lng='-122.04870167079264'/>
    <coord lat='37.49495113582156' lng='-122.04276424443759'/>
    <coord lat='37.4940008328802' lng='-122.03493754771067'/>
    <coord lat='37.4911070542232' lng='-122.03250877984908'/>
    <coord lat='37.49005198376875' lng='-122.0306809957626'/>
    <coord lat='37.4886561367043' lng='-122.02958310940811'/>
    <coord lat='37.48802622805678' lng='-122.030321714468'/>
    <coord lat='37.484987033190954' lng='-122.03034775945375'/>
    <coord lat='37.482854319283845' lng='-122.03001769873603'/>
    <coord lat='37.48001694565582' lng='-122.02813620881855'/>
    <coord lat='37.48363823593' lng='-122.02607979031674'/>
    <coord lat='37.48544888740471' lng='-122.02324880040251'/>
    <coord lat='37.48519633438227' lng='-122.01822820933634'/>
    <coord lat='37.48277969365427' lng='-122.01515723035106'/>
    <coord lat='37.487310032322895' lng='-122.0131161473087'/>
    <coord lat='37.48870737335665' lng='-122.01184747863822'/>
    <coord lat='37.49051333791811' lng='-122.01212374108182'/>
    <coord lat='37.49405957482654' lng='-122.01185538155843'/>
    <coord lat='37.4950227941142' lng='-122.00685509671447'/>
    <coord lat='37.49328647246122' lng='-122.01082323102042'/>
    <coord lat='37.4906475787496' lng='-122.01083294191464'/>
    <coord lat='37.48837472050407' lng='-122.01015102254894'/>
    <coord lat='37.48676159836432' lng='-122.01204156297618'/>
    <coord lat='37.481247561467924' lng='-122.01455246549124'/>
    <coord lat='37.484315193559596' lng='-122.01860821288285'/>
    <coord lat='37.484320411404155' lng='-122.02311474535121'/>
    <coord lat='37.48255992864586' lng='-122.02543282094496'/>
    <coord lat='37.4786096586492' lng='-122.02667081041734'/>
    <coord lat='37.47852615740706' lng='-122.02902693735979'/>
    <coord lat='37.48218852690017' lng='-122.03128437194351'/>
    <coord lat='37.48549429389374' lng='-122.03185142313954'/>
    <coord lat='37.487678644037175' lng='-122.03204190771157'/>
    <coord lat='37.48993573065662' lng='-122.0327663738889'/>
    <coord lat='37.491725423571474' lng='-122.03412971755579'/>
    <coord lat='37.493125125789994' lng='-122.03719996436547'/>
    <coord lat='37.49285749583624' lng='-122.05286766428898'/>
    <coord lat='37.49604696711513' lng='-122.05740704878174'/>
    <coord lat='37.49779468616833' lng='-122.06185134376817'/>
    <coord lat='37.49992654320846' lng='-122.0738307178586'/>
    <coord lat='37.50173769380196' lng='-122.08045249267289'/>
    <coord lat='37.50434178112672' lng='-122.07901704463866'/>
    <coord lat='37.50420816363219' lng='-122.08400897191628'/>
    <coord lat='37.50545852524383' lng='-122.0841854562942'/>
    <coord lat='37.50670888662081' lng='-122.08367528957561'/>
    <coord lat='37.50780268929581' lng='-122.08181630272094'/>
    <coord lat='37.508215586184924' lng='-122.07961395212585'/>
    <coord lat='37.50904241312506' lng='-122.07456759618385'/>
    <coord lat='37.50750678696176' lng='-122.07094601102537'/>
    <coord lat='37.50751576279571' lng='-122.06866432744482'/>
    <coord lat='37.50568183471798' lng='-122.06340363411479'/>
    <coord lat='37.504664870171446' lng='-122.06174796176411'/>
    <coord lat='37.50672490963353' lng='-122.0566698603131'/>
    <coord lat='37.50583842314765' lng='-122.06147189507006'/>
    <coord lat='37.50699450460058' lng='-122.06284071343072'/>
    <coord lat='37.50855753208123' lng='-122.06892582924574'/>
    <coord lat='37.50902797663069' lng='-122.07122566285535'/>
    <coord lat='37.510179112082824' lng='-122.07369726570818'/>
    <coord lat='37.51037699479007' lng='-122.07668390201498'/>
    <coord lat='37.508989443571615' lng='-122.0814204565865'/>
    <coord lat='37.50696278908774' lng='-122.08505684016487'/>
    <coord lat='37.508935716181625' lng='-122.08445012744974'/>
    <coord lat='37.51192877152903' lng='-122.08134872760692'/>
    <coord lat='37.51369374374144' lng='-122.08115433521255'/>
    <coord lat='37.51504490412814' lng='-122.0835125651871'/>
    <coord lat='37.51420638743919' lng='-122.08822930225422'/>
    <coord lat='37.51606978247257' lng='-122.08770674049173'/>
    <coord lat='37.51966093923994' lng='-122.08563210218051'/>
    <coord lat='37.52480164212594' lng='-122.08302831207483'/>
    <coord lat='37.52582485961186' lng='-122.08554608565187'/>
    <coord lat='37.526778834268256' lng='-122.08860774084928'/>
    <coord lat='37.529094136984796' lng='-122.09081120453881'/>
    <coord lat='37.52814307695143' lng='-122.09212821403139'/>
    <coord lat='37.524746193839256' lng='-122.08983369403865'/>
    <coord lat='37.523765595804946' lng='-122.08546478835892'/>
    <coord lat='37.51992591821974' lng='-122.08744743071125'/>
    <coord lat='37.517039261775864' lng='-122.08900093380973'/>
    <coord lat='37.51360796550887' lng='-122.08969603483585'/>
    <coord lat='37.51268163289163' lng='-122.0887001603846'/>
    <coord lat='37.51383140241749' lng='-122.08392918800402'/>
    <coord lat='37.51266631881767' lng='-122.08310642786726'/>
    <coord lat='37.509230753004324' lng='-122.08633822888876'/>
    <coord lat='37.50338657272366' lng='-122.08707380794816'/>
    <coord lat='37.498191429575826' lng='-122.10425418184549'/>
  </outline>
  <outline>
    <coord lat='37.4657566954426' lng='-122.04833780159767'/>
    <coord lat='37.468481656945386' lng='-122.03666248561031'/>
    <coord lat='37.466446940370176' lng='-122.02193805817188'/>
    <coord lat='37.46859262723204' lng='-122.01249212133088'/>
    <coord lat='37.46937492916137' lng='-122.00098583764554'/>
    <coord lat='37.471111251631825' lng='-122.0029547368716'/>
    <coord lat='37.47366492252512' lng='-122.00767040995648'/>
    <coord lat='37.477416817626946' lng='-122.00706183513975'/>
    <coord lat='37.47934251529016' lng='-122.00420604943776'/>
    <coord lat='37.48004201885684' lng='-121.99843186873926'/>
    <coord lat='37.48142269223326' lng='-122.00038238008177'/>
    <coord lat='37.48307580083031' lng='-122.00044465713994'/>
    <coord lat='37.48413301708952' lng='-121.99883325653788'/>
    <coord lat='37.48437288638023' lng='-121.9967068374321'/>
    <coord lat='37.48580611437887' lng='-121.99451386174685'/>
    <coord lat='37.49303142161851' lng='-121.99974100896748'/>
    <coord lat='37.49449815256417' lng='-122.00535993594235'/>
    <coord lat='37.49305224224696' lng='-122.00671028460813'/>
    <coord lat='37.49242350515373' lng='-122.00909054972134'/>
    <coord lat='37.48885057686633' lng='-122.00827200337436'/>
    <coord lat='37.48800178155441' lng='-122.00676688029608'/>
    <coord lat='37.486513417505016' lng='-122.00795590639498'/>
    <coord lat='37.48626086039513' lng='-122.00964722254855'/>
    <coord lat='37.48017101974987' lng='-122.0125142202329'/>
    <coord lat='37.47929729218909' lng='-122.01635951231754'/>
    <coord lat='37.48193240630236' lng='-122.01869775372263'/>
    <coord lat='37.4829795764043' lng='-122.02182955660157'/>
    <coord lat='37.48171085623168' lng='-122.02290135128746'/>
    <coord lat='37.48016968466385' lng='-122.02380144751882'/>
    <coord lat='37.4768654284053' lng='-122.02379666094366'/>
    <coord lat='37.47625077973175' lng='-122.02533200043057'/>
    <coord lat='37.477071843578116' lng='-122.0299656384734'/>
    <coord lat='37.48034894345136' lng='-122.03322487828062'/>
    <coord lat='37.48417878793554' lng='-122.0342502134122'/>
    <coord lat='37.489386840576095' lng='-122.0378462549914'/>
    <coord lat='37.490949216380585' lng='-122.04332256005075'/>
    <coord lat='37.49012337651413' lng='-122.05341828841681'/>
    <coord lat='37.47648313164786' lng='-122.05060544056326'/>
    <coord lat='37.47201302974969' lng='-122.05203463457445'/>
    <coord lat='37.46693016977799' lng='-122.05131725407124'/>
  </outline>
  <outline>
    <coord lat='37.471036184976946' lng='-121.95940969192989'/>
    <coord lat='37.46994655294233' lng='-121.96366936123114'/>
    <coord lat='37.468720425129746' lng='-121.96674322892291'/>
    <coord lat='37.46831164685775' lng='-121.97119030538548'/>
    <coord lat='37.47008272265366' lng='-121.97335771040478'/>
    <coord lat='37.478150884188366' lng='-121.9721463157051'/>
    <coord lat='37.48012107396714' lng='-121.97302050404996'/>
    <coord lat='37.48031913197757' lng='-121.96874554085758'/>
    <coord lat='37.482213649281135' lng='-121.96877837419296'/>
    <coord lat='37.48259660325972' lng='-121.96420918121775'/>
    <coord lat='37.487721384719464' lng='-121.96416785684615'/>
    <coord lat='37.48802577024626' lng='-121.95395689063129'/>
    <coord lat='37.486727097056935' lng='-121.95121638030163'/>
    <coord lat='37.48385683239161' lng='-121.94899774050344'/>
    <coord lat='37.48153717884682' lng='-121.95190160623594'/>
    <coord lat='37.479151319323016' lng='-121.95189428878729'/>
    <coord lat='37.47824834185241' lng='-121.95403823094267'/>
    <coord lat='37.47598306814733' lng='-121.95429384708567'/>
    <coord lat='37.47485822229277' lng='-121.95720823687964'/>
  </outline>
  <outline>
    <coord lat='37.47743608397662' lng='-121.99445500010015'/>
    <coord lat='37.47782355644878' lng='-121.99773260255964'/>
    <coord lat='37.47793848568963' lng='-122.0008385651003'/>
    <coord lat='37.4772359804477' lng='-122.00334368426496'/>
    <coord lat='37.47626097630368' lng='-122.005162109396'/>
    <coord lat='37.47431111007595' lng='-122.00493643148798'/>
    <coord lat='37.4721100478181' lng='-122.00027460569434'/>
    <coord lat='37.47018140239664' lng='-121.9995611400662'/>
    <coord lat='37.470300821582185' lng='-121.99593452577832'/>
    <coord lat='37.469066137166465' lng='-121.9906880243557'/>
    <coord lat='37.46715006630303' lng='-121.98715832165435'/>
    <coord lat='37.467838633170594' lng='-121.98542955728476'/>
    <coord lat='37.469072160915516' lng='-121.98370074846501'/>
    <coord lat='37.47140289270896' lng='-121.98041464482102'/>
    <coord lat='37.47156811918696' lng='-121.97452890165569'/>
    <coord lat='37.47895389564971' lng='-121.97422173723243'/>
    <coord lat='37.48053524102881' lng='-121.97509816013157'/>
    <coord lat='37.48198035492156' lng='-121.97614628338255'/>
    <coord lat='37.48353771817912' lng='-121.97742045422389'/>
    <coord lat='37.48468638811114' lng='-121.98041131607111'/>
    <coord lat='37.48426260777542' lng='-121.99301249350974'/>
    <coord lat='37.48291554607244' lng='-121.99490947730695'/>
    <coord lat='37.482658189040116' lng='-121.99766471803764'/>
    <coord lat='37.48187101394149' lng='-121.99888362106044'/>
    <coord lat='37.481015809480354' lng='-121.99572510729669'/>
  </outline>
  <outline>
    <coord lat='37.462287429952084' lng='-121.95101219824902'/>
    <coord lat='37.46349741944643' lng='-121.95706404878591'/>
    <coord lat='37.46410229022668' lng='-121.96026169096693'/>
    <coord lat='37.46375329679228' lng='-121.96345934409132'/>
    <coord lat='37.46101099105426' lng='-121.97303038154257'/>
    <coord lat='37.46100223840654' lng='-121.98094840421146'/>
    <coord lat='37.46412687521383' lng='-121.98903842180638'/>
    <coord lat='37.465368780221276' lng='-121.98407576698594'/>
    <coord lat='37.46899482553269' lng='-121.97962791426121'/>
    <coord lat='37.469593158101155' lng='-121.97716404943924'/>
    <coord lat='37.46757599920588' lng='-121.97232723104337'/>
    <coord lat='37.46779343165818' lng='-121.96424425836105'/>
    <coord lat='37.470422377404034' lng='-121.95749924920827'/>
    <coord lat='37.47434923758044' lng='-121.95583450286334'/>
    <coord lat='37.471464128455324' lng='-121.95176645729245'/>
  </outline>
  <outline>
    <coord lat='37.462470618512555' lng='-121.99255904605273'/>
    <coord lat='37.4600525426202' lng='-121.98333005008182'/>
    <coord lat='37.450070244691254' lng='-121.96886640374716'/>
    <coord lat='37.45315176589958' lng='-121.96793893674206'/>
    <coord lat='37.45775859496156' lng='-121.9685910428765'/>
    <coord lat='37.459789426007276' lng='-121.9655698037446'/>
    <coord lat='37.45862468463645' lng='-121.97204148715643'/>
    <coord lat='37.45895866441758' lng='-121.97456490893255'/>
  </outline>
  <outline>
    <coord lat='37.46403283015508' lng='-122.11973522644978'/>
    <coord lat='37.461239577132154' lng='-122.12419939026087'/>
    <coord lat='37.47204098885718' lng='-122.12783096984481'/>
    <coord lat='37.474769577779476' lng='-122.12644151959879'/>
    <coord lat='37.47542443688219' lng='-122.12383416114301'/>
    <coord lat='37.47255285940951' lng='-122.12366472683117'/>
    <coord lat='37.47264979842576' lng='-122.12177764237126'/>
    <coord lat='37.47000749267175' lng='-122.11997583407671'/>
    <coord lat='37.46630925840851' lng='-122.11499854591153'/>
    <coord lat='37.46557311234929' lng='-122.11766464948238'/>
  </outline>
  <outline>
    <coord lat='37.5006359162734' lng='-122.15713594895341'/>
    <coord lat='37.50056814197071' lng='-122.15511886829455'/>
    <coord lat='37.499546799321166' lng='-122.15423909586912'/>
    <coord lat='37.49891672678292' lng='-122.15309119608972'/>
    <coord lat='37.49780998323517' lng='-122.15271579022195'/>
    <coord lat='37.49659404875004' lng='-122.15226648771853'/>
    <coord lat='37.493704751433725' lng='-122.153114800949'/>
    <coord lat='37.49287299413474' lng='-122.15298125111214'/>
    <coord lat='37.492784225825005' lng='-122.15183208926227'/>
    <coord lat='37.49242304799258' lng='-122.15119791691488'/>
    <coord lat='37.49281090508795' lng='-122.14940503554233'/>
    <coord lat='37.49225566352929' lng='-122.14662027621313'/>
    <coord lat='37.491705540534284' lng='-122.14359710783671'/>
    <coord lat='37.49032509451204' lng='-122.14163965118446'/>
    <coord lat='37.48873346549249' lng='-122.14129633133861'/>
    <coord lat='37.486324582137456' lng='-122.14181131378092'/>
    <coord lat='37.48218784842503' lng='-122.1396656552953'/>
    <coord lat='37.48240704719634' lng='-122.13826619267313'/>
    <coord lat='37.48476422933837' lng='-122.13640772227058'/>
    <coord lat='37.48671271221419' lng='-122.13334748049435'/>
    <coord lat='37.48659443809561' lng='-122.13249341875171'/>
    <coord lat='37.48811068120114' lng='-122.12992271119464'/>
    <coord lat='37.490189619858704' lng='-122.12727027666055'/>
    <coord lat='37.49121471495246' lng='-122.12702936925163'/>
    <coord lat='37.4990536294274' lng='-122.12834977639356'/>
    <coord lat='37.490147375585956' lng='-122.13785756233008'/>
    <coord lat='37.49290087526949' lng='-122.14125217264274'/>
    <coord lat='37.49543302267979' lng='-122.13782306393557'/>
    <coord lat='37.49356650262717' lng='-122.1356363630639'/>
    <coord lat='37.49612636383088' lng='-122.13302048645609'/>
    <coord lat='37.5046645154395' lng='-122.13295724912138'/>
    <coord lat='37.507482788738756' lng='-122.13662800032454'/>
    <coord lat='37.50724852485978' lng='-122.14023835406599'/>
    <coord lat='37.504532820707595' lng='-122.14737351446878'/>
    <coord lat='37.50270753758901' lng='-122.14942798389714'/>
    <coord lat='37.50265257521088' lng='-122.15225486805515'/>
  </outline>
  <outline>
    <coord lat='37.482395598138915' lng='-122.15846975424377'/>
    <coord lat='37.48336634952827' lng='-122.16579240304966'/>
    <coord lat='37.48473707961406' lng='-122.1696680587832'/>
    <coord lat='37.48576713714319' lng='-122.17371550319545'/>
    <coord lat='37.489274439597175' lng='-122.17394078970746'/>
    <coord lat='37.489342506818744' lng='-122.16812577029295'/>
    <coord lat='37.49558924920328' lng='-122.16801999593048'/>
    <coord lat='37.497403090530696' lng='-122.16599135448928'/>
    <coord lat='37.49776516995452' lng='-122.16489121431593'/>
    <coord lat='37.49804833636994' lng='-122.15781803416176'/>
    <coord lat='37.497999971040635' lng='-122.15620002797534'/>
    <coord lat='37.497679203219036' lng='-122.15483952121602'/>
    <coord lat='37.49660942343206' lng='-122.15438029999909'/>
    <coord lat='37.495626961492235' lng='-122.15475902020958'/>
    <coord lat='37.49478069262566' lng='-122.15556687933436'/>
    <coord lat='37.493900374711565' lng='-122.15573095118513'/>
    <coord lat='37.490668067867446' lng='-122.15332387606306'/>
    <coord lat='37.489544369445255' lng='-122.15361087753747'/>
    <coord lat='37.48956140248732' lng='-122.15096489316393'/>
    <coord lat='37.489101681453015' lng='-122.14994970272018'/>
    <coord lat='37.48925489159636' lng='-122.14889159636017'/>
    <coord lat='37.490361547913984' lng='-122.14843429203978'/>
    <coord lat='37.490940360311306' lng='-122.146575517077'/>
    <coord lat='37.49053144940988' lng='-122.144118700933'/>
    <coord lat='37.489816050428175' lng='-122.14320688178229'/>
    <coord lat='37.48910064872256' lng='-122.14298171902864'/>
    <coord lat='37.48841655592692' lng='-122.14298296778232'/>
    <coord lat='37.487664358097696' lng='-122.14341336582869'/>
    <coord lat='37.486772904452444' lng='-122.14444580463729'/>
    <coord lat='37.486692510134006' lng='-122.15105959398858'/>
    <coord lat='37.482275039079425' lng='-122.15111188964907'/>
  </outline>
  <outline>
    <coord lat='37.51949055587221' lng='-122.20262391568308'/>
    <coord lat='37.518335748502544' lng='-122.20216432797183'/>
    <coord lat='37.51694144029594' lng='-122.20069005476891'/>
    <coord lat='37.516312379784644' lng='-122.19724936151887'/>
    <coord lat='37.51644032724564' lng='-122.1932975635498'/>
    <coord lat='37.51619790280854' lng='-122.19097848514437'/>
    <coord lat='37.51562670273988' lng='-122.18986230699424'/>
    <coord lat='37.51485125338986' lng='-122.18883197889943'/>
    <coord lat='37.51441904047192' lng='-122.18818819163481'/>
    <coord lat='37.512671096858284' lng='-122.18713674714054'/>
    <coord lat='37.510650822096984' lng='-122.18754444060131'/>
    <coord lat='37.50824422276374' lng='-122.18921807954739'/>
    <coord lat='37.50672271303576' lng='-122.19149242943482'/>
    <coord lat='37.50540280243964' lng='-122.19080535822089'/>
    <coord lat='37.50465918757531' lng='-122.18971566149081'/>
    <coord lat='37.506196504245985' lng='-122.18600819149222'/>
    <coord lat='37.506658678734695' lng='-122.18368233412127'/>
    <coord lat='37.50603862763207' lng='-122.18213316289271'/>
    <coord lat='37.50668182304228' lng='-122.18075777657496'/>
    <coord lat='37.506553255689894' lng='-122.17901916820009'/>
    <coord lat='37.50581187580676' lng='-122.17779556121587'/>
    <coord lat='37.505690861065524' lng='-122.1762924971976'/>
    <coord lat='37.50472451352242' lng='-122.17468056051686'/>
    <coord lat='37.50292798941388' lng='-122.1738600881949'/>
    <coord lat='37.50232313902144' lng='-122.17677322564693'/>
    <coord lat='37.50165017072319' lng='-122.17736890448437'/>
    <coord lat='37.498481766205785' lng='-122.17640448604689'/>
    <coord lat='37.49697959120656' lng='-122.17361763567737'/>
    <coord lat='37.49642653125769' lng='-122.16958925623221'/>
    <coord lat='37.498724823898826' lng='-122.16599571410356'/>
    <coord lat='37.502503935204885' lng='-122.16653291827494'/>
    <coord lat='37.50856351214963' lng='-122.16571835034793'/>
    <coord lat='37.521285166080375' lng='-122.18149960511458'/>
    <coord lat='37.52624548806807' lng='-122.19539491847738'/>
    <coord lat='37.524321015204265' lng='-122.19709290594993'/>
    <coord lat='37.51971001906629' lng='-122.19359209219073'/>
  </outline>
  <outline>
    <coord lat='37.50165429842247' lng='-122.22399663684564'/>
    <coord lat='37.50134788129732' lng='-122.22506831109138'/>
    <coord lat='37.517328971003394' lng='-122.22058797605342'/>
    <coord lat='37.517316494689865' lng='-122.21875796590078'/>
    <coord lat='37.518699601946615' lng='-122.2176145601768'/>
    <coord lat='37.51825490496429' lng='-122.21682528756557'/>
    <coord lat='37.520839598624555' lng='-122.21466269485038'/>
    <coord lat='37.52035863077979' lng='-122.21274076374412'/>
    <coord lat='37.518920056853744' lng='-122.20941193898003'/>
    <coord lat='37.516060085437665' lng='-122.21117531387912'/>
    <coord lat='37.511906569354544' lng='-122.21319600303113'/>
    <coord lat='37.50742018493519' lng='-122.21619701426339'/>
    <coord lat='37.50621347471883' lng='-122.21917881086667'/>
    <coord lat='37.50541522362803' lng='-122.22198886831585'/>
    <coord lat='37.504431493941716' lng='-122.22314572609727'/>
  </outline>
  <marker lat="37.569504" lng="-122.12188"/>
  <tide_station>428</tide_station>
  <city>HV9H+R6_Fremont</city>
  <details><![CDATA[
      <p><b>Overview: </b>Much of what looks like bay shoreline in the South Bay actually fronts on retired salt evaporation ponds, and much of that is contained within the Don Edwards National Wildlife Refuge.<p>According to the unofficial OhRanger site, boating is prohibited in salt ponds and small slough channels within the Refuge. We couldn&#x27;t find anything more authoritative about this, so if you plan to paddle in the Refuge, check with Don Edwards officials for current restrictions. If you find anything out, please let us know.<p>Some of the salt ponds are open to boating by duck hunters during the hunting season &#x28;see hunting regs below&#x29;, and that alone may be a good enough reason to stay out of them.</p>
      <p><b>Links: </b><a target="tp_details" href="https://www.ohranger.com/don-edwards-san-francisco-bay-nwr">Don Edwards SF Bay NWR &#x28;OhRanger&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.fws.gov/refuge/don-edwards-san-francisco-bay/map">Map &#x28;US Fish &#x26; Wildlife Service&#x29;</a>
      <br><span style='visibility:hidden'><b>Links: </b></span><a target="tp_details" href="https://www.fws.gov/refuge/don-edwards-san-francisco-bay/visit-us/activities/hunting">Hunting regulations</a></p>
  ]]></details>
</station>
</stations>
''';
