document.getElementById("addItemForm").addEventListener("submit", function(event) {
    event.preventDefault(); // prevent reload
    const newItem = document.getElementById("newItem").value.trim();
    if (newItem !== "") {
      addItemToList(newItem);
      document.getElementById("newItem").value = "";
    }
  });
  
  function addItemToList(newItem) {
    const itemList = document.getElementById("itemList");
    const li = document.createElement("li");
    li.textContent = newItem;
    const deleteButton = document.createElement("button");
    deleteButton.textContent = "Delete";
    deleteButton.addEventListener("click", function() {
      itemList.removeChild(li);
    });
    li.appendChild(deleteButton);
    itemList.appendChild(li);
  }
  