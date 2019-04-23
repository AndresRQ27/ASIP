plot #0,#_0
plot #222,#45
plot #444,#128


;plotline	(5,6)- (15,1) used to store the temporary values of points
ADD		r7,r7,#5
ADD		r8,r8,#6 ; y0
ADD		r9,r9,#2 ; x1
ADD		r10,r10,#20 ; y1
MOV		r2,r7 ; x starts in x0 IN    R2
MOV		r3,r8 ; y starts in y0 IN    R3		


b my_instruction
plot R1,R5
mov R1, R4
my_instruction:
    plot R1,R0
    mov R1,R2

    add R1,R2,R2
    add R1,R2,#0
    
    sub R1,R2,R2
    
    sub R1,R2,#10

    adds R1,R2,R2
    adds R1,R2,#10

    b my_instruction
    bmi my_instruction
    beq my_instruction

    COL @000
    COL @001
    COL @000
    COL @011
    COL @100
    COL @101
    COL @110
    COL @111

    COL @BLACK
    COL @BLUE
    COL @GREEN
    COL @CYAN
    COL @RED
    COL @MAGENTA
    COL @YELLOW
    COL @WHITE

    COL @Black
    COL @Blue
    COL @Green
    COL @Cyan
    COL @Red
    COL @Magenta
    COL @Yellow
    COL @White

    COL @black
    COL @blue
    COL @green
    COL @cyan
    COL @red
    COL @magenta
    COL @yellow
    COL @white

    EOR R1,R2,R2