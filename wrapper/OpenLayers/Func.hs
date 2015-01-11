{-|
Module      :  OpenLayersFunc
Description :  OpenLayers JavaScript and Haskell functions
-}
module OpenLayers.Func where

import           Prelude hiding (void)
import           JQuery
import           Fay.Text hiding (head, tail, map)
import           OpenLayers.Types
import           OpenLayers.Html
import           Fay.FFI
import           OpenLayers.Internal

-- * NEW FUNCTION

newLayerMqt :: String -> Object
newLayerMqt = ffi "new ol.layer.Tile({source: new ol.source.MapQuest({layer: %1})})"

newLayerOSM :: Object
newLayerOSM = ffi "new ol.layer.Tile({source: new ol.source.OSM()})"

newVector :: Object -> Opacity -> Fay Object
newVector = ffi "new ol.layer.Vector({source: %1, opacity: %2.slot1*0.01})"

newFeature :: GeoFeature -> Fay Object
newFeature f = case f of 
    GeoPoint p id s -> newFeaturePoint $ transformPoint' p
    GeoLine pts id s -> newFeatureLine $ transformPoints' pts
    _ -> error "newStyledFeature: the GeoFeature is not implemented yet"

newLineStyle :: GeoLineStyle -> Object
newLineStyle = ffi "[new ol.style.Style({stroke: new ol.style.Stroke({color: %1.color, width: %1.width})})]"

newPointStyle :: GeoPointStyle -> Object
newPointStyle = ffi "[new ol.style.Style({image: new ol.style.Circle({radius: %1.radius, fill: new ol.style.Fill({color:(%1.fillcolor == 'null' ? 'rgba(0,0,0,0)' : %1.fillcolor)}), stroke: %1.outcolor == 'null' ? null : new ol.style.Stroke({color: %1.outcolor, width: %1.outwidth})})})]"

newFeatureLine :: [(Double, Double)] -> Fay Object
newFeatureLine = ffi "new ol.source.GeoJSON({object:{'type':'Feature','geometry':{'type':'LineString','coordinates': %1}}})"

newFeaturePoint :: (Double, Double) -> Fay Object
newFeaturePoint = ffi "new ol.source.GeoJSON({object:{'type':'Feature','geometry':{'type':'Point','coordinates': %1}}})"
    
newOlInput :: JQuery -> String -> Object -> String -> Fay ()
newOlInput = ffi "(new ol.dom.Input(%1[0])).bindTo(%2, %3, %4)"

-- * ADD FUNCTION

addSelectClick :: Fay ()
addSelectClick = ffi "olc.addInteraction(new ol.interaction.Select({condition: ol.events.condition.click}))"

addSingleClickEvent :: Fay ()
addSingleClickEvent = ffi "olc.on('singleclick', function (evt) {alert('Koordinate WGS: ' + ol.proj.transform([evt.coordinate[0], evt.coordinate[1]], 'EPSG:3857', 'EPSG:4326') + '\\nKoordinate Mer: ' + evt.coordinate)})"

addBaseLayer :: MapSource -> Fay ()
addBaseLayer s = void $ do
    removeLayers
    addMapLayer s

addId ::  Object -> Integer ->  Fay Object
addId = ffi "(%2 < 1) ? '' : %1.getSource().getFeatures()[0].setId(%2)"

addMapLayer :: MapSource -> Fay ()
addMapLayer s
      | s == OSM                  = addLayer newLayerOSM
      | Prelude.any(s==)mapQuests = addLayer ( newLayerMqt $ showMapSource s)
      | otherwise                 = error ("wrong MapSource allowed is OSM and " ++ show mapQuests)

addLayer ::  Object -> Fay ()
addLayer = ffi "olc.addLayer(%1)"

addStyledFeature :: GeoFeature -> Opacity -> Fay ()
addStyledFeature f o = do 
    feature <- newFeature f
    styleFeature feature f
    addFeatureId feature f
    vector <- newVector feature o
    addLayer vector

addStyledFeatures :: [GeoFeature] -> Opacity -> Fay ()
addStyledFeatures  f o = do
    features <- map' newFeature f
    zipWithM styleFeature features f
    zipWithM addFeatureId features f
    vectors  <- zipWithM newVector features [ o | x <- [0..(Prelude.length features)-1]]
    addLayer (head vectors)
    sources <- return $ zipWith getFeatureAt ( vectors) [ 0 | x <- [0..(Prelude.length features)-1]]
    addFeatures (head vectors) (tail sources)

addFeatureId :: Object -> GeoFeature -> Fay Object
addFeatureId = ffi "%1.getFeatures()[0].setId(%2.id)"

addFeatures :: Object -> [Object] -> Fay ()
addFeatures = ffi "%1.getSource().addFeatures(%2)"

addPointFromLabels :: String -> String -> String -> String -> GeoPointStyle -> Fay ()
addPointFromLabels xId yId oId idId s = void $ do
    xinput <- selectId' xId
    xcoor <- getVal xinput
    yinput <- selectId' yId
    ycoor <- getVal yinput
    o <- getInputInt oId
    i <- getInputInt idId
    addStyledFeature (GeoPoint (Coordinate (toDouble' xcoor) (toDouble' ycoor) (Projection "EPSG:3857")) i s) (Opacity o)
    
addMapListener :: String -> String -> Fay ()
addMapListener = ffi "olc.on(%1, %2)"

addMapWindowEvent :: String -> Fay JQuery -> Fay ()
addMapWindowEvent = ffi "olc.on(%1, %2)"

addOlDomInput :: String -> String -> String -> Object -> Fay ()
addOlDomInput id typehtml value method = void $ do
    element <- selectId' id
    newOlInput element typehtml method value

-- * REMOVE FUNCTION
removeLayers :: Fay ()
removeLayers = void $ do
    layers <- getLayers
    mapM removeLayer layers

removeLayer :: a -> Fay ()
removeLayer = ffi "olc.removeLayer(%1)"

-- * CHANGE FUNCTION
zoomIn :: Integer -> Fay ()
zoomIn = ffi "olc.getView().setZoom(olc.getView().getZoom()+%1)"

zoomOut :: Integer -> Fay ()
zoomOut = ffi "olc.getView().setZoom(olc.getView().getZoom()-%1)"

styleFeature :: Object -> GeoFeature -> Fay Object
styleFeature object feature = case feature of 
    GeoPoint p id s  -> styleFeature' object $ newPointStyle s
    GeoLine pts id s -> styleFeature' object $ newLineStyle  s
    _ -> error "styleFeature: the GeoFeature is not implemented yet"

styleFeature' :: Object -> Object -> Fay Object
styleFeature' = ffi "%1.getFeatures()[0].setStyle(%2)"

changeBaseLayer :: MapSource -> Fay ()
changeBaseLayer s = void $ do
    layers <- getLayers
    addBaseLayer s
    map' addLayer $ tail layers

-- * SET FUNCTION
setFeatureStyle :: Object -> Object -> Object
setFeatureStyle = ffi "%1.setStyle(%2)"

setCenter' :: (Double, Double) -> Fay ()
setCenter' = ffi "olc.getView().setCenter(%1)"

setCenter :: Coordinate -> Fay ()
setCenter c = setCenter' $ transformPoint' c

setCenterZoom :: Coordinate -> Integer -> Fay ()
setCenterZoom c z = void $ do
    setCenter c
    setZoom z

setZoom :: Integer -> Fay ()
setZoom = ffi "olc.getView().setZoom(%1)"

setEventToHtml :: String -> Fay Text -> Fay JQuery
setEventToHtml elementId function = do 
    value <- function
    element <- selectId' elementId
    setHtml value element

-- * GET FUNCTION
getCenter :: Projectionlike -> Integer -> Fay Text
getCenter proj fixed = do 
     c <- getCenter_
     coordFixed (transformPointBack' proj c) fixed

getZoom :: Fay Text
getZoom = ffi "olc.getView().getZoom()"

getCenter_ :: Fay (Double, Double)
getCenter_ = ffi "olc.getView().getCenter()"

getLayers :: Fay [Object]
getLayers = ffi "olc.getLayers().getArray()"

getLayerByIndex :: Integer -> Object
getLayerByIndex = ffi "olc.getLayers().item(%1)"

getLayerByIndex' :: Integer -> Fay Object
getLayerByIndex' = ffi "olc.getLayers().item(%1)"

getFeatureId :: Object -> Integer
getFeatureId = ffi "%1.getId()"

getFeatureAt :: Object -> Integer -> Object
getFeatureAt = ffi "%1.getSource().getFeatures()[%2]"

getFeatureLength :: Object -> Integer
getFeatureLength = ffi "%1.getSource().getFeatures().length"

-- * TRANSFORM FUNCTION
transformPointBack' :: Projectionlike -> (Double, Double) -> (Double, Double)  --  Funktion wenn Variable von OpenLayers in Haskell benötigt
transformPointBack' = ffi "ol.proj.transform(%2, 'EPSG:3857', %1.slot1)"

transformPoint' :: Coordinate -> (Double, Double)  --  Funktion wenn Variable in Haskell geschrieben
transformPoint' = ffi "ol.proj.transform([%1.x, %1.y], %1.from.slot1, 'EPSG:3857')"

transformPoints' :: [Coordinate] -> [(Double, Double)]
transformPoints' c = [transformPoint' x | x <- c]

-- * OTHER FUNCTION
coordFixed ::  (Double, Double) -> Integer -> Fay Text
coordFixed = ffi "%1[0].toFixed(%2) + ',' + %1[1].toFixed(%2)"

lois :: Fay f -> f
lois = ffi "%1"

toDouble' :: Text -> Double
toDouble' = ffi "%1"

zipWithM3 :: (a -> b -> c -> Fay d) -> [a] -> [b] -> [c] -> Fay [d]
zipWithM3 f xs ys is = sequence $ zipWith3 f xs ys is

zipWithM :: (a -> b -> Fay c) -> [a] -> [b] -> Fay [c]
zipWithM f xs ys = sequence $ zipWith f xs ys

map' :: (a -> Fay b) -> [a] -> Fay [b]
map' f xs = sequence (map f xs)
