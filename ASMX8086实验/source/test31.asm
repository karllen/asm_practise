; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    revised 7/97

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA
     promot  BYTE "������һ���ַ������ֱ�ͳ����ĸ�����֣��������ַ��ĸ���",cr,Lf,0
     value   BYTE 1 DUP(?)
     
     answerLetter BYTE "��ĸ�ĸ�����"
           letter BYTE 11 DUP(?)
                  BYTE cr,Lf, 0
     aswerNumber  BYTE "���ֵĸ�����"
           number BYTE 11 DUP(?)
                  BYTE cr,Lf, 0
     answerOther  BYTE "�����ַ��ĸ�����"
           other  BYTE 11 DUP(?)
                  BYTE cr,Lf, 0

.CODE
_start:
     mov eax,0
     mov ebx,0
     mov ecx,0
    
     output promot
     while:
          input value,1
          cmp   value,0dh
          je    endWhile       ;����س������
          cmp   value,30h      ;30h = 0
          jl    forOther       ;С��30hΪ�ַ�
          ;����ִ�д��ڵ���30h
          cmp   value,3Ah      ;39h = 9
          jl    forNumber      ;С��3AhΪ����
          ;����ִ�д��ڵ���3Ah
          cmp   value,41h      ;С��41hΪ�ַ�
          jl    forOther       ;41h = A
          ;����ִ�д���41h
          cmp   value,5Bh      ;С��5BhΪ��д��ĸ
          jl    forLetter      ;5Bh = |
          ;����ִ�д���5Bh
          cmp   value,61h      ;61h = a
          jl    forOther
          ;����ִ�д���61h
          cmp   value,7Bh      ;7Bh = {
          jl    forLetter
          ;����ִ��7Bh������
          jmp   forOther
       
     forLetter:
               inc eax
               jmp while
     forNumber:
               inc ebx
               jmp while
     forOther:
               inc ecx
               jmp while
    
endWhile:          
     dtoa  letter,eax
     dtoa  number,ebx
     dtoa  other ,ecx
  
     output answerLetter
     output answerNumber
     output answerOther

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code




