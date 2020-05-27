" This file was generated from an m4 template.
" Generation date-time (ISO 8601): 2019-03-09T08:41+00:00
"   Git remote URL: https://github.com/emerald/modes-vim
"   Git commit ID: fac042cce9264ae7370a02acc5454decf2aa1b7b

" Copyright (c) 2018-2019 Oleks <oleks@oleks.info>
" 
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
" 
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" Keywords and built-in types, as found in:
"   Git remote URL: https://github.com/emerald/old-emerald
"   Git commit ID: 8de69f56ed8a7dcec2aacae369d2a20f29dfe960

"   Keywords generated using scripts/keywords.sh
syn keyword Keyword accept and as assert
syn keyword Keyword at attached awaiting begin
syn keyword Keyword builtin by checkpoint class
syn keyword Keyword closure codeof const else
syn keyword Keyword elseif end enumeration exit
syn keyword Keyword export external failure false
syn keyword Keyword field fix for forall
syn keyword Keyword from function if immutable
syn keyword Keyword in initially isfixed islocal
syn keyword Keyword locate loop monitor move
syn keyword Keyword nameof new nil object
syn keyword Keyword op operation or primitive
syn keyword Keyword process record recovery refix
syn keyword Keyword restrict return returnandfail self
syn keyword Keyword signal suchthat syntactictypeof then
syn keyword Keyword to true typeobject typeof
syn keyword Keyword unavailable unfix var view
syn keyword Keyword visit wait when while

"   Types generated using scripts/types-from-builtins.sh
syn keyword Type Any AOpVector
syn keyword Type AOpVectorE AParamList
syn keyword Type Array Bitchunk
syn keyword Type Boolean Buffer
syn keyword Type Character ConcreteType
syn keyword Type Condition COpVector
syn keyword Type COpVectorE Decoder
syn keyword Type Directory DirectoryGaggle
syn keyword Type GListener GManager
syn keyword Type Group Handler
syn keyword Type immutableVector ImmutableVectorOfAny
syn keyword Type ImmutableVectorOfInt ImmutableVectorOfString
syn keyword Type InStream Integer
syn keyword Type InterpreterState LiteralList
syn keyword Type Node NodeList
syn keyword Type NodeListElement None
syn keyword Type OutStream RDirectory
syn keyword Type Real RISA
syn keyword Type RISC Sequence
syn keyword Type SequenceOfAny SequenceOfCharacter
syn keyword Type Signature String
syn keyword Type Stub Time
syn keyword Type type Unix
syn keyword Type Vector VectorOfAny
syn keyword Type VectorOfChar VectorOfInt
syn keyword Type VectorOfString 

" The other parts of the syntax spec, as found in other.vim:
syn match Comment "%.*$"

syn region  Constant start=/"/ skip=/\\["\\]/ end=/"/
syn region  Constant start=/'/ skip=/\\['\\]/ end=/'/

syntax case ignore
