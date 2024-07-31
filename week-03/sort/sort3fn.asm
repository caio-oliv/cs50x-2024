0000000000400730 <sort>:
  400730:	55                   	push   %rbp
  400731:	48 89 e5             	mov    %rsp,%rbp
  400734:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  400738:	89 75 f4             	mov    %esi,-0xc(%rbp)
  40073b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  400742:	8b 45 f0             	mov    -0x10(%rbp),%eax
  400745:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  400748:	83 e9 01             	sub    $0x1,%ecx
  40074b:	39 c8                	cmp    %ecx,%eax
  40074d:	0f 8d 9a 00 00 00    	jge    4007ed <sort+0xbd>
  400753:	8b 45 f0             	mov    -0x10(%rbp),%eax
  400756:	89 45 ec             	mov    %eax,-0x14(%rbp)
  400759:	8b 45 f0             	mov    -0x10(%rbp),%eax
  40075c:	89 45 e8             	mov    %eax,-0x18(%rbp)
  40075f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  400762:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  400765:	83 e9 01             	sub    $0x1,%ecx
  400768:	39 c8                	cmp    %ecx,%eax
  40076a:	0f 8d 3d 00 00 00    	jge    4007ad <sort+0x7d>
  400770:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400774:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  400777:	83 c1 01             	add    $0x1,%ecx
  40077a:	48 63 d1             	movslq %ecx,%rdx
  40077d:	8b 0c 90             	mov    (%rax,%rdx,4),%ecx
  400780:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400784:	48 63 55 ec          	movslq -0x14(%rbp),%rdx
  400788:	3b 0c 90             	cmp    (%rax,%rdx,4),%ecx
  40078b:	0f 8d 09 00 00 00    	jge    40079a <sort+0x6a>
  400791:	8b 45 e8             	mov    -0x18(%rbp),%eax
  400794:	83 c0 01             	add    $0x1,%eax
  400797:	89 45 ec             	mov    %eax,-0x14(%rbp)
  40079a:	e9 00 00 00 00       	jmp    40079f <sort+0x6f>
  40079f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  4007a2:	83 c0 01             	add    $0x1,%eax
  4007a5:	89 45 e8             	mov    %eax,-0x18(%rbp)
  4007a8:	e9 b2 ff ff ff       	jmp    40075f <sort+0x2f>
  4007ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007b1:	48 63 4d f0          	movslq -0x10(%rbp),%rcx
  4007b5:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  4007b8:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  4007bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007bf:	48 63 4d ec          	movslq -0x14(%rbp),%rcx
  4007c3:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  4007c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007ca:	48 63 4d f0          	movslq -0x10(%rbp),%rcx
  4007ce:	89 14 88             	mov    %edx,(%rax,%rcx,4)
  4007d1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  4007d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007d8:	48 63 4d ec          	movslq -0x14(%rbp),%rcx
  4007dc:	89 14 88             	mov    %edx,(%rax,%rcx,4)
  4007df:	8b 45 f0             	mov    -0x10(%rbp),%eax
  4007e2:	83 c0 01             	add    $0x1,%eax
  4007e5:	89 45 f0             	mov    %eax,-0x10(%rbp)
  4007e8:	e9 55 ff ff ff       	jmp    400742 <sort+0x12>
  4007ed:	5d                   	pop    %rbp
  4007ee:	c3                   	ret
  4007ef:	90                   	nop
