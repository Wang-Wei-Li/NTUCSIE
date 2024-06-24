const express = require('express');
const app = express();
const port = 3000;

// 提供靜態資源
app.use(express.static('public'));

// 監聽端口
app.listen(port, () => {
  console.log(`Weather app listening at http://localhost:${port}`);
});
