{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell   #-}

module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.Fay

data App = App { 
       _heist :: Snaplet (Heist App)
     , _fay   :: Snaplet Fay
        }

makeLenses ''App

instance HasHeist App where heistLens = subSnaplet heist

type AppHandler = Handler App App
