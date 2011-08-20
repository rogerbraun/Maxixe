# Maxixe
### A simple statistical segmenter for any language

## About

Maxixe is an implementation of the Tango algorithm describe in the paper "Mostly-unsupervised statistical segmentation of Japanese kanji sequences" by Ando and Lee. While the paper deals with Japanese characters, it should work on any unsegmented text given enough corpus data and a tuning of the algorithm paramenters.

## How to use

First, you need a hash that contains the count of all n-grams in a given corpus.
