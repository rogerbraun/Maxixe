# Maxixe
### A simple statistical segmenter for any language

## About

Maxixe is an implementation of the Tango algorithm describe in the paper "Mostly-unsupervised statistical segmentation of Japanese kanji sequences" by Ando and Lee. While the paper deals with Japanese characters, it should work on any unsegmented text given enough corpus data and a tuning of the algorithm paramenters.

## How to use

Get a corpus of text you will can use to train the segmenter. Pre-segment a small number of sentences by hand. Create a large index for optimizing. Use optimized paramters for segmenting.

```
    pre_segmented = [["MYDOGISINTHEHOUSE", "MY DOG IS IN THE HOUSE"],
                     ["FOURNICEDOGS", "FOUR NICE DOGS"],
                     ["MYCATLIKESMYDOG", "MY CAT LIKES MY DOG"]]
    index = Maxixe::Trainer.generate_corpus_from_io([2,3,4,5], "ILIKEMYDOG
THISHOUSEISMYHOUSE
MYDOGISSONICE
WHOLIKESDOGSANYWAY
CATSANDDOGSUSUALLYFIGHT
INMYHOUSETHEREAREFOURDOGS
IWANTAHOUSEFORMYDOG")
  
    optimal = Maxixe::Trainer.optimize(index, pre_segmented)
        
```

`optimal` is now `{:n => ["2","3"], :t => 0.5, :score => 0}`. Use this to make a segmenter.

Also, see http://rogerbraun.net/maxixe-a-simple-statistical-segmenter-for-any
