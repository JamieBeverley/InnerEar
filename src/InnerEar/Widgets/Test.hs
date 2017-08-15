module InnerEar.Widgets.Test where

import Reflex
import Reflex.Dom
import Reflex.Dom.Contrib.Widgets.Svg
import Data.Map (Map)
import qualified Data.Map as M
import Data.FileEmbed
import Text.Read (readMaybe)
import Data.Maybe (isJust, fromJust)
import Control.Monad
import Control.Monad.IO.Class


import InnerEar.Widgets.Utility
import InnerEar.Types.Request
import InnerEar.Types.Response
import Reflex.Synth.Types
import Reflex.Synth.Synth
import InnerEar.Widgets.Bars

test :: MonadWidget t m => m ()
test = do
   let m = M.fromList [("width","800px"),("height","800px"), ("viewBox", "0 0 300 200")]
   svgAttr "svg" m $ do
    -- let n = fromList [("width","50px"),("height","100px"), ("style", "fill:red")]
     svgClass "rect" "test" $ return ()


testWidget :: MonadWidget t m
  => Event t [Response] -> m (Event t Request,Event t Sound,Event t ())
testWidget responses = el "div" $ do
  source <- sourceWidget
  sound <- mapDyn ((flip FilteredSound) (Filter Lowpass 100 1 1)) source
  playButton <-  button "play sound"
  let sounds = tagDyn sound playButton
  test
  home <- button "back to splash page"
  return (never,sounds,home)



-- Do not delete!
testSoundWidget::MonadWidget t m => Event t [Response] -> m (Event t Request, Event t Sound, Event t ())
testSoundWidget _ = el "div" $ do
  let attrs = constDyn $ M.fromList $ zip ["cols"] ["80"]
  x <- textArea $ def & textAreaConfig_attributes .~ attrs
  eval <- button "eval"
  let text = _textArea_value x
  maybeSound <- mapDyn (\y->maybe NoSound id (readMaybe y::Maybe Sound)) text --dyn Maybe Sound
  mapDyn show maybeSound >>= dynText
  let sounds = tagDyn maybeSound eval
  home <- button "back to splash page"
  return (never,sounds,home)
