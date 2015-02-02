{-|
Module      :  OpenLayers Wrapper mothership
Description :  this module combines OpenLayers with Fay
-}
module OpenLayers where
import           Prelude hiding (void)
import           Fay.FFI
import           OlApp (targetId, designMap)
import           OpenLayers.Internal
-- | to add OpenLayers Wrapper when the page event load is registered 
olwrapperAddOnLoad :: Fay f -> Fay ()
olwrapperAddOnLoad = ffi "window.addEventListener(\"load\", %1)"
-- | to add a default OpenLayers map object with name \"olmap\"
addDefaultMap :: Fay ()
addDefaultMap = ffi "olmap = new ol.Map({renderer: 'canvas'})"
{-|
  Initialises an object of the OpenLayers map as HTML object.
  The JavaScript variable name \"olc\" must be reserved for the application!
-}
defineCode :: Fay ()
defineCode = ffi "olc = $(olmap)[0]"
-- | setting the target between html and OpenLayers
setTarget :: String -> Fay ()
setTarget = ffi "olc.setTarget(%1)"
-- | setting a default view for first map appearence
setDefaultView :: Fay ()
setDefaultView = ffi "olc.setView(new ol.View({center:[0,0],zoom:2}))"
-- | initialises an OpenLayers view and load the definitions from the OpenLayers webapplication defined in "OlApp"
olwrapperLoad :: Fay ()
olwrapperLoad = void $ do
    addDefaultMap
    defineCode
    setTarget targetId
    setDefaultView
    designMap
