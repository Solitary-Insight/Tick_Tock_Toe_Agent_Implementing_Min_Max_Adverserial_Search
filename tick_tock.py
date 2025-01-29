import random

PLAYER_O = "\U0001F9D2"
PLAYER_X = "\U0001F916"
EMPTY = '  '

def check_winner(board):
    for row in range(3):
        if board[row][0] == board[row][1] == board[row][2] != EMPTY:
            return board[row][0]
    for col in range(3):
        if board[0][col] == board[1][col] == board[2][col] != EMPTY:
            return board[0][col]
    if board[0][0] == board[1][1] == board[2][2] != EMPTY:
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] != EMPTY:
        return board[0][2]
    
    if all(cell != EMPTY for row in board for cell in row):
        return 'Draw'
    
    return None  

def minimax(board, depth, is_maximizing):
    winner = check_winner(board)
    
    if winner == PLAYER_X:
        return 10 - depth  
    if winner == PLAYER_O:
        return depth - 10  
    if winner == 'Draw':
        return 0  # Draw
    
    if is_maximizing:
        best = -float('inf')
        for row in range(3):
            for col in range(3):
                if board[row][col] == EMPTY:
                    board[row][col] = PLAYER_X
                    best = max(best, minimax(board, depth + 1, False))
                    board[row][col] = EMPTY
        return best
    else:
        best = float('inf')
        for row in range(3):
            for col in range(3):
                if board[row][col] == EMPTY:
                    board[row][col] = PLAYER_O
                    best = min(best, minimax(board, depth + 1, True))
                    board[row][col] = EMPTY
        return best

def find_best_move(board):
    best_val = -float('inf')
    best_move = (-1, -1)
    
    for row in range(3):
        for col in range(3):
            if board[row][col] == EMPTY:
                board[row][col] = PLAYER_X
                move_val = minimax(board, 0, False)
                board[row][col] = EMPTY
                if move_val > best_val:
                    best_move = (row, col)
                    best_val = move_val
    return best_move

def print_board(board):
    print("- " * 6)

    for row in board:
        print(" | ".join(row))
        print("- " * 6)

def play_game():
    board = [[EMPTY for _ in range(3)] for _ in range(3)]
    
    while True:
        print_board(board)
        print("AI's Move (Bot):")
        row, col = find_best_move(board)
        board[row][col] = PLAYER_X
        
        if check_winner(board):
            print_board(board)
            print(f"Winner: {check_winner(board)}")
            break
        
        print_board(board)
        print("Your Move (Human):")
        row, col = map(int, input("Enter row and column (0, 1, 2) separated by space: ").split())
        if board[row][col] == EMPTY:
            board[row][col] = PLAYER_O
        else:
            print("Invalid move! Try again.")
            continue
        
        if check_winner(board):
            print_board(board)
            print(f"Winner: {check_winner(board)}")
            break

play_game()

