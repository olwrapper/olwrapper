{-|
Module      :  Snaplet Fay Module
Description :  module fay handle olwrapper application onload of a website 
-}
module Index where

import           OpenLayers

main :: Fay ()
main = olwrapperAddOnLoad olwrapperLoad
