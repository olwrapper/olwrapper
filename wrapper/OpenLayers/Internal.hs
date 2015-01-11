module OpenLayers.Internal where

import           Fay.FFI

void :: Fay f -> Fay ()
void f = f >> return ()
