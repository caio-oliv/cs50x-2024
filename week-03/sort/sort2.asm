
sort2:     file format elf64-x86-64


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
  4004ef:	49 c7 c0 80 09 40 00 	mov    $0x400980,%r8
  4004f6:	48 c7 c1 10 09 40 00 	mov    $0x400910,%rcx
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
  400590:	80 3d b9 0a 20 00 00 	cmpb   $0x0,0x200ab9(%rip)        # 601050 <completed.7697>
  400597:	75 17                	jne    4005b0 <__do_global_dtors_aux+0x20>
  400599:	55                   	push   %rbp
  40059a:	48 89 e5             	mov    %rsp,%rbp
  40059d:	e8 7e ff ff ff       	call   400520 <deregister_tm_clones>
  4005a2:	c6 05 a7 0a 20 00 01 	movb   $0x1,0x200aa7(%rip)        # 601050 <completed.7697>
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
  4005f3:	48 bf 98 09 40 00 00 	movabs $0x400998,%rdi
  4005fa:	00 00 00 
  4005fd:	b0 00                	mov    $0x0,%al
  4005ff:	e8 ac fe ff ff       	call   4004b0 <printf@plt>
  400604:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40060b:	89 85 d4 ff fb ff    	mov    %eax,-0x4002c(%rbp)
  400611:	e9 09 01 00 00       	jmp    40071f <main+0x14f>
  400616:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  40061a:	48 8b 78 08          	mov    0x8(%rax),%rdi
  40061e:	48 be b1 09 40 00 00 	movabs $0x4009b1,%rsi
  400625:	00 00 00 
  400628:	e8 a3 fe ff ff       	call   4004d0 <fopen@plt>
  40062d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  400631:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  400636:	0f 85 23 00 00 00    	jne    40065f <main+0x8f>
  40063c:	48 bf b3 09 40 00 00 	movabs $0x4009b3,%rdi
  400643:	00 00 00 
  400646:	b0 00                	mov    $0x0,%al
  400648:	e8 63 fe ff ff       	call   4004b0 <printf@plt>
  40064d:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
  400654:	89 85 d0 ff fb ff    	mov    %eax,-0x40030(%rbp)
  40065a:	e9 c0 00 00 00       	jmp    40071f <main+0x14f>
  40065f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  400666:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  40066a:	48 be c8 09 40 00 00 	movabs $0x4009c8,%rsi
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
  4006f4:	48 bf cb 09 40 00 00 	movabs $0x4009cb,%rdi
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
  400734:	48 83 ec 10          	sub    $0x10,%rsp
  400738:	31 c0                	xor    %eax,%eax
  40073a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40073e:	89 75 f4             	mov    %esi,-0xc(%rbp)
  400741:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  400745:	8b 75 f4             	mov    -0xc(%rbp),%esi
  400748:	83 ee 01             	sub    $0x1,%esi
  40074b:	89 75 f0             	mov    %esi,-0x10(%rbp)
  40074e:	89 c6                	mov    %eax,%esi
  400750:	8b 55 f0             	mov    -0x10(%rbp),%edx
  400753:	e8 38 01 00 00       	call   400890 <mergesort>
  400758:	48 83 c4 10          	add    $0x10,%rsp
  40075c:	5d                   	pop    %rbp
  40075d:	c3                   	ret
  40075e:	66 90                	xchg   %ax,%ax

0000000000400760 <merge>:
  400760:	55                   	push   %rbp
  400761:	48 89 e5             	mov    %rsp,%rbp
  400764:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  400768:	89 75 f4             	mov    %esi,-0xc(%rbp)
  40076b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  40076e:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  400771:	44 89 45 e8          	mov    %r8d,-0x18(%rbp)
  400775:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  40077c:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  40077f:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  400782:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  400785:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  400788:	8b 45 e0             	mov    -0x20(%rbp),%eax
  40078b:	3b 45 f0             	cmp    -0x10(%rbp),%eax
  40078e:	b1 01                	mov    $0x1,%cl
  400790:	88 4d d7             	mov    %cl,-0x29(%rbp)
  400793:	0f 8e 0c 00 00 00    	jle    4007a5 <merge+0x45>
  400799:	8b 45 dc             	mov    -0x24(%rbp),%eax
  40079c:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  40079f:	0f 9e c1             	setle  %cl
  4007a2:	88 4d d7             	mov    %cl,-0x29(%rbp)
  4007a5:	8a 45 d7             	mov    -0x29(%rbp),%al
  4007a8:	a8 01                	test   $0x1,%al
  4007aa:	0f 85 05 00 00 00    	jne    4007b5 <merge+0x55>
  4007b0:	e9 8e 00 00 00       	jmp    400843 <merge+0xe3>
  4007b5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  4007b8:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  4007bb:	0f 8f 28 00 00 00    	jg     4007e9 <merge+0x89>
  4007c1:	8b 45 e0             	mov    -0x20(%rbp),%eax
  4007c4:	3b 45 f0             	cmp    -0x10(%rbp),%eax
  4007c7:	0f 8f 49 00 00 00    	jg     400816 <merge+0xb6>
  4007cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007d1:	48 63 4d e0          	movslq -0x20(%rbp),%rcx
  4007d5:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  4007d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007dc:	48 63 4d dc          	movslq -0x24(%rbp),%rcx
  4007e0:	3b 14 88             	cmp    (%rax,%rcx,4),%edx
  4007e3:	0f 8d 2d 00 00 00    	jge    400816 <merge+0xb6>
  4007e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4007ed:	48 63 4d e0          	movslq -0x20(%rbp),%rcx
  4007f1:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  4007f4:	48 63 45 e4          	movslq -0x1c(%rbp),%rax
  4007f8:	89 14 85 60 10 60 00 	mov    %edx,0x601060(,%rax,4)
  4007ff:	8b 55 e0             	mov    -0x20(%rbp),%edx
  400802:	83 c2 01             	add    $0x1,%edx
  400805:	89 55 e0             	mov    %edx,-0x20(%rbp)
  400808:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  40080b:	83 c2 01             	add    $0x1,%edx
  40080e:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  400811:	e9 28 00 00 00       	jmp    40083e <merge+0xde>
  400816:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  40081a:	48 63 4d dc          	movslq -0x24(%rbp),%rcx
  40081e:	8b 14 88             	mov    (%rax,%rcx,4),%edx
  400821:	48 63 45 e4          	movslq -0x1c(%rbp),%rax
  400825:	89 14 85 60 10 60 00 	mov    %edx,0x601060(,%rax,4)
  40082c:	8b 55 dc             	mov    -0x24(%rbp),%edx
  40082f:	83 c2 01             	add    $0x1,%edx
  400832:	89 55 dc             	mov    %edx,-0x24(%rbp)
  400835:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  400838:	83 c2 01             	add    $0x1,%edx
  40083b:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  40083e:	e9 45 ff ff ff       	jmp    400788 <merge+0x28>
  400843:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  40084a:	8b 45 d8             	mov    -0x28(%rbp),%eax
  40084d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  400850:	0f 8d 29 00 00 00    	jge    40087f <merge+0x11f>
  400856:	48 63 45 d8          	movslq -0x28(%rbp),%rax
  40085a:	8b 0c 85 60 10 60 00 	mov    0x601060(,%rax,4),%ecx
  400861:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400865:	8b 55 f4             	mov    -0xc(%rbp),%edx
  400868:	03 55 d8             	add    -0x28(%rbp),%edx
  40086b:	48 63 f2             	movslq %edx,%rsi
  40086e:	89 0c b0             	mov    %ecx,(%rax,%rsi,4)
  400871:	8b 45 d8             	mov    -0x28(%rbp),%eax
  400874:	83 c0 01             	add    $0x1,%eax
  400877:	89 45 d8             	mov    %eax,-0x28(%rbp)
  40087a:	e9 cb ff ff ff       	jmp    40084a <merge+0xea>
  40087f:	5d                   	pop    %rbp
  400880:	c3                   	ret
  400881:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  400888:	00 00 00 
  40088b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400890 <mergesort>:
  400890:	55                   	push   %rbp
  400891:	48 89 e5             	mov    %rsp,%rbp
  400894:	48 83 ec 20          	sub    $0x20,%rsp
  400898:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40089c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  40089f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  4008a2:	8b 55 f0             	mov    -0x10(%rbp),%edx
  4008a5:	3b 55 f4             	cmp    -0xc(%rbp),%edx
  4008a8:	0f 8e 51 00 00 00    	jle    4008ff <mergesort+0x6f>
  4008ae:	8b 45 f4             	mov    -0xc(%rbp),%eax
  4008b1:	03 45 f0             	add    -0x10(%rbp),%eax
  4008b4:	99                   	cltd
  4008b5:	b9 02 00 00 00       	mov    $0x2,%ecx
  4008ba:	f7 f9                	idiv   %ecx
  4008bc:	89 45 ec             	mov    %eax,-0x14(%rbp)
  4008bf:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  4008c3:	8b 75 f4             	mov    -0xc(%rbp),%esi
  4008c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  4008c9:	89 c2                	mov    %eax,%edx
  4008cb:	e8 c0 ff ff ff       	call   400890 <mergesort>
  4008d0:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  4008d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  4008d7:	83 c0 01             	add    $0x1,%eax
  4008da:	8b 55 f0             	mov    -0x10(%rbp),%edx
  4008dd:	89 c6                	mov    %eax,%esi
  4008df:	e8 ac ff ff ff       	call   400890 <mergesort>
  4008e4:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  4008e8:	8b 75 f4             	mov    -0xc(%rbp),%esi
  4008eb:	8b 55 ec             	mov    -0x14(%rbp),%edx
  4008ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  4008f1:	83 c0 01             	add    $0x1,%eax
  4008f4:	44 8b 45 f0          	mov    -0x10(%rbp),%r8d
  4008f8:	89 c1                	mov    %eax,%ecx
  4008fa:	e8 61 fe ff ff       	call   400760 <merge>
  4008ff:	48 83 c4 20          	add    $0x20,%rsp
  400903:	5d                   	pop    %rbp
  400904:	c3                   	ret
  400905:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40090c:	00 00 00 
  40090f:	90                   	nop

0000000000400910 <__libc_csu_init>:
  400910:	41 57                	push   %r15
  400912:	41 56                	push   %r14
  400914:	49 89 d7             	mov    %rdx,%r15
  400917:	41 55                	push   %r13
  400919:	41 54                	push   %r12
  40091b:	4c 8d 25 ee 04 20 00 	lea    0x2004ee(%rip),%r12        # 600e10 <__frame_dummy_init_array_entry>
  400922:	55                   	push   %rbp
  400923:	48 8d 2d ee 04 20 00 	lea    0x2004ee(%rip),%rbp        # 600e18 <__do_global_dtors_aux_fini_array_entry>
  40092a:	53                   	push   %rbx
  40092b:	41 89 fd             	mov    %edi,%r13d
  40092e:	49 89 f6             	mov    %rsi,%r14
  400931:	4c 29 e5             	sub    %r12,%rbp
  400934:	48 83 ec 08          	sub    $0x8,%rsp
  400938:	48 c1 fd 03          	sar    $0x3,%rbp
  40093c:	e8 37 fb ff ff       	call   400478 <_init>
  400941:	48 85 ed             	test   %rbp,%rbp
  400944:	74 20                	je     400966 <__libc_csu_init+0x56>
  400946:	31 db                	xor    %ebx,%ebx
  400948:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40094f:	00 
  400950:	4c 89 fa             	mov    %r15,%rdx
  400953:	4c 89 f6             	mov    %r14,%rsi
  400956:	44 89 ef             	mov    %r13d,%edi
  400959:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40095d:	48 83 c3 01          	add    $0x1,%rbx
  400961:	48 39 dd             	cmp    %rbx,%rbp
  400964:	75 ea                	jne    400950 <__libc_csu_init+0x40>
  400966:	48 83 c4 08          	add    $0x8,%rsp
  40096a:	5b                   	pop    %rbx
  40096b:	5d                   	pop    %rbp
  40096c:	41 5c                	pop    %r12
  40096e:	41 5d                	pop    %r13
  400970:	41 5e                	pop    %r14
  400972:	41 5f                	pop    %r15
  400974:	c3                   	ret
  400975:	90                   	nop
  400976:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40097d:	00 00 00 

0000000000400980 <__libc_csu_fini>:
  400980:	f3 c3                	repz ret

Disassembly of section .fini:

0000000000400984 <_fini>:
  400984:	48 83 ec 08          	sub    $0x8,%rsp
  400988:	48 83 c4 08          	add    $0x8,%rsp
  40098c:	c3                   	ret
