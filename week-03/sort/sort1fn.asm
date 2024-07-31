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
  40074d:	0f 8d bc 00 00 00    	jge    40080f <sort+0xdf>
  400753:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  400757:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  40075e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  400761:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  400764:	83 e9 01             	sub    $0x1,%ecx
  400767:	2b 4d f0             	sub    -0x10(%rbp),%ecx
  40076a:	39 c8                	cmp    %ecx,%eax
  40076c:	0f 8d 74 00 00 00    	jge    4007e6 <sort+0xb6>
  400772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400776:	48 63 4d e8          	movslq -0x18(%rbp),%rcx
  40077a:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  40077d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400781:	8b 75 e8             	mov    -0x18(%rbp),%esi
  400784:	83 c6 01             	add    $0x1,%esi
  400787:	48 63 ce             	movslq %esi,%rcx
  40078a:	3b 14 88             	cmp    (%rax,%rcx,4),%edx
  40078d:	0f 8e 40 00 00 00    	jle    4007d3 <sort+0xa3>
  400793:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400797:	48 63 4d e8          	movslq -0x18(%rbp),%rcx
  40079b:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  40079e:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  4007a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007a5:	8b 55 e8             	mov    -0x18(%rbp),%edx
  4007a8:	83 c2 01             	add    $0x1,%edx
  4007ab:	48 63 ca             	movslq %edx,%rcx
  4007ae:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  4007b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007b5:	48 63 4d e8          	movslq -0x18(%rbp),%rcx
  4007b9:	89 14 88             	mov    %edx,(%rax,%rcx,4)
  4007bc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  4007bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007c3:	8b 75 e8             	mov    -0x18(%rbp),%esi
  4007c6:	83 c6 01             	add    $0x1,%esi
  4007c9:	48 63 ce             	movslq %esi,%rcx
  4007cc:	89 14 88             	mov    %edx,(%rax,%rcx,4)
  4007cf:	c6 45 ef 01          	movb   $0x1,-0x11(%rbp)
  4007d3:	e9 00 00 00 00       	jmp    4007d8 <sort+0xa8>
  4007d8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  4007db:	83 c0 01             	add    $0x1,%eax
  4007de:	89 45 e8             	mov    %eax,-0x18(%rbp)
  4007e1:	e9 78 ff ff ff       	jmp    40075e <sort+0x2e>
  4007e6:	8a 45 ef             	mov    -0x11(%rbp),%al
  4007e9:	24 01                	and    $0x1,%al
  4007eb:	0f b6 c8             	movzbl %al,%ecx
  4007ee:	83 f9 00             	cmp    $0x0,%ecx
  4007f1:	0f 85 05 00 00 00    	jne    4007fc <sort+0xcc>
  4007f7:	e9 13 00 00 00       	jmp    40080f <sort+0xdf>
  4007fc:	e9 00 00 00 00       	jmp    400801 <sort+0xd1>
  400801:	8b 45 f0             	mov    -0x10(%rbp),%eax
  400804:	83 c0 01             	add    $0x1,%eax
  400807:	89 45 f0             	mov    %eax,-0x10(%rbp)
  40080a:	e9 33 ff ff ff       	jmp    400742 <sort+0x12>
  40080f:	5d                   	pop    %rbp
  400810:	c3                   	ret
  400811:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  400818:	00 00 00 
  40081b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)