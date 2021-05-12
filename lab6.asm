IDEAL
MODEL small
STACK 256
;-----------------------------------------------------------------------------------------------------------
MACRO McROSS ; init macros
    mov ax, @data
    mov ds, ax
    mov es, ax
ENDM
;-----------------------------------------------------------------------------------------------------------
DATASEG
team_number db "team 2:", 10,13, '$' ; string for output
kashtalian db "Kashtalian Yevhenii", 10,13, '$' ; string for output
kobylynskyi db "Kobylynkyi Viktor", 10,13, '$' ; string for output
hodnev db "Hodnev Nikita", 10,13, '$' ; string for output
;-----------------------------------------------------------------------------------------------------------
CODESEG
Start: 
McROSS

push ds
mov ah, 25h
mov al, 52h                         ; запишсуємо номер вектора переривання в al
lea dx, [Interruption]              ; написання адреси переривання через "ефективне змінення"
mov bx, seg Interruption                             
mov ds, bx
int 21h                             ; підключення 52h до нашої процедури
pop ds

int 52h                              ;визиваємо переривання

mov ah, 4ch                          ;  4ch to ah
mov al, 0h                           ; отримання коду виходу
int 21h                              ; визиваємо DOS 4ch для виходу

proc Interruption far                ; процедура переривання 
    mov dx, offset team_number        ; записуємо повідомлення в dx 
    mov ah, 09h                      ;  09h  to ah 
    int 21h                          ; виклик переривання для виведення повідомлення
    mov dx, offset kashtalian
    int 21h
    mov dx, offset kobylynskyi
    int 21h                                                                                                         
    mov dx, offset hodnev 
    int 21h

IRET                                 ; повернення з переривання за допомогою IRET
endp Interruption
end Start