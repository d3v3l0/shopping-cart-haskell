{-# LANGUAGE DataKinds, OverloadedStrings, TypeOperators #-}

module Http.Routes.Items where

import           Control.Monad.IO.Class         ( liftIO )
import           Domain.Brand
import           Domain.Item
import           Effects.Logger
import           Http.Params
import           Http.Routes.Version
import           Servant
import           Services.Items                 ( Items )
import qualified Services.Items                as SI

type ItemsAPI =
  ApiVersion :> "items" :> QueryParam "brand" BrandNameParam :> Get '[JSON] [Item]

itemsServer :: Items IO -> Server ItemsAPI
itemsServer = findItems

findItems :: Items IO -> Maybe BrandNameParam -> Handler [Item]
findItems i (Just bn) = do
  logInfo $ "[Items] - Find by brand: " <> b
  liftIO $ SI.findBy i brand
  where brand@(BrandName b) = toBrandName bn
findItems i Nothing = do
  logInfo "[Items] - Find all"
  liftIO $ SI.findAll i
