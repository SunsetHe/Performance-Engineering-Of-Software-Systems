import subprocess

# 编译C程序
compile_command = ["gcc", "MatrixMultiplication.c", "-o", "matrix_multiplication", "-O"]
compile_process = subprocess.Popen(compile_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
compile_output, compile_error = compile_process.communicate()

# 检查编译是否成功
if compile_process.returncode == 0:
    print("编译成功。")

    # 运行编译后的程序
    run_command = ["./matrix_multiplication", "32"]  # 32是分块大小，你可以根据需要修改
    run_process = subprocess.Popen(run_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    run_output, run_error = run_process.communicate()

    # 输出运行结果
    print("运行输出：")
    print(run_output.decode("utf-8"))

    # 检查运行是否成功
    if run_process.returncode == 0:
        print("程序成功运行。")
    else:
        print("程序运行出错：")
        print(run_error.decode("utf-8"))
else:
    print("编译出错：")
    print(compile_error.decode("utf-8"))
