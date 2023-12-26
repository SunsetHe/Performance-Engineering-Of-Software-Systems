# README

-----------------------------------

## lscpu

-----------------------------------------

```bash

架构：                   x86_64
  CPU 运行模式：         32-bit, 64-bit
  Address sizes:         46 bits physical, 48 bits virtual
  字节序：               Little Endian
CPU:                     1
  在线 CPU 列表：        0
厂商 ID：                GenuineIntel
  型号名称：             Intel(R) Xeon(R) Platinum 8171M CPU @ 2.60GHz
    CPU 系列：           6
    型号：               85
    每个核的线程数：     1
    每个座的核数：       1
    座：                 1
    步进：               4
    BogoMIPS：           4190.15
    标记：               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss
                          syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq ssse3 fma cx1
                         6 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch inv
                         pcid_single pti fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm avx512f avx512dq rdseed adx smap c
                         lflushopt avx512cd avx512bw avx512vl xsaveopt xsavec xsaves md_clear
Virtualization features:
  超管理器厂商：         Microsoft
  虚拟化类型：           完全
Caches (sum of all):
  L1d:                   32 KiB (1 instance)
  L1i:                   32 KiB (1 instance)
  L2:                    1 MiB (1 instance)
  L3:                    35.8 MiB (1 instance)
NUMA:
  NUMA 节点：            1
  NUMA 节点0 CPU：       0
Vulnerabilities:
  Gather data sampling:  Unknown: Dependent on hypervisor status
  Itlb multihit:         KVM: Mitigation: VMX unsupported
  L1tf:                  Mitigation; PTE Inversion
  Mds:                   Mitigation; Clear CPU buffers; SMT Host state unknown
  Meltdown:              Mitigation; PTI
  Mmio stale data:       Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state unknown
  Retbleed:              Vulnerable
  Spec rstack overflow:  Not affected
  Spec store bypass:     Vulnerable
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:            Mitigation; Retpolines, STIBP disabled, RSB filling, PBRSB-eIBRS Not affected
  Srbds:                 Not affected
  Tsx async abort:       Mitigation; Clear CPU buffers; SMT Host state unknown
```

---------------------------------------------------

## Checkoff Item 1

-----------------------------------------

在进行`perf record`和`perf report`命令时，遇到两个权限的问题，

一个是`/proc/sys/kernel/perf_event_paranoid`，用于限制对性能事件的访问。

另外一个是`/proc/sys/kernel/kptr_restrict`，用于限制内核指针的访问权限。

```bash
# 允许几乎所有用户对所有事件的访问，但是虚拟机重启后会恢复原来的权限等级
sudo sysctl -w kernel.perf_event_paranoid=-1

# 允许用户态程序查看内核符号的地址，但是虚拟机重启后会恢复原来的权限等级
echo 0 | sudo tee /proc/sys/kernel/kptr_restrict 
```

执行`perf report` 之后进入以下界面，可以发现isort函数占用的资源是最多的

```bash
Samples: 2K of event 'cpu-clock:pppH', Event count (approx.): 711500000
Overhead  Command  Shared Object      Symbol
  99.86%  isort    isort              [.] isort
   0.04%  isort    [kernel.kallsyms]  [k] clear_page_erms
   0.04%  isort    [kernel.kallsyms]  [k] copy_page
   0.04%  isort    [kernel.kallsyms]  [k] folio_memcg_lock.part.0
   0.04%  isort    libc.so.6          [.] rand_r 
```

选择Shared Object中isort的那一项，进入以下界面

```bash
Annotate isort                                                                                                              ◆Zoom into isort thread                                                                                                      ▒Zoom into isort DSO (use the 'k' hotkey to zoom directly into the kernel)                                                   ▒
Browse map details                                                                                                          ▒
Run scripts for samples of symbol [isort]                                                                                   ▒
Run scripts for all samples                                                                                                 ▒
Switch to another data file in PWD                                                                                          ▒
Exit
```

选择`Annotate isort` ，回车，进入对isort进行源码级分析的界面，也可以`perf annotate isort > profiling-results.txt`将分析导入到txt文件中查看，都是一样的

```
 Percent |	Source code & Disassembly of isort for cpu-clock:pppH (2845 samples, percent: local period)
-----------------------------------------------------------------------------------------------------------
         :
         : 1    /home/sunsethehehe/.debug/.build-id/1d/0cecab4e1f4265e87b24c51668567447b6c713/elf：     文件格式 elf64-x86-64
         :
         :
         : 4    Disassembly of section .text:
         :
         : 6    0000000000001190 <isort>:
         : 7    isort():
    0.00 :   1190:   push   %rbp
    0.00 :   1191:   mov    %rsp,%rbp
    0.00 :   1194:   mov    %rdi,-0x8(%rbp)
    0.00 :   1198:   mov    %rsi,-0x10(%rbp)
    0.00 :   119c:   mov    -0x8(%rbp),%rax
    0.00 :   11a0:   add    $0x4,%rax
    0.00 :   11a4:   mov    %rax,-0x18(%rbp)
    0.00 :   11a8:   mov    -0x18(%rbp),%rax
    0.00 :   11ac:   cmp    -0x10(%rbp),%rax
    0.00 :   11b0:   ja     1236 <isort+0xa6>
    0.04 :   11b6:   mov    -0x18(%rbp),%rax
    0.00 :   11ba:   mov    (%rax),%eax
    0.00 :   11bc:   mov    %eax,-0x1c(%rbp)
    0.00 :   11bf:   mov    -0x18(%rbp),%rax
    0.00 :   11c3:   add    $0xfffffffffffffffc,%rax
    0.00 :   11c7:   mov    %rax,-0x28(%rbp)
    7.91 :   11cb:   mov    -0x28(%rbp),%rcx
    0.46 :   11cf:   xor    %eax,%eax
    1.16 :   11d1:   cmp    -0x8(%rbp),%rcx
    4.15 :   11d5:   mov    %al,-0x29(%rbp)
    8.79 :   11d8:   jb     11ed <isort+0x5d>
    0.46 :   11de:   mov    -0x28(%rbp),%rax
    1.48 :   11e2:   mov    (%rax),%eax
    5.10 :   11e4:   cmp    -0x1c(%rbp),%eax
    7.80 :   11e7:   seta   %al
    5.27 :   11ea:   mov    %al,-0x29(%rbp)
   10.86 :   11ed:   mov    -0x29(%rbp),%al
   18.66 :   11f0:   test   $0x1,%al
    0.00 :   11f2:   jne    11fd <isort+0x6d>
    0.00 :   11f8:   jmp    121b <isort+0x8b>
    8.37 :   11fd:   mov    -0x28(%rbp),%rax
    0.53 :   1201:   mov    (%rax),%ecx
    1.55 :   1203:   mov    -0x28(%rbp),%rax
    3.62 :   1207:   mov    %ecx,0x4(%rax)
    7.52 :   120a:   mov    -0x28(%rbp),%rax
    0.60 :   120e:   add    $0xfffffffffffffffc,%rax
    1.76 :   1212:   mov    %rax,-0x28(%rbp)
    3.87 :   1216:   jmp    11cb <isort+0x3b>
    0.00 :   121b:   mov    -0x1c(%rbp),%ecx
    0.07 :   121e:   mov    -0x28(%rbp),%rax
    0.00 :   1222:   mov    %ecx,0x4(%rax)
    0.00 :   1225:   mov    -0x18(%rbp),%rax
    0.00 :   1229:   add    $0x4,%rax
    0.00 :   122d:   mov    %rax,-0x18(%rbp)
    0.00 :   1231:   jmp    11a8 <isort+0x18>
    0.00 :   1236:   pop    %rbp
    0.00 :   1237:   ret

```

根据对输出结果的观察，观察占据时钟周期较多的命令mov和j（跳转），我认为该程序的性能瓶颈主要在于**缓存命中**和**分支预测**上，于是我接下来打算进行下一步探索，详细查看分支预测的性能统计，但是却发生了一些问题

```bash
$ perf record -e branches,branch-misses ./isort 10000 10
Error:
The branches event is not supported.
```

于是我查看了`perf list`

```bash
$ perf list

List of pre-defined events (to be used in -e or -M):

  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]
  msr/pperf/                                         [Kernel PMU event]
  msr/smi/                                           [Kernel PMU event]
  msr/tsc/                                           [Kernel PMU event]
  rNNN                                               [Raw hardware event descriptor]
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
       [(see 'man perf-list' on how to encode it)]
  mem:<addr>[/len][:access]                          [Hardware breakpoint]
  sdt_libc:cond_broadcast                            [SDT event]
  sdt_libc:cond_destroy                              [SDT event]
  sdt_libc:cond_init                                 [SDT event]
  sdt_libc:cond_signal                               [SDT event]
  sdt_libc:cond_wait                                 [SDT event]
  sdt_libc:lll_lock_wait                             [SDT event]
  sdt_libc:lll_lock_wait_private                     [SDT event]
  sdt_libc:longjmp                                   [SDT event]
  sdt_libc:longjmp_target                            [SDT event]
  sdt_libc:memory_arena_new                          [SDT event] 
```

发现我的电脑不支持branches和cache等hardware event，上网查询后貌似是硬件问题，我使用的是Azure for student提供的免费Ubuntu云主机，因此作罢。

---------------------------------------------

## 
