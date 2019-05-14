#!/bin/bash

echo "compiling Examples/add.s"
./arm-compiler-dbg Examples/add.s compilation/add.o
echo "compiling Examples/beq.s"
./arm-compiler-dbg Examples/beq.s compilation/beq.o
echo "compiling Examples/bmi.s"
./arm-compiler-dbg Examples/bmi.s compilation/bmi.o
echo "compiling Examples/b.s"
./arm-compiler-dbg Examples/b.s compilation/b.o
echo "compiling Examples/col.s"
./arm-compiler-dbg Examples/col.s compilation/col.o
echo "compiling Examples/drawline.s"
./arm-compiler-dbg Examples/drawline.s compilation/drawline.o
echo "compiling Examples/drawrect.s"
./arm-compiler-dbg Examples/drawrect.s compilation/drawrect.o
echo "compiling Examples/eor.s"
./arm-compiler-dbg Examples/eor.s compilation/eor.o
echo "compiling Examples/fillrect.s"
./arm-compiler-dbg Examples/fillrect.s compilation/fillrect.o
echo "compiling Examples/plot.s"
./arm-compiler-dbg Examples/plot.s compilation/plot.o
echo "compiling Examples/sub.s"
./arm-compiler-dbg Examples/sub.s compilation/sub.o
echo "compiling Examples/test.s"
./arm-compiler-dbg Examples/test.s compilation/test.o

