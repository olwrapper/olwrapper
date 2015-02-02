module Tutorial.OlApp where

import           Prelude hiding (void)
import           OpenLayers.Func
import           OpenLayers.Types
import           OpenLayers.Html
import           OpenLayers.Internal
import           Tutorial.Traffic
import           Fay.FFI

zoomlevel = 11
defaultopacity = Opacity 80

coor1 =  Coordinate  16.369   48.196 wgs84proj
coor2 =  Coordinate  16.370   48.195 wgs84proj
coor3 =  Coordinate  16.371   48.194 wgs84proj
vienna = Coordinate  16.397   48.219 wgs84proj
rome   = Coordinate  12.5     41.9   wgs84proj
bern   = Coordinate   7.4458  46.95  wgs84proj
madrid = Coordinate (-3.6833) 40.4   wgs84proj

-- Styles
mypointstyle = GeoPointStyle 4 "green" "black" 2
mylinestyle  = GeoLineStyle  "green" 3

-- Features
mypoint = GeoPoint vienna                301 mypointstyle
myline  = GeoLine  [coor1, coor2, coor3] 101 mylinestyle

-- IDs for the html-tags

descId = "mapdesc"
formId = "forminput"
hochinputId = "xinput"
rechtsinputId = "yinput"
opacityinputId = "opacinput"
idinputId = "idinputId"

zoomlabel = "zoomlabel"
wgslabel = "wgslabel"
mercatorlabel = "mercatorlabel"
visiblecheckboxU1 = "opacitycheckboxU1"
visiblecheckboxU2 = "opacitycheckboxU2"
visiblecheckboxU3 = "opacitycheckboxU3"
visiblecheckboxU4 = "opacitycheckboxU4"

designTutorialMap :: Fay ()
designTutorialMap = void $ do
    -- baselayer loaded before
    -- init center and zoom
    setCenter vienna
    setZoom zoomlevel
    --  ADD LAYERS
    --  LAYER Index 1      --  add only one feature
    addStyledFeature myline  $ Opacity 0    --  hiding with Opacity 0
    --  LAYER Index 2      --  add only one feature
    addStyledFeature mypoint $ Opacity 0    --  hiding with Opacity 0
    --  LAYER Index 3      --  or add more with a list
    addStyledFeatures u1 defaultopacity
    --  LAYER Index 4
    addStyledFeatures u2 defaultopacity
    --  LAYER Index 5
    addStyledFeatures u3 defaultopacity
    --  LAYER Index 6
    addStyledFeatures u4 defaultopacity
    --
    --  CLICK EVENT
    addSingleClickEventAlertCoo "EPSG:4326"
    addDiv descId "div0" "Klicke in die Karte, um Koordinaten zu erhalten."
    addBreakline descId
    --
    --  ADD INPUT POINT
    ----  create an input form to be able to type a coordinate to insert a pointfeature
    addForm descId formId
    addInput "Mercator Hochwert: " formId hochinputId "1819207"
    addInput "Mercator Rechtswert: " formId rechtsinputId "6141206"
    addInput "Deckkraft: " formId opacityinputId "90"
    addInput "Id: " formId idinputId "1000"
    ----  add the button to insert the pointfeature
    addButton "Symbol einsetzen" descId $ addPointFromLabels hochinputId rechtsinputId opacityinputId idinputId mypointstyle 
    addBreakline descId
    --
    --  CHANGE BASELAYER
    ----  change your baselayer at Index 0
    addBreakline descId
    addButton "Wechsel Basiskarte Satellit" descId $ changeBaseLayer Sat
    addButton "Wechsel Basiskarte OpenStreetMap" descId $ changeBaseLayer OSM
    addBreakline descId
    --
    --  BUTTONS WITH DIFFERENT METHODS
    ----  add buttons to navigate to specific location and zoomlevel
    addBreakline descId
    addButton "Wien"   descId $ setCenter vienna
    addButton "Rom"    descId $ setCenterZoom rome zoomlevel
    addButton "Madrid" descId $ setCenterZoom madrid zoomlevel
    addBreakline descId
    --  add button for other tools
    addButton "Zoom +" descId $ zoomIn  1
    addButton "Zoom -" descId $ zoomOut 1
    addBreakline descId
    --
    --  BINDINGS
    ----  create some checkbox for binding
    addCheckbox visiblecheckboxU1 "table1" "U1 "
    addCheckbox visiblecheckboxU2 "table2" "U2 "
    addCheckbox visiblecheckboxU3 "table3" "U3 "
    addCheckbox visiblecheckboxU4 "table4" "U4 "
    ----  bind the html-element checkbox with a layer
    addOlDomInput visiblecheckboxU1 "checked" "visible" $ getLayerByIndex 3
    addOlDomInput visiblecheckboxU2 "checked" "visible" $ getLayerByIndex 4
    addOlDomInput visiblecheckboxU3 "checked" "visible" $ getLayerByIndex 5
    addOlDomInput visiblecheckboxU4 "checked" "visible" $ getLayerByIndex 6
    --
    --  EVENT LABELS
    ----  add some labels to display map events
    addElement zoomlabel     "<div>" "zl1"
    addElement wgslabel      "<div>" "wl1"
    addElement mercatorlabel "<div>" "ml1"
    ----  at moveend of the map add the center and zoomlevel of the map to the label
    addMapWindowEvent "moveend" $ setEventToHtml zoomlabel getZoom
    addMapWindowEvent "moveend" $ setEventToHtml wgslabel $ getCenter wgs84proj 5
    addMapWindowEvent "moveend" $ setEventToHtml mercatorlabel $ getCenter mercatorproj 1
    --
