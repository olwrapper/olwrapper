module Tutorial.Traffic where

import           OpenLayers.Types

uStationSize = 3
uLineSize = 2

u1Color = "red"
u1StationStyle = GeoPointStyle uStationSize u1Color u1Color 1
u1LineStyle = GeoLineStyle u1Color uLineSize
u2Color = "#8904B1"
u2StationStyle = GeoPointStyle uStationSize u2Color u2Color 1
u2LineStyle = GeoLineStyle u2Color uLineSize
u3Color = "orange"
u3StationStyle = GeoPointStyle uStationSize u3Color u3Color 1
u3LineStyle = GeoLineStyle u3Color uLineSize
u4Color = "green"
u4StationStyle = GeoPointStyle uStationSize u4Color u4Color 1
u4LineStyle = GeoLineStyle u4Color uLineSize

u4_01 = Coordinate 16.26139 48.19750 wgs84proj
u4_02 = Coordinate 16.27528 48.19250 wgs84proj
u4_03 = Coordinate 16.28639 48.19111 wgs84proj
u4_04 = Coordinate 16.29473 48.18972 wgs84proj
u4_05 = Coordinate 16.30389 48.18778 wgs84proj
u4_06 = Coordinate 16.31890 48.18555 wgs84proj
u4_07 = Coordinate 16.32834 48.18361 wgs84proj
u4_08 = Coordinate 16.33472 48.18472 wgs84proj
u4_09 = Coordinate 16.34250 48.18834 wgs84proj
u4_10 = Coordinate 16.35445 48.19278 wgs84proj
u4_11 = Coordinate 16.35806 48.19667 wgs84proj
u4_12 = Coordinate 16.36889 48.20015 wgs84proj
u4_13 = Coordinate 16.37889 48.20278 wgs84proj
u4_14 = Coordinate 16.38500 48.20612 wgs84proj
u4_15 = Coordinate 16.37750 48.21150 wgs84proj
u4_16 = Coordinate 16.37195 48.21611 wgs84proj
u4_17 = Coordinate 16.36751 48.22194 wgs84proj
u4_18 = Coordinate 16.36361 48.22778 wgs84proj
u4_19 = Coordinate 16.35806 48.23472 wgs84proj
u4_20 = Coordinate 16.36612 48.24888 wgs84proj

u4 = [
    GeoPoint u4_01 40001 u4StationStyle,
    GeoPoint u4_02 40002 u4StationStyle,
    GeoPoint u4_03 40003 u4StationStyle,
    GeoPoint u4_04 40004 u4StationStyle,
    GeoPoint u4_05 40005 u4StationStyle,
    GeoPoint u4_06 40006 u4StationStyle,
    GeoPoint u4_07 40007 u4StationStyle,
    GeoPoint u4_08 40008 u4StationStyle,
    GeoPoint u4_09 40009 u4StationStyle,
    GeoPoint u4_10 40010 u4StationStyle,
    GeoPoint u4_11 40011 u4StationStyle,
    GeoPoint u4_12 40012 u4StationStyle,
    GeoPoint u4_13 40013 u4StationStyle,
    GeoPoint u4_14 40014 u4StationStyle,
    GeoPoint u4_15 40015 u4StationStyle,
    GeoPoint u4_16 40016 u4StationStyle,
    GeoPoint u4_17 40017 u4StationStyle,
    GeoPoint u4_18 40018 u4StationStyle,
    GeoPoint u4_19 40019 u4StationStyle,
    GeoPoint u4_20 40020 u4StationStyle,
    GeoLine [u4_01, u4_02, u4_03, u4_04, u4_05, u4_06, u4_07, u4_08, u4_09, u4_10,
             u4_11, u4_12, u4_13, u4_14, u4_15, u4_16, u4_17, u4_18, u4_19, u4_20] 41001 u4LineStyle
    ]

u3_01 = Coordinate 16.42024 48.17001 wgs84proj
u3_02 = Coordinate 16.41389 48.17611 wgs84proj
u3_03 = Coordinate 16.41139 48.17944 wgs84proj
u3_04 = Coordinate 16.41722 48.18528 wgs84proj
u3_05 = Coordinate 16.41500 48.19084 wgs84proj
u3_06 = Coordinate 16.40667 48.19445 wgs84proj
u3_07 = Coordinate 16.39972 48.19750 wgs84proj
u3_08 = Coordinate 16.39223 48.20222 wgs84proj
u3_09 = Coordinate 16.38500 48.20639 wgs84proj
u3_10 = Coordinate 16.37917 48.20750 wgs84proj
u3_11 = Coordinate 16.37222 48.20833 wgs84proj
u3_12 = Coordinate 16.36500 48.20944 wgs84proj
u3_13 = Coordinate 16.35834 48.20501 wgs84proj
u3_14 = Coordinate 16.35222 48.19917 wgs84proj
u3_15 = Coordinate 16.34611 48.19722 wgs84proj
u3_16 = Coordinate 16.33861 48.19695 wgs84proj
u3_17 = Coordinate 16.32861 48.19778 wgs84proj
u3_18 = Coordinate 16.31972 48.19778 wgs84proj
u3_19 = Coordinate 16.31167 48.19972 wgs84proj
u3_20 = Coordinate 16.30890 48.20444 wgs84proj
u3_21 = Coordinate 16.31111 48.21195 wgs84proj

u3 = [
    GeoPoint u3_01 30001 u3StationStyle,
    GeoPoint u3_02 30002 u3StationStyle,
    GeoPoint u3_03 30003 u3StationStyle,
    GeoPoint u3_04 30004 u3StationStyle,
    GeoPoint u3_05 30005 u3StationStyle,
    GeoPoint u3_06 30006 u3StationStyle,
    GeoPoint u3_07 30007 u3StationStyle,
    GeoPoint u3_08 30008 u3StationStyle,
    GeoPoint u3_09 30009 u3StationStyle,
    GeoPoint u3_10 30010 u3StationStyle,
    GeoPoint u3_11 30011 u3StationStyle,
    GeoPoint u3_12 30012 u3StationStyle,
    GeoPoint u3_13 30013 u3StationStyle,
    GeoPoint u3_14 30014 u3StationStyle,
    GeoPoint u3_15 30015 u3StationStyle,
    GeoPoint u3_16 30016 u3StationStyle,
    GeoPoint u3_17 30017 u3StationStyle,
    GeoPoint u3_18 30018 u3StationStyle,
    GeoPoint u3_19 30019 u3StationStyle,
    GeoPoint u3_20 30020 u3StationStyle,
    GeoPoint u3_21 30021 u3StationStyle,
    GeoLine [u3_01, u3_02, u3_03, u3_04, u3_05, u3_06, u3_07, u3_08, u3_09, u3_10,
             u3_11, u3_12, u3_13, u3_14, u3_15, u3_16, u3_17, u3_18, u3_19, u3_20, u3_21] 31001 u3LineStyle
    ]

u2_01 = Coordinate 16.36910 48.20028 wgs84proj
u2_02 = Coordinate 16.36139 48.20251 wgs84proj
u2_03 = Coordinate 16.35833 48.20556 wgs84proj
u2_04 = Coordinate 16.35528 48.21056 wgs84proj
u2_05 = Coordinate 16.36305 48.21528 wgs84proj
u2_06 = Coordinate 16.37195 48.21639 wgs84proj
u2_07 = Coordinate 16.38074 48.21908 wgs84proj
u2_08 = Coordinate 16.39133 48.21875 wgs84proj
u2_09 = Coordinate 16.40640 48.21770 wgs84proj
u2_10 = Coordinate 16.41376 48.21466 wgs84proj
u2_11 = Coordinate 16.42095 48.21030 wgs84proj

u2 = [
    GeoPoint u2_01 20001 u2StationStyle,
    GeoPoint u2_02 20002 u2StationStyle,
    GeoPoint u2_03 20003 u2StationStyle,
    GeoPoint u2_04 20004 u2StationStyle,
    GeoPoint u2_05 20005 u2StationStyle,
    GeoPoint u2_06 20006 u2StationStyle,
    GeoPoint u2_07 20007 u2StationStyle,
    GeoPoint u2_08 20008 u2StationStyle,
    GeoPoint u2_09 20009 u2StationStyle,
    GeoPoint u2_10 20010 u2StationStyle,
    GeoPoint u2_11 20011 u2StationStyle,
    GeoLine [u2_01, u2_02, u2_03, u2_04, u2_05, u2_06, u2_07, u2_08, u2_09, u2_10,
             u2_11] 21001 u2LineStyle
    ]


u1_01 = Coordinate 16.37778 48.17500 wgs84proj
u1_02 = Coordinate 16.37612 48.17945 wgs84proj
u1_03 = Coordinate 16.37278 48.18751 wgs84proj
u1_04 = Coordinate 16.37056 48.19389 wgs84proj
u1_05 = Coordinate 16.36889 48.20028 wgs84proj
u1_06 = Coordinate 16.37194 48.20836 wgs84proj
u1_07 = Coordinate 16.37750 48.21167 wgs84proj
u1_08 = Coordinate 16.38583 48.21556 wgs84proj
u1_09 = Coordinate 16.39333 48.21944 wgs84proj
u1_10 = Coordinate 16.40139 48.22390 wgs84proj
u1_11 = Coordinate 16.41055 48.22889 wgs84proj
u1_13 = Coordinate 16.41611 48.23305 wgs84proj
u1_14 = Coordinate 16.42436 48.23811 wgs84proj
u1_15 = Coordinate 16.43390 48.24362 wgs84proj
u1_16 = Coordinate 16.44333 48.25041 wgs84proj
u1_17 = Coordinate 16.44922 48.25702 wgs84proj
u1_18 = Coordinate 16.45158 48.26277 wgs84proj
u1_19 = Coordinate 16.44773 48.27164 wgs84proj
u1_20 = Coordinate 16.45164 48.27719 wgs84proj

u1 = [
    GeoPoint u1_01 10001 u1StationStyle,
    GeoPoint u1_02 10002 u1StationStyle,
    GeoPoint u1_03 10003 u1StationStyle,
    GeoPoint u1_04 10004 u1StationStyle,
    GeoPoint u1_05 10005 u1StationStyle,
    GeoPoint u1_06 10006 u1StationStyle,
    GeoPoint u1_07 10007 u1StationStyle,
    GeoPoint u1_08 10008 u1StationStyle,
    GeoPoint u1_09 10009 u1StationStyle,
    GeoPoint u1_10 10010 u1StationStyle,
    GeoPoint u1_11 10011 u1StationStyle,
    GeoPoint u1_13 10013 u1StationStyle,
    GeoPoint u1_14 10014 u1StationStyle,
    GeoPoint u1_15 10015 u1StationStyle,
    GeoPoint u1_16 10016 u1StationStyle,
    GeoPoint u1_17 10017 u1StationStyle,
    GeoPoint u1_18 10018 u1StationStyle,
    GeoPoint u1_19 10019 u1StationStyle,
    GeoPoint u1_20 10020 u1StationStyle,
    GeoLine [u1_01, u1_02, u1_03, u1_04, u1_05, u1_06, u1_07, u1_08, u1_09, u1_10,
             u1_11, u1_13, u1_14, u1_15, u1_16, u1_17, u1_18, u1_19, u1_20] 11001 u1LineStyle
    ]
