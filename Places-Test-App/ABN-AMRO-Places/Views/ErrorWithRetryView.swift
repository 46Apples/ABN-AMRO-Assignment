import SwiftUI

struct ErrorWithRetryView: View {
    private let action: () -> Void
    
    // Specify the action to be invoked when the [Retry] button is pressed.
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Text("Oops! Something went wrong")
            .padding()
        
        Button("Retry") {
            // Invoke the specified [retry] action when the button is pressed.
            action()
        }
        .padding()
    }
}

#Preview {
    ErrorWithRetryView {
        print("\(#function)")
    }
}
