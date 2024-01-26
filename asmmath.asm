.code

	;Gets Value between to 32 bit integers, returns 32 bit integer.
        ;extern "C" int CalculateDist32d(int,int);
	CalculateDist32d proc
		mov eax, ecx;
		mov r9d, edx;

		sub eax, edx;
		sub r9d, ecx;

		cmp edx, ecx;
		cmovg eax, r9d;
		ret
	CalculateDist32d endp

	;Gets the absolute value of a supplied 32 bit inhteger, returns 32 bit integer.
        ;extern "C" int AbsValue32d(int);
	AbsValue32d proc
		mov eax, ecx;
		neg ecx;

		cmp ecx, eax;
		cmovg eax, ecx; 
		ret
	AbsValue32d endp

	;Chooses the Higher of the two supplied 32 bit integers, returns 32 bit integer.
        ;extern "C" int Max32d(int);
	Max32d proc
		mov eax, ecx;
		cmp edx, eax;

		cmovg eax, edx;
		ret
	Max32d endp

	;Chooses the Lower of the two supplied 32 bit integers, returns 32 bit integer.
        ;extern "C" int Min32d(int);
	Min32d proc
		mov eax, ecx;
		cmp edx, eax;

		cmovl eax, edx;
		ret
	Min32d endp

	;Copies memory from one 32 bit int array to a destination 32 bit int array at a given pointer index w/ a set count of elements.
	;Usage can be MemCopy32d(src + 5, dest + 4, 20); this would copy Source at index 5 through 24 to Destination indexes 4 through 23. 
        ;extern "C" void MemCopy32d(int src, int dest, int count);
	MemCopy32d proc
		cmp r8d, 0
		jle Finished;

	MainLoop:
		dec r8d;
		mov r9d, dword ptr[rcx + r8 * 4h];
		mov dword ptr[rdx + r8 * 4h], r9d;
		cmp r8d, 0;
		jg MainLoop

	Finished:
		ret
	MemCopy32d endp

	;Does a generic loop across the elements from Last to First and compares the previously stored Reg1 value w/ src_address[count]
	;Then will conditionally store src_address[count] if it exceeds the value of Reg1's current value. At end returns the Highest Value Found.
  	;extern "C" int FindMaxValue32d(int* src, int count);
	FindMaxValue32d proc
		cmp rdx, 0;
		mov eax, 80000000h;
		jle Finished;

		MainLoop:
			dec rdx;
			mov r8d, dword ptr[rcx + rdx * 4h];
			cmp r8d, eax;
			cmovg eax, r8d;
			cmp rdx, 0;
			jg MainLoop;
		
		Finished:
			ret
	FindMaxValue32d endp


	;Does a generic loop across the elements from Last to First and compares the previously stored Reg1 value w/ src_address[count]
	;Then will conditionally store src_address[count] if its less than the value of Reg1's current value. At end returns the Lowest Value Found.
  	;extern "C" int FindMinValue32d(int* src, int count);
	FindMinValue32d proc
		cmp rdx, 0;
		mov eax, 7FFFFFFFh;
		jle Finished;

		MainLoop:
			dec rdx;
			mov r8d, dword ptr[rcx + rdx * 4h];
			cmp r8d, eax;
			cmovl eax, r8d;
			cmp rdx, 0;
			jg MainLoop;
		
		Finished:
			ret
	FindMinValue32d endp

	;This is largest non sse clear method, but is an effective way to clear bytes quickly without getting into better simd sse instructions.
	;Takes in a pointer to memory to clear of any type and the amount of memory to clear. Clears 8 bytes at a time. Then remaining bytes 1 by 1.
	;Begins by checking if we're 7 or below. If not store our size in Reg8 then divide by 8 to get a Loop Count. Then we begin clearing memory.
	;Once we've completed our count, we now loop any remaining bits, but first we check if our AND'd Reg4 by 7 to get a value between 0 and 7 if this is 0 we're done
	;If this is not 0 then we loop the memory again but this time by 1 byte clearing. 
	;void ZeroMemory64(void* memory, int memory_size);
	ZeroMemory64 proc
		cmp edx, 7h
		jle CheckZero;

		mov r8d, edx;
		shr r8d, 3

		MainLoop:
			mov qword ptr [rcx], 0;
			add rcx, 8h;
			dec r8d;
			jnz MainLoop;
			
		and edx, 7h

		CheckZero:
			cmp edx, 0
			jle Finished;

		ClearFinalBytes:
			mov byte ptr [rcx], 0;
			inc rcx;
			dec edx;
			jnz ClearFinalBytes;

		Finished:
			ret
	ZeroMemory64 endp

end
