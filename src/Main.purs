module Main where

import Debug.Trace
import Control.Monad.Eff
import Control.Plus (empty)

import Data.Array hiding (span)
import Data.Foldable
import Data.Maybe
import Data.Maybe.Unsafe

import React
import React.DOM

type State = { board :: Board }
type Board = [Row]
type Row   = [Cell]
type Cell  = { stone :: Maybe Stone }

data Stone = Black | White

showStone :: Stone -> String
showStone Black = "black"
showStone White = "white"

emptyBoard :: Board
emptyBoard = empty

emptyRow :: Row
emptyRow = empty

emptyCell :: Cell
emptyCell = { stone: Nothing }

makeRow :: Number -> Row
makeRow size = foldr (\_ row -> emptyCell : row) emptyRow (0 .. (size - 1))

makeBoard :: Number -> Board
makeBoard size =
  foldr (\_ board -> makeRow size : board) emptyBoard (0 .. (size - 1))

cell = mkUI spec do
  props <- getProps
  return $ div [
             className "cell"
           ] $ case props.cell.stone of
                    Just stone -> [text $ showStone stone]
                    Nothing    -> []


row = mkUI spec do
  props <- getProps
  return $ div [
             className "row"
           ] $ (\c -> cell { cell: c }) <$> props.row

board = mkUI spec do
  props <- getProps
  return $ div [
             className "board"
           ] $ (\r -> row { row: r }) <$> props.board.rows

goSeigen = mkUI spec do
  props <- getProps
  return $ div [
             className "go-seigen"
           ] $ [
             board { board: props.board }
           ]

main = do
  renderToElementById "application" $ goSeigen { board: { rows: makeBoard 19 } }
