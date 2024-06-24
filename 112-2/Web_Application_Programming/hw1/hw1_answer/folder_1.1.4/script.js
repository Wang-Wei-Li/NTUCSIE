document.getElementById("Enter").addEventListener("click", button_clicks);

function button_clicks(){
    let inputText = document.getElementById("textbar");
    if (inputText.value.trim() != ""){
        const new_todo = document.createElement("p");
        new_todo.textContent = inputText.value.trim();
        document.getElementById("todo-list").appendChild(new_todo);
        inputText.value = "";
    }
}