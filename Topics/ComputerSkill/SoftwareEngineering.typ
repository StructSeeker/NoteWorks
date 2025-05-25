

== Absolute Path of Executable 
argv is the shell commandline used to run the process.
argv 是用于运行进程的 shell 命令行。

So no, argv[0] is not guaranteed to be the executable path, it just happens to be most of the time. It can be a relative path from the current working directory, or just the filename of your program if your program is in PATH, or an absolute path to your program, or the name a symlink that points to your program file, maybe there are even more possibilities. It's whatever you typed in the shell to run your program.
所以，argv[0] 不一定是可执行文件路径，只是大多数情况下碰巧是。它可以是当前工作目录的相对路径，或者仅仅是程序的文件名（如果程序在 PATH 中），或者是程序的绝对路径，或者是指向程序文件的符号链接名称，甚至可能还有更多可能性。它是你在 shell 中输入的用于运行程序的内容。

on linux, you can read the /proc/1234/exe symlink to get the executable path, where 1234 is the pid of your process.
在 Linux 上，您可以读取 /proc/1234/exe 符号链接来获取可执行路径，其中 1234 是您的进程的 pid。

on linux, you can read the /proc/self/exe symlink to get the executable path.
在 Linux 上，您可以读取 /proc/self/exe 符号链接来获取可执行文件路径。

on macos, you can use the libproc.h interface, which has the proc_pidpath(int pid, void \*path_out, uint32_t buffersize) method that will give you the executable path of a process.
在 macos 上，您可以使用 libproc.h 接口，该接口具有 proc_pidpath(int pid, void \*path_out, uint32_t buffersize) 方法，可以为您提供进程的可执行路径。

on windows, you can use GetModuleFileNameEx(HANDLE handle, HMODULE module, LPSTR path_out, DWORD buffersize) with a handle of your process to query the executable path. You can get such a handle with OpenProcess(...) GetCurrentProcess(...).
在 Windows 上，您可以使用 GetModuleFileNameEx(HANDLE handle, HMODULE module, LPSTR path_out, DWORD buffersize) 以及进程句柄来查询可执行文件路径。您可以使用 OpenProcess(...) GetCurrentProcess(...) 获取此类句柄。