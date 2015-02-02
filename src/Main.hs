{-# LANGUAGE CPP               #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import          Control.Exception (SomeException, try)
import          Data.Text
import          Snap.Http.Server
import          Snap.Snaplet
import          Snap.Snaplet.Config
import          Snap.Core
import          System.IO
import          Site

#ifdef DEVELOPMENT
import           Snap.Loader.Dynamic
#else
import           Snap.Loader.Static
#endif

getConf :: IO (Config Snap AppConfig)
getConf = commandLineAppConfig defaultConfig

getActions :: Config Snap AppConfig -> IO (Snap (), IO ())
getActions conf = do
    (msgs, site, cleanup) <- runSnaplet (appEnvironment =<< getOther conf) app
    hPutStrLn stderr $ unpack msgs
    return (site, cleanup)

main :: IO ()
main = do
    (conf, site, cleanup) <- $(loadSnapTH [| getConf |] 'getActions ["snaplets/heist/templates"])
    _ <- try $ httpServe conf site :: IO (Either SomeException ())
    cleanup
