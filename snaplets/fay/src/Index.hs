module Index where

import           Fay.FFI
import           OpenLayers

addOnload :: Fay f -> Fay ()
addOnload = ffi "window.addEventListener(\"load\", %1)"

void' :: Fay f -> Fay ()
void' f = f >> return ()

onload :: Fay ()
onload = void' $ do
  olwrapperLoad  -- including OpenLayers

main :: Fay ()
main = addOnload onload
