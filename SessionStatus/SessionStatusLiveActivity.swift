//
//  SessionStatusLiveActivity.swift
//  SessionStatus
//
//  Created by dleegan on 30/09/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SessionStatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var emoji: String
        var counter: Int
        var stepName: String
    }

    // Fixed non-changing properties about your activity go here!
//    var name: String
}

struct SessionStatusLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionStatusAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("\(context.state.counter)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("\(context.state.stepName)")
                    .font(.title)
            }
            .padding()
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.stepName): \(context.state.counter)")
                    // more content
                }
            } compactLeading: {
                Text("")
            } compactTrailing: {
                Text("\(context.state.counter)")
            } minimal: {
                Text("\(context.state.counter)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//extension SessionStatusAttributes {
//    fileprivate static var preview: SessionStatusAttributes {
//        SessionStatusAttributes(name: "World")
//    }
//}
//
//extension SessionStatusAttributes.ContentState {
//    fileprivate static var smiley: SessionStatusAttributes.ContentState {
//        SessionStatusAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: SessionStatusAttributes.ContentState {
//         SessionStatusAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//#Preview("Notification", as: .content, using: SessionStatusAttributes.preview) {
//   SessionStatusLiveActivity()
//} contentStates: {
//    SessionStatusAttributes.ContentState.smiley
//    SessionStatusAttributes.ContentState.starEyes
//}
