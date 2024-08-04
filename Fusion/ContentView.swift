//
//  ContentView.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var game = Game()

    /// Our name space for matched geometry effects.
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 2) {
            ForEach(Array(game.board.contents.enumerated()), id: \.offset) { row in
                HStack(spacing: 2) {
                    ForEach(Array(row.element.enumerated()), id: \.offset) { column in
                        let value = String(game.board[row.offset, column.offset].value)
                        Text(value == "0" ? "" : value)
                            .padding()
                            .background(value == "0" ? .clear : color(for: game.board[row.offset, column.offset].value), in: RoundedRectangle(cornerRadius: 8))
                            .frame(width: 75, height: 75)
                            // Make it a "container."
                            .clipped()
                            .scaleEffect(1)
                            // Rough animation support.
                            .id(game.board[row.offset, column.offset].id)
                            .matchedGeometryEffect(id: game.board[row.offset, column.offset].id, in: namespace)
                            // The underlying background.
                            .padding(4)
                            .background(.gray.opacity(0.2))
                    }
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                withAnimation(.linear(duration: 0.1)) {
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        game.swiped(towards: .leading)
                    case (0..., -30...30):
                        game.swiped(towards: .trailing)
                    case (-100...100, ...0):
                        game.swiped(towards: .top)
                    case (-100...100, 0...):
                        game.swiped(towards: .bottom)
                    default:
                        break
                    }
                }
            }
        )
        .alert(game.state.title, isPresented: $game.showAlert, actions: {
            Button("Play Again", action: {
                game.restart()
            })
        }, message: {
            Text(game.state.message)
        })
    }

    func color(for int: Int) -> Color {
        switch int {
        case 2:
                .purple.opacity(0.2)
        case 4:
                .blue.opacity(0.2)
        case 8:
                .green.opacity(0.2)
        case 16:
                .purple.opacity(0.5)
        case 32:
                .blue.opacity(0.5)
        case 64:
                .green.opacity(0.5)
        case 128:
                .purple.opacity(0.8)
        default:
                .gray.opacity(0.2)
        }
    }
}

#Preview("Game Start") {
    ContentView()
}
