{-# LANGUAGE DeriveAnyClass, DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings, RecordWildCards #-}

module Domain.Order where

import           Data.Aeson
import           Data.Map
import           Data.Text                      ( Text )
import           Data.UUID                      ( UUID )
import           Database.PostgreSQL.Simple
import           Domain.Cart
import           Domain.Item
import           Domain.Payment
import           GHC.Generics                   ( Generic )

newtype OrderId = OrderId {
  unOrderId :: UUID
} deriving (Eq, Generic, Ord, Show, ToRow)

data Order = Order
  { orderId :: OrderId
  , orderPaymentId :: PaymentId
  , orderItems :: Map ItemId Quantity
  , orderTotal :: Money
  } deriving (Generic, Show)

instance ToJSON Order where
  toJSON Order {..} = object
    [ "order_id" .= unOrderId orderId
    , "payment_id" .= unPaymentId orderPaymentId
    , "items" .= toJSON orderItems
    , "total" .= unMoney orderTotal
    ]
