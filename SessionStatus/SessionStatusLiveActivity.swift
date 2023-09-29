//
//  SessionStatusLiveActivity.swift
//  SessionStatus
//
//  Created by dleegan on 29/09/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SessionStatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SessionStatusLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionStatusAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        Spacer()
                        Text("Bottom \(context.state.emoji)")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.red)
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SessionStatusAttributes {
    fileprivate static var preview: SessionStatusAttributes {
        SessionStatusAttributes(name: "World")
    }
}

extension SessionStatusAttributes.ContentState {
    fileprivate static var smiley: SessionStatusAttributes.ContentState {
        SessionStatusAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SessionStatusAttributes.ContentState {
         SessionStatusAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SessionStatusAttributes.preview) {
   SessionStatusLiveActivity()
} contentStates: {
    SessionStatusAttributes.ContentState.smiley
    SessionStatusAttributes.ContentState.starEyes
}
