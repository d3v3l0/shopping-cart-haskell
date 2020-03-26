{-# LANGUAGE DataKinds, TypeOperators #-}
{-# LANGUAGE OverloadedStrings, RecordWildCards #-}

module Http.Routes.Orders where

import           Control.Monad.IO.Class         ( liftIO )
import qualified Data.UUID                     as UUID
import           Domain.Order
import           Domain.User
import           Effects.Logger
import           Http.Params
import           Http.Routes.Version
import           Servant
import           Services.Orders                ( Orders )
import qualified Services.Orders               as SO

-- TODO: it should be authenticated via JWT
type OrdersAPI =
  ApiVersion :> "orders" :> Capture "id" UserId :> Get '[JSON] [Order] :<|>
  ApiVersion :> "orders" :> Capture "id" UserId :> Capture "oid" OrderId :> Get '[JSON] (Maybe Order)

ordersServer :: Orders IO -> Server OrdersAPI
ordersServer s = findAllOrdersBy s :<|> findOrderBy s

findAllOrdersBy :: Orders IO -> UserId -> Handler [Order]
findAllOrdersBy s uid@UserId {..} = do
  logInfo $ "[Orders] - Find all by UserId: " <> UUID.toText unUserId
  liftIO $ SO.findBy s uid

findOrderBy :: Orders IO -> UserId -> OrderId -> Handler (Maybe Order)
findOrderBy s uid@UserId {..} oid = do
  logInfo $ "[Orders] - Find order for UserId: " <> UUID.toText unUserId
  liftIO $ SO.get s uid oid
