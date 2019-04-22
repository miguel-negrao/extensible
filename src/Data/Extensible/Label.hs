{-# LANGUAGE CPP, TypeFamilies, MultiParamTypeClasses, UndecidableInstances, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Extensible.Label
-- Copyright   :  (c) Fumiaki Kinoshita 2018
-- License     :  BSD3
--
-- Maintainer  :  Fumiaki Kinoshita <fumiexcel@gmail.com>
--
-- Experimental API for OverloadedLabels. GHC 8.0+ only
-----------------------------------------------------------------------------
module Data.Extensible.Label where

import Data.Extensible.Class
import Data.Extensible.Field
import Data.Proxy
import GHC.OverloadedLabels
import Data.Extensible.Wrapper

instance k ~ l => IsLabel k (Proxy l) where
#if __GLASGOW_HASKELL__ >= 802
  fromLabel = Proxy
#else
  fromLabel _ = Proxy
#endif

-- | Specialised version of 'itemAssoc'.
訊 :: Proxy k -> FieldOptic k
訊 = itemAssoc

instance (Extensible f p e
  , Lookup xs k v
  , Labelling k p
  , Wrapper h
  , ExtensibleConstr e (Field h) xs (k ':> v)
  , rep ~ Repr h v
  , s ~ e (Field h) xs
  , s ~ t
  , rep ~ rep'
  )
  => IsLabel k (p rep (f rep') -> p s (f t)) where
#if __GLASGOW_HASKELL__ >= 802
  fromLabel = itemAssoc (Proxy :: Proxy k)
#else
  fromLabel _ = itemAssoc (Proxy :: Proxy k)
#endif
