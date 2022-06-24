
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;org 100h

org 100h

.data

msg DB 0AH,0DH,"Welcome to the Factorial Program $ "  ;first message 
msg_2 DB 0AH,0DH,"Please input the number for Calculating it's Factorial? [0-8] = $" ;input message  
msg_3 DB 0AH,0DH,"Not in the range! $" ;error message 
msg_4 DB "!= $" ;result equation mark
FACT EQU cx ;define FACT variable (cx)

.code

main proc far

mov ax,@data ;assgin default ds address
mov ds,ax 


lea dx,msg ;load address of the string 

mov ah,09h ;output the msg string loaded in dx
int 21h 
  

dongu:lea dx,msg_2 ;output the string loaded in msg_2 
      mov ah,09h   ;print the msg_2 string
      int 21h 
    
      mov ah,01h ;take the input
      int 21h
    
      mov bl,al  ;assign input into bl        
           
      sub bl,30h ;convert to int equivalent
  
      cmp bl,8   ;compare input with 8
      jng skip_error ; if bl is not greater than 8 skip error 
    
      lea dx,msg_3 ;if bl is greater than 8 show msg_3
      mov ah,09h
      int 21h
    
      jmp dongu ;jump to start of dongu
    
skip_error:  
      
      mov dl,10  ;This part                   ;create a new line
      mov ah,02h ;create a new 
      int 21h    ;line
      mov dl,13  ;This part
      mov ah,02h ;carry the cursor 
      int 21h    ;start of the line
      mov ah,02h ;This part 
      mov dl,bl  ;print the input 
      add dl, "0";turning dl into string 
      int 21h
      
      xor cx,cx ;clean the cx register 
      mov cl,bl ;assign bl input into cl 
      mov ax,cx ;assign cx into ax   
        
      cmp ax,0 ;compare ax to 0
      je zero  ;if ax equal to 0 then jump to zero
      jne fakto ;if ax not equal to 0 jump to fakto
      
      zero:
        mov bx,1 ;move 1 to bx 
        jmp beyond ;jump to beyond
         
      ;calculate factorial    
      fakto: 
        cmp cx,1 ;compare cx to 1
        je one   ;if cx equal to 1 jump to one
        dec cx   ;decrease cx 
        mul cx   ;multiply cx with ax 
        cmp cx,1 ;compare cx to 1
        jne fakto ;cx not equal to 1 jump to fakto
             
        mov bx,ax ;move fakto result to bx
      
        one:
        mov bx,ax ;move fakto result to bx

       beyond:
       lea dx,msg_4 ;load address of string
       mov ah,09h   ;print the msg_4 string
       int 21h 
       
       mov cx,bx ;move result to cx
       mov FACT,cx ;move result to FACT variable with cx 
    
       mov ax,cx ;move result to ax again 
       
       mov bx,10 ;move 10 to bx
       xor cx,cx ;clean cx register
       .a_stack:xor dx,dx ;clean bx register
          div bx  ;divide ax by bx 
          push dx ;push remainder to stack
          inc cx ;increase cx
          test ax,ax ;test if quotient is zero
          jnz .a_stack ;if not zero back to a_stack
       .b:pop dx ;pop dx value
          add dl,"0" ;turn dl into character
          mov ah,02h ;print the character
          int 21h 
          loop .b

      
mov ah,4ch ;assure the safe program end
int 21h 

main endp
end main

ret

;ret




