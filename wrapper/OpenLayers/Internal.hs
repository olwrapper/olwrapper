{-|
Module      :  OpenLayers Wrapper Internal Definitions
Description :  use this modul to for global definitions 
-}
module OpenLayers.Internal where
import           Fay.FFI
-- | a functor to ignore the result of the function, such as the return value of an IO action. 
void :: Fay f -> Fay ()
void f = f >> return ()
