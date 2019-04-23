		;plotline	(5,6)- (15,1) used to store the temporary values of points
		MOV		r7,#5 ; x0
		MOV		r8,#6 ; y0
		MOV		r9,#2 ; x1
		MOV		r10,#20 ; y1
		MOV		r2,r7 ; x starts in x0 IN    R2
		MOV		r3,r8 ; y starts in y0 IN    R3		
		SUBS		r11,r9,r7 		;dx in r11
		BMI		changedx:
		EOR		r9,r9,r9
		ADD		r9,r9,#1		;sign of dx in r9
		B		dy:
changedx:	SUBS		r11,r7,r9 		;abs dx
		EOR		r9,r9,r9		
		SUB		r9,r9,#1
dy:		SUBS		r12,r10,r8 		;dy  r12
		BMI		changedy:
		EOR		r10,r10,r10 		;sign of dy in r10
		ADD		r10,r10,#1
		B		swap:
changedy:	SUBS		r12,r8,r10 		;abs dy
		EOR		r10,r10,r10
		SUB		r10,r10,#1
swap:		SUB		R8,R8,R8 		;swap in r8
		SUBS		r0, r12, r11
		BMI		eabvars:		;if dy<dx branch
		MOV		r0,r11			;if dy>dy swaps dy and dx
		MOV		r11, r12
		MOV		r12, r0
		ADD		r8, r8, #1
eabvars:	LSL		r7,r11, #1		;r7 = 2*dx
		LSL		r6,r12, #1		;r6 = 2*dy      a
		SUB		r5,r6,r7		;r5 = 2dy-2dx   b
		SUB		r7,r6,r11		;r7 = 2dy-dx    e
		;PLOT     r2,r3
		SUB		r4,r4, r4		;i for loop
while:		SUBS		r0,r11,r4
		BEQ		finish:
		ADD		r4,r4,#1
		ADDS		r0,r7,#0
		BMI		lesse:
		ADD		r3,r3,r10
		ADD		r2,r2,r9
		ADD		r7,r7,r5
		;PLOT     r2,r3
		B		while:
lesse:		ADD		r7,r7,r6
		ADDS		r8,r8,#0
		BEQ		noswap:
		ADD		r3,r3,r10
		;PLOT     r2,r3
		B		while:
noswap:		ADD		r2,r2,r9
		;PLOT     r2,r3
		B		while:
finish:		SUB		r0,r0,r0
		
		
		
		
		
