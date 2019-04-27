require json

class Hangman

    @@min_length = 5
    @@max_length = 12
    @@wordlist_file = 'wordlist.txt'
    @@save_file = "saved_game.json"
    @@guess_limit = 8

    def initialize
        @wordlist = []
        @secret_word = ""

        File.open(@@wordlist_file, "r") do |file|
            file.readlines.each do |word|
                word = word.strip
                @wordlist << word if ((word.length >= @@min_length) && (word.length <= @@max_length))
            end   
        end
    end


    def start_game
        print "Enter 1 to start a new game or 2 to load an existing game: "
        choice = gets.chomp()
        self.new_game
    end

    def new_game
        @secret_word = @wordlist[rand(@wordlist.length)].downcase
        puts @secret_word

        guess_count = 0
        correct_letters = 0
        remaining_guesses = "o" * @@guess_limit
        guessed_letters = "" * @@guess_limit
        guess_string = "_" * @secret_word.length

        print_status(guess_string, guessed_letters, remaining_guesses)

        winner = nil

        begin
            # get guess from user
            print "Guess a letter, or enter 'save' to save the game: "
            guess_char = gets.chomp.downcase

            if guessed_letters.include? guess_char
                puts "already guessed"
            elsif @secret_word.include? guess_char
                @secret_word.split("").each_with_index do |secret_char, index|
                    if guess_char == secret_char
                        guess_string[index] = guess_char
                        correct_letters += 1
                    end
                end
                guessed_letters += guess_char
            else
                remaining_guesses[guess_count] = 'x'
                guessed_letters += guess_char
                guess_count += 1
            end
            print_status(guess_string, guessed_letters, remaining_guesses)
            puts
            winner = winner(guess_string, guess_count)
        end until winner
        puts winner + " wins!"

    end

    def winner(guess_string, guess_count)
        if !(guess_string.include? '_')
            return 'guesser'
        elsif guess_count == @@guess_limit
            return 'computer'
        else
            return nil
        end
    end

    def print_status(guess_string, guessed_letters, remaining_guesses)
        # print underscores representing each character
        puts "word: " + guess_string
        # print guesses
        puts "guessed letters: " + guessed_letters
        # print remaining number of guesses
        puts "remaining guesses: " + remaining_guesses
    end

    def load_game

    end

    def save_game
        
    end

    def to_json(guess_string, guessed_letters, remaining_guesses, guess_count)
        JSON.dump ({
            :secret_word => @secret_word,
            :guess_string => guess_string,
            :guessed_letters => guessed_letters,
            :remaining_guesses => remaining_guesses,
            :guess_count => guess_count
        })
    end

end

game = Hangman.new()
game.new_game()