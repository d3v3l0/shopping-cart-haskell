{-# LANGUAGE DeriveGeneric, GeneralizedNewtypeDeriving #-}

module Domain.User where

import           Data.UUID                      ( UUID )
import           GHC.Generics                   ( Generic )
import           Servant                        ( FromHttpApiData )

newtype UserId = UserId {
 unUserId :: UUID
} deriving (Eq, Generic, FromHttpApiData, Show)
