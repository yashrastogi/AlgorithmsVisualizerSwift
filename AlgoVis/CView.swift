//
//  CView.swift
//  AlgoVis
//
//  Created by Yash on 26/04/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      VStack(spacing: 30) {
        NavigationLink(destination: SortingVisualizer()) {
          Text("Sorting Algorithms")
        }
        .font(.title)
        .buttonStyle(.borderedProminent)
      }
      .navigationTitle("Algorithm Visualizer")
    }
    #if os(macOS)
      .frame(width: 350, height: 550)
    #endif
    .padding()
  }
}

#Preview {
  ContentView()
}
