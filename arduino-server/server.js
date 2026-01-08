// 导入所需模块
const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors'); // 新增 CORS 模块

// ---- 初始化 SQLite 数据库 ----
const db = new sqlite3.Database('./data.db');

db.serialize(() => {
    db.run(`
        CREATE TABLE IF NOT EXISTS sensor_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            temperature REAL,
            humidity REAL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    `);
    console.log("SQLite 数据库初始化完成");
});

const PORT = 8080;
const app = express();

// ---- 启用 CORS（允许所有域访问） ----
app.use(cors());

// ---- JSON Body 解析 ----
app.use(bodyParser.json());

// ---- 全局存储 Arduino 最新数据 ----
let latestData = null;

// =====================================
// 1️⃣ Arduino 上传数据接口 POST /upload
// =====================================
app.post('/upload', (req, res) => {
    const data = req.body;

    if (data.temperature === undefined || data.humidity === undefined) {
        return res.status(400).send({
            status: "error",
            message: "Invalid data format"
        });
    }

    latestData = data;

    console.log("---- 接收到 Arduino 数据 ----");
    console.log(`温度: ${data.temperature}°C`);
    console.log(`湿度: ${data.humidity}%`);
    console.log("----------------------------");

    // 插入数据库
    const query = `
        INSERT INTO sensor_data (temperature, humidity)
        VALUES (?, ?)
    `;

    db.run(query, [data.temperature, data.humidity], function (err) {
        if (err) {
            console.error("数据库写入失败:", err);
            return res.status(500).send({ status: "error" });
        }

        console.log(`数据库写入成功，RowID = ${this.lastID}`);

        res.status(200).send({
            status: "success",
            message: "Data received & saved successfully!"
        });
    });
});

// =====================================
// 2️⃣ 前端获取最新数据接口 GET /latest
// =====================================
app.get('/latest', (req, res) => {
    if (!latestData) {
        return res.send({ message: "No data yet" });
    }
    res.send(latestData);
});

// =====================================
// 3️⃣ 前端获取历史记录接口 GET /history
// =====================================
app.get('/history', (req, res) => {
    const query = `
        SELECT * FROM sensor_data
        ORDER BY id DESC
        LIMIT 20
    `;

    db.all(query, (err, rows) => {
        if (err) {
            console.error("数据库读取失败", err);
            return res.status(500).send({ status: "error" });
        }

        res.send(rows);
    });
});

// =====================================
// 4️⃣ 启动服务器
// =====================================
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Node.js Server running at http://0.0.0.0:${PORT}`);
});
