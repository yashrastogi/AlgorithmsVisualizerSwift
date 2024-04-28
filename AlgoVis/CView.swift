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
        NavigationLink(destination: NQueensVisualizer()) {
          Text("n-Queens Algorithm")
        }
        .font(.title)
        .buttonStyle(.borderedProminent)
        NavigationLink(destination: PathfindingVisualizer()) {
          Text("Pathfinding Algorithms")
        }
        .font(.title)
        .buttonStyle(.borderedProminent)
        NavigationLink(destination: SearchingVisualizer()) {
          Text("Searching Algorithms")
        }
        .font(.title)
        .buttonStyle(.borderedProminent)
      }
      .navigationTitle("Algorithm Visualizer")
    }
    #if os(macOS)
      .frame(minWidth: 350, minHeight: 750)
    #endif
  }
}

#Preview {
  ContentView()
}
