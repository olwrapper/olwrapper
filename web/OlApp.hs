{-|
Module      :  OpenLayers Wrapper Webdevelopment
Description :  to create a web application
-}
module OlApp where

import           OpenLayers.Func
import           OpenLayers.Types
import           OpenLayers.Internal
import           Tutorial.OlApp (designTutorialMap)
import           Fay.FFI

-- | ID for the combination of the HTML-Element map and the OpenLayers object 
targetId = "map"
-- | definition of the behaviour for OpenLayers
designMap :: Fay ()
designMap = OpenLayers.Internal.void $ do
    addBaseLayer OSM
    designTutorialMap

