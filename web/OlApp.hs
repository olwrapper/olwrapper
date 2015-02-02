{-|
Module      :  OpenLayers Wrapper Webdevelopment
Description :  to create a web application
-}
module OlApp where

import           Prelude hiding (void)
import           OpenLayers.Func
import           OpenLayers.Types
import           OpenLayers.Internal
import           Tutorial.OlApp (designTutorialMap)
import           Fay.FFI

-- | ID to combine the HTML-Element map with the OpenLayers object 
targetId = "map"
-- | definition of the behaviour for OpenLayers
designMap :: Fay ()
designMap = void $ do
    addBaseLayer OSM
    designTutorialMap
