{-# language QuasiQuotes, NoMonomorphismRestriction #-}
module Main where

import Pure.Data.Time
import Pure.Data.Txt (fromTxt,toTxt)
import Pure.Data.Txt.Interpolate
import Pure.Data.Txt.Interpolate.Unindent

import Dev

import System.Environment

data Opts = Opts
  { epub :: Bool
  , pdf  :: Bool
  , html :: Bool
  }

main :: IO ()
main = do
  as <- getArgs
  let os = Opts ("--epub" `elem` as) ("--pdf" `elem` as) ("--html" `elem` as)
  defaultMain "book" [ Restartable "compile" (first (files os)) ]
  where
    files os = [ "**/*" |$ Main.compile os ]

compile os = do
  let command = [i|#{cp_css} && #{html_command} && #{epub_command} && #{pdf_command}|] 
      cp_css :: String
      cp_css = "mkdir -p dist/book/ && cp book/book.css dist/book/book.css"
      html_command = pandoc html "dist/index.html" "--standalone"
      epub_command = pandoc epub "output.epub" "--metadata-file=book/metadata.yaml --epub-embed-font='static/*.ttf'"
      pdf_command  = pandoc pdf "output.pdf" ""
  status (Running command)
  spawn command
  status (Good [i|Built|])
  where
    pandoc :: (Opts -> Bool) -> String -> String -> String
    pandoc f out extras
      | f os      = [i|pandoc $(find book/* -name '*.md') -o #{out} #{flags} #{extras}|]
      | otherwise = " : " -- bash no-op

    flags :: String
    flags = [i|--css=book/book.css --table-of-contents --pdf-engine=xelatex --from=markdown --highlight-style=pygments -V documentclass=report -V papersize=A4 -V geometry:margin=1in|]
