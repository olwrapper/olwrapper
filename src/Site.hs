{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}

module Site ( app ) where

import               Data.ByteString     (ByteString)
import               Snap.Snaplet
import               Snap.Snaplet.Fay
import               Snap.Snaplet.Heist
import               Snap.Util.FileServe

----------------------------------------------------------
import           Application

routes :: [(ByteString, AppHandler ())]
routes = [
           ("/fay",    with fay fayServe)
         , ("/static", serveDirectory "static")
         ]

app :: SnapletInit App App
app = makeSnaplet "app" "" Nothing $ do
    h <- nestSnaplet "" heist ( heistInit "templates" )
    f <- nestSnaplet "fay" fay initFay
    addRoutes routes
    return $ App h f
