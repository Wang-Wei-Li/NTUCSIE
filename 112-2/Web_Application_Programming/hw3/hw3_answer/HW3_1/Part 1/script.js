function addItem() {
    var input = document.getElementById("itemInput");
    var itemText = input.value.trim();
    if (itemText !== '') {
        var itemList = document.getElementById("itemList");
        var li = document.createElement("li");
        li.textContent = itemText;
        var deleteButton = document.createElement("button");
        deleteButton.textContent = "Delete";
        deleteButton.addEventListener("click", function() {
            itemList.removeChild(li);
        });
        li.appendChild(deleteButton);
        itemList.appendChild(li);
        input.value = '';
    }
}