import OSLog

// A convenience constructor to allow creating [Logger] instances without having to include the [subsystem] parameter at every call site.
extension Logger {
    init(category: String) {
        self = Logger(
            subsystem: "com.abn.amro",
            category: category
        )
    }
}
