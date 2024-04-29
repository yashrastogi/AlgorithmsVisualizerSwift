//
//  SearchingVisualizer.swift
//  AlgoVis
//
//  Created by Yash on 27/04/24.
//

import Combine
import SwiftUI

struct SearchingVisualizer: View {
  let ARR_SIZE = 48
  let UPDATE_DELAY: UInt32 = 250000
  var ROW_SIZE: Int = 5
  let searchingAlgos = ["Linear Search", "Binary Search"]
  @State var searchingAlgo = "Linear Search"
  @State var matrix: [Int] = []
  @State var searchNum: String = ""
  @State var isSearching = false
  @State var highlightCell: (Set<Int>, Int) = ([0], 0)  // ([indices], color)
  @State var showingAlert = false

  init() {
    _matrix = State(initialValue: generateMatrix())
    #if os(macOS)
      let screenWidth = NSScreen.main?.visibleFrame.width ?? 0
    #else
      let screenWidth = UIScreen.main.bounds.width
    #endif
    ROW_SIZE = Int(screenWidth) / 50
  }

  func generateMatrix() -> [Int] {
    var matrix: [Int] = Array(repeating: 0, count: ARR_SIZE)
    var randomSet = Set<Int>()
    for i in 0..<matrix.count {
      var temp = 0
      repeat {
        temp = Int.random(in: 1...max(999, ARR_SIZE))
      } while randomSet.contains(temp)
      matrix[i] = temp
      randomSet.insert(temp)
    }
    return matrix
  }

  func searchMatrix(_ searchNum: Int) {
    isSearching = true
    highlightCell.0 = [0]
    DispatchQueue.global().async {
      switch searchingAlgo {
      case searchingAlgos[1]:
        showingAlert = true
        binarySearch(searchNum)
      default:
        linearSearch(searchNum)
      }
      isSearching = false
    }
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        HStack {
          Button(action: {
            matrix = generateMatrix()
            highlightCell = ([0], 0)
          }) {
            Text("Reset")
          }
          .disabled(isSearching)

          Picker("", selection: $searchingAlgo) {
            ForEach(searchingAlgos, id: \.self) { item in
              Text(item)
            }
          }
          .labelsHidden().disabled(isSearching)
        }

        HStack {
          TextField("Search number", text: $searchNum)
            .frame(width: 150)
            .textFieldStyle(.roundedBorder)
            .border(Color.black.opacity(0.1))
            // .keyboardType(.numberPad)
            .onReceive(Just(searchNum)) { newValue in
              let filtered = newValue.filter { "0123456789".contains($0) }
              if filtered != newValue { searchNum = filtered }
            }

          Button(action: {
            if let searchNumInt = Int(searchNum) {
              searchMatrix(searchNumInt)
            }
          }) {
            Text("Search")
          }
          //          .alert("Array will be sorted first for binary search", isPresented: $showingAlert) {
          //            Button("OK", role: .cancel) {}
          //          }
          .disabled(isSearching)
        }

        VStack(spacing: 0) {
          ForEach(0..<((ARR_SIZE / ROW_SIZE) + (ARR_SIZE % ROW_SIZE == 0 ? 0 : 1)), id: \.self) {
            row in
            HStack(spacing: 0) {
              ForEach(0..<ROW_SIZE, id: \.self) { column in
                let idx = row * ROW_SIZE + column
                RoundedRectangle(cornerRadius: 0)
                  .aspectRatio(1, contentMode: .fit)
                  .overlay(
                    idx < ARR_SIZE || highlightCell.0.contains(idx)
                      ? Text("\(matrix[idx])").foregroundColor(.white) : nil
                  )
                  .foregroundColor(
                    (idx < ARR_SIZE
                      ? (highlightCell.0.contains(idx)
                        ? (highlightCell.1 == 0 ? .red : .green)
                        : .black)
                      : .white)
                  )
              }
            }
          }
        }
        .cornerRadius(8)
        .frame(maxHeight: 700)
      }
      .padding()
      .navigationTitle("Searching Algorithms")
    }
  }
}

#Preview {
  SearchingVisualizer()
}
