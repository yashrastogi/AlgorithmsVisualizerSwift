import SwiftUI

let SIZE_OF_BOARD = 25

struct SortingVisualizer: View {
    @State var matrix: [[Double]] = []
    @State var selectedColor = Int.random(in: 0 ... 2)
    
    init() {
        _matrix = State(initialValue: generateMatrix())
    }
    
    func generateMatrix() -> [[Double]] {
        let step = 1.0 / Double(SIZE_OF_BOARD * SIZE_OF_BOARD)
        let flatMatrix = (0 ..< (SIZE_OF_BOARD * SIZE_OF_BOARD)).map { Double($0) * step }.shuffled()
        return stride(from: 0, to: SIZE_OF_BOARD * SIZE_OF_BOARD, by: SIZE_OF_BOARD).map { offset in
            Array(flatMatrix[offset ..< (offset + SIZE_OF_BOARD)])
        }
    }
    
    func rectangleColor(_ value: Double) -> Color {
        var rgb = [0.0, 0.0, 0.0]
        rgb[selectedColor] = value
        return Color(red: rgb[0], green: rgb[1], blue: rgb[2])
    }
    
    func sortMatrix(_ i: Int = 0, _ j: Int = 0) {
        guard i < SIZE_OF_BOARD * SIZE_OF_BOARD else { return }
        let rowI = i / SIZE_OF_BOARD, colI = i % SIZE_OF_BOARD
        let rowJ = j / SIZE_OF_BOARD, colJ = j % SIZE_OF_BOARD
        if matrix[rowI][colI] > matrix[rowJ][colJ] {
            let temp = matrix[rowI][colI]
            matrix[rowI][colI] = matrix[rowJ][colJ]
            matrix[rowJ][colJ] = temp
            DispatchQueue.main.async {
                sortMatrix(j + 1 == SIZE_OF_BOARD * SIZE_OF_BOARD ? i + 1 : i, (j + 1) % (SIZE_OF_BOARD * SIZE_OF_BOARD))
            }
        } else {
            sortMatrix(j + 1 == SIZE_OF_BOARD * SIZE_OF_BOARD ? i + 1 : i, (j + 1) % (SIZE_OF_BOARD * SIZE_OF_BOARD))
        }
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Button(action: { matrix = generateMatrix(); selectedColor = Int.random(in: 0 ... 2) }) {
                    Text("Reset")
                }
                
                Button(action: { sortMatrix() }) {
                    Text("Sort")
                }
            }
            VStack(spacing: 0) {
                ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { column in
                            RoundedRectangle(cornerRadius: 0)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(rectangleColor(matrix[row][column]))
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
