
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h 

horizontal macro x,y,z    
    local hori_loop
    mov cx,x
    mov dx,y
    mov bh,0h 
    hori_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc cx
        cmp cx,340
        jnz hori_loop   
endm

vertical macro x,y,z
    local verti_loop
    mov cx,x
    mov dx,y
    mov bh,0h
    verti_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc dx
        cmp dx,260
        jnz verti_loop
endm 

set_hori_x macro x,y,z,a 
    local hori_loop
    mov cx,[x]
    mov dx,[y]
    mov bh,0h
    hori_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc cx
        cmp cx,[a]
        jnz hori_loop
    
endm 

set_verti_x macro x,y,z,a 
    local verti_loop
    mov cx,[x]
    mov dx,[y]
    mov bh,0h
    verti_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc dx
        cmp dx,[a]
        jnz verti_loop
    endm

set_verti_y macro x,y,z,a  
    local verti_loop 
    mov cx,[x]
    mov dx,[y]
    mov bh,0h
    verti_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc dx
        cmp dx,[a]
        jnz verti_loop
     endm

set_hori_y macro x,y,z,a 
    local hori_loop
    mov cx,[x]
    mov dx,[y]
    mov bh,0h
    hori_loop:
        mov ah,0ch
        mov al,z
        int 10h
        inc cx
        cmp cx,[a]
        jnz hori_loop
        
    endm

.data 
right equ 4d00h
left equ  4b00h
up equ    4800h
down equ  5000h 

loc_x dw 320  ;formal location x
loc_y dw 240  ;formal location y

hori_first dw 300 ;first x of horizontal
verti_first dw 220 ;first y of horizontal

hori dw 340  ;first increment of horizontal
verti dw 260 ;first increment of vertical
.code
main proc far
    mov ax,@data
    mov ds,ax   
                
    ;mov ax,600h
    ;mov bh,02h
    ;mov cx,0
    ;mov bx,184fh
    ;int 10h
                
    mov ah,00h ;graphic mode
    mov al,12h
    int 10h
      
    
    call draw_cross

dongu:

    xor ax,ax ;clean ax            
            
    mov ah,01h
    int 16h
    
    mov ah,00h
    int 16h 
    
    
    cmp ax,right
    je right
    cmp ax,left
    je left
    cmp ax,up
    je up
    cmp ax,down
    je down
    cmp al,20h
    je exit
    
    jmp dongu 
    
    
    right:
      ;call bing  
      ;cmp loc_x,640
      ;je exit
      add [loc_x],50 
      add [hori_first],50 
      add [hori],50
      set_verti_x loc_x,verti_first,09,verti 
      set_hori_x  hori_first,loc_y,09,hori
      jmp dongu
    left:
      sub [loc_x],50
      sub [hori_first],50
      sub [hori],50
      set_verti_x loc_x,verti_first,09,verti
      set_hori_x hori_first,loc_y,09,hori
      jmp dongu
    up: 
      sub [loc_y],50
      sub [verti_first],50
      sub [verti],50
      set_verti_y loc_x,verti_first,09,verti 
      set_hori_y hori_first,loc_y,09,hori
      jmp dongu 
    down:
      add [loc_y],50
      add [verti_first],50
      add [verti],50
      set_verti_y loc_x,verti_first,09,verti
      set_hori_y hori_first,loc_y,09,hori  
      jmp dongu
                          
exit:
mov ah,4ch
int 21h      

main endp 

draw_cross proc
    horizontal 300,240,09
    vertical 320,220,09  
    ret
draw_cross endp  

bing proc
      cmp loc_x,640
      je dongu_2
      cmp loc_y,480
      je dongu_2 
      
      jmp exit_2
      dongu_2:
         mov ah,02
         mov dl,07
         int 21h
         mov ah,01h
         int 16h
         jz dongu_2
         mov ah,0h 
         int 16h
         cmp al,20h
         je exit
         jmp dongu_2   
      
      exit_2:
    ret
bing endp 

clear_screen proc ;code not exist 
       ret
clear_screen endp

    
end 

ret




