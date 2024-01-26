.code

	CalculateDist32d proc
		mov eax, ecx;
		mov r9d, edx;

		sub eax, edx;
		sub r9d, ecx;

		cmp edx, ecx;
		cmovg eax, r9d;
		ret
	CalculateDist32d endp


	AbsValue32d proc
		mov eax, ecx;
		neg ecx;

		cmp ecx, eax;
		cmovg eax, ecx; 
		ret
	AbsValue32d endp


	Max32d proc
		mov eax, ecx;
		cmp edx, eax;

		cmovg eax, edx;
		ret
	Max32d endp


	Min32d proc
		mov eax, ecx;
		cmp edx, eax;

		cmovl eax, edx;
		ret
	Min32d endp


	MemCopy32 proc
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
	MemCopy32 endp

end
