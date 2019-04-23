#include <stdio.h>

int main(){
    int r = 10;
    int x0 = 50;
    int y0 = 50;

    int sx = x0 - r - 1;
    int sy = y0 - r - 1;

    int fx = x0 + r + 1;
    int fy = y0 + r + 1;

    int x = sx;
    int y = sy;

    int temp1 = 0;
    int temp2 = 0;
    int temp3 = 0;
    int temp4 = 0;

    while (y != fy)
    {
        x = sx;
        while (x != fx)
        {
            temp1 = (x - x0) * (x - x0);
            temp2 = (y - y0) * (y - y0);
            temp3 = r * r;
            temp4 = temp1 + temp2 - temp3 + 4;
            //std::cout << x << " , " << y << std::endl;
            if ((temp4 > 0) && (temp4 < 10))
            {
                printf("%d , %d\n", x, y);
                //std::cout << x << " , " << y << std::endl;
            }

            x += 1;
        }
        y += 1;
    }

    return 0;


}