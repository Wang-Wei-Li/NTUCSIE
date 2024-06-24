document.getElementById("search-button").addEventListener("click",
function() {
    var city = document.getElementById("city-input").value;
    if (city.trim() !== "") {
        fetchWeather(city);
    } else {
        alert("Please enter a city name.");
    }
});

function fetchWeather(city) {
    var apiUrl = `https://wttr.in/${city}?format=%t+%w+%h`;
    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch weather data.");
            }
            return response.text();
        })
        .then(data => {
            displayWeather(data);
        })
        .catch(error => {
            console.error("Error fetching weather data:", error);
            alert("Failed to fetch weather data. Please try again later.");
        });
}

function displayWeather(data) {
    var weatherInfo = document.getElementById("weather-info");
    weatherInfo.innerText = data;
}