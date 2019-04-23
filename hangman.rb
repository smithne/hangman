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
        @secret_word = @wordlist[rand(@wordlist.length)]
        puts @secret_word

        remaining_guesses_string = "o" * @@guess_limit
        guessed_letters = "" * @@guess_limit
        guess_string = "_" * @secret_word.length

        # print underscores representing each character
        puts guess_string
        # print guesses
        puts guess_string
        # print remaining number of guesses
        puts remaining_guesses

        # get guess from user
        guess_char = gets.chomp.downcase
        # check if valid
            # single character
            # not already guessed
            # exists in alphabet

        if guessed_letters.include? guess_char
            puts "already guessed"
        end

        
        # check if in the word
            # if in word

            # if not in word
                # increment guesses


    end

    def load_game

    end

    def save_game

    end

    def play_round

    end

end

game = Hangman.new()