module Main where

import Debug.Trace

import Control.Plus (empty)
import qualified Control.Monad.Eff.DOM as DOM

import Data.Array
import Data.Foldable
import Data.Maybe
import Data.Tuple

import DOM

import VirtualDOM
import VirtualDOM.VTree

data Column = A | B | C | D | E | F | G | H | I | J | L | M | N | O | P | Q |
              R | S | T

data Row = One | Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten |
           Eleven | Twelve | Thirteen | Fourteen | Fifteen | Sixteen |
           Seventeen | Eighteen | Nineteen

type Coordinates = Tuple Column Row
data Play        = Play Player Coordinates
type Board       = [Vector]
type Vector      = [Cell]
type Cell        = { stone :: Maybe Stone }
type Player      = { color :: Stone }

data Stone = Black | White

type State = { boardSize :: Number
             , board     :: Board
             , plays     :: [Play]
             }

instance showStone :: Show Stone where
  show Black = "black"
  show White = "white"

emptyCell :: Cell
emptyCell = { stone: Nothing }

makeVector :: Number -> Vector
makeVector size = foldr (\_ vector -> emptyCell : vector) (empty :: Vector) (0 .. (size - 1))

makeBoard :: Number -> Board
makeBoard size =
  foldr (\_ board -> makeVector size : board) (empty :: Board) (0 .. (size - 1))

cellUI :: Cell -> VTree
cellUI cell =
  vnode "div" { className: "cell" } $ case cell.stone of
                                           Just stone -> [vtext $ show stone]
                                           Nothing    -> [vtext ""]

vectorUI :: Vector -> VTree
vectorUI vector = vnode "div" { className: "vector" } $ cellUI <$> vector

boardUI :: Board -> VTree
boardUI board = vnode "div" { className: "board" } $ vectorUI <$> board

initialState :: State
initialState = { board: makeBoard 19
               , boardSize: 19
               , plays: []
               }

goSeigenUI :: State -> VTree
goSeigenUI state =
  vnode "div" { className: "go-seigen" } [ boardUI state.board ]

main = do
  let goSeigenNode = createElement $ goSeigenUI initialState
  Just applicationNode <- DOM.querySelector "#application"
  DOM.appendChild goSeigenNode applicationNode
