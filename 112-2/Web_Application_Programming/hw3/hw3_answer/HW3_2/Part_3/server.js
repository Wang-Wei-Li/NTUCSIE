const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// 使用 body-parser 中間件來解析 POST 請求的正文
app.use(bodyParser.urlencoded({ extended: false }));

// 設置 EJS 模板引擎
app.set('view engine', 'ejs'); // 這代表 view engine 我們宣告為 ejs

let weatherInfo = "";
let alert = "";

// 渲染天氣資訊頁面
app.get('/', (req, res) => {
    currentAlert = alert;
    alert = "";
    res.render('index', { weatherInfo, alert: currentAlert });
  });

// 處理天氣查詢請求
app.post('/citySubmit', (req, res) => {
    const city = req.body['city-input'];
    if (city.trim() !== "") {
        fetchWeather(city, res);
    } else {
        alert = '<script>alert("Please enter a city name.");</script>';
        res.redirect('/');
    }
});

function fetchWeather(city, res) {
    var apiUrl = `https://wttr.in/${city}?format=%t+%w+%h`;
    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch weather data.");
            }
            return response.text();
        })
        .then(data => {
            weatherInfo = data;
            res.redirect('/');
        })
        .catch(error => {
            console.error("Error fetching weather data:", error);
            alert = '<script>alert("Failed to fetch weather data. Please try again later.");</script>';
            res.redirect('/');
        });
}

// 監聽端口
app.listen(port, () => {
    console.log(`Weather app listening at http://localhost:${port}`);
  });
  