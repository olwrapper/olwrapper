{-|
Module      :  OpenLayersHtmlFunc
Description :  OpenLayers HTML and JQuery functions and constants
-}
module OpenLayers.Html where

import           Prelude hiding (void, showString)
import           JQuery
import           Fay.Text
import           Fay.FFI
import           OpenLayers.Internal
-- * CONSTANTS
-- | a \<a\> element
aElement  = "<a>"
-- | a \<br\> element
brElement = "<br>"
-- | a \<p\> element
pElement  = "<p>"
-- | a \<div\> element
divElement  = "<div>"
-- | a \<form\> element
formElement  = "<form>"
-- | a \<input\> element
buttonElement = "<input>"
-- | a \<input\> element of type text
inputTextElement = "<input type=text>"
-- | a \<input\> element of type checkbox
inputCheckboxElement = "<input type=checkbox>"
-- * FUNCTIONS
-- ** ADD FUNCTIONS
-- | add a new html element to an existing and fill the content of the new with text
addTextToHtml :: String  -- ^ text to add
              -> String  -- ^ typ of the html element to add
              -> String  -- ^ id of the html element to append
              -> Fay ()
addTextToHtml content element parentId = void $ do
     c <- selectId parentId
     d <- select' element
     setHtml' content d
     appendTo c d
-- | add a new button (type=submit) to an existing html element with a text and a method
addButton :: String  -- ^ text for the button
          -> String  -- ^ id of the html element to append
          -> Fay ()  -- ^ method for the button
          -> Fay ()
addButton text parentId method = void $ do
     c <- selectId parentId
     d <- select' buttonElement
     setAttr' "value" text d
     setAttr' "type" "submit" d
     onClick' method d
     appendTo c d
-- | add a new checkbox to an existing html element with a text and a method 
addCheckbox :: String  -- ^ id for the new checkbox
            -> String  -- ^ id of the html element to append
            -> String  -- ^ text for the checkbox
            -> Fay ()
addCheckbox id parentId label = void $ do
    parent  <- selectId parentId
    div     <- select' divElement
    setHtml' label div
    checkbox <- select' inputCheckboxElement
    setAttr' "id" id checkbox
    appendTo div checkbox
    appendTo parent div
-- | add a div-element with a text
addDiv :: String  -- ^ id of the html element to append
       -> String  -- ^ id for the new div-element
       -> String  -- ^ text for the div-element
       -> Fay ()
addDiv parentId divId label = void $ do
    parent  <- selectId parentId
    div    <- select' divElement
    setAttr' "id" divId div
    setHtml' label div
    appendTo parent div
-- | add a custom html element
addElement :: String  -- ^ id of the html element to append
           -> String  -- ^ element type (f. e. \"<div>\")
           -> String  -- ^ id for the new element
           -> Fay ()
addElement parentId element id = void $ do
    parent <- selectId parentId
    d <- select' element
    setAttr' "id" id d
    appendTo parent d
-- | add a new form-element
addForm :: String   -- ^ id of the html element to append
        -> String   -- ^ id for the new form-element
        -> Fay JQuery
addForm parentId formId = do
    parent   <- selectId parentId
    form     <- select' $ formElement
    setAttr' "id" formId form
    appendTo parent form
-- | add a new input element of type text
addInput :: String  -- ^ label of the element
         -> String  -- ^ id of the html element to append
         -> String  -- ^ id for the new input element
         -> String  -- ^ default value for the text field
         -> Fay ()
addInput label parentId elementId defaultValue = void $ do
    parent <- selectId parentId
    div    <- select' divElement
    setHtml' label div
    input   <- select' inputTextElement
    setAttr' "id"    elementId    input
    setAttr' "value" defaultValue input
    appendTo div input
    appendTo parent div
-- | add a new breakline
addBreakline :: String  -- ^ id of the html element to append
             -> Fay ()
addBreakline id = void $ do
    parent <- selectId id
    value <- select' brElement
    appendTo parent value
-- ** OTHER FUNCTIONS
-- | get the integer value of an element
getInputInt :: String       -- ^ id of the html element
            -> Fay Integer
getInputInt labelId = do
    idinput <- selectId labelId
    idvalue <- getVal idinput
    toInt idvalue
-- | select an element due to his id
selectId :: String      -- ^ id of the html element
         -> Fay JQuery
selectId s = select $ showString $ "#" ++ s
-- | in combination f. e. with "addMapWindowEvent" to change the html element content
setEventToHtml :: String      -- ^ id of the html element 
               -> Fay Text    -- ^ method to generate text (f. e. "getZoom")
               -> Fay JQuery
setEventToHtml elementId function = do 
    element <- selectId elementId
    f <- function
    setHtml f element
-- | String to Text with FFI
showString :: String -> Text
showString = ffi "%1"
-- | Double to Text with FFI
showDouble :: Double -> Text
showDouble = ffi "%1"
-- | Text to Fay Integer with FFI
toInt :: Text -> Fay Integer
toInt = ffi "%1"
-- | String to Integer with FFI
toInt' :: String -> Integer
toInt' = ffi "%1"
-- ** ADAPTED FAY.JQUERY FUNCTIONS
-- | adapted from JQuery's "select"
onClick' :: Fay ()     -- ^ method for the button
         -> JQuery     -- ^ button element
         -> Fay JQuery
onClick' = ffi "%2['click'](%1)"
-- | adapted from JQuery's "select"
select' :: String      -- ^ html element to select (see CONSTANTS)
        -> Fay JQuery
select' s = select $ showString s
-- | adapted from JQuery's "setHtml"
setHtml' :: String     -- ^ value for inner html
         -> JQuery     -- ^ html element to set
         -> Fay JQuery
setHtml' content target = setHtml (showString content) target
-- | adapted from 'Fay.JQuery.setAttr'
setAttr' :: String     -- ^ parameter to set (f.e. \"id\")
         -> String     -- ^ value for the parameter
         -> JQuery     -- ^ html element to set
         -> Fay JQuery
setAttr' att val target = setAttr (showString att) (showString val) target
