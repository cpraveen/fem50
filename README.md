# 2-D FEM code in Matlab

This is a matlab code for solving poisson equation by FEM on 2-d domains. It is taken from

"Remarks around 50 lines of Matlab: short finite element implementation"

 * http://link.springer.com/article/10.1023/A:1019155918070
 * https://www.math.hu-berlin.de/~cc/cc_homepage/download/1999-AJ_CC_FS-50_Lines_of_Matlab.pdf

## Examples

 * sample   : This contains the example grid from the paper
 * Gamma    : Generate grid by running Gamma.m in matlab
 * sinusoid :
 * square   : Generate grid by running square.m in matlab

## How to run code in "square"

```
bash> cd square
```

Start matlab

```
bash> matlab
```

Generate mesh
```
>> square(30)
>> close all
>> clear all
```

Add path to fem code and run it
```
>> addpath(path,'../src')
>> fem_50()
```
