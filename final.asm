
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  

set_po macro x,y
    mov ah,02
    mov bh,00
    mov dl,x
    mov dh,y
    int 10h
    endm

.data 

snake dw 7 dup(0)
tail dw ?
sayac db 0 
sayac_2 db 3
sayac_3 db 0 
sayac_4 db 0

.code
main proc far
    mov ax,@data
    mov ds,ax
    
    set_the_wall:
        set_po 6d,2d
        mov ah,09h
        mov bh,0
        mov bl,0ah
        mov cx,1
        mov al,'m'
        int 10h
        set_po 15d,3d
        mov ah,09h
        mov bh,0
        mov bl,09h
        mov cx,1
        mov al,'i'
        int 10h
        set_po 2d,5d
        mov ah,09h
        mov bh,0
        mov bl,04h
        mov cx,1
        mov al,'c'
        int 10h
        set_po 16d,7d
        mov ah,02h
        mov dl,'r'
        int 21h
        set_po 18d,8d
        mov ah,09h
        mov bh,0
        mov bl,06h
        mov cx,1
        mov al,'o'
        int 10h
        
    set_po 0,0 ;reset   
    
  
    
    call hide_cursor 
     
     
    snake_loop:
         
         mov al,0
         mov ah,05h
         int 10h      
        
        
        mov dx,snake[0]
        
        mov ah,02h
        int 10h
        
        mov al,"*"
        mov ah,09h
        mov bl,0eh
        mov cx,1
        int 10h
        
        mov ax,snake[8]
        mov tail,ax
        
        call move_the_snake
        
        mov dx,tail
        
        mov ah,02h
        int 10h
        
        mov al,' '
        mov ah,09h
        mov bl,0eh
        mov cx,1 
        int 10h
        
        jmp snake_loop
    
    
    mov ah,4ch
    int 21h
    
main endp

  move_the_snake proc
    mov ax,40h
    mov es,ax
    
    mov di,8
    mov cx,4
    
    moving_snake:
        mov ax,snake[di-2]
        mov snake[di],ax
        sub di,2
        loop moving_snake 
        
            
        cmp [sayac_3],3
        je left     
        cmp [sayac],19
        je up   
        cmp [sayac_2],-5
        je right
        cmp [sayac],16
        je down   
        cmp [sayac_2],0
        je right   
        cmp [sayac],6
        je down 
        jmp right
        
        
     right:   
        mov al,b.snake[0]
        inc al  
        add [sayac],1h
        mov b.snake[0],al
        cmp al,es:[4ah] 
        jb stop 
        mov b.snake[0],0
        jmp stop 
     left:
        mov al,b.snake[0]
        dec al  
        mov b.snake[0],al
        cmp al,-1
        jne stop
        mov al,es:[4ah]
        dec al
        mov b.snake[0],al
        jmp stop 
     down:
       mov al,b.snake[1]
       inc al
       sub [sayac_2],1
       mov b.snake[1],al
       cmp al,es:[84h]
       jbe stop
       mov b.snake[1],0
       jmp stop
     up:
       mov al,b.snake[1]
       dec al 
       add [sayac_3],1
       mov b.snake[1],al 
       cmp al,-1
       jne stop
       cmp al,es:[84h]
       mov b.snake[1],al
       jmp stop 
        
        stop:        
        ret
   move_the_snake endp 
  hide_cursor proc
    mov ah,1
    mov ch,2bh
    mov cl,0bh
    int 10h
    ret
  hide_cursor endp 
end

ret




