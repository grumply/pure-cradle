# ePub development workspace

Simply run `./write` and start editing in `/book`. 

Saving will trigger a re-compile and produce `output.epub`, `output.pdf`, and `dist/index.html`.

Supports embedded fonts and images, syntax highlighting of code blocks, inline latex, inline html, and custom CSS.

## Description

Edit metadata description in `book/metadata.yaml`.

## CSS

Edit `book/book.css` to customize layout, styles, and font.

## Custom Fonts

Add TrueType Fonts (.ttf) to `book/static/` and include them in `book/book.css`.

## Custom Images

Add global images to `book/static/` and reference as `static/...`.

Add local images to `book/<chapter>/static/<file>` and refence them as `./static/<file>`.
