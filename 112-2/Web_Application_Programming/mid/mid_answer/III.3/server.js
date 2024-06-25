const http = require("http"); // require 函數會返回一個 http object, 在此用 const http 裝它
const fs = require("fs");// fs stands for file system.
const qs = require("querystring");

const port = 5169;
const ip = "127.0.0.1";

const sendResponse = (filename, statusCode, response) => {
    fs.readFile(`./view/${filename}`, (error, data) => {
        if (error) {
            response.statusCode = 500; // 伺服器端錯誤(500 Internal Server Error)
            response.setHeader("Content-Type", "text/plain");
            response.end("Sorry, Internet error!");
        } else {
            response.statusCode = statusCode;
            response.setHeader("Content-Type", "text/html");
            response.end(data);
        }
    })
};

const server = http.createServer((request, response) => { // createServer 函數會返回一個 server object, 在此用 const server 裝它
    const method = request.method;
    let url = request.url;

    if (method === "GET") {
        const requestUrl = new URL(url, `http://${ip}:${port}`); // URL 參數: new URL(current URL, basic URL);
        url = requestUrl.pathname;
        if (url === "/") { // "/" 代表根目錄
            sendResponse(`index.html`, 200, response); // 成功回應(200 OK)
        } else if (url === "/about") {
            sendResponse(`about.html`, 200, response);
        } else if (url === "/contact") {
            sendResponse(`contact.html`, 200, response);
        }
    }
});

server.listen(port, ip, () => {
    console.log(`Server is running at http://${ip}:${port}`);
}); // server object 裡的 listen 函數可以監聽來自前端的請求