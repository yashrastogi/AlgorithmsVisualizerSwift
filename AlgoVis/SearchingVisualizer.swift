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
  let ROW_SIZE = 12
  let searchingAlgos = ["Linear Search", "Binary Search"]
  @State var searchingAlgo = "Linear Search"
  @State var matrix: [Int] = []
  @State var searchNum: String = ""
  @State var isSearching = false

  init() {
    _matrix = State(initialValue: generateMatrix())
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
    DispatchQueue.global().async {
      switch searchingAlgo {
      case searchingAlgos[1]: binarySearch(searchNum)
      default: linearSearch(searchNum)
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

          TextField("Search number", text: $searchNum)
            .frame(width: 150)
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
            .border( /*@START_MENU_TOKEN@*/Color.black /*@END_MENU_TOKEN@*/.opacity(0.1))
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
          .disabled(isSearching)
        }
        VStack(spacing: 0) {
          ForEach(0..<((ARR_SIZE / ROW_SIZE) + (ARR_SIZE % ROW_SIZE == 0 ? 0 : 1)), id: \.self) {
            row in
            HStack(spacing: 0) {
              ForEach(0..<ROW_SIZE, id: \.self) { column in
                RoundedRectangle(cornerRadius: 0)
                  .aspectRatio(1, contentMode: .fit)
                  .foregroundColor(row * ROW_SIZE + column < ARR_SIZE ? .black : .white)
                  .overlay(
                    row * ROW_SIZE + column < ARR_SIZE
                      ? Text("\(matrix[row * ROW_SIZE + column])").colorInvert() : nil
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
