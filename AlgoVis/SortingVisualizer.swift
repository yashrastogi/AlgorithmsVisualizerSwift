import SwiftUI

let SIZE_OF_BOARD = 15
let UPDATE_DELAY: UInt32 = 500

struct SortingVisualizer: View {
  let matrixSize = SIZE_OF_BOARD * SIZE_OF_BOARD
  @State var matrix: [Double] = []
  @State var sortingAlgo = "Insertion Sort"
  var sortingAlgos = ["Bubble Sort", "Insertion Sort"]
  @State var selectedColor = Int.random(in: 0...2)
  @State var isSorting = false

  init() {
    _matrix = State(initialValue: generateMatrix())
  }

  func generateMatrix() -> [Double] {
    let step = 1.0 / Double(matrixSize)
    return (0..<matrixSize).map { Double($0) * step }.shuffled()
  }

  func rectangleColor(_ i: Int, _ j: Int) -> Color {
    var rgb = Array(repeating: 0.0, count: 3)
    rgb[selectedColor] = matrix[(i * SIZE_OF_BOARD) + j]
    return Color(red: rgb[0], green: rgb[1], blue: rgb[2])
  }

  func sortMatrix() {
    isSorting = true
    DispatchQueue.global().async {
      switch sortingAlgo {
      case "Insertion Sort": insertionSort()
      default: bubbleSort()
      }
      isSorting = false
    }
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        HStack {
          Button(action: {
            matrix = generateMatrix()
            selectedColor = Int.random(in: 0...2)
          }) {
            Text("Reset")
          }
          .disabled(isSorting)

          Picker("", selection: $sortingAlgo) {
            ForEach(sortingAlgos, id: \.self) { item in
              Text(item)
            }
          }.labelsHidden().disabled(isSorting)

          Button(action: {
            sortMatrix()
          }) {
            Text("Sort")
          }
          .disabled(isSorting)
        }
        VStack(spacing: 0) {
          ForEach(0..<SIZE_OF_BOARD, id: \.self) { row in
            HStack(spacing: 0) {
              ForEach(0..<SIZE_OF_BOARD, id: \.self) { column in
                RoundedRectangle(cornerRadius: 0)
                  .aspectRatio(1, contentMode: .fit)
                  .foregroundColor(rectangleColor(row, column))
              }
            }
          }
        }.cornerRadius(8)
      }
      .padding()
      .navigationTitle("Sorting Algorithms")
    }
  }
}

#Preview {
  SortingVisualizer()
    .frame(width: 350, height: 550)
}
