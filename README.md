# 2-D FEM code in Matlab

This is a matlab code for solving poisson equation by FEM on 2-d domains. It is taken from

**Alberty, Carstensen, Funken: Remarks around 50 lines of Matlab: short finite element implementation**

* http://link.springer.com/article/10.1023/A:1019155918070
* https://www.math.hu-berlin.de/~cc/cc_homepage/download/1999-AJ_CC_FS-50_Lines_of_Matlab.pdf

## Examples

* sample   : This contains the example grid from the paper
* Gamma    : Generate grid by running Gamma.m in matlab
* sinusoid :
* square   : Generate grid by running square.m in matlab

## How to run code in "square"

```shell
bash> cd square
```

Start matlab

```shell
bash> matlab
```

In matlab, generate mesh

```matlab
>> square(30)
>> close all
>> clear all
```

Add path to fem code and run it

```matlab
>> addpath(path,'../src')
>> fem_50()
```

## Running on matlab drive

Download code

```matlab
unzip('https://github.com/cpraveen/fem50/archive/master.zip')
movefile('fem50-master', 'fem50'), addpath(fullfile(cd,'fem50/src')), savepath
```

Run it

```matlab
square(30)
fem_50()
```

## You can avoid matlab

There is no reason to use matlab which is not a free software. You have better options in Python and Julia. For similar codes as this, see

1. Python: https://github.com/cpraveen/fem/tree/master/python/2d
1. Julia: https://github.com/cpraveen/juliafem
