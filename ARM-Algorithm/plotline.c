#include <stdio.h>



void bresenham(int x1,int y1, int x2, int y2){

    int x = x1;
    int y = y1;

    int dx = x2 - x1;
    int sx = 1;
    if (dx < 0)
    {
        sx = -1;
        dx = x1-x2;
    }
    int dy = y2 - y1;
    int sy = 1;
    if (dy < 0)
    {
        sy = -1;
        dy = y1-y2;
    }

    int swap = 0;

    if(dy>dx){
        swap = dx;
        dx = dy;
        dy = swap;
        swap = 1;
    }

    int e = 2*dy-dx;
    int a = 2*dy;
    int b = 2*dy-2*dx;

    printf("%d , %d\n", x, y);
    int i = 1;

    while(i <= dx){
        if (e<0){
            if(swap){
                y = y+sy;
            }else{
                x=x+sx;
            }
            e = e+a;
        }else{
            y = y+sy;
            x = x+sx;
            e = e+b;
        }
        printf("%d , %d\n", x, y);
        i+=1;
    }

    //printf("%d , %d\n", x, y);
}

int main(){

    int x1 = 5;
    int y1 = 1;
    int x2 = 1;
    int y2 = 10;


    bresenham(x1,y1,x2,y2);

    

    return 0;
}