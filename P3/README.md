##Write-up 2 

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
 Percent |    Source code & Disassembly of isort for cpu-clock:pppH (2845 samples, percent: local period)
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

发现我的电脑不支持branches和cache等hardware event，查看了pdf后面的内容，发现像aws和azure这种云主机不支持hardware event貌似是正常现象，可能因为使用的应该是虚拟cpu，我使用的是Azure for student提供的免费Ubuntu云主机，因此没有做进一步探究。

---------------------------------------------

## Checkoff Item 2

-------------------------

先展示一下原始参数的运行结果

```bash
$ make sum
$ valgrind --tool=cachegrind --branch-sim=yes ./sum
==16525== Cachegrind, a cache and branch-prediction profiler
==16525== Copyright (C) 2002-2017, and GNU GPL'd, by Nicholas Nethercote et al.
==16525== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==16525== Command: ./sum
==16525==
--16525-- warning: L3 cache found, using its data for the LL simulation.
--16525-- warning: specified LL cache: line_size 64  assoc 11  total_size 37,486,592
--16525-- warning: simulated LL cache: line_size 64  assoc 18  total_size 37,748,736
Allocated array of size 10000000
Summing 100000000 random values...
Done. Value = 938895920
==16525==
==16525== I   refs:      3,440,139,741
==16525== I1  misses:            1,360
==16525== LLi misses:            1,353
==16525== I1  miss rate:          0.00%
==16525== LLi miss rate:          0.00%
==16525==
==16525== D   refs:        610,047,349  (400,033,452 rd   + 210,013,897 wr)
==16525== D1  misses:      100,546,579  ( 99,920,883 rd   +     625,696 wr)
==16525== LLd misses:        6,314,761  (  5,689,108 rd   +     625,653 wr)
==16525== D1  miss rate:          16.5% (       25.0%     +         0.3%  )
==16525== LLd miss rate:           1.0% (        1.4%     +         0.3%  )
==16525==
==16525== LL refs:         100,547,939  ( 99,922,243 rd   +     625,696 wr)
==16525== LL misses:         6,316,114  (  5,690,461 rd   +     625,653 wr)
==16525== LL miss rate:            0.2% (        0.1%     +         0.3%  )
==16525==
==16525== Branches:        210,023,832  (110,023,450 cond + 100,000,382 ind)
==16525== Mispredicts:           3,103  (      2,928 cond +         175 ind)
==16525== Mispred rate:            0.0% (        0.0%     +         0.0%   )
```

可以发现指令未命中和分支预测错误都很少，数量级在千分之一之下，而L1的缓存未命中有16.5%，L3的缓存未命中有1%。接下来调整U和N的值，进行测试，因为每次要修改U和N都要重新编译再运行valgrind命令，为了方便，我修改了一下sum.c，让它在运行时接受两个参数作为U和N的值，再编译

```c
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint32_t data_t;

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("Usage: %s U N\n", argv[0]);
    return -1;
  }

  const int U = atoi(argv[1]);   // size of the array
  const int N = atoi(argv[2]);   // number of searches to perform

  data_t* data = (data_t*) malloc(U * sizeof(data_t));
  if (data == NULL) {
    printf("Error: not enough memory\n");
    return -1;
  }

  // fill up the array with sequential (sorted) values.
  int i;
  for (i = 0; i < U; i++) {
    data[i] = i;
  }

  printf("Allocated array of size %d\n", U);
  printf("Summing %d random values...\n", N);

  data_t val = 0;
  data_t seed = 42;
  for (i = 0; i < N; i++) {
    int l = rand_r(&seed) % U;
    val = (val + data[l]);
  }

  free(data);
  printf("Done. Value = %d\n", val);
  return 0;
}
```

接下来我编写了一个脚本来遍历U和N的值，将输出中的`D1  miss rate`和`LLd miss rate`的行输出到result_u.txt中，脚本如下，注意result_u.txt代表外层循环的值为U，修改U和N的位置和result_n.txt，得到两个结果txt，更方便对比查看，运行脚本后目录下出现很多cachevalgrind的东西，可以删除

```shell
#!/bin/bash

for ((u = 10; u <= 10000000; u *= 10)); do
  for ((n = 10; n <= 100000000; n *= 10)); do

    valgrind_cmd="valgrind --tool=cachegrind --branch-sim=yes ./sum $u $n"


    $valgrind_cmd 2>&1 | tee temp_result.txt


    echo "U: $u" >> result_u.txt
    echo "N: $n" >> result_u.txt
    sed -n '22p' temp_result.txt >> result_u.txt
    sed -n '23p' temp_result.txt >> result_u.txt
    echo -e "\n " >> result_u.txt

    rm temp_result.txt
  done
done
```

查看result_u.txt的部分内容，可以发现，在U较小（U的数量在10000及以下的时候）以及U/N小于1的情况下，继续减少U/N的值（也就是增大N的值）可以显著减少两个缓存未命中的概率，部分证据如下

```textile
U: 10
N: 10
==32675== D1  miss rate:     4.7% (   4.8%     +    4.5%  )
==32675== LLd miss rate:     4.0% (   3.9%     +    4.2%  )


U: 10
N: 100
==32680== D1  miss rate:     4.7% (   4.8%     +    4.5%  )
==32680== LLd miss rate:     4.0% (   3.9%     +    4.2%  )


U: 10
N: 1000
==32685== D1  miss rate:     4.2% (   4.3%     +    4.0%  )
==32685== LLd miss rate:     3.6% (   3.5%     +    3.7%  )


U: 10
N: 10000
==32690== D1  miss rate:     2.1% (   2.2%     +    1.9%  )
==32690== LLd miss rate:     1.8% (   1.8%     +    1.7%  )


U: 10
N: 100000
==32695== D1  miss rate:       0.3% (    0.4%     +     0.3%  )
==32695== LLd miss rate:       0.3% (    0.3%     +     0.3%  ) 

。。。。。。


U: 1000
N: 10
==32761== D1  miss rate:     4.8% (   4.8%     +    4.6%  )
==32761== LLd miss rate:     4.1% (   3.9%     +    4.4%  )


U: 1000
N: 100
==32766== D1  miss rate:     4.7% (   4.8%     +    4.6%  )
==32766== LLd miss rate:     4.0% (   3.9%     +    4.3%  )


U: 1000
N: 1000
==32771== D1  miss rate:     4.2% (   4.3%     +    4.1%  )
==32771== LLd miss rate:     3.6% (   3.5%     +    3.9%  )


U: 1000
N: 10000
==32776== D1  miss rate:     2.1% (   2.2%     +    2.0%  )
==32776== LLd miss rate:     1.8% (   1.8%     +    1.9%  )


U: 1000
N: 100000 
==32781== D1  miss rate:       0.4% (    0.4%     +     0.3%  )
==32781== LLd miss rate:       0.3% (    0.3%     +     0.3%  )


U: 1000
N: 1000000
==32786== D1  miss rate:        0.0% (      0.0%     +       0.0%  )
==32786== LLd miss rate:        0.0% (      0.0%     +       0.0%  )
```

而如果N不变，增大U的值，大部分情况下都会导致两个缓存未命中的概率变大

下面是找到的能使两个概率接近于0的U和N的搭配

```textile
U: 10
N: 100000
==32695== D1  miss rate:       0.3% (    0.4%     +     0.3%  )
==32695== LLd miss rate:       0.3% (    0.3%     +     0.3%  ) 

U: 10
N: 1000000
==32700== D1  miss rate:        0.0% (      0.0%     +       0.0%  )
==32700== LLd miss rate:        0.0% (      0.0%     +       0.0%  ) 

U: 10
N: 10000000
==32705== D1  miss rate:         0.0% (       0.0%     +        0.0%  )
==32705== LLd miss rate:         0.0% (       0.0%     +        0.0%  ) 

U: 10
N: 100000000
==32711== D1  miss rate:           0.0% (        0.0%     +         0.0%  )
==32711== LLd miss rate:           0.0% (        0.0%     +         0.0%  ) 
-----------------------------------
U: 100
N: 100000
==32739== D1  miss rate:       0.3% (    0.4%     +     0.3%  )
==32739== LLd miss rate:       0.3% (    0.3%     +     0.3%  )


U: 100
N: 1000000
==32744== D1  miss rate:        0.0% (      0.0%     +       0.0%  )
==32744== LLd miss rate:        0.0% (      0.0%     +       0.0%  )


U: 100
N: 10000000
==32749== D1  miss rate:         0.0% (       0.0%     +        0.0%  )
==32749== LLd miss rate:         0.0% (       0.0%     +        0.0%  ) 

U: 100
N: 100000000
==32756== D1  miss rate:           0.0% (        0.0%     +         0.0%  )
==32756== LLd miss rate:           0.0% (        0.0%     +         0.0%  ) 
--------------------------------------------------
U: 1000
N: 100000
==32781== D1  miss rate:       0.4% (    0.4%     +     0.3%  )
==32781== LLd miss rate:       0.3% (    0.3%     +     0.3%  )


U: 1000
N: 1000000
==32786== D1  miss rate:        0.0% (      0.0%     +       0.0%  )
==32786== LLd miss rate:        0.0% (      0.0%     +       0.0%  )


U: 1000
N: 10000000
==32791== D1  miss rate:         0.0% (       0.0%     +        0.0%  )
==32791== LLd miss rate:         0.0% (       0.0%     +        0.0%  )


U: 1000
N: 100000000
==32797== D1  miss rate:           0.0% (        0.0%     +         0.0%  )
==32797== LLd miss rate:           0.0% (        0.0%     +         0.0%  )**U:100000000，1e8**
```

U的数值代表的是数组所占内存的大小，这个大小最好不要超过lscpu中L1缓存的大小，超过了L1的未命中率就会比较大一些，我的lscpu中L1缓存的大小是32KiB，N的一千万对应的是40Mib，N的一万对应的是40KiB，刚好就卡在这个1000上面。

------------------------------------------------------------------

## Write-up 1

---------------------------------------

DEBUG=1

```textile
==36798== Cachegrind, a cache and branch-prediction profiler
==36798== Copyright (C) 2002-2017, and GNU GPL'd, by Nicholas Nethercote et al.
==36798== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==36798== Command: ./sort 1000000 10
==36798==
--36798-- warning: L3 cache found, using its data for the LL simulation.
--36798-- warning: specified LL cache: line_size 64  assoc 11  total_size 37,486,592
--36798-- warning: simulated LL cache: line_size 64  assoc 18  total_size 37,748,736

Running test #0...
Generating random array of 1000000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 9.065486 sec
sort_a repeated : Elapsed execution time: 9.061520 sec
Generating inverted array of 1000000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 17.929647 sec
sort_a repeated : Elapsed execution time: 17.945858 sec

Running test #1...
 --> test_zero_element at line 245: PASS

Running test #2...
 --> test_one_element at line 266: PASS
Done testing.
==36798==
==36798== I   refs:      51,644,426,942
==36798== I1  misses:             1,781
==36798== LLi misses:             1,639
==36798== I1  miss rate:           0.00%
==36798== LLi miss rate:           0.00%
==36798==
==36798== D   refs:      34,375,857,924  (26,001,429,180 rd   + 8,374,428,744 wr)
==36798== D1  misses:        95,816,197  (    48,958,159 rd   +    46,858,038 wr)
==36798== LLd misses:           252,256  (         1,493 rd   +       250,763 wr)
==36798== D1  miss rate:            0.3% (           0.2%     +           0.6%  )
==36798== LLd miss rate:            0.0% (           0.0%     +           0.0%  )
==36798==
==36798== LL refs:           95,817,978  (    48,959,940 rd   +    46,858,038 wr)
==36798== LL misses:            253,895  (         3,132 rd   +       250,763 wr)
==36798== LL miss rate:             0.0% (           0.0%     +           0.0%  )
==36798==
==36798== Branches:       4,980,210,522  ( 4,810,209,836 cond +   170,000,686 ind)
==36798== Mispredicts:      401,722,605  (   401,722,307 cond +           298 ind)
==36798== Mispred rate:             8.1% (           8.4%     +           0.0%   )
```

DEBUG=0

```textile
==36853== Cachegrind, a cache and branch-prediction profiler
==36853== Copyright (C) 2002-2017, and GNU GPL'd, by Nicholas Nethercote et al.
==36853== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==36853== Command: ./sort 1000000 10
==36853==
--36853-- warning: L3 cache found, using its data for the LL simulation.
--36853-- warning: specified LL cache: line_size 64  assoc 11  total_size 37,486,592
--36853-- warning: simulated LL cache: line_size 64  assoc 18  total_size 37,748,736

Running test #0...
Generating random array of 1000000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 4.323486 sec
sort_a repeated : Elapsed execution time: 4.306340 sec
Generating inverted array of 1000000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 8.655471 sec
sort_a repeated : Elapsed execution time: 8.620938 sec

Running test #1...
 --> test_zero_element at line 245: PASS

Running test #2...
 --> test_one_element at line 266: PASS
Done testing.
==36853==
==36853== I   refs:      29,650,850,858
==36853== I1  misses:             1,803
==36853== LLi misses:             1,663
==36853== I1  miss rate:           0.00%
==36853== LLi miss rate:           0.00%
==36853==
==36853== D   refs:      10,445,373,841  (6,356,422,974 rd   + 4,088,950,867 wr)
==36853== D1  misses:        95,922,565  (   48,964,526 rd   +    46,958,039 wr)
==36853== LLd misses:           252,279  (        1,515 rd   +       250,764 wr)
==36853== D1  miss rate:            0.9% (          0.8%     +           1.1%  )
==36853== LLd miss rate:            0.0% (          0.0%     +           0.0%  )
==36853==
==36853== LL refs:           95,924,368  (   48,966,329 rd   +    46,958,039 wr)
==36853== LL misses:            253,942  (        3,178 rd   +       250,764 wr)
==36853== LL miss rate:             0.0% (          0.0%     +           0.0%  )
==36853==
==36853== Branches:       3,035,052,147  (2,865,051,440 cond +   170,000,707 ind)
==36853== Mispredicts:      109,279,219  (  109,278,909 cond +           310 ind)
==36853== Mispred rate:             3.6% (          3.8%     +           0.0%   ) 
```

----------------------------------

### 比较

--------------------------------

明显可以发现，首先是1（9秒和17秒）的运行时间基本为0（4秒和8秒）的两倍多一点，1的指令数有51billion，是0（29billion）的约1.7倍，而数据读写数为34billion，是0（10billion）的三倍多一点，1的分支数反而只是0的1.3倍左右，但是1的分支预测错误率为8.1%，而0的为3.6%。我认为造成各项数据1的比0高基本都是因为调试模式下编译器生成了更多代码以支持调试信息，从而导致指令数、数据读写次数，分支预测错误率的明显提升。

-------------------------------------------------

### 优点

---------------------------

指令计数可以快速获取程序执行工作量的指标。它直接反映了程序执行期间的指令数量，因此可以用作衡量工作量的简单方法。

----------------------------------------------

### 缺点

--------------------------------------

由于指令计数并不考虑单个指令的执行时间、缓存命中、分支预测等方面，如果一个程序指令数少，但是在这三个方面表现很差，该程序的运行时间是有可能的比指令数多的程序还要运行的更久的。

--------------------------------------------

## Write-up 2&3

--------------------------------------

我尝试内联了`merge_i`和`copy_i`函数，编译运行之后发现，当程序输入的数组大小为10000左右时，程序运行时间并没有很显著的提高，只有将参数大小设为10到100，才有比较明显，接近于运行时间减少40%左右的提升。尝试内联util.c中的函数没有为运行时间带来显著差异。而尝试内联`sort_i`函数后进行make时会报错，因此没有接着尝试。

```textile
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.048865 sec
sort_a repeated : Elapsed execution time: 0.038391 sec
sort_i          : Elapsed execution time: 0.052034 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.088333 sec
sort_a repeated : Elapsed execution time: 0.077869 sec
sort_i          : Elapsed execution time: 0.096642 sec 
--------------------------------------
Running test #0...
Generating random array of 100 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.007931 sec
sort_a repeated : Elapsed execution time: 0.000365 sec
sort_i          : Elapsed execution time: 0.005771 sec
Generating inverted array of 100 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.008492 sec
sort_a repeated : Elapsed execution time: 0.000726 sec
sort_i          : Elapsed execution time: 0.006135 sec 
--------------------------------------
Running test #0...
Generating random array of 10 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.004942 sec
sort_a repeated : Elapsed execution time: 0.000042 sec
sort_i          : Elapsed execution time: 0.003258 sec
Generating inverted array of 10 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.005128 sec
sort_a repeated : Elapsed execution time: 0.000102 sec
sort_i          : Elapsed execution time: 0.003301 sec
```

-----------------------------------

## Write-up 4

----------------------------------------

### 可能提高性能的原因

--------------------------------------------

1. 指针允许直接对内存进行访问，而不需要进行数组索引计算。在某些情况下，这可以减少内存访问的开销，因为不需要额外的索引计算

2. 编译器通常会添加额外的代码来检查索引是否超出数组范围。使用指针可以避免这种溢出检查，从而减少运行时开销

---------------------------

### 测试结果

--------------------------------

将代码更改为使用指针之后并没有为程序运行时间带来明显的优化，在数组大小为100~10000这几个数量级上，使用指针的成绩有时候优于不使用指针的，有时候又差于，很难评价。这里放一个运行时间稍微短一点的成绩

```textile
Running test #0...
Generating random array of 1000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.013416 sec
sort_a repeated : Elapsed execution time: 0.003879 sec
sort_i          : Elapsed execution time: 0.009763 sec
sort_p          : Elapsed execution time: 0.009356 sec
Generating inverted array of 1000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.017176 sec
sort_a repeated : Elapsed execution time: 0.007625 sec
sort_i          : Elapsed execution time: 0.013394 sec
sort_p          : Elapsed execution time: 0.012893 sec
```

------------------------------------

## Write-up 5

-----------------------------------

在`util.h`的两行函数定义下添加`void isort(data_t* begin, data_t* end);`  在`sort_c.c`处修改下面这个函数成这样，在元素少于等于五个的时候使用插入排序

```c
void sort_c(data_t* A, int p, int r) {
  assert(A);
  if (p < r) {
    // Use insertion sort for small subarrays
    if (r - p + 1 <= 5) {
      isort(A + p, A + r);
    } else {
      int q = (p + r) / 2;
      sort_c(A, p, q);
      sort_c(A, q + 1, r);
      merge_c(A, p, q, r);
    }
  }
}
```

再进行测试

```textile
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.046481 sec
sort_a repeated : Elapsed execution time: 0.038751 sec
sort_i          : Elapsed execution time: 0.045198 sec
sort_p          : Elapsed execution time: 0.044500 sec
sort_c          : Elapsed execution time: 0.022802 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.084457 sec
sort_a repeated : Elapsed execution time: 0.076291 sec
sort_i          : Elapsed execution time: 0.083502 sec
sort_p          : Elapsed execution time: 0.083552 sec
sort_c          : Elapsed execution time: 0.038389 sec
```

可以发现程序运行速度发生比较大的提升，运行时间变成了原来的50%左右。在这个数为5的情况下，数组元素个数越少，提升越不明显，很容易可知道这是算法复杂度导致的。设定同样的数组元素10000，变更这个数为10等，

```textile
10
-----------------------------
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.048334 sec
sort_a repeated : Elapsed execution time: 0.039424 sec
sort_i          : Elapsed execution time: 0.045540 sec
sort_p          : Elapsed execution time: 0.043999 sec
sort_c          : Elapsed execution time: 0.018005 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.086085 sec
sort_a repeated : Elapsed execution time: 0.077259 sec
sort_i          : Elapsed execution time: 0.084906 sec
sort_p          : Elapsed execution time: 0.083711 sec
sort_c          : Elapsed execution time: 0.031157 sec 
--------------------------------
20
-----------------------------
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.046012 sec
sort_a repeated : Elapsed execution time: 0.038611 sec
sort_i          : Elapsed execution time: 0.044946 sec
sort_p          : Elapsed execution time: 0.044334 sec
sort_c          : Elapsed execution time: 0.017505 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.084540 sec
sort_a repeated : Elapsed execution time: 0.077142 sec
sort_i          : Elapsed execution time: 0.084631 sec
sort_p          : Elapsed execution time: 0.084777 sec
sort_c          : Elapsed execution time: 0.030018 sec 
-----------------------------------------
400
--------------------------------------
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.049450 sec
sort_a repeated : Elapsed execution time: 0.038800 sec
sort_i          : Elapsed execution time: 0.044890 sec
sort_p          : Elapsed execution time: 0.045796 sec
sort_c          : Elapsed execution time: 0.040483 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.088367 sec
sort_a repeated : Elapsed execution time: 0.077119 sec
sort_i          : Elapsed execution time: 0.084325 sec
sort_p          : Elapsed execution time: 0.084577 sec
sort_c          : Elapsed execution time: 0.103604 sec 
------------------------------------------
500
------------------------------------------
Running test #0...
Generating random array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.047033 sec
sort_a repeated : Elapsed execution time: 0.037182 sec
sort_i          : Elapsed execution time: 0.043108 sec
sort_p          : Elapsed execution time: 0.048790 sec
sort_c          : Elapsed execution time: 0.049990 sec
Generating inverted array of 10000 elements
Arrays are sorted: yes
 --> test_correctness at line 217: PASS
sort_a          : Elapsed execution time: 0.084696 sec
sort_a repeated : Elapsed execution time: 0.075818 sec
sort_i          : Elapsed execution time: 0.083209 sec
sort_p          : Elapsed execution time: 0.088041 sec
sort_c          : Elapsed execution time: 0.113843 sec
```

最终测试出来在这个数在400~500之间时，归并排序的效果逐渐好于插入排序。选择涉及到两个排序算法的复杂度，插入是n^2，归并是nlog(n)。

------------------------------------

## Write-up 5

-----------------------------------

试着写了好几遍函数但是无法通过编译，放弃了:(


