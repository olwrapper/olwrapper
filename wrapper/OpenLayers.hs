{-|
Module      :  OpenLayers Wrapper mothership
Description :  combine OpenLayers with Fay
-}
module OpenLayers where

import           OpenLayers.Internal
import           Fay.FFI
import           OlApp (targetId, designMap)

-- | Adds an default naked OpenLayers Map Object
addDefaultMap :: Fay ()
addDefaultMap = ffi "olmap = new ol.Map({renderer: 'canvas'})"
{-|
  Initialises an object of the OpenLayers Map as HTML object.
  The variable name \"olc\" must be reserved for the whole website!
-}
defineCode :: Fay ()
defineCode = ffi "olc = $(olmap)[0]"
-- | setting the target between html and OpenLayers
setTarget :: String -> Fay ()
setTarget = ffi "olc.setTarget(%1)"
-- | setting a default view for first map appearence
setDefaultView :: Fay ()
setDefaultView = ffi "olc.setView(new ol.View({center:[0,0],zoom:2}))"
-- | Initialises an OpenLayers View and load the definitions from the OpenLayers Webapplication defined in "OlApp"
olwrapperLoad :: Fay ()
olwrapperLoad = OpenLayers.Internal.void $ do
    addDefaultMap
    defineCode
    setTarget targetId
    setDefaultView
    designMap
