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


add_y dw 320 
y_formal dw 220 
y_inc dw 260   

add_x dw 240
x_formal dw 300
x_inc dw 340

.code
main proc far
    mov ax,@data
    mov ds,ax   
                
    
    call dijital  
    
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
      call dijital
      add [add_y],10 
      set_hori_x x_formal,add_x,09,x_inc
      set_verti_x add_y,y_formal,09,y_inc
      jmp dongu
    left:
      call dijital  
      sub [add_y],10 
      set_hori_x x_formal,add_x,09,x_inc
      set_verti_x add_y,y_formal,09,y_inc
      jmp dongu
    up:
      call dijital   
      sub [add_x],10  
      set_verti_y add_y,y_formal,09,y_inc
      set_hori_y x_formal,add_x,09,x_inc
      jmp dongu 
    down:
      call dijital
      add [add_x],10 
      set_verti_y add_y,y_formal,09,y_inc
      set_hori_y x_formal,add_x,09,x_inc 
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
    ret
bing endp 

clear_screen proc   
     
clear_screen endp
   
dijital proc
    mov ah,00
    mov al,12h
    int 10h   
    ret
dijital endp
end 

ret


