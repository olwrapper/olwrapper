{-|
Module      :  OpenLayersTypes
Description :    new types, new data, global constants and mapsource for olwrapper
-}
module OpenLayers.Types where

-- * Constants
-- | The 'Projectionlike' for WGS84
wgs84proj = Projection "EPSG:4326"
-- | The 'Projectionlike' for Mercator
mercatorproj = Projection "EPSG:3857"

-- * Types
-- ** type
-- | Layers with IDs are using 'GeoId'
type GeoId = Integer
-- ** data
-- | OpenLayers Projection constructed f.e. with \'Projection \"EPSG:4326\"\'
data Projectionlike = Projection String
-- | constructor for a coordinate with x,y and projection
data Coordinate = Coordinate { 
        -- | first coordinate
        x :: Double, 
        -- | second coordinate
        y :: Double, 
        -- | projection
        from :: Projectionlike 
    }
-- | Layer Opacity from min=0 (not visible) to max=100
data Opacity = Opacity Integer
data GeoFeature 
    -- | A GeoLine is a styled line feature with an id
    = GeoLine { 
        -- | linepoints as a  list of 'Coordinate'
        pts :: [Coordinate], 
        -- | id for the feature with 'GeoId'
        id :: GeoId, 
        -- | linestyle with 'GeoLineStyle'
        lstyle :: GeoLineStyle
    } 
    -- | A GeoPoint is a styled point feature with an id
    | GeoPoint {
        -- | position with a 'Coordinate'
        pt ::  Coordinate, 
        id :: GeoId, 
        -- | pointstyle with 'GeoPointStyle'
        pstyle :: GeoPointStyle
    }
-- | defining a style for a 'GeoLine' feature
data GeoLineStyle = GeoLineStyle { 
        -- | line color, can be a name (red) or code (#8904B1)
        color :: String, 
        -- | width of the line
        width :: Integer 
    }
-- | defining a style for a circled 'GeoPoint' feature
data GeoPointStyle = GeoPointStyle { 
        -- | radius of the circle
        radius :: Integer, 
        -- | fill color of the circle, can be a name (red) or code (#8904B1)
        fillcolor :: String, 
        -- | line color of the border of the circle, name (red) or code (#8904B1)
        outcolor :: String, 
        -- | width of the border of the circle, if 0 no outcolor needed
        outwidth :: Integer 
    }
-- | list of possible mapsources
data MapSource 
    = Sat  -- ^ MapQuest's satellite
    | Hyb  -- ^ MapQuest's hybrid
    | Osm  -- ^ MapQuest's OpenStreetMap
    | OSM  -- ^ OpenStreetMap
    deriving (Show, Eq)
    
-- * List
-- | puts the sources from MapQuest in a list
mapQuests = [Osm, Sat, Hyb]

-- * Functions
-- | transform 'MapSource' to 'String' and handle wrong input
showMapSource :: MapSource -> String
showMapSource ms
    | ms == Sat = "sat"
    | ms == Hyb = "hyb"
    | ms == Osm = "osm"
    | ms == OSM = "OSM"
    | otherwise = "showMapSource not defined, check Layer"
