//
//  ScreenTest.swift
//  SportTimer
//
//  Created by dleegan on 23/10/2023.
//

import SwiftUI

struct ScreenTest: View {
    @State var prepare: Int? = 0
    @State var prepare2: Int? = 0
    
    var body: some View {

        
        List {
            ForEach(1..<10) { acti in
                Button(action: {
                    print("\(String(describing: index))")
                }, label: {
                    HStack {
                        Text("\(acti)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(acti) ee")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                })
                .tint(.primary)
                .listRowBackground(acti == 4 ? Color(white: 1, opacity: 0.2) : nil)
        }
        }
    }
}

#Preview {
    ScreenTest()
}
