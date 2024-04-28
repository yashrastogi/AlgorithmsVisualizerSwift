import SwiftUI

struct SortingVisualizer: View {
  let SIZE_OF_BOARD = 10
  let UPDATE_DELAY: UInt32 = 9000
  var matrixSize: Int {
    return SIZE_OF_BOARD * SIZE_OF_BOARD
  }
  var sortingAlgos = ["Bubble Sort", "Insertion Sort"]
  @State var matrix: [Double] = []
  @State var sortingAlgo = "Insertion Sort"
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
    let colorVal = matrix[(i * SIZE_OF_BOARD) + j]
    return Color(
      red: selectedColor == 0 ? colorVal : 0.0,
      green: selectedColor == 1 ? colorVal : 0.0,
      blue: selectedColor == 2 ? colorVal : 0.0)
  }

  func sortMatrix() {
    isSorting = true
    DispatchQueue.global().async {
      switch sortingAlgo {
      case sortingAlgos[1]: insertionSort()
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
            Text("Sort  ")
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
        }
        .cornerRadius(8)
        SpaceTimeComplexityTable()
      }
      .padding()
      .navigationTitle("Sorting Algorithms")
    }
  }
}

struct SpaceTimeComplexityTable: View {
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Algorithm")
          .frame(maxWidth: .infinity, alignment: .leading)
        VStack {
          Text("Time Complexity")
            .frame(maxWidth: .infinity, alignment: .center)
          HStack(spacing: 40) {
            Text("Best")
              .frame(maxWidth: .infinity, alignment: .center)
              .font(.system(size: 11))
            Text("Worst")
              .frame(maxWidth: .infinity, alignment: .center)
              .font(.system(size: 11))
          }
        }
        Text("Space Complexity")
          .frame(maxWidth: .infinity, alignment: .center)
      }
      HStack {
        Text("Bubble Sort")
          .frame(maxWidth: .infinity, alignment: .leading)
        HStack(spacing: 40) {
          Text("N")
            .frame(maxWidth: .infinity, alignment: .center)
          Text("N²")
            .frame(maxWidth: .infinity, alignment: .center)
        }
        Text("N")
          .frame(maxWidth: .infinity, alignment: .center)
      }
      HStack {
        Text("Insertion Sort")
          .frame(maxWidth: .infinity, alignment: .leading)
        HStack(spacing: 40) {
          Text("N")
            .frame(maxWidth: .infinity, alignment: .center)
          Text("N²")
            .frame(maxWidth: .infinity, alignment: .center)
        }
        Text("N")
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
    .padding()
  }
}

#Preview {
  SortingVisualizer()
}
