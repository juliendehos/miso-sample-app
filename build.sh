#!/bin/sh

wasm32-wasi-cabal update

wasm32-wasi-cabal build 

rm -rf public

mkdir public

$(wasm32-wasi-ghc --print-libdir)/post-link.mjs --input $(wasm32-wasi-cabal list-bin app) --output public/ghc_wasm_jsffi.js

cp -v $(wasm32-wasi-cabal list-bin app) public/

wasm-opt -all -O2 public/app.wasm -o public/app.wasm

wasm-tools strip -o public/app.wasm public/app.wasm

cp static/* public/

