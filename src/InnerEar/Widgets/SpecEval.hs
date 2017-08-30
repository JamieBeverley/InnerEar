module InnerEar.Widgets.SpecEval where

import Reflex
import Reflex.Dom
import Data.Map as M
import Control.Monad

import InnerEar.Types.Frequency
import InnerEar.Widgets.Utility
import InnerEar.Widgets.Bars
import InnerEar.Types.Score
import InnerEar.Widgets.Labels


displaySpectrumEvaluation :: MonadWidget t m => Dynamic t String -> Dynamic t (Map Frequency Score) -> m ()
displaySpectrumEvaluation graphLabel score= elClass "div" "specEvalWrapper" $ do
  dynGraphLabel (constDyn "graphLabel") graphLabel
  maybeScore<- mapDyn (mapKeys (freqAsString) . fmap (\v-> case v of (Score 0 0 0)-> Nothing;otherwise->Just v)) score
  listWithKey maybeScore (flip scoreBar)
  return ()

displayCurrentSpectrumEvaluation :: MonadWidget t m => Dynamic t String -> Dynamic t (Map Frequency Score) -> m ()
displayCurrentSpectrumEvaluation graphLabel score = elClass "div" "specEvalWrapper" $ do

  let labels = ["31","63","125","250","500","1","2","4","8","16"]
  let frequencies = zipWith F [31::Double,63,125,250,500,1000,2000,4000,8000,16000] labels -- [Frequency]
  let band0Hz = (!!0) labels -- String
  let band1Hz = (!!1) labels
  let band2Hz = (!!2) labels
  let band3Hz = (!!3) labels
  let band4Hz = (!!4) labels
  let band5Hz = (!!5) labels
  let band6Hz = (!!6) labels
  let band7Hz = (!!7) labels
  let band8Hz = (!!8) labels
  let band9Hz = (!!9) labels

  band0Score <- mapDyn (M.lookup (frequencies!!0)) score --  Dynamic t (Score) ?
  band1Score <- mapDyn (M.lookup (frequencies!!1)) score
  band2Score <- mapDyn (M.lookup (frequencies!!2)) score
  band3Score <- mapDyn (M.lookup (frequencies!!3)) score
  band4Score <- mapDyn (M.lookup (frequencies!!4)) score
  band5Score <- mapDyn (M.lookup (frequencies!!5)) score
  band6Score <- mapDyn (M.lookup (frequencies!!6)) score
  band7Score <- mapDyn (M.lookup (frequencies!!7)) score
  band8Score <- mapDyn (M.lookup (frequencies!!8)) score
  band9Score <- mapDyn (M.lookup (frequencies!!9)) score

  band0ScoreBar <- scoreBar band0Score band0Hz -- m ()
  band1ScoreBar <- scoreBar band1Score band1Hz
  band2ScoreBar <- scoreBar band2Score band2Hz
  band3ScoreBar <- scoreBar band3Score band3Hz
  band4ScoreBar <- scoreBar band4Score band4Hz
  band5ScoreBar <- scoreBar band5Score band5Hz
  band6ScoreBar <- scoreBar band6Score band6Hz
  band7ScoreBar <- scoreBar band7Score band7Hz
  band8ScoreBar <- scoreBar band8Score band8Hz
  band9ScoreBar <- scoreBar band9Score band9Hz
  faintedXaxis
  faintedYaxis
  percentageMainLabel
  hzMainLabel
  countMainLabel
  dynGraphLabel (constDyn "graphLabel") graphLabel

  return ()

displayHistoricalSpectrumEvaluation :: MonadWidget t m => Dynamic t String -> Dynamic t (Map Frequency Score) -> m ()
displayHistoricalSpectrumEvaluation graphLabel score = elClass "div" "specEvalWrapper" $ do
    dynGraphLabel (constDyn "graphLabel") graphLabel
    percentageMainLabel
    hzMainLabel
    countMainLabel

    let labels = ["31","63","125","250","500","1","2","4","8","16"]
    let frequencies = zipWith F [31::Double,63,125,250,500,1000,2000,4000,8000,16000] labels -- [Frequency]
    let band0Hz = (!!0) labels -- String
    let band1Hz = (!!1) labels
    let band2Hz = (!!2) labels
    let band3Hz = (!!3) labels
    let band4Hz = (!!4) labels
    let band5Hz = (!!5) labels
    let band6Hz = (!!6) labels
    let band7Hz = (!!7) labels
    let band8Hz = (!!8) labels
    let band9Hz = (!!9) labels

    band0Score <- mapDyn (M.lookup (frequencies!!0)) score
    band1Score <- mapDyn (M.lookup (frequencies!!1)) score
    band2Score <- mapDyn (M.lookup (frequencies!!2)) score
    band3Score <- mapDyn (M.lookup (frequencies!!3)) score
    band4Score <- mapDyn (M.lookup (frequencies!!4)) score
    band5Score <- mapDyn (M.lookup (frequencies!!5)) score
    band6Score <- mapDyn (M.lookup (frequencies!!6)) score
    band7Score <- mapDyn (M.lookup (frequencies!!7)) score
    band8Score <- mapDyn (M.lookup (frequencies!!8)) score
    band9Score <- mapDyn (M.lookup (frequencies!!9)) score

    band0ScoreBar <- scoreBar band0Score band0Hz
    band1ScoreBar <- scoreBar band1Score band1Hz
    band2ScoreBar <- scoreBar band2Score band2Hz
    band3ScoreBar <- scoreBar band3Score band3Hz
    band4ScoreBar <- scoreBar band4Score band4Hz
    band5ScoreBar <- scoreBar band5Score band5Hz
    band6ScoreBar <- scoreBar band6Score band6Hz
    band7ScoreBar <- scoreBar band7Score band7Hz
    band8ScoreBar <- scoreBar band8Score band8Hz
    band9ScoreBar <- scoreBar band9Score band9Hz

    return ()
--
displaySpectrumEvaluationGraphs :: MonadWidget t m => m ()
displaySpectrumEvaluationGraphs = do

  --  let currentM = constDyn (M.fromList [((F 31 "31"), (Score 1 0 9)), ((F 63 "63"), (Score 2 0 8)), ((F 125 "125"), (Score 3 0 7)), ((F 250 "250"), (Score 4 0 6)), ((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4)), ((F 2000 "2"), (Score 7 0 3)), ((F 4000 "4"), (Score 8 0 2)), ((F 8000 "8"), (Score 9 0 1)), ((F 16000 "16"), (Score 10 0 0))])
  --  let currentM = constDyn (M.fromList [((F 125 "125"), (Score 3 0 7)), ((F 250 "250"), (Score 4 0 6)), ((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4)), ((F 2000 "2"), (Score 7 0 3)), ((F 4000 "4"), (Score 8 0 2)), ((F 8000 "8"), (Score 9 0 1)), ((F 16000 "16"), (Score 10 0 0))])
  --  let currentM = constDyn (M.fromList [((F 63 "63"), (Score 2 0 8)),((F 125 "125"), (Score 3 0 7)), ((F 250 "250"), (Score 4 0 6)), ((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4)), ((F 2000 "2"), (Score 7 0 3)), ((F 4000 "4"), (Score 8 0 2)), ((F 8000 "8"), (Score 9 0 1))])
  --  let currentM = constDyn (M.fromList [((F 125 "125"), (Score 3 0 7)), ((F 250 "250"), (Score 4 0 6)), ((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4)), ((F 2000 "2"), (Score 7 0 3)), ((F 4000 "4"), (Score 8 0 2))])
  --  let currentM = constDyn (M.fromList [((F 250 "250"), (Score 4 0 6)), ((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4)), ((F 2000 "2"), (Score 7 0 3))])
  --  let currentM = constDyn (M.fromList [((F 500 "500"), (Score 5 0 5)), ((F 1000 "1"), (Score 6 0 4))])
    let currentM = constDyn (M.fromList [((F 500 "500"), (Score 5 0 5))])
    displayCurrentSpectrumEvaluation (constDyn "Current Performance") currentM
