
sort3:     file format elf64-x86-64


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
  4004ef:	49 c7 c0 60 08 40 00 	mov    $0x400860,%r8
  4004f6:	48 c7 c1 f0 07 40 00 	mov    $0x4007f0,%rcx
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
  4005f3:	48 bf 78 08 40 00 00 	movabs $0x400878,%rdi
  4005fa:	00 00 00 
  4005fd:	b0 00                	mov    $0x0,%al
  4005ff:	e8 ac fe ff ff       	call   4004b0 <printf@plt>
  400604:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40060b:	89 85 d4 ff fb ff    	mov    %eax,-0x4002c(%rbp)
  400611:	e9 09 01 00 00       	jmp    40071f <main+0x14f>
  400616:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  40061a:	48 8b 78 08          	mov    0x8(%rax),%rdi
  40061e:	48 be 91 08 40 00 00 	movabs $0x400891,%rsi
  400625:	00 00 00 
  400628:	e8 a3 fe ff ff       	call   4004d0 <fopen@plt>
  40062d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  400631:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  400636:	0f 85 23 00 00 00    	jne    40065f <main+0x8f>
  40063c:	48 bf 93 08 40 00 00 	movabs $0x400893,%rdi
  400643:	00 00 00 
  400646:	b0 00                	mov    $0x0,%al
  400648:	e8 63 fe ff ff       	call   4004b0 <printf@plt>
  40064d:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
  400654:	89 85 d0 ff fb ff    	mov    %eax,-0x40030(%rbp)
  40065a:	e9 c0 00 00 00       	jmp    40071f <main+0x14f>
  40065f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  400666:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  40066a:	48 be a8 08 40 00 00 	movabs $0x4008a8,%rsi
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
  4006f4:	48 bf ab 08 40 00 00 	movabs $0x4008ab,%rdi
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

00000000004007f0 <__libc_csu_init>:
  4007f0:	41 57                	push   %r15
  4007f2:	41 56                	push   %r14
  4007f4:	49 89 d7             	mov    %rdx,%r15
  4007f7:	41 55                	push   %r13
  4007f9:	41 54                	push   %r12
  4007fb:	4c 8d 25 0e 06 20 00 	lea    0x20060e(%rip),%r12        # 600e10 <__frame_dummy_init_array_entry>
  400802:	55                   	push   %rbp
  400803:	48 8d 2d 0e 06 20 00 	lea    0x20060e(%rip),%rbp        # 600e18 <__do_global_dtors_aux_fini_array_entry>
  40080a:	53                   	push   %rbx
  40080b:	41 89 fd             	mov    %edi,%r13d
  40080e:	49 89 f6             	mov    %rsi,%r14
  400811:	4c 29 e5             	sub    %r12,%rbp
  400814:	48 83 ec 08          	sub    $0x8,%rsp
  400818:	48 c1 fd 03          	sar    $0x3,%rbp
  40081c:	e8 57 fc ff ff       	call   400478 <_init>
  400821:	48 85 ed             	test   %rbp,%rbp
  400824:	74 20                	je     400846 <__libc_csu_init+0x56>
  400826:	31 db                	xor    %ebx,%ebx
  400828:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40082f:	00 
  400830:	4c 89 fa             	mov    %r15,%rdx
  400833:	4c 89 f6             	mov    %r14,%rsi
  400836:	44 89 ef             	mov    %r13d,%edi
  400839:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40083d:	48 83 c3 01          	add    $0x1,%rbx
  400841:	48 39 dd             	cmp    %rbx,%rbp
  400844:	75 ea                	jne    400830 <__libc_csu_init+0x40>
  400846:	48 83 c4 08          	add    $0x8,%rsp
  40084a:	5b                   	pop    %rbx
  40084b:	5d                   	pop    %rbp
  40084c:	41 5c                	pop    %r12
  40084e:	41 5d                	pop    %r13
  400850:	41 5e                	pop    %r14
  400852:	41 5f                	pop    %r15
  400854:	c3                   	ret
  400855:	90                   	nop
  400856:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40085d:	00 00 00 

0000000000400860 <__libc_csu_fini>:
  400860:	f3 c3                	repz ret

Disassembly of section .fini:

0000000000400864 <_fini>:
  400864:	48 83 ec 08          	sub    $0x8,%rsp
  400868:	48 83 c4 08          	add    $0x8,%rsp
  40086c:	c3                   	ret
