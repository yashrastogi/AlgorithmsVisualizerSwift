import SwiftUI

let SIZE_OF_BOARD = 25
let UPDATE_DELAY: UInt32 = 100

struct SortingVisualizer: View {
    private let matrixSize = SIZE_OF_BOARD * SIZE_OF_BOARD
    @State private var matrix: [Double] = []
    @State private var sortingAlgo = "Insertion Sort"
    private var sortingAlgos = ["Bubble Sort", "Insertion Sort"]
    @State private var selectedColor = Int.random(in: 0 ... 2)
    @State private var isSorting = false

    init() {
        _matrix = State(initialValue: generateMatrix())
    }

    func generateMatrix() -> [Double] {
        let step = 1.0 / Double(matrixSize)
        return (0 ..< matrixSize).map { Double($0) * step }.shuffled()
    }

    func rectangleColor(_ i: Int, _ j: Int) -> Color {
        var rgb = Array(repeating: 0.0, count: 3)
        rgb[selectedColor] = matrix[(i * SIZE_OF_BOARD) + j]
        return Color(red: rgb[0], green: rgb[1], blue: rgb[2])
    }

    func insertionSort() {
        var left = 0
        for i in 1 ..< matrixSize {
            if matrix[i - 1] > matrix[i] {
                let temp = matrix[i]
                matrix[i] = matrix[i - 1]
                matrix[i - 1] = temp
                left += 1
                // add a delay to see updates in progress
                usleep(UPDATE_DELAY)
                for j in stride(from: left - 1, to: 0, by: -1) {
                    if matrix[j - 1] > matrix[j] {
                        let temp = matrix[j]
                        matrix[j] = matrix[j - 1]
                        matrix[j - 1] = temp
                        // add a delay to see updates in progress
                        usleep(UPDATE_DELAY)
                    }
                }
            } else {
                left += 1
            }
        }
    }

    func bubbleSort() {
        for i in 0 ..< matrixSize {
            for j in i + 1 ..< matrixSize {
                if matrix[i] > matrix[j] {
                    let temp = matrix[i]
                    matrix[i] = matrix[j]
                    matrix[j] = temp
                    // add a delay to see updates in progress
                    usleep(UPDATE_DELAY)
                }
            }
        }
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
        ScrollView {
            HStack {
                Button(action: {
                    matrix = generateMatrix()
                    selectedColor = Int.random(in: 0 ... 2)
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
                ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { column in
                            RoundedRectangle(cornerRadius: 0)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(rectangleColor(row, column))
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SortingVisualizer()
        .frame(width: 350, height: 550)
}
