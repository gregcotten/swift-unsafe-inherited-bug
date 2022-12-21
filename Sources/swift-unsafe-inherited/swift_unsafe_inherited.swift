actor ParentActor: ChildActorDelegate {
    let child: ChildActor

    init() async {
        child = ChildActor()
        await child.setActorDelegate(self)
    }
}

protocol ChildActorDelegate: Actor {}
actor ChildActor {
    weak var delegate: ChildActorDelegate?

    init() {}

    #if UNSAFE_INHERIT
    @_unsafeInheritExecutor
    func setActorDelegate(_ delegate: ChildActorDelegate) {
        self.delegate = delegate
    }
    #else
    func setActorDelegate(_ delegate: ChildActorDelegate) {
        self.delegate = delegate
    }
    #endif

}
