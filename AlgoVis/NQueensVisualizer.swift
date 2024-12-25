//
//  NQueensVisualizer.swift
//  AlgoVis
//
//  Created by Yash on 27/04/24.
//

import SwiftUI

struct NQueensVisualizer: View {
    let SIZE_OF_BOARD = 5
    let UPDATE_DELAY: UInt32 = 250_000
    let selectedColor = Int.random(in: 0 ... 2)
    var defaultMatrix: [[Bool]] {
        return Array(repeating: Array(repeating: false, count: SIZE_OF_BOARD), count: SIZE_OF_BOARD)
    }

    @State var matrix: [[Bool]] = []
    @State var isRunning = false
    @State var statusUpdates: [String] = []

    init() {
        _matrix = State(initialValue: defaultMatrix)
    }

    func runNQueens() {
        isRunning = true
        DispatchQueue.global().async {
            nQueens()
            isRunning = false
            statusUpdates.insert("Successfully placed all queens.", at: 0)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Button(action: {
                        matrix = defaultMatrix
                        statusUpdates = []
                    }) {
                        Text("Reset")
                    }
                    .disabled(isRunning)

                    Button(action: {
                        runNQueens()
                    }) {
                        Text("Start")
                    }
                    .disabled(isRunning)
                }
                VStack(spacing: 0) {
                    ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { col in
                                RoundedRectangle(cornerRadius: 20)
                                    .aspectRatio(1, contentMode: .fit)
                                    .border(.white, width: 2)
                                    .foregroundColor(.black)
                                    .overlay(
                                        matrix[row][col] ? Image(.queenPiece).resizable().scaledToFit() : nil
                                    )
                            }
                        }
                    }
                }
                .cornerRadius(8)
                .frame(maxHeight: 700)
                Text(statusUpdates.joined(separator: "\n"))
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .padding()
            .navigationTitle("n-Queens Algorithm")
        }
    }
}

#Preview {
    NQueensVisualizer()
}
