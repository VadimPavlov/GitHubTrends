//
//  LoadingView.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import SwiftUI
import Utilities

public struct LoadingView<J, V: View>: View {
    public init(job: Job<J>, retry: String? = nil, @ViewBuilder content: @escaping (J?) -> V) {
        self.job = job
        self.retry = retry
        self.content = content
    }
        
    @ObservedObject var job: Job<J>
    let retry: String?
    let content: (J?) -> V

    public var body: some View {
        if job.isRunning {
            ProgressView("Loading...")
        } else {
            switch job.result {
            case .success(let result):
                content(result)
            case .failure(let error):
                if let retry = retry {
                    VStack {
                        Text(retry + ":").bold()
                        Text(error.localizedDescription).multilineTextAlignment(.center)
                        Button(action: { job.reload() }) {
                            Image(systemName: "arrow.clockwise")
                        }.padding(.top)

                    }
                } else {
                    content(nil)
                }
            default:
                content(nil)
            }
        }
    }
}

//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        //LoadingView(job: <#T##<<error type>>#>)
//    }
//}
