			;drawcircle			
			ADD		r12,r12,#2  ;r  in r12
			ADD		r11,r11,#4  ;x0 in r11
			ADD		r10,r10,#4  ;y0 in r10			
			SUB		r6,r11,r12
			SUB		r6,r6,#1    ;sx = x in r6
			ADD		r6,r11,#2		
			SUB		r5,r10,r12
			SUB		r5,r5,#1    ;y in r5			
			SUB		r4,r4,r4    ;calculate part of solution
			SUB		r3,r3,r3    ;calculate part of solution						
			SUBS		r9,r9,r9    ; resets r3
			SUBS		r2,r12,#0  ; counter
sqrR			SUBS		r2,r2,#0
			BEQ		whiley
			ADDS		r9,r9,r12
			SUBS		r2,r2,#1		;r2		is temporal variables
			B		sqrR									
whiley			ADD		r7,r10,r12			
			ADD		r7,r7,#1    ;fy in r7
			SUBS		r2,r7,r5    ;if fy=y finish
			BEQ		finish			
			SUB		r6,r11,r12
			SUB		r6,r6,#1      ;x = sx in r6
			SUBS		r7,r5,r10   ; y-y0
			BMI		restoredy
			B		notrestoredy
restoredy		SUB		r7,r10,r5			
notrestoredy		SUB		r2,r7,#0      ; counter
			SUBS		r3,r3,r3    ; resets r3
sqrY			SUBS		r2,r2,#0
			BEQ		whilex
			ADDS		r3,r3,r7
			SUBS		r2,r2,#1
			B		sqrY			
whilex			ADD		r8,r11,r12
			ADD		r8,r8,#1   ;fx in r8
			SUBS		r2,r8,r6    ;if fx=x finish
			BEQ		endwhiley			
			SUBS		r8,r6,r11   ;(x - x0)
			BMI		restoredx
			B		notrestoredx
restoredx		SUB		r8,r11,r6
notrestoredx		SUB		r2,r8,#0    ; counter
			SUB		r4,r4,r4    ;resets r4			
sqrX			SUBS		r2,r2,#0
			BEQ		verify
			ADDS		r4,r4,r8
			SUBS		r2,r2,#1
			B		sqrX			
verify			ADD		r4,r4,r3
			SUB		r4,r4,r9
			ADDS	r4,r4,#4			
			SUBS	r2,r4,#0
			BMI		noplot
			SUB		r2,r2,r2
			ADD		r2,r2,#10
			SUBS	r2,r2,r4
			BMI		noplot
			;plot 
			MOV 	r0,r6
			MOV		r1,r5
noplot			ADD		r6,r6,#1
			B		whilex
endwhiley		ADD		r5,r5,#1
			B		whiley
finish			EOR		r1,r1,r1
