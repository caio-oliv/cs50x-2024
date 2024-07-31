
sort1:     file format elf64-x86-64


Disassembly of section .init:

0000000000400478 <_init>:
  400478:	48 83 ec 08          	sub    $0x8,%rsp
  40047c:	48 8b 05 75 0b 20 00 	mov    0x200b75(%rip),%rax        # 600ff8 <__gmon_start__>
  400483:	48 85 c0             	test   %rax,%rax
  400486:	74 02                	je     40048a <_init+0x12>
  400488:	ff d0                	call   *%rax
  40048a:	48 83 c4 08          	add    $0x8,%rsp
  40048e:	c3                   	ret

Disassembly of section .plt:

0000000000400490 <.plt>:
  400490:	ff 35 72 0b 20 00    	push   0x200b72(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400496:	ff 25 74 0b 20 00    	jmp    *0x200b74(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40049c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004004a0 <__isoc99_fscanf@plt>:
  4004a0:	ff 25 72 0b 20 00    	jmp    *0x200b72(%rip)        # 601018 <__isoc99_fscanf@GLIBC_2.7>
  4004a6:	68 00 00 00 00       	push   $0x0
  4004ab:	e9 e0 ff ff ff       	jmp    400490 <.plt>

00000000004004b0 <printf@plt>:
  4004b0:	ff 25 6a 0b 20 00    	jmp    *0x200b6a(%rip)        # 601020 <printf@GLIBC_2.2.5>
  4004b6:	68 01 00 00 00       	push   $0x1
  4004bb:	e9 d0 ff ff ff       	jmp    400490 <.plt>

00000000004004c0 <feof@plt>:
  4004c0:	ff 25 62 0b 20 00    	jmp    *0x200b62(%rip)        # 601028 <feof@GLIBC_2.2.5>
  4004c6:	68 02 00 00 00       	push   $0x2
  4004cb:	e9 c0 ff ff ff       	jmp    400490 <.plt>

00000000004004d0 <fopen@plt>:
  4004d0:	ff 25 5a 0b 20 00    	jmp    *0x200b5a(%rip)        # 601030 <fopen@GLIBC_2.2.5>
  4004d6:	68 03 00 00 00       	push   $0x3
  4004db:	e9 b0 ff ff ff       	jmp    400490 <.plt>

Disassembly of section .text:

00000000004004e0 <_start>:
  4004e0:	31 ed                	xor    %ebp,%ebp
  4004e2:	49 89 d1             	mov    %rdx,%r9
  4004e5:	5e                   	pop    %rsi
  4004e6:	48 89 e2             	mov    %rsp,%rdx
  4004e9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4004ed:	50                   	push   %rax
  4004ee:	54                   	push   %rsp
  4004ef:	49 c7 c0 90 08 40 00 	mov    $0x400890,%r8
  4004f6:	48 c7 c1 20 08 40 00 	mov    $0x400820,%rcx
  4004fd:	48 c7 c7 d0 05 40 00 	mov    $0x4005d0,%rdi
  400504:	ff 15 e6 0a 20 00    	call   *0x200ae6(%rip)        # 600ff0 <__libc_start_main@GLIBC_2.2.5>
  40050a:	f4                   	hlt
  40050b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400510 <_dl_relocate_static_pie>:
  400510:	f3 c3                	repz ret
  400512:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  400519:	00 00 00 
  40051c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400520 <deregister_tm_clones>:
  400520:	55                   	push   %rbp
  400521:	b8 48 10 60 00       	mov    $0x601048,%eax
  400526:	48 3d 48 10 60 00    	cmp    $0x601048,%rax
  40052c:	48 89 e5             	mov    %rsp,%rbp
  40052f:	74 17                	je     400548 <deregister_tm_clones+0x28>
  400531:	b8 00 00 00 00       	mov    $0x0,%eax
  400536:	48 85 c0             	test   %rax,%rax
  400539:	74 0d                	je     400548 <deregister_tm_clones+0x28>
  40053b:	5d                   	pop    %rbp
  40053c:	bf 48 10 60 00       	mov    $0x601048,%edi
  400541:	ff e0                	jmp    *%rax
  400543:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400548:	5d                   	pop    %rbp
  400549:	c3                   	ret
  40054a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400550 <register_tm_clones>:
  400550:	be 48 10 60 00       	mov    $0x601048,%esi
  400555:	55                   	push   %rbp
  400556:	48 81 ee 48 10 60 00 	sub    $0x601048,%rsi
  40055d:	48 89 e5             	mov    %rsp,%rbp
  400560:	48 c1 fe 03          	sar    $0x3,%rsi
  400564:	48 89 f0             	mov    %rsi,%rax
  400567:	48 c1 e8 3f          	shr    $0x3f,%rax
  40056b:	48 01 c6             	add    %rax,%rsi
  40056e:	48 d1 fe             	sar    $1,%rsi
  400571:	74 15                	je     400588 <register_tm_clones+0x38>
  400573:	b8 00 00 00 00       	mov    $0x0,%eax
  400578:	48 85 c0             	test   %rax,%rax
  40057b:	74 0b                	je     400588 <register_tm_clones+0x38>
  40057d:	5d                   	pop    %rbp
  40057e:	bf 48 10 60 00       	mov    $0x601048,%edi
  400583:	ff e0                	jmp    *%rax
  400585:	0f 1f 00             	nopl   (%rax)
  400588:	5d                   	pop    %rbp
  400589:	c3                   	ret
  40058a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400590 <__do_global_dtors_aux>:
  400590:	80 3d b1 0a 20 00 00 	cmpb   $0x0,0x200ab1(%rip)        # 601048 <__TMC_END__>
  400597:	75 17                	jne    4005b0 <__do_global_dtors_aux+0x20>
  400599:	55                   	push   %rbp
  40059a:	48 89 e5             	mov    %rsp,%rbp
  40059d:	e8 7e ff ff ff       	call   400520 <deregister_tm_clones>
  4005a2:	c6 05 9f 0a 20 00 01 	movb   $0x1,0x200a9f(%rip)        # 601048 <__TMC_END__>
  4005a9:	5d                   	pop    %rbp
  4005aa:	c3                   	ret
  4005ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005b0:	f3 c3                	repz ret
  4005b2:	0f 1f 40 00          	nopl   0x0(%rax)
  4005b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4005bd:	00 00 00 

00000000004005c0 <frame_dummy>:
  4005c0:	55                   	push   %rbp
  4005c1:	48 89 e5             	mov    %rsp,%rbp
  4005c4:	5d                   	pop    %rbp
  4005c5:	eb 89                	jmp    400550 <register_tm_clones>
  4005c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4005ce:	00 00 

00000000004005d0 <main>:
  4005d0:	55                   	push   %rbp
  4005d1:	48 89 e5             	mov    %rsp,%rbp
  4005d4:	48 81 ec 40 00 04 00 	sub    $0x40040,%rsp
  4005db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  4005e2:	89 7d f8             	mov    %edi,-0x8(%rbp)
  4005e5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  4005e9:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
  4005ed:	0f 84 23 00 00 00    	je     400616 <main+0x46>
  4005f3:	48 bf a8 08 40 00 00 	movabs $0x4008a8,%rdi
  4005fa:	00 00 00 
  4005fd:	b0 00                	mov    $0x0,%al
  4005ff:	e8 ac fe ff ff       	call   4004b0 <printf@plt>
  400604:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40060b:	89 85 d4 ff fb ff    	mov    %eax,-0x4002c(%rbp)
  400611:	e9 09 01 00 00       	jmp    40071f <main+0x14f>
  400616:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  40061a:	48 8b 78 08          	mov    0x8(%rax),%rdi
  40061e:	48 be c1 08 40 00 00 	movabs $0x4008c1,%rsi
  400625:	00 00 00 
  400628:	e8 a3 fe ff ff       	call   4004d0 <fopen@plt>
  40062d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  400631:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  400636:	0f 85 23 00 00 00    	jne    40065f <main+0x8f>
  40063c:	48 bf c3 08 40 00 00 	movabs $0x4008c3,%rdi
  400643:	00 00 00 
  400646:	b0 00                	mov    $0x0,%al
  400648:	e8 63 fe ff ff       	call   4004b0 <printf@plt>
  40064d:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
  400654:	89 85 d0 ff fb ff    	mov    %eax,-0x40030(%rbp)
  40065a:	e9 c0 00 00 00       	jmp    40071f <main+0x14f>
  40065f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  400666:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  40066a:	48 be d8 08 40 00 00 	movabs $0x4008d8,%rsi
  400671:	00 00 00 
  400674:	48 8d 95 dc ff fb ff 	lea    -0x40024(%rbp),%rdx
  40067b:	b0 00                	mov    $0x0,%al
  40067d:	e8 1e fe ff ff       	call   4004a0 <__isoc99_fscanf@plt>
  400682:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  400686:	89 85 cc ff fb ff    	mov    %eax,-0x40034(%rbp)
  40068c:	e8 2f fe ff ff       	call   4004c0 <feof@plt>
  400691:	83 f8 00             	cmp    $0x0,%eax
  400694:	0f 84 05 00 00 00    	je     40069f <main+0xcf>
  40069a:	e9 1f 00 00 00       	jmp    4006be <main+0xee>
  40069f:	8b 85 dc ff fb ff    	mov    -0x40024(%rbp),%eax
  4006a5:	48 63 4d e4          	movslq -0x1c(%rbp),%rcx
  4006a9:	89 84 8d e0 ff fb ff 	mov    %eax,-0x40020(%rbp,%rcx,4)
  4006b0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  4006b3:	83 c0 01             	add    $0x1,%eax
  4006b6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  4006b9:	e9 a8 ff ff ff       	jmp    400666 <main+0x96>
  4006be:	48 8d bd e0 ff fb ff 	lea    -0x40020(%rbp),%rdi
  4006c5:	8b 75 e4             	mov    -0x1c(%rbp),%esi
  4006c8:	e8 63 00 00 00       	call   400730 <sort>
  4006cd:	c7 85 d8 ff fb ff 00 	movl   $0x0,-0x40028(%rbp)
  4006d4:	00 00 00 
  4006d7:	8b 85 d8 ff fb ff    	mov    -0x40028(%rbp),%eax
  4006dd:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  4006e0:	0f 8d 39 00 00 00    	jge    40071f <main+0x14f>
  4006e6:	48 63 85 d8 ff fb ff 	movslq -0x40028(%rbp),%rax
  4006ed:	8b b4 85 e0 ff fb ff 	mov    -0x40020(%rbp,%rax,4),%esi
  4006f4:	48 bf db 08 40 00 00 	movabs $0x4008db,%rdi
  4006fb:	00 00 00 
  4006fe:	b0 00                	mov    $0x0,%al
  400700:	e8 ab fd ff ff       	call   4004b0 <printf@plt>
  400705:	89 85 c8 ff fb ff    	mov    %eax,-0x40038(%rbp)
  40070b:	8b 85 d8 ff fb ff    	mov    -0x40028(%rbp),%eax
  400711:	83 c0 01             	add    $0x1,%eax
  400714:	89 85 d8 ff fb ff    	mov    %eax,-0x40028(%rbp)
  40071a:	e9 b8 ff ff ff       	jmp    4006d7 <main+0x107>
  40071f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  400722:	48 81 c4 40 00 04 00 	add    $0x40040,%rsp
  400729:	5d                   	pop    %rbp
  40072a:	c3                   	ret
  40072b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

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

0000000000400820 <__libc_csu_init>:
  400820:	41 57                	push   %r15
  400822:	41 56                	push   %r14
  400824:	49 89 d7             	mov    %rdx,%r15
  400827:	41 55                	push   %r13
  400829:	41 54                	push   %r12
  40082b:	4c 8d 25 de 05 20 00 	lea    0x2005de(%rip),%r12        # 600e10 <__frame_dummy_init_array_entry>
  400832:	55                   	push   %rbp
  400833:	48 8d 2d de 05 20 00 	lea    0x2005de(%rip),%rbp        # 600e18 <__do_global_dtors_aux_fini_array_entry>
  40083a:	53                   	push   %rbx
  40083b:	41 89 fd             	mov    %edi,%r13d
  40083e:	49 89 f6             	mov    %rsi,%r14
  400841:	4c 29 e5             	sub    %r12,%rbp
  400844:	48 83 ec 08          	sub    $0x8,%rsp
  400848:	48 c1 fd 03          	sar    $0x3,%rbp
  40084c:	e8 27 fc ff ff       	call   400478 <_init>
  400851:	48 85 ed             	test   %rbp,%rbp
  400854:	74 20                	je     400876 <__libc_csu_init+0x56>
  400856:	31 db                	xor    %ebx,%ebx
  400858:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40085f:	00 
  400860:	4c 89 fa             	mov    %r15,%rdx
  400863:	4c 89 f6             	mov    %r14,%rsi
  400866:	44 89 ef             	mov    %r13d,%edi
  400869:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40086d:	48 83 c3 01          	add    $0x1,%rbx
  400871:	48 39 dd             	cmp    %rbx,%rbp
  400874:	75 ea                	jne    400860 <__libc_csu_init+0x40>
  400876:	48 83 c4 08          	add    $0x8,%rsp
  40087a:	5b                   	pop    %rbx
  40087b:	5d                   	pop    %rbp
  40087c:	41 5c                	pop    %r12
  40087e:	41 5d                	pop    %r13
  400880:	41 5e                	pop    %r14
  400882:	41 5f                	pop    %r15
  400884:	c3                   	ret
  400885:	90                   	nop
  400886:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40088d:	00 00 00 

0000000000400890 <__libc_csu_fini>:
  400890:	f3 c3                	repz ret

Disassembly of section .fini:

0000000000400894 <_fini>:
  400894:	48 83 ec 08          	sub    $0x8,%rsp
  400898:	48 83 c4 08          	add    $0x8,%rsp
  40089c:	c3                   	ret
