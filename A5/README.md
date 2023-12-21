# A5

------------------------------------

## 1

-----------------------

将对应两行代码更改为下面的代码

```cpp
int global_row = index.get_group(0) * index.get_local_range(0) + index.get_local_id(0);
int global_col = index.get_group(1) * index.get_local_range(1) + index.get_local_id(1); 
```

然后在`~/oneAPI_course/code` 下面新建gemm_basic.sh文件

```bash
#!/bin/bash

echo
echo start: $(date "+%y%m%d.%H%M%S.%3N")
echo

# TODO list
source /opt/intel/oneapi/setvars.sh > /dev/null 2>&1
dpcpp gemm_basic.cpp -o gemm_basic
if [ $? -eq 0 ]; then ./gemm_basic; fi

echo
echo stop:  $(date "+%y%m%d.%H%M%S.%3N")
echo 
```

随后运行`qsub -l nodes=1:gpu:ppn=2 -d . gemm_basic.sh` 此命令，提交计算任务至计算节点，此命令会有类似于`2451912.v-qsvr-1.aidevcloud` 的输出，那一串数字是该任务的标识，等待一会后，运行`ls -al gemm_basic*` 可以发现多出了下面两个文件

- gemm_basic.sh.o2451912

- gemm_basic.sh.e2451912

使用nano查看，第一题的gemm_basic.sh.o2451912内容如下

```textile
########################################################################
#      Date:           Thu Dec 21 08:08:48 AM PST 2023
#    Job ID:           2451912.v-qsvr-1.aidevcloud
#      User:           u209084
# Resources:           cput=75:00:00,neednodes=1:gpu:ppn=2,nodes=1:gpu:ppn=2,walltime=06:00:00
########################################################################


start: 231221.080849.976

Problem size: c(1024,1024) = a(1024,1024) * b(1024,1024)

Performance Flops = 2147483648.000000, 
GPU Computation Time = 117.180505 (ms); 
CPU Computaiton Time = 442.295032 (ms); 

stop: 231221.080916.431


########################################################################
# End of output for job 2451912.v-qsvr-1.aidevcloud
# Date: Thu Dec 21 08:09:16 AM PST 2023
########################################################################
```

可以看到任务成功运行并通过了正确性测试。gemm_basic.sh.e2451912文件没有什么实质性内容，只是一些告警，不影响程序运行，这里不做展示。

------------------------------

## 2

-------------------------------------------------------

首先是将M，N，K设置为2000

```cpp
int errCode = gemm(2000, 2000, 2000, 4, 10, my_gpu_queue);
```

然后运行，通过了正确性测试，只是运行时间变长，gemm_basic.sh.o2451918

```textile
Problem size: c(2000,2000) = a(2000,2000) * b(2000,2000)

Performance Flops = 16000000000.000000,
GPU Computation Time = 883.553961 (ms);
CPU Computaiton Time = 2278.809570 (ms);
```

然后将误差判别的值从1e-3改为1e-4，gemm_basic.sh.o2451921

```textile
Problem size: c(2000,2000) = a(2000,2000) * b(2000,2000)

522.520386, 522.520264
512.090027, 512.089905
512.102600, 512.102478
514.565491, 514.565613
521.673340, 521.673218
520.009766, 520.009888
478.700714, 478.700836 
...(后面的略，因为有两千多行，翻到最后面看到运行时间跟上面那个是差不多的)
```

发现此时无法通过正确性测试，对此我提出的方法是修改误差的定义，将误差定义为相对误差，即为(cpu-gpu)/cpu，下面是代码的修改

```cpp
int verify(float *cpu_res, float *gpu_res, int length){
    float tolerance = 1e-4;
    int err = 0;
    for(int i = 0; i < length; i++) {
       float relative_error = fabs((cpu_res[i] - gpu_res[i]) / cpu_res[i]);
       if(relative_error > tolerance) {
          err++;
          printf("\n%lf, %lf", cpu_res[i], gpu_res[i]);
       } 
    }
    return(err);
}
```

修改之后在运行，gemm_basic.sh.o2451929

```textile

########################################################################
#      Date:           Thu Dec 21 09:23:02 AM PST 2023
#    Job ID:           2451929.v-qsvr-1.aidevcloud
#      User:           u209084
# Resources:           cput=75:00:00,neednodes=1:gpu:ppn=2,nodes=1:gpu:ppn=2,walltime=06:00:00
########################################################################


start: 231221.092309.486

Problem size: c(2000,2000) = a(2000,2000) * b(2000,2000)

Performance Flops = 16000000000.000000,
GPU Computation Time = 877.355426 (ms);
CPU Computaiton Time = 2253.382422 (ms);

stop: 231221.092445.270


########################################################################
# End of output for job 2451929.v-qsvr-1.aidevcloud
# Date: Thu Dec 21 09:24:45 AM PST 2023
########################################################################
```

此时可以发现其通过了正确性测试，随后我将误差的判别值逐步往下调，

- 1e-5，gemm_basic.sh.o2451932

- 1e-6，gemm_basic.sh.o2451933

- 1e-7，gemm_basic.sh.o2451935

在1e-7时，此时无法通过正确性测试，对应的文件夹有二十多万行，这里就不放出来了。



如果设立随机数种子的话，误差为1e-6的正确性测试仍然可以通过，-7的不行，这里就不展示了，最终上传到仓库只有在此md中写出文件名的。






