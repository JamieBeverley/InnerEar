{-# LANGUAGE DeriveDataTypeable #-}

module InnerEar.Exercises.OddEvenAll (oddEvenAllExercise) where

import Reflex
import Reflex.Dom
import Data.Map
import Text.JSON
import Text.JSON.Generic

import Reflex.Synth.Types
import InnerEar.Exercises.MultipleChoice
import InnerEar.Types.ExerciseId
import InnerEar.Types.Exercise
import InnerEar.Types.Score
import InnerEar.Widgets.Config
import InnerEar.Widgets.SpecEval
import InnerEar.Types.Data
import InnerEar.Types.Frequency

type Config = Frequency -- represents fundamental frequency for sound generation

configs :: [Config]
configs = [F 100 "100 Hz",F 200 "200 Hz", F 400 "400 Hz", F 800 "800 Hz", F 1600 "1600Hz", F 3200 "3200Hz"]

data Answer = Answer Bool deriving (Eq,Ord,Data,Typeable)

instance Show Answer where
  show (Answer True) = "With Noise"
  show (Answer False) = "Clean"

answers = [Answer False,Answer True]

renderAnswer :: Config -> Source -> Maybe Answer -> Sound
renderAnswer db (NodeSource node dur) (Just (Answer True)) = OverlappedSound "addedWhiteNoiseExercise"  [GainSound (Sound $ NodeSource node dur) (-10) , GainSound (Sound $ NodeSource (BufferNode $ File "whitenoise.wav") dur ) db] -- should be soundSource (b) at -10 plus whiteNoise at dB
renderAnswer db b (Just (Answer False)) = OverlappedSound "addedWhiteNoiseExercise" [GainSound (Sound b) (-10)] -- note: this must be an overlapped sound so that it cuts off the previous playing sound...
renderAnswer db b Nothing = OverlappedSound "addedWhiteNoiseExercise" [GainSound (Sound b) (-10)] -- should also just be soundSource (b) at -10
-- note also: default sound source for this is a 300 Hz sine wave, but user sound files are possible
-- pink or white noise should NOT be possible as selectable sound source types

displayEval :: MonadWidget t m => Dynamic t (Map Answer Score) -> m ()
displayEval = displayMultipleChoiceEvaluationGraph' "Session Performance" "" answers

generateQ :: Config -> [ExerciseDatum] -> IO ([Answer],Answer)
generateQ _ _ = randomMultipleChoiceQuestion [Answer False,Answer True]

instructions :: MonadWidget t m => m ()
instructions = el "div" $ do
  elClass "div" "instructionsText" $ text "In this exercise, a low level of noise (white noise) is potentially added to a reference signal. Your task is to detect whether or not the noise has been added. Configure the level of the noise progressively lower and lower to challenge yourself."
  elClass "div" "instructionsText" $ text "Note: the exercise will work right away with a sine wave as a reference tone (to which noise is or is not added), however it is strongly recommended that the exercise be undertaken with recorded material such as produced music, field recordings, etc. Click on the sound source menu to load a sound file from the local filesystem."



sourcesMap:: Map Int (String,Source)
sourcesMap = fromList $ [(0,("300hz sine wave", NodeSource (OscillatorNode $ Oscillator Sine 440 0) (Just 2))), (1,("Load a soundfile", NodeSource (BufferNode $ LoadedFile "addedWhiteNoiseExercise" (PlaybackParam 0 1 False)) Nothing))]

addedWhiteNoiseExercise :: MonadWidget t m => Exercise t m Config [Answer] Answer (Map Answer Score)
addedWhiteNoiseExercise = multipleChoiceExercise
  1
  [Answer False,Answer True]
  instructions
  (configWidget "addedWhiteNoiseExercise" sourcesMap 0 "Noise level (dB): " configMap)
  renderAnswer
  AddedWhiteNoise
  (-10)
  displayEval
  generateQ