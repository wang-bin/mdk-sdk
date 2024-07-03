---
name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:

**Expected behavior**
A clear and concise description of what you expected to happen.

**Environment:**
 - OS:
 - GPU: optional

**Log**
Add any other context about the problem here.
```cpp
setLogHandler([&log_file](LogLevel level, const char* msg){
    //write_msg_to_a_file(msg); // it's better to add system time. example: https://github.com/wang-bin/mdk-examples/blob/master/GLFW/prettylog.h
});
```

**Crash**
use lldb, gdb, visual studio to show the call stack.