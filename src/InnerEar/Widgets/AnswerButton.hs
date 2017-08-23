module InnerEar.Widgets.AnswerButton where

import Reflex
import Reflex.Dom
import Data.Map
import Control.Monad

import InnerEar.Widgets.Utility
import InnerEar.Widgets.Bars


data AnswerButtonMode = NotPossible | Possible | IncorrectDisactivated | IncorrectActivated  | Correct deriving (Eq,Show)

buttonDynCss :: MonadWidget t m => String -> Dynamic t String -> m (Event t ())
buttonDynCss label cssClass = do
  cssClass' <- mapDyn (singleton "class") cssClass
  (element, _) <- elDynAttr' "button" cssClass' $ text label -- m
  return $ domEvent Click element  -- domEvent :: EventName en -> a -> Event t (EventResultType en)

answerButton:: MonadWidget t m => Dynamic t String -> Dynamic t AnswerButtonMode -> a -> m (Event t a)
answerButton buttonString buttonMode x = do
  curClass <- mapDyn modeToClass buttonMode
  clickableDivDynClass buttonString curClass x

answerButton' :: MonadWidget t m => String -> Dynamic t AnswerButtonMode -> m (Event t ())
answerButton' buttonString buttonMode = do
  curClass <- mapDyn modeToClass buttonMode
  buttonDynCss buttonString curClass

modeToClass :: AnswerButtonMode -> String
modeToClass NotPossible = "notPossibleButton"
modeToClass Possible = "possibleButton"
modeToClass IncorrectDisactivated = "incorrectDisactivatedButton"
modeToClass Correct = "correctButton"
modeToClass IncorrectActivated = "incorrectActivatedButton"
