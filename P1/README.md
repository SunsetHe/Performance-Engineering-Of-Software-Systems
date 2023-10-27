# P1

------------------

## 配置读入

---------------------------------

配置文件保存在**configuration.txt**，要修改对应的超参数组合可以在该文件中修改

```
MatrixMultiplication.c
8,16,32,64,128
O0,O1,O2,O3
GS
//第一行为目标程序
//第二行为循环分块大小
//第三为编译优化级别
//第四行为参数值搜索算法，GS为Grid Search，RS为Random Search
```

接下来在python中读入配置

```python
print('###################################')

print('正在读取配置文件configuration.txt')
print('请确保目标程序在本程序同一目录下')

# 从configuration.txt文件中读取配置信息
with open("configuration.txt", "r", encoding='utf-8') as file:
    lines = file.read().splitlines()

# 分别读取每一行并存储为相应的变量
target_program = lines[0]
block_sizes = lines[1].split(",")
optimization_levels = lines[2].split(",")
parameter_search_algorithm = lines[3]

print('读取成功')
print('###################################')
```

-----------------------------

## Grid Search

-----------------------------------

```python
if parameter_search_algorithm == 'GS':

    print('执行Grid Search')
    print('###################################')

    best_configuration = None
    best_runtime = float('inf')

    for block_size in block_sizes:
        for optimization_level in optimization_levels:
            print('当前配置')
            print('循环分块大小 ', block_size)
            print('编译优化级别 ', optimization_level)

            # 编译C程序
            compile_command = ["gcc", target_program, "-o", "matrix_multiplication", f"-{optimization_level}", "-std=c99"]

            compile_process = subprocess.Popen(compile_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            compile_output, compile_error = compile_process.communicate()

            # 检查编译是否成功
            if compile_process.returncode == 0:
                print("编译成功")

                # 运行编译后的程序
                run_command = ["./matrix_multiplication", block_size]  # 分块大小，可以根据需要修改
                run_process = subprocess.Popen(run_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                run_output, run_error = run_process.communicate()

                # 输出运行结果
                print("运行结果：")
                print(run_output.decode("utf-8"))

                # 检查运行是否成功
                if run_process.returncode == 0:
                    print("程序成功运行")

                    # 将程序输出解析为浮点数，作为运行时间
                    try:
                        runtime = float(run_output.decode("utf-8"))
                        print(f"运行时间: {runtime:.6f} 秒")

                        # 如果当前配置的运行时间更短，更新最佳配置
                        if runtime < best_runtime:
                            best_runtime = runtime
                            best_configuration = (block_size, optimization_level)
                    except ValueError:
                        print("无法解析运行时间")
                else:
                    print("程序运行出错")
                print('###################################')
            else:
                print("编译失败")
                print(compile_error.decode("utf-8"))
                print('###################################')

    if best_configuration is not None:
        print('最优配置:')
        print('循环分块大小', best_configuration[0])
        print('编译优化级别', best_configuration[1])
        print('最佳运行时间:', best_runtime)
    else:
        print('没有找到最优配置')
```

**以下为全部参数的运行时间，单位为秒**

| 分块大小\优化等级 | O0     | O1    | O2    | O3    |
|:---------:|:------:|:-----:|:-----:|:-----:|
| 8         | 281.59 | 82.05 | 83.92 | 65.18 |
| 16        | 270.27 | 56.80 | 56.10 | 46.86 |
| 32        | 259.74 | 46.24 | 43.53 | 32.89 |
| 64        | 256.56 | 45.64 | 42.63 | 25.52 |
| 128       | 254.21 | 46.61 | 43.69 | 22.23 |

**grid search找的最优超参数组合为O3，128**

### 分析

从横向来看，O3级别是最快的，是因为O3编译优化级别包括了更多的优化，包括循环展开、向量化等，这些优化可以提高程序的性能。而O0是最慢的，它执行最少的编译优化，但是据说在编译速度上会更快一些。

从纵向上来看，分块大小提高减小了程序运行时间，但是减少的并不多，可以减少运行时间的原因可能是因为可以更好地利用缓存，并且减少了循环迭代的次数，从而提高了计算效率。

------------------------

## Random Search

----------------

**随机搜索，随机搜索10组超参数，最后得出十个超参数组合中的最优组合**

```python
if parameter_search_algorithm == 'RS':

    print('执行Random Search')
    print('###################################')

    num_random_configs = 10  # 设置生成的随机配置数量

    best_configuration = None
    best_runtime = float('inf')

    for i in range(num_random_configs):
        block_size = random.choice(block_sizes)
        optimization_level = random.choice(optimization_levels)
#略
```

---------------------

## 两种方法对比

----------------------

明显的，grid search需要遍历全部的超参数组合，运行代码需要大量时间和计算资源，但是可以找到全局最优组合。

而随机搜索只搜索固定的组合数，甚至这些组合中有概率重复，这种方法只能找到一个比较好的方法，而不是最好的，优点则是可以花费更少的时间以及计算资源。


