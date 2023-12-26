
isort：     文件格式 elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 2f 00 00 	mov    0x2fd9(%rip),%rax        # 3fe8 <__gmon_start__@Base>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	ret    

Disassembly of section .plt:

0000000000001020 <free@plt-0x10>:
    1020:	ff 35 e2 2f 00 00    	push   0x2fe2(%rip)        # 4008 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 e4 2f 00 00    	jmp    *0x2fe4(%rip)        # 4010 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001030 <free@plt>:
    1030:	ff 25 e2 2f 00 00    	jmp    *0x2fe2(%rip)        # 4018 <free@GLIBC_2.2.5>
    1036:	68 00 00 00 00       	push   $0x0
    103b:	e9 e0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001040 <rand_r@plt>:
    1040:	ff 25 da 2f 00 00    	jmp    *0x2fda(%rip)        # 4020 <rand_r@GLIBC_2.2.5>
    1046:	68 01 00 00 00       	push   $0x1
    104b:	e9 d0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001050 <printf@plt>:
    1050:	ff 25 d2 2f 00 00    	jmp    *0x2fd2(%rip)        # 4028 <printf@GLIBC_2.2.5>
    1056:	68 02 00 00 00       	push   $0x2
    105b:	e9 c0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001060 <malloc@plt>:
    1060:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 4030 <malloc@GLIBC_2.2.5>
    1066:	68 03 00 00 00       	push   $0x3
    106b:	e9 b0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001070 <atoi@plt>:
    1070:	ff 25 c2 2f 00 00    	jmp    *0x2fc2(%rip)        # 4038 <atoi@GLIBC_2.2.5>
    1076:	68 04 00 00 00       	push   $0x4
    107b:	e9 a0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001080 <exit@plt>:
    1080:	ff 25 ba 2f 00 00    	jmp    *0x2fba(%rip)        # 4040 <exit@GLIBC_2.2.5>
    1086:	68 05 00 00 00       	push   $0x5
    108b:	e9 90 ff ff ff       	jmp    1020 <_init+0x20>

Disassembly of section .plt.got:

0000000000001090 <__cxa_finalize@plt>:
    1090:	ff 25 62 2f 00 00    	jmp    *0x2f62(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1096:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000010a0 <_start>:
    10a0:	f3 0f 1e fa          	endbr64 
    10a4:	31 ed                	xor    %ebp,%ebp
    10a6:	49 89 d1             	mov    %rdx,%r9
    10a9:	5e                   	pop    %rsi
    10aa:	48 89 e2             	mov    %rsp,%rdx
    10ad:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    10b1:	50                   	push   %rax
    10b2:	54                   	push   %rsp
    10b3:	45 31 c0             	xor    %r8d,%r8d
    10b6:	31 c9                	xor    %ecx,%ecx
    10b8:	48 8d 3d 81 01 00 00 	lea    0x181(%rip),%rdi        # 1240 <main>
    10bf:	ff 15 13 2f 00 00    	call   *0x2f13(%rip)        # 3fd8 <__libc_start_main@GLIBC_2.34>
    10c5:	f4                   	hlt    
    10c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    10cd:	00 00 00 

00000000000010d0 <deregister_tm_clones>:
    10d0:	48 8d 3d 81 2f 00 00 	lea    0x2f81(%rip),%rdi        # 4058 <__TMC_END__>
    10d7:	48 8d 05 7a 2f 00 00 	lea    0x2f7a(%rip),%rax        # 4058 <__TMC_END__>
    10de:	48 39 f8             	cmp    %rdi,%rax
    10e1:	74 15                	je     10f8 <deregister_tm_clones+0x28>
    10e3:	48 8b 05 f6 2e 00 00 	mov    0x2ef6(%rip),%rax        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    10ea:	48 85 c0             	test   %rax,%rax
    10ed:	74 09                	je     10f8 <deregister_tm_clones+0x28>
    10ef:	ff e0                	jmp    *%rax
    10f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    10f8:	c3                   	ret    
    10f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001100 <register_tm_clones>:
    1100:	48 8d 3d 51 2f 00 00 	lea    0x2f51(%rip),%rdi        # 4058 <__TMC_END__>
    1107:	48 8d 35 4a 2f 00 00 	lea    0x2f4a(%rip),%rsi        # 4058 <__TMC_END__>
    110e:	48 29 fe             	sub    %rdi,%rsi
    1111:	48 89 f0             	mov    %rsi,%rax
    1114:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1118:	48 c1 f8 03          	sar    $0x3,%rax
    111c:	48 01 c6             	add    %rax,%rsi
    111f:	48 d1 fe             	sar    %rsi
    1122:	74 14                	je     1138 <register_tm_clones+0x38>
    1124:	48 8b 05 c5 2e 00 00 	mov    0x2ec5(%rip),%rax        # 3ff0 <_ITM_registerTMCloneTable@Base>
    112b:	48 85 c0             	test   %rax,%rax
    112e:	74 08                	je     1138 <register_tm_clones+0x38>
    1130:	ff e0                	jmp    *%rax
    1132:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1138:	c3                   	ret    
    1139:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001140 <__do_global_dtors_aux>:
    1140:	f3 0f 1e fa          	endbr64 
    1144:	80 3d 0d 2f 00 00 00 	cmpb   $0x0,0x2f0d(%rip)        # 4058 <__TMC_END__>
    114b:	75 2b                	jne    1178 <__do_global_dtors_aux+0x38>
    114d:	55                   	push   %rbp
    114e:	48 83 3d a2 2e 00 00 	cmpq   $0x0,0x2ea2(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1155:	00 
    1156:	48 89 e5             	mov    %rsp,%rbp
    1159:	74 0c                	je     1167 <__do_global_dtors_aux+0x27>
    115b:	48 8b 3d ee 2e 00 00 	mov    0x2eee(%rip),%rdi        # 4050 <__dso_handle>
    1162:	e8 29 ff ff ff       	call   1090 <__cxa_finalize@plt>
    1167:	e8 64 ff ff ff       	call   10d0 <deregister_tm_clones>
    116c:	c6 05 e5 2e 00 00 01 	movb   $0x1,0x2ee5(%rip)        # 4058 <__TMC_END__>
    1173:	5d                   	pop    %rbp
    1174:	c3                   	ret    
    1175:	0f 1f 00             	nopl   (%rax)
    1178:	c3                   	ret    
    1179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001180 <frame_dummy>:
    1180:	f3 0f 1e fa          	endbr64 
    1184:	e9 77 ff ff ff       	jmp    1100 <register_tm_clones>
    1189:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001190 <isort>:
    1190:	55                   	push   %rbp
    1191:	48 89 e5             	mov    %rsp,%rbp
    1194:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1198:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    119c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11a0:	48 83 c0 04          	add    $0x4,%rax
    11a4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    11a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11ac:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
    11b0:	0f 87 80 00 00 00    	ja     1236 <isort+0xa6>
    11b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11ba:	8b 00                	mov    (%rax),%eax
    11bc:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    11bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11c3:	48 83 c0 fc          	add    $0xfffffffffffffffc,%rax
    11c7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    11cb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    11cf:	31 c0                	xor    %eax,%eax
    11d1:	48 3b 4d f8          	cmp    -0x8(%rbp),%rcx
    11d5:	88 45 d7             	mov    %al,-0x29(%rbp)
    11d8:	0f 82 0f 00 00 00    	jb     11ed <isort+0x5d>
    11de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    11e2:	8b 00                	mov    (%rax),%eax
    11e4:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
    11e7:	0f 97 c0             	seta   %al
    11ea:	88 45 d7             	mov    %al,-0x29(%rbp)
    11ed:	8a 45 d7             	mov    -0x29(%rbp),%al
    11f0:	a8 01                	test   $0x1,%al
    11f2:	0f 85 05 00 00 00    	jne    11fd <isort+0x6d>
    11f8:	e9 1e 00 00 00       	jmp    121b <isort+0x8b>
    11fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1201:	8b 08                	mov    (%rax),%ecx
    1203:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1207:	89 48 04             	mov    %ecx,0x4(%rax)
    120a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    120e:	48 83 c0 fc          	add    $0xfffffffffffffffc,%rax
    1212:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    1216:	e9 b0 ff ff ff       	jmp    11cb <isort+0x3b>
    121b:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
    121e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1222:	89 48 04             	mov    %ecx,0x4(%rax)
    1225:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1229:	48 83 c0 04          	add    $0x4,%rax
    122d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    1231:	e9 72 ff ff ff       	jmp    11a8 <isort+0x18>
    1236:	5d                   	pop    %rbp
    1237:	c3                   	ret    
    1238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    123f:	00 

0000000000001240 <main>:
    1240:	55                   	push   %rbp
    1241:	48 89 e5             	mov    %rsp,%rbp
    1244:	48 83 ec 30          	sub    $0x30,%rsp
    1248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    124f:	89 7d f8             	mov    %edi,-0x8(%rbp)
    1252:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    1256:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    125a:	0f 84 18 00 00 00    	je     1278 <main+0x38>
    1260:	48 8d 3d 9d 0d 00 00 	lea    0xd9d(%rip),%rdi        # 2004 <_IO_stdin_used+0x4>
    1267:	b0 00                	mov    $0x0,%al
    1269:	e8 e2 fd ff ff       	call   1050 <printf@plt>
    126e:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    1273:	e8 08 fe ff ff       	call   1080 <exit@plt>
    1278:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    127c:	48 8b 78 08          	mov    0x8(%rax),%rdi
    1280:	e8 eb fd ff ff       	call   1070 <atoi@plt>
    1285:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    128c:	48 8b 78 10          	mov    0x10(%rax),%rdi
    1290:	e8 db fd ff ff       	call   1070 <atoi@plt>
    1295:	89 45 e8             	mov    %eax,-0x18(%rbp)
    1298:	c7 45 e4 2a 00 00 00 	movl   $0x2a,-0x1c(%rbp)
    129f:	8b 75 ec             	mov    -0x14(%rbp),%esi
    12a2:	48 8d 3d 7e 0d 00 00 	lea    0xd7e(%rip),%rdi        # 2027 <_IO_stdin_used+0x27>
    12a9:	b0 00                	mov    $0x0,%al
    12ab:	e8 a0 fd ff ff       	call   1050 <printf@plt>
    12b0:	48 63 7d ec          	movslq -0x14(%rbp),%rdi
    12b4:	48 c1 e7 02          	shl    $0x2,%rdi
    12b8:	e8 a3 fd ff ff       	call   1060 <malloc@plt>
    12bd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    12c1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
    12c6:	0f 85 21 00 00 00    	jne    12ed <main+0xad>
    12cc:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
    12d0:	e8 5b fd ff ff       	call   1030 <free@plt>
    12d5:	48 8d 3d 61 0d 00 00 	lea    0xd61(%rip),%rdi        # 203d <_IO_stdin_used+0x3d>
    12dc:	b0 00                	mov    $0x0,%al
    12de:	e8 6d fd ff ff       	call   1050 <printf@plt>
    12e3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    12e8:	e8 93 fd ff ff       	call   1080 <exit@plt>
    12ed:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
    12f4:	8b 45 d0             	mov    -0x30(%rbp),%eax
    12f7:	3b 45 e8             	cmp    -0x18(%rbp),%eax
    12fa:	0f 8d 61 00 00 00    	jge    1361 <main+0x121>
    1300:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
    1307:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    130a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    130d:	0f 8d 24 00 00 00    	jge    1337 <main+0xf7>
    1313:	48 8d 7d e4          	lea    -0x1c(%rbp),%rdi
    1317:	e8 24 fd ff ff       	call   1040 <rand_r@plt>
    131c:	89 c2                	mov    %eax,%edx
    131e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1322:	48 63 4d d4          	movslq -0x2c(%rbp),%rcx
    1326:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    1329:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    132c:	83 c0 01             	add    $0x1,%eax
    132f:	89 45 d4             	mov    %eax,-0x2c(%rbp)
    1332:	e9 d0 ff ff ff       	jmp    1307 <main+0xc7>
    1337:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
    133b:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
    133f:	48 63 45 ec          	movslq -0x14(%rbp),%rax
    1343:	48 c1 e0 02          	shl    $0x2,%rax
    1347:	48 01 c6             	add    %rax,%rsi
    134a:	48 83 c6 fc          	add    $0xfffffffffffffffc,%rsi
    134e:	e8 3d fe ff ff       	call   1190 <isort>
    1353:	8b 45 d0             	mov    -0x30(%rbp),%eax
    1356:	83 c0 01             	add    $0x1,%eax
    1359:	89 45 d0             	mov    %eax,-0x30(%rbp)
    135c:	e9 93 ff ff ff       	jmp    12f4 <main+0xb4>
    1361:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
    1365:	e8 c6 fc ff ff       	call   1030 <free@plt>
    136a:	48 8d 3d e6 0c 00 00 	lea    0xce6(%rip),%rdi        # 2057 <_IO_stdin_used+0x57>
    1371:	b0 00                	mov    $0x0,%al
    1373:	e8 d8 fc ff ff       	call   1050 <printf@plt>
    1378:	31 c0                	xor    %eax,%eax
    137a:	48 83 c4 30          	add    $0x30,%rsp
    137e:	5d                   	pop    %rbp
    137f:	c3                   	ret    

0000000000001380 <swap>:
    1380:	55                   	push   %rbp
    1381:	48 89 e5             	mov    %rsp,%rbp
    1384:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1388:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    138c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1390:	8b 00                	mov    (%rax),%eax
    1392:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1395:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1399:	8b 08                	mov    (%rax),%ecx
    139b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    139f:	89 08                	mov    %ecx,(%rax)
    13a1:	8b 4d ec             	mov    -0x14(%rbp),%ecx
    13a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13a8:	89 08                	mov    %ecx,(%rax)
    13aa:	5d                   	pop    %rbp
    13ab:	c3                   	ret    
    13ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000013b0 <partition>:
    13b0:	55                   	push   %rbp
    13b1:	48 89 e5             	mov    %rsp,%rbp
    13b4:	48 83 ec 20          	sub    $0x20,%rsp
    13b8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13bc:	89 75 f4             	mov    %esi,-0xc(%rbp)
    13bf:	89 55 f0             	mov    %edx,-0x10(%rbp)
    13c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13c6:	48 63 4d f0          	movslq -0x10(%rbp),%rcx
    13ca:	8b 04 88             	mov    (%rax,%rcx,4),%eax
    13cd:	89 45 ec             	mov    %eax,-0x14(%rbp)
    13d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    13d3:	83 e8 01             	sub    $0x1,%eax
    13d6:	89 45 e8             	mov    %eax,-0x18(%rbp)
    13d9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    13dc:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    13df:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    13e2:	8b 4d f0             	mov    -0x10(%rbp),%ecx
    13e5:	83 e9 01             	sub    $0x1,%ecx
    13e8:	39 c8                	cmp    %ecx,%eax
    13ea:	0f 8f 53 00 00 00    	jg     1443 <partition+0x93>
    13f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13f4:	48 63 4d e4          	movslq -0x1c(%rbp),%rcx
    13f8:	8b 04 88             	mov    (%rax,%rcx,4),%eax
    13fb:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    13fe:	0f 87 2c 00 00 00    	ja     1430 <partition+0x80>
    1404:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1407:	83 c0 01             	add    $0x1,%eax
    140a:	89 45 e8             	mov    %eax,-0x18(%rbp)
    140d:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
    1411:	48 63 45 e8          	movslq -0x18(%rbp),%rax
    1415:	48 c1 e0 02          	shl    $0x2,%rax
    1419:	48 01 c7             	add    %rax,%rdi
    141c:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
    1420:	48 63 45 e4          	movslq -0x1c(%rbp),%rax
    1424:	48 c1 e0 02          	shl    $0x2,%rax
    1428:	48 01 c6             	add    %rax,%rsi
    142b:	e8 50 ff ff ff       	call   1380 <swap>
    1430:	e9 00 00 00 00       	jmp    1435 <partition+0x85>
    1435:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1438:	83 c0 01             	add    $0x1,%eax
    143b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    143e:	e9 9c ff ff ff       	jmp    13df <partition+0x2f>
    1443:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
    1447:	8b 45 e8             	mov    -0x18(%rbp),%eax
    144a:	83 c0 01             	add    $0x1,%eax
    144d:	48 98                	cltq   
    144f:	48 c1 e0 02          	shl    $0x2,%rax
    1453:	48 01 c7             	add    %rax,%rdi
    1456:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
    145a:	48 63 45 f0          	movslq -0x10(%rbp),%rax
    145e:	48 c1 e0 02          	shl    $0x2,%rax
    1462:	48 01 c6             	add    %rax,%rsi
    1465:	e8 16 ff ff ff       	call   1380 <swap>
    146a:	8b 45 e8             	mov    -0x18(%rbp),%eax
    146d:	83 c0 01             	add    $0x1,%eax
    1470:	48 83 c4 20          	add    $0x20,%rsp
    1474:	5d                   	pop    %rbp
    1475:	c3                   	ret    
    1476:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    147d:	00 00 00 

0000000000001480 <quickSortIterative>:
    1480:	55                   	push   %rbp
    1481:	48 89 e5             	mov    %rsp,%rbp
    1484:	48 83 ec 30          	sub    $0x30,%rsp
    1488:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    148c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    148f:	89 55 f0             	mov    %edx,-0x10(%rbp)
    1492:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1495:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1498:	29 c8                	sub    %ecx,%eax
    149a:	83 c0 01             	add    $0x1,%eax
    149d:	89 c1                	mov    %eax,%ecx
    149f:	48 89 e0             	mov    %rsp,%rax
    14a2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    14a6:	48 8d 14 8d 0f 00 00 	lea    0xf(,%rcx,4),%rdx
    14ad:	00 
    14ae:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    14b2:	48 89 e0             	mov    %rsp,%rax
    14b5:	48 29 d0             	sub    %rdx,%rax
    14b8:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    14bc:	48 89 c4             	mov    %rax,%rsp
    14bf:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    14c3:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
    14ca:	8b 55 f4             	mov    -0xc(%rbp),%edx
    14cd:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    14d0:	83 c1 01             	add    $0x1,%ecx
    14d3:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    14d6:	48 63 c9             	movslq %ecx,%rcx
    14d9:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    14dc:	8b 55 f0             	mov    -0x10(%rbp),%edx
    14df:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    14e2:	83 c1 01             	add    $0x1,%ecx
    14e5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    14e8:	48 63 c9             	movslq %ecx,%rcx
    14eb:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    14ee:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    14f2:	0f 8c b7 00 00 00    	jl     15af <quickSortIterative+0x12f>
    14f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    14fc:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    14ff:	89 ca                	mov    %ecx,%edx
    1501:	83 c2 ff             	add    $0xffffffff,%edx
    1504:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1507:	48 63 c9             	movslq %ecx,%rcx
    150a:	8b 0c 88             	mov    (%rax,%rcx,4),%ecx
    150d:	89 4d f0             	mov    %ecx,-0x10(%rbp)
    1510:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    1513:	89 ca                	mov    %ecx,%edx
    1515:	83 c2 ff             	add    $0xffffffff,%edx
    1518:	89 55 dc             	mov    %edx,-0x24(%rbp)
    151b:	48 63 c9             	movslq %ecx,%rcx
    151e:	8b 04 88             	mov    (%rax,%rcx,4),%eax
    1521:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1524:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
    1528:	8b 75 f4             	mov    -0xc(%rbp),%esi
    152b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    152e:	e8 7d fe ff ff       	call   13b0 <partition>
    1533:	89 45 d8             	mov    %eax,-0x28(%rbp)
    1536:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1539:	83 e8 01             	sub    $0x1,%eax
    153c:	3b 45 f4             	cmp    -0xc(%rbp),%eax
    153f:	0f 8e 2b 00 00 00    	jle    1570 <quickSortIterative+0xf0>
    1545:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1549:	8b 55 f4             	mov    -0xc(%rbp),%edx
    154c:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    154f:	83 c1 01             	add    $0x1,%ecx
    1552:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    1555:	48 63 c9             	movslq %ecx,%rcx
    1558:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    155b:	8b 55 d8             	mov    -0x28(%rbp),%edx
    155e:	83 ea 01             	sub    $0x1,%edx
    1561:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    1564:	83 c1 01             	add    $0x1,%ecx
    1567:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    156a:	48 63 c9             	movslq %ecx,%rcx
    156d:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    1570:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1573:	83 c0 01             	add    $0x1,%eax
    1576:	3b 45 f0             	cmp    -0x10(%rbp),%eax
    1579:	0f 8d 2b 00 00 00    	jge    15aa <quickSortIterative+0x12a>
    157f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1583:	8b 55 d8             	mov    -0x28(%rbp),%edx
    1586:	83 c2 01             	add    $0x1,%edx
    1589:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    158c:	83 c1 01             	add    $0x1,%ecx
    158f:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    1592:	48 63 c9             	movslq %ecx,%rcx
    1595:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    1598:	8b 55 f0             	mov    -0x10(%rbp),%edx
    159b:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    159e:	83 c1 01             	add    $0x1,%ecx
    15a1:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    15a4:	48 63 c9             	movslq %ecx,%rcx
    15a7:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    15aa:	e9 3f ff ff ff       	jmp    14ee <quickSortIterative+0x6e>
    15af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15b3:	48 89 c4             	mov    %rax,%rsp
    15b6:	48 89 ec             	mov    %rbp,%rsp
    15b9:	5d                   	pop    %rbp
    15ba:	c3                   	ret    

Disassembly of section .fini:

00000000000015bc <_fini>:
    15bc:	f3 0f 1e fa          	endbr64 
    15c0:	48 83 ec 08          	sub    $0x8,%rsp
    15c4:	48 83 c4 08          	add    $0x8,%rsp
    15c8:	c3                   	ret    
