module InnerEar.Types.Point where

import Text.JSON
import Data.Time.Clock
import Data.Time.Calendar (Day(ModifiedJulianDay))
import InnerEar.Types.Utility
import InnerEar.Types.Datum

type Time = UTCTime

data Point = Point {
  time :: Time,
  datum :: Datum
}

instance JSON Point where
  showJSON (Point t d) = encJSDict [("t",showJSON "notrecordingtime-needtofinishthislater"),("d",showJSON d)]
  readJSON (JSObject x) = Point <$> Ok (UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 0)) <*> valFromObj "d" x
  readJSON _ = Error "Unable to parse non-JSObject as Point"
