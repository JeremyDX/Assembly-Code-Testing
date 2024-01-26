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

end
