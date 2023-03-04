# Anyolite crash repro

## Requirements

* `wrk`
* `crystal`
* Anyolite dependencies (rake, etc)

## Tested against

* crystal 1.7.2
* anyolite git ref efe3337

## Instructions

* `shards install`
* `crystal run ./repro.cr`
* In another shell, `wrk -c 50 -d 10 -t 10 --latency http://localhost:8080/`
  * May not fail on first run
* On M1X Macbook Pro, arm64, it crashes sooner or later with:

```
Invalid memory access (signal 11) at address 0x0
[0x1042f4d80] *Exception::CallStack::print_backtrace:Nil +104 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1042a93c8] ~procProc(Int32, Pointer(LibC::SiginfoT), Pointer(Void), Nil)@/opt/homebrew/Cellar/crystal/1.7.2/share/crystal/src/signal.cr:127 +320 in 
/Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1a8f2c2a4] _sigtramp +56 in /usr/lib/system/libsystem_platform.dylib
[0x104481068] mrb_vm_exec +10496 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x10447e608] mrb_vm_run +148 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1044d5ea4] mrb_load_exec +880 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x10446b3e4] execute_script_line +80 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x104413658] *Anyolite::RbInterpreter#execute_script_line<String>:struct.Anyolite::RbCore::RbValue +124 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1042dfa10] ~procProc(HTTP::Server::Context, Nil)@src/bouncer.cr:20 +60 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x10442bba4] *HTTP::Server::RequestProcessor#process<IO+, IO+>:Nil +880 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x10442a700] *HTTP::Server#handle_client<IO+>:Nil +1756 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1042e0364] ~procProc(Nil)@/opt/homebrew/Cellar/crystal/1.7.2/share/crystal/src/http/server.cr:468 +32 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x104354d3c] *Fiber#run:(IO::FileDescriptor | Nil) +84 in /Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
[0x1042a8ec4] ~proc2Proc(Fiber, (IO::FileDescriptor | Nil))@/opt/homebrew/Cellar/crystal/1.7.2/share/crystal/src/fiber.cr:98 +12 in 
/Users/chendo/.cache/crystal/crystal-run-bouncer.tmp
```

## Notes

* Could not reproduce on amd64 (inside Rosetta-enabled Docker container)
* On a successful run on my M1X Macbook Pro, I can get 53k requests per second!!
