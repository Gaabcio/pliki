from time import time_ns
from typing import Optional, Tuple, List


class TicTacToe:
    def __init__(self):
        self.board: List[List[Optional[str]]] = [[None] * 4 for _ in range(4)]
        self.max_initial_depth = 3

    def is_game_over(self) -> bool:
        return self.get_winner() is not None or all(cell is not None for row in self.board for cell in row)

    def get_winner(self) -> Optional[str]:
        lines = []

        for i in range(4):
            lines.append(self.board[i])  # wiersz
            lines.append([self.board[r][i] for r in range(4)])  # kolumna

        # przekątne główne
        lines.append([self.board[i][i] for i in range(4)])
        lines.append([self.board[i][3 - i] for i in range(4)])

        # dodatkowe przekątne 4-elementowe
        for r in range(1):
            for c in range(1):
                diag1 = [self.board[r + i][c + i] for i in range(4)]
                diag2 = [self.board[r + i][c + 3 - i] for i in range(4)]
                lines.extend([diag1, diag2])

        for line in lines:
            if len(line) >= 4:
                for i in range(len(line) - 4 + 1):
                    window = line[i:i + 4]
                    if window.count(window[0]) == 4 and window[0] is not None:
                        return window[0]
        return None

    def get_possible_moves(self) -> List[Tuple[int, int]]:
        return [(r, c) for r in range(4) for c in range(4) if self.board[r][c] is None]

    def evaluate(self, depth: int) -> int:
        winner = self.get_winner()
        if winner == "O":
            return 10 - depth
        if winner == "X":
            return depth - 10
        return 0

    def minimax(self, is_maximizing: bool, depth: int = 0, alpha: int = float('-inf'),
                beta: int = float('inf'), max_depth: int = 3) -> Tuple[int, Optional[Tuple[int, int]]]:
        if self.is_game_over() or depth >= max_depth:
            return self.evaluate(depth), None

        best_move = None

        if is_maximizing:
            best_score = float('-inf')
            for move in self.get_possible_moves():
                r, c = move
                self.board[r][c] = "O"
                score, _ = self.minimax(False, depth + 1, alpha, beta, max_depth)
                self.board[r][c] = None

                if score > best_score:
                    best_score = score
                    best_move = move

                alpha = max(alpha, best_score)
                if beta <= alpha:
                    break
        else:
            best_score = float('inf')
            for move in self.get_possible_moves():
                r, c = move
                self.board[r][c] = "X"
                score, _ = self.minimax(True, depth + 1, alpha, beta, max_depth)
                self.board[r][c] = None

                if score < best_score:
                    best_score = score
                    best_move = move

                beta = min(beta, best_score)
                if beta <= alpha:
                    break

        return best_score, best_move

    def player_turn(self) -> None:
        move = None
        while move not in self.get_possible_moves():
            try:
                move = tuple(map(int, input("Podaj ruch (wiersz kolumna): ").split()))
            except ValueError:
                continue
        self.board[move[0]][move[1]] = "O"

    def ai_turn(self, move_count: int) -> None:
        print("AI myśli...")
        start = time_ns()

        max_depth = self.max_initial_depth if move_count < (4 * 4 * 3 // 4) else float('inf')
        score, move = self.minimax(False, alpha=float('-inf'), beta=float('inf'), max_depth=max_depth)

        end = time_ns()
        elapsed = (end - start) / 1e9
        print(f"Czas oczekiwania na ruch AI: {elapsed:.6f} sekundy")
        print(f"Score = {score}")
        if move:
            self.board[move[0]][move[1]] = "X"

    def __repr__(self):
        result = "TicTacToe()\n"
        for row in self.board:
            result += " ".join(cell if cell else "-" for cell in row) + "\n"
        return result

    def play(self, player_starts: bool = True) -> None:
        print("Rozpoczynamy grę w Kółko i Krzyżyk 4x4!")
        player_turn = player_starts
        move_count = 0

        print(self)

        while not self.is_game_over():
            if player_turn:
                self.player_turn()
            else:
                self.ai_turn(move_count)
            print(self)
            player_turn = not player_turn
            move_count += 1

        winner = self.get_winner()
        if winner:
            print(f"Wygrał {winner}!")
        else:
            print("Remis!")


if __name__ == '__main__':
    game = TicTacToe()
    game.play(player_starts=True)
