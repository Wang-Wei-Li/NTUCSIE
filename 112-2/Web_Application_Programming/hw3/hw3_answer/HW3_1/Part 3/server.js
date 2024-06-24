const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// 使用 body-parser 中間件來解析 POST 請求的正文
app.use(bodyParser.urlencoded({ extended: false }));

// 設置 EJS 模板引擎
app.set('view engine', 'ejs'); // 這代表 view engine 我們宣告為 ejs

// 購物清單數據
let items = [];

// 渲染購物清單頁面
app.get('/', (req, res) => {
  res.render('index', { items });
});

// 添加新項目到購物清單
app.post('/addItem', (req, res) => {
  const newItem = req.body.newItem;
  if (newItem.trim() !== '') {
    items.push(newItem);
  }
  res.redirect('/');
});

// 刪除購物清單項目
app.post('/deleteItem', (req, res) => {
  const index = req.body.index;
  if (index >= 0 && index < items.length) {
    items.splice(index, 1);
  }
  res.redirect('/');
});

// 監聽端口
app.listen(port, () => {
  console.log(`Shopping list app listening at http://localhost:${port}`);
});
