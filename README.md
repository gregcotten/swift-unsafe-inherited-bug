# swift-unsafe-inherited-bug

[Swift Issue](https://github.com/apple/swift/issues/62731)

Passing an actor as a parameter to another actor causes an assertion error:

`Assertion failed: SGF.ExpectedExecutor || SGF.unsafelyInheritsExecutor(), file D:\a\1\s\swift\lib\SILGen\SILGenProlog.cpp, line 880`

Relevant line permalink from `swift` repo: https://github.com/apple/swift/blob/swift-5.7.1-RELEASE/lib/SILGen/SILGenProlog.cpp#L880

Just run on macOS with a swift toolchain built with assertions enabled OR Windows with 5.7.1 or 5.7.2 Release:

`swift build -Xswiftc -DUNSAFE_INHERIT`

and all is well! But if you run:

`swift build` or, to get an understandable error: `swift build --use-integrated-swift-driver`

you get:

```
Building for debugging...
Assertion failed: SGF.ExpectedExecutor || SGF.unsafelyInheritsExecutor(), file D:\a\1\s\swift\lib\SILGen\SILGenProlog.cpp, line 880
Please submit a bug report (https://swift.org/contributing/#reporting-bugs) and include the project and the crash backtrace.
Stack dump:
0.	Program arguments: swift-frontend.exe -emit-module -experimental-skip-non-inlinable-function-bodies-without-types D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\Sources\\swift-unsafe-inherited\\swift_unsafe_inherited.swift -target x86_64-unknown-windows-msvc -disable-objc-interop -sdk C:\\Library\\Developer\\Platforms\\Windows.platform\\Developer\\SDKs\\Windows.sdk -I D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug -I C:\\Library\\Developer\\Platforms\\Windows.platform\\Developer\\Library\\XCTest-development\\usr\\lib\\swift\\windows\\x86_64 -enable-testing -g -module-cache-path D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug\\ModuleCache -swift-version 5 -Onone -D SWIFT_PACKAGE -D DEBUG -empty-abi-descriptor -resource-dir C:\\Library\\Developer\\Toolchains\\unknown-Asserts-development.xctoolchain\\usr\\lib\\swift -enable-anonymous-context-mangled-names -module-name swift_unsafe_inherited -emit-module-doc-path D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug\\swift_unsafe_inherited.swiftdoc -emit-module-source-info-path D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug\\swift_unsafe_inherited.swiftsourceinfo -emit-dependencies-path D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug\\swift_unsafe_inherited.build\\swift_unsafe_inherited.emit-module.d -parse-as-library -o D:\\a\\swift-unsafe-inherited-bug\\swift-unsafe-inherited-bug\\.build\\x86_64-unknown-windows-msvc\\debug\\swift_unsafe_inherited.swiftmodule
1.	compnerd.org Swift version 5.7.2 (swift-5.7.2-RELEASE)
2.	Compiling with the current language version
3.	While evaluating request ASTLoweringRequest(Lowering AST to SIL for module swift_unsafe_inherited)
4.	While silgen constructor initializer SIL function "@$s22swift_unsafe_inherited11ParentActorCACyYacfc".
 for 'init()' (at D:\a\swift-unsafe-inherited-bug\swift-unsafe-inherited-bug\Sources\swift-unsafe-inherited\swift_unsafe_inherited.swift:4:5)
 #0 0x00007ff682d1e195 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x4f2e195)
 #1 0x00007ffb47a5bab4 (C:\Windows\System32\ucrtbase.dll+0x7bab4)
 #2 0x00007ffb47a5ca81 (C:\Windows\System32\ucrtbase.dll+0x7ca81)
 #3 0x00007ffb47a5e451 (C:\Windows\System32\ucrtbase.dll+0x7e451)
 #4 0x00007ffb47a5e691 (C:\Windows\System32\ucrtbase.dll+0x7e691)
 #5 0x00007ff67e5b86b5 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7c86b5)
 #6 0x00007ff67e5e7df6 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7f7df6)
 #7 0x00007ff67e5e148a (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7f148a)
 #8 0x00007ff67e5df738 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7ef738)
 #9 0x00007ff67e5e9280 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7f9280)
#10 0x00007ff67e583204 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x793204)
#11 0x00007ff67e582963 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x792963)
#12 0x00007ff67e579661 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x789661)
#13 0x00007ff67e5746e3 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7846e3)
#14 0x00007ff67e5b45ba (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7c45ba)
#15 0x00007ff67e5b37b6 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7c37b6)
#16 0x00007ff67e5b22e3 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7c22e3)
#17 0x00007ff67e532630 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x742630)
#18 0x00007ff67e52643b (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x73643b)
#19 0x00007ff67e528ea9 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x738ea9)
#20 0x00007ff67e524da4 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x734da4)
#21 0x00007ff67e560bb7 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x770bb7)
#22 0x00007ff67e55c7fb (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x76c7fb)
#23 0x00007ff67e561788 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x771788)
#24 0x00007ff67e5290c1 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7390c1)
#25 0x00007ff67e529b12 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x739b12)
#26 0x00007ff67e52fe98 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x73fe98)
#27 0x00007ff67e5204d3 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x7304d3)
#28 0x00007ff67e52e4d1 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x73e4d1)
#29 0x00007ff67dee6c15 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0xf6c15)
#30 0x00007ff67dee59c3 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0xf59c3)
#31 0x00007ff67dee8283 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0xf8283)
#32 0x00007ff67de7d854 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x8d854)
#33 0x00007ff67de7d392 (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x8d392)
#34 0x00007ff682d841bc (C:\Library\Developer\Toolchains\unknown-Asserts-development.xctoolchain\usr\bin\swift-frontend.exe+0x4f941bc)
#35 0x00007ffb492d4de0 (C:\Windows\System32\KERNEL32.DLL+0x14de0)
#36 0x00007ffb49f3e40b (C:\Windows\SYSTEM32\ntdll.dll+0x7e40b)
[0/2] Emitting module for swift_unsafe_inherited
##[error]Process completed with exit code 1.
```
