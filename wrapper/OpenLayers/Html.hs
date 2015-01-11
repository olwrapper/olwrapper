{-|
Module      :  OpenLayersHtmlFunc
Description :  OpenLayers HTML and JQuery functions
-}
module OpenLayers.Html where

import           JQuery
import           Fay.Text
import           OpenLayers.HtmlInternal
import           OpenLayers.Internal
import           Fay.FFI
import           Prelude          hiding (void)

addTextToHtml :: String -> String -> String -> Fay ()
addTextToHtml content element id = void $ do
     c <- selectId' id
     d <- select' element
     setHtml' content d
     appendTo c d

addButton :: String -> String -> Fay () -> Fay ()
addButton text id method = void $ do
     c <- selectId' id
     d <- select' buttonElement
     setAttr' "value" text d
     setAttr' "type" "submit" d
     onClick' method d
     appendTo c d

addCheckbox :: String -> String -> String -> Fay ()
addCheckbox id parentId label = void $ do
    parent  <- selectId' parentId
    div     <- select' divElement
    setHtml' label div
    checkbox <- select' inputCheckboxElement
    setAttr' "id" id checkbox
    appendTo div checkbox
    appendTo parent div

addDiv :: String -> String -> String -> Fay ()
addDiv parentId divId label = void $ do
    parent  <- selectId' parentId
    div    <- select' divElement
    setAttr' "id" divId div
    setHtml' label div
    appendTo parent div
    
addLabel :: String -> String -> String -> Fay ()
addLabel parentId element id = void $ do
    parent <- selectId' parentId
    d <- select' element
    setAttr' "id" id d
    appendTo parent d

addForm :: String -> String -> Fay JQuery
addForm parentId formId = do
    parent   <- selectId' parentId
    form     <- select' $ formElement
    setAttr' "id" formId form
    appendTo parent form

addInput :: String -> String -> String -> String -> Fay ()
addInput label formId elementId defaultValue = void $ do
    parent <- selectId' formId
    div    <- select' divElement
    setHtml' label div
    input   <- select' inputTextElement
    setAttr' "id"    elementId    input
    setAttr' "value" defaultValue input
    appendTo div input
    appendTo parent div

addBreakline :: String -> Fay ()
addBreakline id = void $ do
    parent <- selectId' id
    value <- select' "<br>"
    appendTo parent value

getInputInt :: String -> Fay Integer
getInputInt labelId = do
    idinput <- selectId' labelId
    idvalue <- getVal idinput
    toInt idvalue

onClick' :: Fay () -> JQuery -> Fay JQuery
onClick' = ffi "%2['click'](%1)"

select' :: String -> Fay JQuery
select' s = select $ showString' s

selectId' :: String -> Fay JQuery
selectId' s = select $ showString' $ "#" ++ s

setHtml' :: String -> JQuery -> Fay JQuery
setHtml' content target = setHtml (showString' content) target

setAttr' :: String -> String -> JQuery -> Fay JQuery
setAttr' att val target = setAttr (showString' att) (showString' val) target

setDoubleAttr' :: String -> Double -> JQuery -> Fay JQuery
setDoubleAttr' att val target = setAttr (showString' att) (showDouble' val) target

showString' :: String -> Text
showString' = ffi "%1"

showDouble' :: Double -> Text
showDouble' = ffi "%1"

toInt :: Text -> Fay Integer
toInt = ffi "%1"

toInt' :: String -> Integer
toInt' = ffi "%1"





