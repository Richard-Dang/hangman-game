%Richard Dang
%Computer Hangman
%2011/12/29
%Ms.Dyke

/*
 This program is a virtual game of hangman and the topic/category is computer terms.
 A word will be randomly selected from a stored list of 10.
 There will be two levels, level 1 will give you hints and level 2 will not.
 You have the option to 'Play Game', 'Instructions' or 'Quit Game' at the main menu.
 If you choose to play game then you have the option of 'Level 1' or 'Level 2'.
 You will have a total of 10 lives, each part of the hangman is a life.
 If the hangman is completed, you lose.
 If you think you know the word, you can guess it but entering '?'.
 You can enter 1,2,3 or 4 in level 1 for hints.
 The letters you have used will display in a box.
 You will be congradulated if you guess the entire word or all the letters in the word.
 You may choose to read the instructions if you are unsure of how to play.
 You may also choose to view the credits if you wish at the main menu.
 If you choose to quit game, there will be a message thanking the user for playing.
 The program will then exit when the user enters any key.
 */

%Declaration Section (Global)
import GUI %Imports GUI

forward proc mainMenu %Reads the mainMenu procedure

var buttonMenu, buttonPlay, buttonHelp, buttonCredits, buttonQuit, buttonLevel1, buttonLevel2 : int %Main Menu, Play, Help, Credits,  Quit, Level 1 and 2 Buttons
var word : int % Locates a word from the stored list of 10
var winID := Window.Open ("position:200;200,graphics:640;400") %Creates the main window
var picID, picID2, picID3, picID4, picID5, picID6 : int %Pictures
var font : int := Font.New ("serif:12:bold") %Changes font and size font
var levelUp : boolean := true %Enables or disables hints (true=enabled/false=disable)

setscreen ("nocursor") %Hides the cursor
setscreen ("noehco") %Stops keys from echoing
setscreen ("buttonbar") %Shows Button Bar (with options)

%Obtains pictures from folder
proc initPicture

    picID := Pic.FileNew ("Pictures/1.jpg") %Obtains picture 1
    picID2 := Pic.FileNew ("Pictures/2.jpg") %Obtains picture 2
    picID3 := Pic.FileNew ("Pictures/3.jpg") %Obtains picture 3
    picID4 := Pic.FileNew ("Pictures/4.jpg") %Obtains picture 4
    picID5 := Pic.FileNew ("Pictures/5.jpg") %Obtains picture 5
    picID6 := Pic.FileNew ("Pictures/6.jpg") %Obtains picture 6

end initPicture

%Program Title
proc title

    cls %Clears screen
    Draw.Text ("Computer Hangman", 255, 382, font, 30) %Title of program
    Draw.ThickLine (245, 380, 400, 380, 2, 30) %Underlines the title

end title

%Pauses Program
proc pauseProgram

    var reply : string (1)
    put ""
    put "Press any key to continue..." ..
    getch (reply) % Pauses program until user inputs a key

end pauseProgram

%Random Word
proc randWord

    randint (word, 1, 10) %Randomizes the 10 stored words

end randWord

%Loading Screen
proc load

    title

    initPicture %Gets the picture file
    Pic.Draw (picID6, 0, 0, picUnderMerge) %Draws the sixth picture

    Draw.Text ("Loading in Progess...", 20, 60, font, 30)

    drawbox (20, 27, 620, 52, 30) %Outline of loading bar
    drawfillbox (21, 28, 619, 51, 0) %Draws loading bar

    for x : 0 .. 589 %Moving bar in loading bar
	drawfillbox (21 + x, 30, 30 + x, 50, 0)
	drawfillbox (22 + x, 30, 32 + x, 50, Rand.Int (1, 100))
	delay (3) %Delay of moving bar
	View.Update
    end for

    Pic.Free (picID6) %Frees picture's memory

end load

process music
    %Plays music during credits.
    play (">1a4b>1c4deage8f+d4fc<a>fe<bg+>edc<a>c<8bag+fec<b>e1a4b1>c4deage8f+d4fc<a>fe<bg+b1a2>defd8cde<ab>cce<ab2>cdefd8<ab>4c<8b>c4d8cd4e8defa1g+1e<<")
end music

%Credit Screen
proc credits

    fork music %Plays music

    drawfillbox (0, 0, 639, 399, 7) %Black Background

    for x : 0 .. 1100
	drawfillbox (0, 0 - x, 640, 1200 - x, 7) %Erases markings left by text
	Draw.Text ("Computer Science ISP:", 140, 1000 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Computer Hangman", 150, 950 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Music Used:", 220, 850 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Music Notes (Final Fantasy III)", 70, 800 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Pictures Used:", 200, 700 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Android IceCreamSandwich Wallpaper", 5, 650 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Program Designed By:", 150, 550 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	Draw.Text ("Richard Dang", 200, 500 - x, Font.New ("serif:28:bold"), Rand.Int (1, 255))
	delay (20) %Delay of moving text
	View.Update
    end for

    mainMenu %Main Menu screen

end credits

%Program Introduction
proc intro

    title

    initPicture %Gets the picture file
    Pic.Draw (picID5, 0, 0, picUnderMerge) %Draws the first picture

    for x : 1 .. 100 %Switches font colour
	Draw.Text ("Welcome to Richard's Computer Hangman Game", 30, 320, Font.New ("serif:20:bold"), Rand.Int (33, 55))
	delay (20) %Delay of font colour change
    end for

    Draw.Text ("(Please read the 'Instructions' at the main menu before playing a game)", 80, 130, font, black)

    randWord %Selects a random word from list

    buttonMenu := GUI.CreateButton (250, 150, 150, "Main Menu", mainMenu) %Creates the Main Menu Button

    Pic.Free (picID) %Free picture's memory

end intro

%Instructions
proc instructions

    load %Loading screen

    GUI.Hide (buttonPlay)         %Hides Play Game, Instructions, Credits  & Quit Game Buttons
    GUI.Hide (buttonHelp)           %(Cancals overlapping of buttons)
    GUI.Hide (buttonCredits)
    GUI.Hide (buttonQuit)

    title

    initPicture %Gets the picture file
    Pic.Draw (picID, 0, 0, picUnderMerge) %Draws the fifth picture

    Draw.Text ("Instructions:", 0, 350, font, black) %Instructions for game
    Draw.Text ("This program will allow you to play Hangman while helping you learn new computer terms.", 0, 320, font, black)
    Draw.Text ("There are two levels, level 1 will give you hints while level 2 will not.", 0, 290, font, black)
    Draw.Text ("You will have a total of 10 lives, each hangman part representing one.", 0, 260, font, black)
    Draw.Text ("If you guess all the letters in the word or the word itself, you win.", 0, 230, font, black)
    Draw.Text ("If the hangman is completed, you lose.", 0, 200, font, black)

    buttonMenu := GUI.CreateButton (250, 100, 150, "Main Menu", mainMenu) %Creates the Main Menu Button

    Pic.Free (picID5) %Free picture's memory

end instructions

%Good Bye Screen
proc goodBye

    load %Loading Screen

    title

    initPicture %Gets the picture file
    Pic.Draw (picID2, 0, 0, picUnderMerge) %Draws the second picture

    Draw.Text ("Thank you for playing my 'Computer Hangman' game.", 150, 330, font, black)
    Draw.Text ("This program was designed by: Richard Dang.", 160, 290, font, black)
    Draw.Text ("The program will close when you enter any key.", 160, 250, font, black)

    loop
	exit when hasch     %Exits when user has pressed any key
    end loop

    Pic.Free (picID2) %Free picture's memory

    Window.Close (winID) %Closes main window


end goodBye

%Level 1
proc level1

    %Declartion Section (Local)
    var words : array 1 .. 10 of string := init ("operating-system", "fragmentation",     %Stored list of 10 computer terms
	"ethernet", "partition", "root-directory", "system-backup", "mouse-cursor", "database", "defragment", "peripheral")
    var guess : string (1) % Character entered by user
    var tries : int := 10 %Number of tries
    var answer : int %Locates the users guess within the word
    var correct : int := 0 %Checks if the gets all the correct letters
    var space : int := 2 %Spaces between used letters
    var guessWord : string %Guess word entered by user
    var used : string := chr (1) %Changes the value of the letter in the alphabet

    load %Loading Screen

    GUI.Hide (buttonLevel1) %Hides Level 1 & Level 2 buttons
    GUI.Hide (buttonLevel2) %(Cancels overlapping of buttons)

    title

    %Draws the Gallows (Frame for hanging)
    Draw.ThickLine (550, 200, 630, 200, 2, 7)
    Draw.ThickLine (590, 200, 590, 350, 2, 7)
    Draw.ThickLine (590, 350, 550, 320, 2, 7)

    %Draws the Used Letter Box
    drawbox (10, 300, 500, 370, 7)
    drawline (10, 350, 500, 350, 7)
    locate (3, 25)
    put "Used Characters" ..

    %Draws the dashes of each letter in the word
    var dash : array 1 .. length (words (word)) of string
    for x : 1 .. length (words (word))
	dash (x) := "__"
    end for

    %Letters of the alphabet
    var letters : array 1 .. 26 of string
    var usedLetters : array 1 .. 26 of string
    for x : 1 .. 26
	letters (x) := chr (96 + x)
	usedLetters (x) := chr (96 + x)
    end for

    %Loops until user runs of of tries or guess the word
    loop

	%Draws individual parts of the man depending on number of tries
	if tries = 9 then
	    drawfilloval (550, 310, 10, 10, 7)
	elsif tries = 8 then
	    Draw.ThickLine (550, 300, 550, 250, 2, 7)
	elsif tries = 7 then
	    Draw.ThickLine (550, 275, 570, 290, 2, 7)
	elsif tries = 6 then
	    Draw.ThickLine (550, 275, 530, 290, 2, 7)
	elsif tries = 5 then
	    Draw.ThickLine (550, 250, 570, 220, 2, 7)
	elsif tries = 4 then
	    Draw.ThickLine (550, 250, 530, 220, 2, 7)
	elsif tries = 3 then
	    Draw.ThickLine (570, 290, 570, 300, 2, 7)
	elsif tries = 2 then
	    Draw.ThickLine (530, 290, 530, 300, 2, 7)
	elsif tries = 1 then
	    Draw.ThickLine (570, 220, 580, 220, 2, 7)
	elsif tries = 0 then
	    Draw.ThickLine (530, 220, 520, 220, 2, 7)
	end if

	%Draws the spaces inbetween the dashes
	locate (10, 5)
	for x : 1 .. length (words (word))
	    put dash (x) : 3, " " ..
	end for

	%Checks to see if all the dashes are changed to letters
	for x : 1 .. length (words (word))
	    correct := correct + index (dash (x), "__")
	end for

	%Exits loop when user guesses all the correct letters in the word or used up all their tries
	exit when correct = 0 or tries = 0

	%Set correct to the value 0 if all dashes are replaced with letters
	correct := 0

	%Spaces between the used letters
	space += 2

	locate (14, 1)
	put "Guess the word I am thinking of..."
	put "If you would like to guess the word enter '?'"

	%*Disabled in level 2*
	if levelUp = true then
	    put "If you need a hint enter '1,2,3 or 4'"
	end if

	put ""
	put "Enter a letter: " ..

	%Shows on cursor
	setscreen ("cursor")

	getch (guess) %Gets user's guess for the letter

	%Hides off cursor
	setscreen ("nocursor")

	put guess %Shows user their guess
	put ""

	%Error traps if the user has already used the letter
	for x : 1 .. 26
	    if guess = letters (x) then
		%Checks to see if value of the letter has been changed
		if usedLetters (x) = used then
		    put "You have already used this letter."
		    %Cancels out tries -=1 so user does not lose another life
		    tries += 1
		else
		    %Changes the value of the letter in the alphabet
		    usedLetters (x) := used
		end if
	    end if
	end for

	%Looks for the user's guess in the word selected
	answer := index (words (word), guess)

	%Different hints given to the user depending on number entered
	%*Disabled in level 2*
	if levelUp = true then
	    if guess = "1" then
		put "If the word is long, try using a hyphen '-'."
		pauseProgram
	    elsif guess = "2" then
		put "Try using vowels. (A,E,I,O,U)."
		pauseProgram
	    elsif guess = "3" then
		put "The most commoning occuring letters are E,T,A,O,I,N,S,H,R,D,L and U."
		pauseProgram
	    elsif guess = "4" then
		put "There are 26 letters in the alphabet, they are: ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		pauseProgram
	    end if
	end if

	%Allows user to guess the word if they think they know it
	if guess = "?" then
	    put "Please enter the word: " ..

	    %Shows on cursor
	    setscreen ("cursor")

	    get guessWord : *

	    %Hides off cursor
	    setscreen ("nocursor")

	    if guessWord = words (word) then
		%Congratulates the user if he guesses the word
		put "Good Job, you got the word!"
		pauseProgram
		%Clears text for new input
		locate (14, 1)
		for x : 1 .. 10
		    put ""
		end for
		%Exits the loop when user guesses the correct word
		exit when guessWord = words (word)
	    else
		%Subtracts 1 from tries if the user guessed the wrong word
		tries -= 1
		%Displays if the user guesses an incorrect word
		put "You guessed an incorrect word."
		pauseProgram
		%Clears text for new input
		locate (14, 1)
		for x : 1 .. 10
		    put ""
		end for
	    end if
	else
	    if answer = 0 and guess not= "1" and guess not= "2" and guess not= "3" and guess not= "4" then
		%Subtracts 1 from tries if the user guessed a wrong letter
		tries -= 1
		%Displays if user enters an incorrect letter
		put "The letter entered was not found in the word."
		pauseProgram
		%Clears text for new input
		locate (14, 1)
		for x : 1 .. 10
		    put ""
		end for
		%Puts the letter in the used letter box
		locate (5, space)
		put guess ..
		%Displays if the user needs a hint
	    elsif guess = "1" or guess = "2" or guess = "3" or guess = "4" then
		%Clears text for new input
		locate (14, 1)
		for x : 1 .. 9
		    put ""
		end for
	    else
		%Displays if user guesses a correct letter
		put "Good job, '", guess, "' was located in the word."
		pauseProgram
		%Clears text for new input
		locate (14, 1)
		for x : 1 .. 10
		    put ""
		end for
		%Puts the letter in the used letter box
		locate (5, space)
		put guess ..
		%If the user guesses a correct letter the dash is replaced with the letter in the word
		locate (10, 5)
		for x : 1 .. length (words (word))
		    if guess = words (word) (x) then
			dash (x) := guess
		    end if
		end for
	    end if
	end if
    end loop

    if tries = 0 then
	locate (15, 1)
	%Displays if the user uses up all his/her guess (full hangman)
	put "You have used up all your tries. Too bad, you lose."
    elsif correct = 0 then
	locate (15, 1)
	%Displays if the user guesses entire word
	put "Good job guessing the word. You've won!"
    elsif guessWord = words (word) then
	locate (15, 1)
	%Displays if the user guesses all the letters in the word
	put "Nice, you guessed all the letters in the word. You've won!"
    end if
    put "" %Displays the correct word
    put "The correct word was '", words (word), "'!"
    put ""
    put "Please view the 'Credits' at the main menu before you quit game, Thank you."

    randWord         %Chooses a new word for next game
    tries := 10         %Resets the number of tries

    buttonMenu := GUI.CreateButton (250, 50, 150, "Main Menu", mainMenu)         %Creates the Main Menu Button

end level1


proc level2

    levelUp := false         %Disables hints

    level1         %Same as level 1 WITHOUT hints

end level2

%Level Selection
proc levels

    load %Loading Screen

    GUI.Hide (buttonPlay)         %Hides Play Game, Instruction, Credits & Quit Game Buttons
    GUI.Hide (buttonHelp)           %(Cancals overlapping of buttons)
    GUI.Hide (buttonCredits)
    GUI.Hide (buttonQuit)

    title

    initPicture         %Gets the picture file
    Pic.Draw (picID4, 0, 0, picUnderMerge)         %Draws the forth picture

    buttonLevel1 := GUI.CreateButton (250, 250, 150, "Level 1 (Hints)", level1)         %Creates the Level 1 Button
    buttonLevel2 := GUI.CreateButton (250, 170, 150, "Level 2 (No Hints)", level2)         %Creates the Level 2 Button

    Pic.Free (picID4)         %Free picture's memory

end levels

%Main Menu
body proc mainMenu

    load %Loading screen

    GUI.Hide (buttonMenu)         %Hides Main Menu Buttons (Cancels overlapping of buttons)

    title

    initPicture         %Gets the picture file
    Pic.Draw (picID3, 0, 0, picUnderMerge)         %Draws the third picture


    buttonPlay := GUI.CreateButton (250, 280, 150, "Play New Game", levels)         %Creates the Play New Game Button
    buttonHelp := GUI.CreateButton (250, 230, 150, "Instructions", instructions)        %Creates the Instructions Button
    buttonCredits := GUI.CreateButton (250, 180, 150, "Credits", credits)         %Creates the Credits Button
    buttonQuit := GUI.CreateButton (250, 130, 150, "Quit Game", GUI.Quit)         %Creates the Quit Button

    Pic.Free (picID3)         %Free picture's memory

end mainMenu



%Main Program
intro
loop
    %Exit when user clicks 'Quit Button'
    exit when GUI.ProcessEvent
end loop
goodBye
%End Program

