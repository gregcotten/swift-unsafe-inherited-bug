# swift-unsafe-inherited-bug

Passing an actor as a parameter to another actor causes an assertion error:

`Assertion failed: SGF.ExpectedExecutor || SGF.unsafelyInheritsExecutor(), file D:\a\1\s\swift\lib\SILGen\SILGenProlog.cpp, line 880`

Relevant line permalink from `swift` repo: https://github.com/apple/swift/blob/swift-5.7.1-RELEASE/lib/SILGen/SILGenProlog.cpp#L880

Just run on macOS with a swift toolchain built with assertions enabled OR Windows with 5.7.1 or 5.7.2 Release:

`swift build -Xswiftc -DUNSAFE_INHERIT`

and all is well! But if you run:

`swift build` or, to get an understandable error: `swift build --use-integrated-swift-driver`

you get:

(PLACEHOLDER ERROR DUMP)