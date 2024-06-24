const randNum = Math.floor(Math.random() * 100) + 1;
document.getElementById("submit guess").addEventListener("click", feedback);

function feedback(){
    let guess_input = document.getElementById("guess-input").value;
    if (guess_input == randNum)
        document.write("Congrat! You guess the right number!");
    else if (guess_input > randNum && guess_input < 101)
        alert("Guess lower!");
    else if (guess_input < randNum && guess_input > 0)
        alert("Guess higher!");
    else
        alert("Invalid input!");
}