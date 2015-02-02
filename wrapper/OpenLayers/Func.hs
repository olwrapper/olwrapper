{-|
Module      :  OpenLayersFunc
Description :  OpenLayers JavaScript and Haskell functions (using FFI)
-}
module OpenLayers.Func where

import           Prelude hiding (void)
import           JQuery
import           Fay.Text hiding (head, tail, map)
import           OpenLayers.Html
import           OpenLayers.Internal
import           OpenLayers.Types
import           Fay.FFI
-- * NEW FUNCTION
-- | new MapQuest layer
newLayerMqt :: String     -- ^ map type
            -> Object     -- ^ new layer (Tile)
newLayerMqt = ffi "new ol.layer.Tile({source: new ol.source.MapQuest({layer: %1})})"
-- | new OpenStreetMap layer
newLayerOSM :: Object     -- ^ new layer (Tile)
newLayerOSM = ffi "new ol.layer.Tile({source: new ol.source.OSM()})"
-- | new Layer as vector
newVector :: Object      -- ^ vectorsource
          -> Opacity     -- ^ opacity
          -> Fay Object  -- ^ new layer (Vector)
newVector = ffi "new ol.layer.Vector({source: %1, opacity: %2.slot1*0.01})"
-- | new 'GeoFeature' ('GeoPoint' or 'GeoLine')
newFeature :: GeoFeature -> Fay Object
newFeature f = case f of 
    GeoPoint p id s -> newFeaturePoint $ transformPoint p
    GeoLine pts id s -> newFeatureLine $ transformPoints pts
    _ -> error "newStyledFeature: the GeoFeature is not implemented yet"
-- | new map source GeoJSON as LineString
newFeatureLine :: [(Double, Double)]  -- ^ input coordinates
               -> Fay Object
newFeatureLine = ffi "new ol.source.GeoJSON({object:{'type':'Feature','geometry':{'type':'LineString','coordinates': %1}}})"
-- | new map source GeoJSON as Point
newFeaturePoint :: (Double, Double)  -- ^ an input coordinate
                -> Fay Object
newFeaturePoint = ffi "new ol.source.GeoJSON({object:{'type':'Feature','geometry':{'type':'Point','coordinates': %1}}})"
-- | new styled 'GeoLine'
newLineStyle :: GeoLineStyle -> Object
newLineStyle = ffi "[new ol.style.Style({stroke: new ol.style.Stroke({color: %1.color, width: %1.width})})]"
-- | new styled 'GeoPoint'
newPointStyle :: GeoPointStyle -> Object
newPointStyle = ffi "[new ol.style.Style({image: new ol.style.Circle({radius: %1.radius, fill: new ol.style.Fill({color:(%1.fillcolor == 'null' ? 'rgba(0,0,0,0)' : %1.fillcolor)}), stroke: %1.outcolor == 'null' ? null : new ol.style.Stroke({color: %1.outcolor, width: %1.outwidth})})})]"
-- | new OpenLayers DOM binding
newOlInput :: JQuery  -- ^ element to bind to
           -> String  -- ^ case (f.e. \"checked\" by Checkbox)
           -> Object  -- ^ map object (f.e. 'getLayerByIndex 0')
           -> String  -- ^ attribute of map object to change (f.e. \"visible\")
           -> Fay ()  -- ^ return type is void
newOlInput = ffi "(new ol.dom.Input(%1[0])).bindTo(%2, %3, %4)"
-- * ADD FUNCTION
-- | add an event on \"singleclick\" to display pop-up with coordinates in mercator and custom projection
addSingleClickEventAlertCoo :: String  -- ^ EPSG-Code of custom projection (f.e. \"EPSG:4326\")
                            -> Fay ()  -- ^ return type is void
addSingleClickEventAlertCoo = ffi "olc.on('singleclick', function (evt) {alert(%1 + ': ' + ol.proj.transform([evt.coordinate[0], evt.coordinate[1]], 'EPSG:3857', %1) + '\\nEPSG:3857: ' + evt.coordinate)})"
-- | add a layer to the map, and remove all layers before inserting (baselayer has now index 0)
addBaseLayer :: MapSource -> Fay ()
addBaseLayer s = void $ do
    removeLayers
    addMapLayer s
-- | add a MapSource to the map
addMapLayer :: MapSource -> Fay ()
addMapLayer s
      | s == OSM                  = addLayer newLayerOSM
      | Prelude.any(s==)mapQuests = addLayer ( newLayerMqt $ showMapSource s)
      | otherwise                 = error ("wrong MapSource allowed is OSM and " ++ show mapQuests)
-- | add a layer to the map
addLayer ::  Object -> Fay ()
addLayer = ffi "olc.addLayer(%1)"
-- | add a 'GeoFeature' to a new layer to the map (first add coordinates to a new feature and then add the style and the id to this new feature, at least create a layer with the feature and add the layer to the map)
addStyledFeature :: GeoFeature -- ^ input ('GeoPoint' or 'GeoLine')
                -> Opacity     -- ^ opacity for the GeoFeature
                -> Fay ()
addStyledFeature f o = do 
    feature <- newFeature f
    styleFeature feature f
    setFeatureId feature f
    vector <- newVector feature o
    addLayer vector
-- | add more than one 'GeoFeature' to a new layer (similar to the 'addStyledFeature' function)
addStyledFeatures :: [GeoFeature]  -- ^ input ('GeoPoint' and/or 'GeoLine')
                  -> Opacity       -- ^ global opacity for the GeoFeatures
                  -> Fay ()
addStyledFeatures  f o = do
    features <- mapS newFeature f
    zipWithS styleFeature features f
    zipWithS setFeatureId features f
    vectors  <- zipWithS newVector features [ o | x <- [0..(Prelude.length features)-1]]
    addLayer (head vectors)
    sources <- return $ zipWith getVectorFeatureAt ( vectors) [ 0 | x <- [0..(Prelude.length features)-1]]
    addFeatures (head vectors) (tail sources)
-- | add an array with features to a layer
addFeatures :: Object     -- ^ layer
            -> [Object]   -- ^ featurearray
            -> Fay ()
addFeatures = ffi "%1.getSource().addFeatures(%2)"
-- | add a new point feature (and a new layer) by defining from HTML elements
addPointFromLabels :: String         -- ^ id of the HTML element for the first coordinate (element need value, must be a double, see 'Coordinate')
                   -> String         -- ^ id of the HTML element for the seconde coordinate (element need value, must be a double, see 'Coordinate')
                   -> String         -- ^ id of the HTML element for the opacity (element need value, must be an integer, see 'Opacity')
                   -> String         -- ^ id of the HTML element for the feature id (element need value, must be a positive integer, see 'OpenLayers.Types.id')
                   -> GeoPointStyle  -- ^ define the style of the feature
                   -> Fay ()         -- ^
addPointFromLabels xId yId oId idId s = void $ do
    xinput <- selectId xId
    xcoor <- getVal xinput
    yinput <- selectId yId
    ycoor <- getVal yinput
    o <- getInputInt oId
    i <- getInputInt idId
    addStyledFeature (GeoPoint (Coordinate (toDouble xcoor) (toDouble ycoor) (Projection "EPSG:3857")) i s) (Opacity o)
-- | add a map event listener (f.e. when zoom or pan)
addMapWindowEvent :: String      -- ^ the event trigger (f.e. \"moveend\")
                  -> Fay JQuery  -- ^ action on the event
                  -> Fay ()
addMapWindowEvent = ffi "olc.on(%1, %2)"
-- | add a connection between HTML and OpenLayers to manipulate layer attributes
addOlDomInput :: String   -- ^ id of the HTML element which triggers
              -> String   -- ^ HTML value to trigger (f.e. \"checked\")
              -> String   -- ^ layer attribute to manipulate (f.e. \"visible\")
              -> Object   -- ^ layer to manipulate
              -> Fay ()
addOlDomInput id typehtml value method = void $ do
    element <- selectId id
    newOlInput element typehtml method value
-- * REMOVE FUNCTION
-- | remove all layers from the map
removeLayers :: Fay ()
removeLayers = void $ do
    layers <- getLayers
    mapM removeLayer layers
-- | remove a layer object (only use with layers)
removeLayer :: a       -- ^ layer to remove
            -> Fay ()
removeLayer = ffi "olc.removeLayer(%1)"
-- * CHANGE FUNCTION
-- | zoom IN and specify levels to change 
zoomIn :: Integer    -- ^ number of zoomlevels to change
       -> Fay ()
zoomIn = ffi "olc.getView().setZoom(olc.getView().getZoom()+%1)"
-- | zoom OUT and specify levels to change
zoomOut :: Integer   -- ^ number of zoomlevels to change 
        -> Fay ()
zoomOut = ffi "olc.getView().setZoom(olc.getView().getZoom()-%1)"
-- | style a feature @/after/@ creating a new feature and @/before/@ adding to a new layer (this is an internal function for 'addStyledFeature' and 'addStyledFeatures')
styleFeature :: Object      -- ^ the prevoiusly created new feature
             -> GeoFeature  -- ^ the GeoFeature object of the prevoiusly created feature
             -> Fay ()
styleFeature object feature = case feature of 
    GeoPoint p id s  -> styleFeature' object $ newPointStyle s
    GeoLine pts id s -> styleFeature' object $ newLineStyle  s
    _ -> error "styleFeature: the GeoFeature is not implemented"
-- | style a feature FFI function
styleFeature' :: Object -> Object -> Fay ()
styleFeature' = ffi "%1.getFeatures()[0].setStyle(%2)"
-- | change the baselayer at layerindex 0
changeBaseLayer :: MapSource   -- ^ new 'MapSource' for the baselayer
                -> Fay ()
changeBaseLayer s = void $ do
    layers <- getLayers
    addBaseLayer s
    mapS addLayer $ tail layers
-- * SET FUNCTION
-- | set the id of a feature, get the feature by layer and featureindex
setId ::  Object  -- ^ layer with the requested feature 
      -> Integer  -- ^ new id for the feature ( > 0)
      -> Integer  -- ^ index of the feature in the layer (Layer.getFeatures()[i] , i >= 0)
      ->  Fay ()
setId = ffi "(%2 < 1 || %3 < 0) ? '' : %1.getSource().getFeatures()[%3].setId(%2)"
-- | set the id of the first feature of the vector 
setFeatureId :: Object     -- ^ vector
             -> GeoFeature -- ^ input for the id
             -> Fay ()
setFeatureId = ffi "%1.getFeatures()[0].setId(%2.id)"
-- | set map center with a 'Coordinate'
setCenter :: Coordinate -> Fay ()
setCenter c = setCenter' $ transformPoint c
-- | set map center FFI function
setCenter' :: (Double, Double) -> Fay ()
setCenter' = ffi "olc.getView().setCenter(%1)"
-- | set the map center and the zoomlevel at the same time
setCenterZoom :: Coordinate  -- ^ center position
              -> Integer     -- ^ zoomlevel
              -> Fay ()      -- ^ return type is void
setCenterZoom c z = void $ do
    setCenter c
    setZoom z
-- | set the zoomlevel of the map
setZoom :: Integer -> Fay ()
setZoom = ffi "olc.getView().setZoom(%1)"
-- * GET FUNCTION
-- | get map center in requested projection with n decimal places
getCenter :: Projectionlike  -- ^ requested projection
          -> Integer         -- ^ decimal places
          -> Fay Text
getCenter proj fixed = do 
     c <- getCenter'
     coordFixed (transformPointTo proj c) fixed
-- | get map center FFI function
getCenter' :: Fay (Double, Double)
getCenter' = ffi "olc.getView().getCenter()"
-- | get map zoom level
getZoom :: Fay Text
getZoom = ffi "olc.getView().getZoom()"
-- | get an array of all layers in the map
getLayers :: Fay [Object]
getLayers = ffi "olc.getLayers().getArray()"
-- | get a layer by index and return a object
getLayerByIndex :: Integer -> Object
getLayerByIndex = ffi "olc.getLayers().item(%1)"
-- | get a layer by index and return a fay object
getLayerByIndex' :: Integer -> Fay Object
getLayerByIndex' = ffi "olc.getLayers().item(%1)"
-- | get the id of a feature (<http://openlayers.org/en/v3.1.1/apidoc/ol.Feature.html OpenLayers Feature>)
getFeatureId :: Object 
             -> Integer
getFeatureId = ffi "%1.getId()"
-- | get a feature from a vector at index position
getVectorFeatureAt :: Object      -- ^ Vector
                   -> Integer     -- ^ index of vector features
                   -> Object
getVectorFeatureAt = ffi "%1.getSource().getFeatures()[%2]"
-- | get the number of features in a vector
getVectorFeatureLength :: Object  -- ^ Vector
                       -> Integer -- ^ number of features in vector
getVectorFeatureLength = ffi "%1.getSource().getFeatures().length"
-- * TRANSFORM FUNCTION
-- | transform coordinates from mercator to requested projection
transformPointTo :: Projectionlike    -- ^ target projection
                 -> (Double, Double)  -- ^ input
                 -> (Double, Double)  -- ^ output
transformPointTo = ffi "ol.proj.transform(%2, 'EPSG:3857', %1.slot1)"
-- | transform 'Coordinate' to mercator (EPSG:3857)
transformPoint :: Coordinate        -- ^ input
               -> (Double, Double)  -- ^ output
transformPoint = ffi "ol.proj.transform([%1.x, %1.y], %1.from.slot1, 'EPSG:3857')"
-- | transform 'Coordinate's to mercator (EPSG:3857)
transformPoints :: [Coordinate] -> [(Double, Double)]
transformPoints c = [transformPoint x | x <- c]
-- * OTHER FUNCTION
-- | create a Text from a tuple of doubles with fixed decimal places and seperator \",\"
coordFixed ::  (Double, Double) -> Integer -> Fay Text
coordFixed = ffi "%1[0].toFixed(%2) + ',' + %1[1].toFixed(%2)"
-- | change Text to Double
toDouble :: Text -> Double
toDouble = ffi "%1"
-- | 'sequence' the 'map'-function
mapS :: (a -> Fay b) -> [a] -> Fay [b]
mapS f x = sequence (map f x)
-- | 'sequence' the 'zipWith'-function
zipWithS :: (a -> b -> Fay c) -> [a] -> [b] -> Fay [c]
zipWithS f x y = sequence $ zipWith f x y

-- zipWithS3 :: (a -> b -> c -> Fay d) -> [a] -> [b] -> [c] -> Fay [d]
-- zipWithS3 f x y z = sequence $ zipWith3 f x y z
