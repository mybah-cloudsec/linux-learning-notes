# Day 5 — Memory Management

## Physical and Virtual Memory

Linux manages both physical memory (RAM) and virtual memory.

### Virtual Memory
For better flexibility, Linux uses a virtual memory system.
Each process has its own virtual address space — giving it the
illusion of having access to all system memory.

This virtual memory is then mapped to physical memory via an
internal mechanism managed by the kernel.

---

## Performance Monitoring Tools

### vmstat — Virtual Memory Statistics
$ vmstat

Shows in real time :
- Processes (r = running)
- Memory (free)
- Swap usage
- I/O (buff / cache)
- CPU (si / so)

$ vmstat -r 1 3
(runs every 1 second, 3 times — System Activity Reporter)

---

### sar — System Activity Reporter
$ sar -r 1 3
Detailed system activity : CPU, memory, I/O over time

---

## Deep Analysis — Memory Leak Detection

### Valgrind
Tool to deeply analyze programs and detect :
- Memory leaks
- Allocation / liberation errors
- Invalid memory accesses

---

*What I understood :*
Each process thinks it has access to all memory — that is virtual
memory. The kernel handles the real mapping to RAM. vmstat gives
a quick snapshot of system health in real time.
